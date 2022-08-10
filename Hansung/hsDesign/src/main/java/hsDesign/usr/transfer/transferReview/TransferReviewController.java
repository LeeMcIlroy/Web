package hsDesign.usr.transfer.transferReview;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.usr.cmm.CmmController;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class TransferReviewController extends CmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TransferReviewController.class);
	
	@Autowired private TransferReviewDAO transferReviewDAO;
	
	// 모집요강
	@RequestMapping("/usr/transfer/prospectus.do")
	public String transferProspectus(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/transfer/prospectus.do - 사용자 > 편입 > 모집요강");
		session.setAttribute("menuNo", "301");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/transfer/prospectus";
	}
	
	// 입학 모집요강
	@RequestMapping("/usr/enter/prospectus.do")
	public String enterProspectus(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/enter/prospectus.do - 사용자 > 편입 > 모집요강");
		session.setAttribute("menuNo", "201");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/enter/prospectus";
	}
	
	// 목록
	@RequestMapping("/usr/transfer/transferReview/transferReviewList.do")
	public String transferReviewList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/transfer/transferReview/transferReviewList.do - 사용자 > 편입 > 편입성공사례 > 목록");
		LOGGER.debug("searchVO = {}", searchVO.toString());

		if(EgovStringUtil.isEmpty(searchVO.getSearchType())) searchVO.setSearchType("01");
		
		if(EgovStringUtil.isEmpty(searchVO.getMenuType())) searchVO.setMenuType("01");
		
		if("01".equals(searchVO.getMenuType())){
			// menuNo
			session.setAttribute("menuNo", "10105");
		}
		
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 10, 10);
		CmmnListVO listVO = transferReviewDAO.selectTransferReviewList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);

		for(EgovMap vo : listVO.getEgovList()){
			if("01".equals(searchVO.getSearchType())){
				vo.put("trActivity", vo.get("trActivity").toString().replaceAll("\r\n", "<br/>"));
			}else{
				vo.put("grActivity", vo.get("grActivity").toString().replaceAll("\r\n", "<br/>"));
			}
		}
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		
		model.addAttribute("bannerList", selectLeftBannerList());
		
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/usr/transfer/transferReview/transferReviewList";
	}
}
