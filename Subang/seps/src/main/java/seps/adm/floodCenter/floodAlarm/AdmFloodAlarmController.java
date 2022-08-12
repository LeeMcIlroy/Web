package seps.adm.floodCenter.floodAlarm;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import seps.cmmn.CmmnDAO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;

@Controller
public class AdmFloodAlarmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmFloodAlarmController.class);
	
	@Resource View jsonView;
	@Autowired CmmnDAO cmmnDAO;
	
	@Autowired private AdmFloodAlarmDAO dao;

	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/adm/floodCenter/floodAlarmList.do";
	}
	
	/**
	 * 기간별알람현황 목록 화면
	 * @param searchVO
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/floodAlarmList.do")
	public String floodAlarmList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/floodCenter/floodAlarmList.do - 기간별알람현황 목록 화면");
		if(session != null) session.setAttribute("leftMeneNo", "301");
		
		// searchVO.searchType set - start
		searchVO.setSearchType("LIST");
		// searchVO.searchType set - end
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		CmmnListVO listVO = dao.selectFloodAlarmList(searchVO);
		
		for (EgovMap egovMap : listVO.getEgovList()) {
			if("FC".equals(egovMap.get("tType").toString())){
				egovMap.put("content", ComStringUtil.sepsReturnWeatherLevel(egovMap.get("content").toString()));
			}
			/*
			else if("wl".equals(egovMap.get("tType").toString())){
				String[] tempDate = getTempletDate(egovMap);
				egovMap.put("issueDate", tempDate[0]);
				egovMap.put("issueTime", tempDate[1]);
			}
			*/
			egovMap.put("issueDate", egovMap.get("issueDate")+"("+getDateDay(egovMap.get("issueDate").toString(), "-")+")");
		}
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/floodCenter/floodAlarm/floodAlarmList";
	}
	
	
	/**
	 *  수방근무현황 삭제 처리
	 * @param searchVO
	 * @param snsId
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/floodAlarmDelete.do")
	public String floodAlarmDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/floodCenter/floodAlarmDelete.do - 수방근무현황 삭제 처리");
		LOGGER.info("searchVO  : "+searchVO.toString());
		
		String message = "삭제되었습니다.";
		switch (searchVO.getSearchType()) {
		case "D":
		case "K":
			//수방근무 삭제
			dao.deleteAlarm(searchVO);
			break;
		case "FC":
			//수방단계 삭제
			dao.deleteAlarm2(searchVO.getSearchCode());
			break;
		default:
			message = "잘못된 요청입니다.";
			break;
		}
		
		return redirectListPage( message, searchVO, reda);
	}
	
	/*요일 구하기*/
	public String getDateDay(String date, String type) throws Exception {
	     
	    String day = "" ;
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy"+type+"MM"+type+"dd") ;
	    Date nDate = dateFormat.parse(date) ;
	    Calendar cal = Calendar.getInstance() ;
	    cal.setTime(nDate);
	    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
	    switch(dayNum){
	        case 1:
	            day = "일";
	            break ;
	        case 2:
	            day = "월";
	            break ;
	        case 3:
	            day = "화";
	            break ;
	        case 4:
	            day = "수";
	            break ;
	        case 5:
	            day = "목";
	            break ;
	        case 6:
	            day = "금";
	            break ;
	        case 7:
	            day = "토";
	            break ;
	             
	    }
	    return day ;
	}
	
	//날짜 템플렛 - yyyy.mm.dd(요일) HH:mm 
	public String[] getTempletDate(EgovMap paramMap) throws Exception {
		
		String tempDate1 = paramMap.get("issueDate").toString().subSequence(0, 4)+"-"+paramMap.get("issueDate").toString().subSequence(4, 6)+"-"+paramMap.get("issueDate").toString().subSequence(6, 8);
		//tempDate1 = tempDate1+"("+getDateDay(tempDate1, ".")+")";
		String tempDate2 =paramMap.get("issueTime").toString().substring(0, 2)+":"+paramMap.get("issueTime").toString().substring(2, 4);
		
		return new String[]{tempDate1, tempDate2};
	}

}
