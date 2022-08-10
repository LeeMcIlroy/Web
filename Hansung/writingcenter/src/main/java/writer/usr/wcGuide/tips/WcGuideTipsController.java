package writer.usr.wcGuide.tips;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import component.web.PaginationController;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class WcGuideTipsController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(WcGuideTipsController.class);
	
	@Autowired private WcGuideTipsDAO wcGuideTipsDAO;
	
	// 목록
	@RequestMapping("/usr/wcGuide/tips/wcGuideTipsList.do")
	public String wcGuideTipsList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/wcGuide/tips/wcGuideTipsList.do - 사용자 > 글쓰기 길잡이 > 라이팅팁스 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("menuNo", "601");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = wcGuideTipsDAO.selectWcGuideTipsList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 스크립트 제거
		for(EgovMap vo : listVO.getEgovList()){
			if (vo.get("tipContent") != null) {
				String removeTagStr = EgovWebUtil.clearXSSMinimum(vo.get("tipContent").toString());
				removeTagStr = removeTagStr.replace("\r\n", "<br/>");
				vo.put("tipContent", removeTagStr);
			}
		}
		
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/usr/wcGuide/tips/wcGuideTipsList";
	}
}
