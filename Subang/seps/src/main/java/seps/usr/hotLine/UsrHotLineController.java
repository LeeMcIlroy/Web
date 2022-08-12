package seps.usr.hotLine;

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
import org.springframework.web.servlet.View;

import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;

import component.web.PaginationController;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class UsrHotLineController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UsrHotLineController.class);
	
	@Resource View jsonView;
	
	@Autowired private UsrHotLineDAO dao;
	
	//사용자 비상연락망
	@RequestMapping("/usr/hotLine/hotLineList.do")
	public String hotLine(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/hotLine/hotLineList.do - 사용자 비상연락망");
		if(session != null) session.setAttribute("leftMeneNo", "601");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		
		CmmnListVO listVO = dao.selectHotLineList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> deptList = dao.selectHotlineDeptList();
		model.addAttribute("deptList", deptList);
		
		return "/usr/hotLine/hotLineList";
	}
}
