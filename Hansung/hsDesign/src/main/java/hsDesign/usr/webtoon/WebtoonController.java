package hsDesign.usr.webtoon;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import component.web.PaginationController;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class WebtoonController {
	private static final Logger LOGGER = LoggerFactory.getLogger(WebtoonController.class);
	
	@Autowired private WebtoonDAO webtoonDAO;
	
	// 목록
	@RequestMapping("/usr/community/webtoon/webtoonList.do")
	public String webtoonList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/community/webtoon/webtoonList.do - 사용자 > 커뮤니티 > 웹툰&동영상 > 한툰 목록");
		LOGGER.debug("searchVO = {}", searchVO);
		
		// tap set - start
//		searchVO.setMenuType("0802");
		// tap set - end
		
		session.setAttribute("menuNo", "16002");
		
		// webtoon category set - start
		model.addAttribute("webtoonCategory", webtoonDAO.selectWebtoonCategoryList());
		// webtoon category set - end
		
		// webtoon list - start
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 5);
		CmmnListVO listVO = webtoonDAO.selectWebtoonList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		// webtoon list - end
		
		return "/usr/community/webtoon/webtoonList";
	}
	
	// 조회
	@RequestMapping("/usr/community/webtoon/webtoonView.do")
	public String webtoonView(@RequestParam String wSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/usr/community/webtoon/webtoonView.do - 사용자 > 커뮤니티 > 웹툰&동영상 > 한툰 조회");
		LOGGER.debug("searchVO = {}\nwSeq = {}", searchVO.toString(), wSeq);
		model.addAttribute("resultVO", webtoonDAO.selectWebtoonOne(wSeq));
		return "/usr/community/webtoon/webtoonView";
	}
}
