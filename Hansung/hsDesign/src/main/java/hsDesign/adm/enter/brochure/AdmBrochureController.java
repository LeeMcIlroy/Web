package hsDesign.adm.enter.brochure;

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
public class AdmBrochureController extends AdmCmmController{

	private final static Logger LOGGER = LoggerFactory.getLogger(AdmBrochureController.class);
	@Autowired private AdmBrochureDAO admBrochureDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/enter/brochure/admBrochureList.do";
	}
	
	// 목록
	@RequestMapping("/qxerpynm/enter/brochure/admBrochureList.do")
	public String admBrochureList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/enter/brochure/admBrochureList.do - 관리자 > 입학안내 > 브로셔목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "202");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admBrochureDAO.selectBrochureList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 로그등록
		admLogInsert(null, "브로셔", "목록", request);
		
		return "/adm/enter/brochure/admBrochureList";
	}
	
	// 삭제
	@RequestMapping("/qxerpynm/enter/brochure/admBrochureDelete.do")
	public String admBrochureDelete(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda, String brcSeq, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/enter/brochure/admBrochureDelete.do - 관리자 > 입학안내 > 브로셔목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("brcSeq = "+brcSeq);
		
		String message = "오류가 발생하였습니다."; 	
		
		if(EgovStringUtil.isEmpty(brcSeq)) {
			searchVO.setMessage("신청번호가 존재하지않습니다.");
			 return redirectListPage(message, searchVO, reda);
		}
		
		admBrochureDAO.deleteBrochureOne(brcSeq);
		message = "삭제되었습니다.";
		
		// 로그등록
		admLogInsert(null, "브로셔 삭제", brcSeq, request);
		
		return redirectListPage(message, searchVO, reda);
	}
	
		
	
}
