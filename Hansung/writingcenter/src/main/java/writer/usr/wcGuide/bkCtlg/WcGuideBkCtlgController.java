package writer.usr.wcGuide.bkCtlg;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import writer.valueObject.BookcatalogVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class WcGuideBkCtlgController {

	private final static Logger LOGGER = LoggerFactory.getLogger(WcGuideBkCtlgController.class);
	@Autowired WcGuideBkCtlgDAO wcGuideBkCtlgDAO;
	
	/**************************************** 공통 ****************************************/
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, String message, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do";
	}
	
	/**************************************** 도서목록 ****************************************/
	// 목록
	@RequestMapping("/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do")
	public String admWcGuideBookCatalogList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do - 사용자 > 글쓰기 길잡이 > 도서목록 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("menuNo", "603");
		
		if (EgovStringUtil.isEmpty(searchVO.getSearchType())) {
			searchVO.setSearchType("NORMAL");
		}
		
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO,8,10);
		CmmnListVO listVO = wcGuideBkCtlgDAO.selectWcGuideBkCtlgList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/usr/wcGuide/bkCtlg/wcGuideBookCatalogList";
	}
	
	// 조회
	@RequestMapping("/usr/wcGuide/bkCtlg/wcGuideBookCatalogView.do")
	public String admWcGuideBookCatalogView(@RequestParam String ctlSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/wcGuide/bkCtlg/wcGuideBookCatalogView.do - 사용자 > 글쓰기 길잡이 > 도서목록 조회");
		LOGGER.debug("ctlSeq ="+ctlSeq);
		
		BookcatalogVO bookcatalogVO = wcGuideBkCtlgDAO.selectWcGuideBkCtlgOne(ctlSeq);
		
		if (bookcatalogVO == null) {
			LOGGER.debug("선택한 글이 없습니다.(ctlSeq = "+ctlSeq+")");
			return redirectListPage(searchVO, "선택한 글이 없습니다.", reda);
		}
		
		model.addAttribute("bookcatalogVO", bookcatalogVO);
		return "/usr/wcGuide/bkCtlg/wcGuideBookCatalogView";
	}
}
