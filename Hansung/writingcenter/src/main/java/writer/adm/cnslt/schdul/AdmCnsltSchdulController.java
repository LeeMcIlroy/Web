package writer.adm.cnslt.schdul;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import writer.adm.cmm.AdmCmmDAO;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.CnsltScheduleVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmCnsltSchdulController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmCnsltSchdulController.class);
	
	@Autowired private AdmCnsltSchdulDAO admCnsltSchdulDAO;
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	@Autowired private AdmCmmDAO admCmmDAO;
	
	/*********************************** 공통 ***********************************/
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/xabdmxgr/cnslt/schdul/admCnsltScheduleList.do";
	}
	
	/*********************************** 상담일정 ***********************************/
	
	// 목록 화면
	@RequestMapping("/xabdmxgr/cnslt/schdul/admCnsltScheduleList.do")
	public String admCnsltScheduleList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/schdul/admCnsltScheduleList.do - 관리자 > 상담 > 상담일정 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("admMenuNo", "202");
		
		return "/adm/cnslt/schdul/admCnsltScheduleList";
	}
	
	// 목록 불러오기
	@Resource View jsonView;
	@RequestMapping("/xabdmxgr/cnslt/schdul/admCnsltScheduleListAjax.do")
	public View admCnsltScheduleListAjax(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/schdul/admCnsltScheduleListAjax.do - 관리자 > 상담 > 상담일정 목록불러오기");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		List<CnsltScheduleVO> resultList = admCnsltSchdulDAO.selectCnsltScheduleList(searchVO);
		model.addAttribute("resultList", resultList);
		return jsonView;
	}
	
	// 등록&수정화면
	@RequestMapping("/xabdmxgr/cnslt/schdul/admCnsltScheduleModify.do")
	public String admCnsltScheduleModify(String schSeq, String schYmd, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/schdul/admCnsltScheduleModify.do - 관리자 > 상담 > 상담일정 등록&수정화면");
		LOGGER.debug("schSeq = "+schSeq+", schYmd = "+schYmd);
		
		CnsltScheduleVO cnsltScheduleVO = null;
		if (EgovStringUtil.isEmpty(schSeq)) {
			// 등록화면
			cnsltScheduleVO = new CnsltScheduleVO();
			if (!EgovStringUtil.isEmpty(schYmd)) {
				cnsltScheduleVO.setSchdulStartDate(schYmd);
			}
		}else {
			// 수정화면
			cnsltScheduleVO = admCnsltSchdulDAO.selectCnsltScheduleOne(schSeq);
		}

		model.addAttribute("memList", admCmmDAO.selectAdmList());
		model.addAttribute("cnsltScheduleVO", cnsltScheduleVO);
		return "/adm/cnslt/schdul/admCnsltScheduleModify";
	}
	
	// 등록&수정
	@RequestMapping("/xabdmxgr/cnslt/schdul/admCnsltScheduleUpdate.do")
	public String admCnsltScheduleUpdate(CnsltScheduleVO cnsltScheduleVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/schdul/admCnsltScheduleUpdate.do - 관리자 > 상담 > 상담일정 등록&수정");
		LOGGER.debug("cnsltScheduleVO = "+cnsltScheduleVO.toString());

		String logJob = "";
		if (EgovStringUtil.isEmpty(cnsltScheduleVO.getSchSeq())) {
			// 등록
			
			if (EgovStringUtil.isEmpty(cnsltScheduleVO.getSchdulEndDate())) {
				cnsltScheduleVO.setSchYmd(cnsltScheduleVO.getSchdulStartDate());	// 날짜 set
				admCnsltSchdulDAO.cnsltScheduleInsert(cnsltScheduleVO);				// 등록
			}else {
				// 시작일과 종료일 비교
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date startDay = format.parse(cnsltScheduleVO.getSchdulStartDate());
				Date endDay = format.parse(cnsltScheduleVO.getSchdulEndDate());
				
				int compare = startDay.compareTo(endDay);
				
				if(compare == 0){	/** == */
					cnsltScheduleVO.setSchYmd(cnsltScheduleVO.getSchdulStartDate());// 날짜 set
					admCnsltSchdulDAO.cnsltScheduleInsert(cnsltScheduleVO);			// 등록
				}else if (compare < 0){	/** < */
					
					long diff = endDay.getTime() - startDay.getTime();
					long diffDays = diff / (24 * 60 * 60 * 1000);
					
					for (int i = 0; i < diffDays+1; i++) {
						Calendar cal = Calendar.getInstance();
						cal.setTime(startDay);
						cal.add(Calendar.DATE, i);
						String tmpDay = format.format(cal.getTime());
						cnsltScheduleVO.setSchYmd(tmpDay);							// 날짜 set
						admCnsltSchdulDAO.cnsltScheduleInsert(cnsltScheduleVO);		// 등록
					}
					
				}else{	/** > */
					LOGGER.debug("종료일이 시작일 보다 크다.(startDay = "+startDay+", endDay = "+endDay+")");
					searchVO.setMessage("종료일이 시작일 보다 큽니다.");
					return redirectListPage(searchVO, reda);
				}
			}
			logJob = "상담 > 상담일정 > 등록()";
			searchVO.setMessage("등록되었습니다.");
		}else{
			// 수정
			admCnsltSchdulDAO.cnsltScheduleUpdate(cnsltScheduleVO);

			logJob = "상담 > 상담일정 > 수정("+cnsltScheduleVO.getSchSeq()+")";
			searchVO.setMessage("수정되었습니다.");
		}
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		admCmmLogDAO.insertLogOne(logJob, ip);
		return redirectListPage(searchVO, reda);
	}

	// 삭제
	@RequestMapping("/xabdmxgr/cnslt/schdul/admCnsltScheduleDelete.do")
	public String admCnsltScheduleDelete(@RequestParam String schSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/cnslt/schdul/admCnsltScheduleDelete.do - 관리자 > 상담 > 상담일정 삭제");
		LOGGER.debug("schSeq = "+schSeq);
		admCnsltSchdulDAO.cnsltScheduleDelete(schSeq);
		
		String logJob = "";
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		logJob = "상담 > 상담일정 > 삭제("+schSeq+")";
		admCmmLogDAO.insertLogOne(logJob, ip);
		searchVO.setMessage("삭제되었습니다.");
		return redirectListPage(searchVO, reda);
	}
	
}
