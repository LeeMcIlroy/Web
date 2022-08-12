package seps.adm.floodCenter.sns;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import component.web.PaginationController;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import seps.cmmn.CmmnDAO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;

@Controller
public class AdmSnsController {
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmSnsController.class);
	
	@Resource View jsonView;
	@Autowired CmmnDAO cmmnDAO;
	@Autowired private AdmSnsDAO dao;
	
	// 목록
	@RequestMapping("/adm/floodCenter/snsList.do")
	public String snsList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/adm/floodCenter/snsList.do - 관리자 > 수방센터 > sns공유현황 - 목록");
		if(session != null) session.setAttribute("leftMeneNo", "304");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		
		CmmnListVO listVO = dao.selectSnsList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/floodCenter/sns/snsList";
	}
}
