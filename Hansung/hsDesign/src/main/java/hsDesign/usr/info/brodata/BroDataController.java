//200408주석      >>> 같은 기능으로 CmmboardController 에 있음

//package hsDesign.usr.info.brodata;
//
//import javax.servlet.http.HttpSession;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.ModelMap;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import component.web.PaginationController;
//import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
//import hsDesign.valueObject.cmm.CmmnListVO;
//import hsDesign.valueObject.cmm.CmmnSearchVO;
//
//@Controller
//public class BroDataController {
//	private static final Logger LOGGER = LoggerFactory.getLogger(BroDataController.class);
//	
//	@Autowired private BroDataDAO broDataDAO;
//	
//	// 목록
//	@RequestMapping("/usr/info/brodata/broDataList.do")
//	public String broDataList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
//		LOGGER.info("/usr/info/brodata/broDataList.do - 사용자 > 한디원소개 > 작품자료실 - 목록");
//		LOGGER.debug("searchVO.toString = {}", searchVO.toString());
//		
//		// incLeft 메뉴
//		session.setAttribute("menuNo", "16003");
//		
//		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 9, 5);
//		CmmnListVO listVO = broDataDAO.selectBroDataList(searchVO);
//		
//		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
//		
//		model.addAttribute("paginationInfo", paginationInfo);
//		model.addAttribute("resultList", listVO.getEgovList());
//		
//		return "/usr/info/brodata/broDataList";
//	}
//}
