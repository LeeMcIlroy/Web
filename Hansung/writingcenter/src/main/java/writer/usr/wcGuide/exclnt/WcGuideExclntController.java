package writer.usr.wcGuide.exclnt;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import writer.usr.cmm.CmmnBoardDAO;
import writer.usr.cntst.CntstController;
import writer.valueObject.BoardVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

import component.web.PaginationController;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class WcGuideExclntController {

	private final static Logger LOGGER = LoggerFactory.getLogger(CntstController.class);
	@Autowired CmmnBoardDAO cmmnBoardDAO;
	
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/usr/wcGuide/exclnt/wcGuideExclntList.do";		// 목록
		
		return redirectPage;
		
	}
		
	// 목록
	@RequestMapping("/usr/wcGuide/exclnt/wcGuideExclntList.do")
	public String cnstDataList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO")CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/usr/wcGuide/exclnt/wcGuideExclntList.do - 사용자 > 글쓰기길잡이 > 우수과제 목록");
		LOGGER.debug("searchVO - "+searchVO.toString());
		request.getSession().setAttribute("menuNo", "602");
		
		searchVO.setSearchType("EXCLNT");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=cmmnBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> noticeListVO = cmmnBoardDAO.selectCmmnBoardNoticeList(searchVO.getSearchType());
		model.addAttribute("resultList_notice", noticeListVO);
		
		return "/usr/wcGuide/exclnt/wcGuideExcellentList";
	}
	
	// 조회
	@RequestMapping("/usr/wcGuide/exclnt/wcGuideExclntView.do")
	public String cnstDataView(ModelMap model, String brdSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/wcGuide/exclnt/wcGuideExclntView.do - 사용자 > 글쓰기길잡이 > 우수과제 조회");
		LOGGER.debug("brdSeq"+brdSeq);
		
		BoardVO boardVO=cmmnBoardDAO.selectCmmnBoardOne(brdSeq);
		List<EgovMap> upfileList=cmmnBoardDAO.selectCmmnBoardUpfileList(brdSeq);
		if(boardVO==null){
			searchVO.setMessage("게시글이 없습니다.");
			LOGGER.debug("message-"+searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		model.addAttribute("boardVO",boardVO);
		model.addAttribute("upfileList", upfileList);
		return "/usr/wcGuide/exclnt/wcGuideExcellentView";
	}
}
