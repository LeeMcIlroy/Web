package hsDesign.adm.siteMng.admission;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmAdmissionController extends AdmCmmController{

	private final static Logger LOGGER = LoggerFactory.getLogger(AdmAdmissionController.class);
	@Autowired private AdmAdmissionDAO admAdmissionDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/siteMng/admission/admAdmissionList.do";
	}
	
	// 목록
	@RequestMapping("/qxerpynm/siteMng/admission/admAdmissionList.do")
	public String admAdmissionList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/siteMng/admission/admAdmissionList.do - 관리자 > 입학안내 > 브로셔목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "606");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admAdmissionDAO.selectAdmissionList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 로그등록
		admLogInsert(null, "상담회 신청", "목록", request);
		
		return "/adm/siteMng/admission/admAdmissionList";
	}
	
	// 삭제
	@RequestMapping("/qxerpynm/siteMng/admission/admAdmissionDelete.do")
	public String admAdmissionDelete(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda, String adSeq, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/siteMng/admission/admAdmissionDelete.do - 관리자 > 입학안내 > 브로셔목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("adSeq = "+adSeq);
		
		String message = "오류가 발생하였습니다."; 	
		
		if(EgovStringUtil.isEmpty(adSeq)) {
			searchVO.setMessage("신청번호가 존재하지않습니다.");
			 return redirectListPage(message, searchVO, reda);
		}
		
		admAdmissionDAO.deleteAdmissionOne(adSeq);
		message = "삭제되었습니다.";
		
		// 로그등록
		admLogInsert(null, "상담회 신청 삭제", adSeq, request);
		
		return redirectListPage(message, searchVO, reda);
	}
	
		
	
}
