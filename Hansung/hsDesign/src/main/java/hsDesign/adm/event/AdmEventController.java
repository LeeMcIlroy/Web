package hsDesign.adm.event;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.web.PaginationController;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.EventVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmEventController extends AdmCmmController{

	private final static Logger LOGGER = LoggerFactory.getLogger(AdmEventController.class);
	@Autowired private AdmEventDAO admEventDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/event/admEventList.do";
	}
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage2(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/event/admEventCancelList.do";
	}
	
	// 신청 목록
	@RequestMapping("/qxerpynm/event/admEventList.do")
	public String admEventList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/event/admEventList.do - 관리자 > 진로&교양과정 > 행사참가신청");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "505");
		
		searchVO.setSearchCondition3("N");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admEventDAO.selectEventList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<String> eveNumList = admEventDAO.selectEveNumList();
		model.addAttribute("eveNumList", eveNumList);
		
		// 로그등록
		admLogInsert(null, "행사참가신청", "목록", request);
		
		return "/adm/event/admEventList";
	}
	
	// 취소 목록
	@RequestMapping("/qxerpynm/event/admEventCancelList.do")
	public String admEventCancelList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/event/admEventCancelList.do - 관리자 > 진로&교양과정 > 행사참가취소");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "506");
		
		searchVO.setSearchCondition3("Y");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admEventDAO.selectEventList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<String> eveNumList = admEventDAO.selectEveNumList();
		model.addAttribute("eveNumList", eveNumList);
		
		// 로그등록
		admLogInsert(null, "행사참가취소", "목록", request);
		
		return "/adm/event/admEventCancelList";
	}
	
	// 행사참가비 입금여부 수정
	@RequestMapping("/qxerpynm/event/admEventDepoYnUpdate.do")
	public String admEventDepoYnUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, EventVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/event/admEventDepoYnUpdate.do - 행사참가비 입금여부 수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		if(!EgovStringUtil.isEmpty(paramVO.getEveRefundYn())){
			admEventDAO.updateAdmEventRefundYn(paramVO);
			admLogInsert(null, "행사참가비 환불여부", "수정", request);
		}
		admEventDAO.updateAdmEventDepoYn(paramVO);
		
		// 로그등록
		admLogInsert(null, "행사참가비 입금여부", "수정", request);
		reda.addFlashAttribute("searchVO", searchVO);
		
		if(!EgovStringUtil.isEmpty(paramVO.getEveRefundYn())) {
			return "redirect:/qxerpynm/event/admEventCancelList.do";
		}
		return "redirect:/qxerpynm/event/admEventList.do";
	}
	
	// 행사참가비 환불여부 수정
	@RequestMapping("/qxerpynm/event/admEventRefundYnUpdate.do")
	public String admEventRefundYnUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, EventVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/event/admEventRefundYnUpdate.do - 행사참가비 입금환불 수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		admEventDAO.updateAdmEventRefundYn(paramVO);
		
		// 로그등록
		admLogInsert(null, "행사참가비 환불여부", "수정", request);
		reda.addFlashAttribute("searchVO", searchVO);
		
		return "redirect:/qxerpynm/event/admEventCancelList.do";
	}
	
	// 행사참가신청 삭제
	@RequestMapping("/qxerpynm/event/admEventDelete.do")
	public String admEventDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, EventVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/event/admEventDelete.do - 행사참가신청 삭제");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		admEventDAO.deleteAdmEvent(paramVO);
		
		// 로그등록
		admLogInsert(null, "행사참가신청", "삭제", request);
		reda.addFlashAttribute("searchVO", searchVO);
		
		if(!EgovStringUtil.isEmpty(paramVO.getEveRefundYn())) return "redirect:/qxerpynm/event/admEventCancelList.do";
		return "redirect:/qxerpynm/event/admEventList.do";
	}
	
	// 행사참가 - 정보조회
	@RequestMapping("/qxerpynm/event/admEventModify.do")
	public String admEventModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String eveSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/event/admEventModify.do - 행사참가 정보");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("eveSeq = "+eveSeq);
		
		EventVO paramVO = admEventDAO.selectAdmEventOne(eveSeq);
		model.addAttribute("eventVO", paramVO);
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/event/admEventModify";
	}
	
	@RequestMapping("/qxerpynm/event/admEventExcelDownload.do")
	public void admEventExcelDownload(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda){
		LOGGER.info("/qxerpynm/event/admEventExcelDownload.do - 행사참가신청 엑셀 다운로드");
		LOGGER.debug(searchVO.toString());
		
		List<EgovMap> egovList = admEventDAO.selectEventExcelList(searchVO);
		Map<String, Object> map = new HashMap<String, Object>();
		AdminVO adminvo = (AdminVO) request.getSession().getAttribute("adminSession");
		
		map.put("resultList", egovList);
		map.put("printUser", adminvo.getAdmName());
		map.put("printTime",new SimpleDateFormat("yyyy년 MM월 dd일", Locale.KOREA).format( new Date() ));
		ExcelUtil eUtil = new ExcelUtil();
		String excelName="", fileName="";
		
		excelName = "eventCancelFile";
		fileName = "행사참가신청 리스트";
		
		try {
			eUtil.getPerformanceExcel(map, fileName, excelName, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
