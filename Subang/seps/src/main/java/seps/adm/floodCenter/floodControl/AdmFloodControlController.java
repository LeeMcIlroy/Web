package seps.adm.floodCenter.floodControl;

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

import seps.cmmn.CmmnDAO;
import seps.valueObject.FloodControlVO;
import seps.valueObject.UserInfoVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdmFloodControlController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmFloodControlController.class);
	
	@Resource View jsonView;
	@Autowired AdmFloodControlDAO dao;
	@Autowired CmmnDAO cmmnDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/adm/floodCenter/floodControlList.do";
	}
	
	/**
	 * 수방단계설정 목록 화면
	 * @param searchVO
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/floodControlList.do")
	public String floodControlList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/floodCenter/floodControlList.do - 수방단계설정 목록 화면");
		if(session != null) session.setAttribute("leftMeneNo", "301");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		
		CmmnListVO listVO = dao.selectFloodControlList(searchVO);
		
		for(EgovMap vo : listVO.getEgovList()){
			switch (vo.get("floodLevel").toString()) {
			case "1":
				vo.put("floodLevel", "1단계(주의) "+vo.get("issueDate")+"("+getDateDay(vo.get("issueDate").toString())+") "+vo.get("issueTime").toString()+" 발령");
				break;
			case "2":
				vo.put("floodLevel", "2단계(경계) "+vo.get("issueDate")+"("+getDateDay(vo.get("issueDate").toString())+") "+vo.get("issueTime").toString()+" 발령");
				break;
			case "3":
				vo.put("floodLevel", "3단계(심각) "+vo.get("issueDate")+"("+getDateDay(vo.get("issueDate").toString())+") "+vo.get("issueTime").toString()+" 발령");
				break;
			case "4":
				vo.put("floodLevel", "평시(관심) "+vo.get("issueDate")+"("+getDateDay(vo.get("issueDate").toString())+") "+vo.get("issueTime").toString()+" 발령");
				break;
			case "5":
				vo.put("floodLevel", "포트홀(예방) "+vo.get("issueDate")+"("+getDateDay(vo.get("issueDate").toString())+") "+vo.get("issueTime").toString()+" 발령");
				break;
			case "6":
				vo.put("floodLevel", "보강(주의) "+vo.get("issueDate")+"("+getDateDay(vo.get("issueDate").toString())+") "+vo.get("issueTime").toString()+" 발령");
				break;
			default:
				vo.put("floodLevel", "평시(관심) "+vo.get("issueDate")+"("+getDateDay(vo.get("issueDate").toString())+") "+vo.get("issueTime").toString()+" 발령");
				break;
			}
		}
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/floodCenter/floodControl/floodControlList";
	}
	
	/**
	 * 수방단계설정 조회화면
	 * @param searchVO
	 * @param model
	 * @param floodControlId
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("/adm/floodCenter/floodControlView.do")
	public String floodControlView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String floodControlId, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/floodCenter/floodControlView.do - 수방단계설정 조회화면");
		LOGGER.debug("floodControlId > "+floodControlId);
		model.addAttribute("floodControlVO", dao.selectFloodControlView(floodControlId));
		
		FloodControlVO returnVO = dao.selectFloodControlView(floodControlId);
		
		switch (returnVO.getFloodLevel()) {
		case "1":
			returnVO.setFloodLevel("1단계(주의) "+returnVO.getIssueDate()+"("+getDateDay(returnVO.getIssueDate())+") "+returnVO.getIssueTime()+" 발령");
			break;
		case "2":
			returnVO.setFloodLevel("2단계(경계) "+returnVO.getIssueDate()+"("+getDateDay(returnVO.getIssueDate())+") "+returnVO.getIssueTime()+" 발령");
			break;
		case "3":
			returnVO.setFloodLevel("3단계(심각) "+returnVO.getIssueDate()+"("+getDateDay(returnVO.getIssueDate())+") "+returnVO.getIssueTime()+" 발령");
			break;
		case "4":
			returnVO.setFloodLevel("평시(관심) "+returnVO.getIssueDate()+"("+getDateDay(returnVO.getIssueDate())+") "+returnVO.getIssueTime()+" 발령");
			break;
		case "5":
			returnVO.setFloodLevel("포트홀(예방) "+returnVO.getIssueDate()+"("+getDateDay(returnVO.getIssueDate())+") "+returnVO.getIssueTime()+" 발령");
			break;
		case "6":
			returnVO.setFloodLevel("보강(주의) "+returnVO.getIssueDate()+"("+getDateDay(returnVO.getIssueDate())+") "+returnVO.getIssueTime()+" 발령");
			break;
		default:
			returnVO.setFloodLevel("평시(관심) "+returnVO.getIssueDate()+"("+getDateDay(returnVO.getIssueDate())+") "+returnVO.getIssueTime()+" 발령");
			break;
		}
		model.addAttribute("issueTime1", returnVO.getIssueTime().split(":")[0]);
		model.addAttribute("issueTime2", returnVO.getIssueTime().split(":")[1]);
		model.addAttribute("floodControlVO", returnVO);
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/floodCenter/floodControl/floodControlView";
	}
	
	/**
	 *  수방단계설정 등록 화면
	 * @param searchVO
	 * @param floodControlId
	 * @param model
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/floodControlModify.do")
	public String floodControlModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String floodControlId, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/adm/floodCenter/floodControlModify.do - 수방단계설정 등록&수정 화면");
		
		UserInfoVO sessionVO = (UserInfoVO) EgovUserDetailsHelper.getAuthenticatedUser();
		FloodControlVO returnVO = null;
		if(EgovStringUtil.isEmpty(floodControlId)){
			returnVO = new FloodControlVO();
		}else{
			returnVO = dao.selectFloodControlView(floodControlId);
			returnVO.setUdtNm(sessionVO.getUserNm());
		}
		returnVO.setRegNm(sessionVO.getUserNm());
		model.addAttribute("floodControlVO", returnVO);
		return "/adm/floodCenter/floodControl/floodControlModify";
	}
	
	
	/**
	 *  수방단계설정 등록&수정 처리
	 * @param searchVO
	 * @param paramVO
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/floodControlSubmit.do")
	public String floodControlSubmit(@ModelAttribute("searchVO") CmmnSearchVO searchVO, FloodControlVO paramVO, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/floodCenter/floodControlSubmit.do - 수방단계설정 등록&수정 처리");
		LOGGER.debug("paramVO >> " +paramVO.toString());
		String message = "등록되었습니다";
		
		if(EgovStringUtil.isEmpty(paramVO.getFloodControlId())){
			dao.insertFloodControl(paramVO);
		}else{
			dao.updateFloodControl(paramVO);
			message = "수정되었습니다.";
		}
		
		return redirectListPage( message, searchVO, reda);
	}
	
	/**
	 *  수방단계설정 삭제 처리
	 * @param searchVO
	 * @param floodControlId
	 * @param model
	 * @param session
	 * @param request
	 * @param reda
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/adm/floodCenter/floodControlDelete.do")
	public String floodControlDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String floodControlId, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/adm/floodCenter/floodControlSubmit.do - 수방단계설정 삭제 처리");

		dao.deleteFloodControl(floodControlId);
		return redirectListPage( "삭제되었습니다", searchVO, reda);
	}
	
	
	/*요일 구하기*/
	public String getDateDay(String date) throws Exception {
	     
	    String day = "" ;
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd") ;
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

}
