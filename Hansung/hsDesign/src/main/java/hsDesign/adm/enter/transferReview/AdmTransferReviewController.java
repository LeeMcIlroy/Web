package hsDesign.adm.enter.transferReview;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.TransferReviewVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmTransferReviewController extends AdmCmmController {

	private final static Logger LOGGER = LoggerFactory.getLogger(AdmTransferReviewController.class);
	@Autowired private AdmTransferReviewDAO admTRDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/enter/transferReview/admTransferReviewList.do";
	}
	
	// 목록
	@RequestMapping("/qxerpynm/enter/transferReview/admTransferReviewList.do")
	public String admTransferReviewList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/enter/transferReview/admTransferReviewList.do - 관리자 > 입학안내 > 편입성공사례목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "203");
		if(searchVO.getMenuType().equals("")) {
			searchVO.setMenuType("01");
			
		}
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admTRDAO.selectTransferReviewList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		
		for(EgovMap vo: listVO.getEgovList()) {
			vo.put("trActivity", vo.get("trActivity").toString().replaceAll("\r\n", "<br/>"));
		}
		
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 로그등록
		admLogInsert(null, "편입성공사례", "목록", request);
		
		return "/adm/enter/transferReview/admTransferReviewList";
	}
	
	// 등록 & 수정화면
	@RequestMapping("/qxerpynm/enter/transferReview/admTransferReviewModify.do")
	public String admTransferReviewModify(String trSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.debug("/qxerpynm/enter/transferReview/admTransferReviewModify.do - 관리자 > 입학안내 > 편입성공사례 > 등록&수정화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("trSeq = "+trSeq);
		
		TransferReviewVO transferReviewVO;
		
		if(EgovStringUtil.isEmpty(trSeq)){
			// 등록
			transferReviewVO = new TransferReviewVO();
		}else{
			// 수정
			transferReviewVO = admTRDAO.selectTransferReviewOne(trSeq);
			
		}
		
		List<EgovMap> majorList = admTRDAO.selectMajorList();
		
		model.addAttribute("majorList", majorList);
		model.addAttribute("transferReviewVO", transferReviewVO);
		return "/adm/enter/transferReview/admTransferReviewModify";
	}
	
	// 등록&수정
	@RequestMapping("/qxerpynm/enter/transferReview/admTransferReviewUpdate.do")
	public String admTransferReviewUpdate(TransferReviewVO transferReviewVO , @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/enter/transferReview/admTransferReviewUpdate.do - 관리자 > 입학안내 > 편입성공사례 > 등록&수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("transferReviewVO = "+transferReviewVO.toString());
		
		String message = "";
		transferReviewVO.setTrActivity(EgovWebUtil.clearXSSMinimum(transferReviewVO.getTrActivity()));
		
		if(EgovStringUtil.isEmpty(transferReviewVO.getTrSeq())){
			// 등록
			admTRDAO.insertTransferReviewOne(transferReviewVO);
			message = "등록되었습니다.";
			
			
			// 로그등록
			admLogInsert(null, "편입성공사례", "등록", request);
		}else{
			// 수정
			admTRDAO.updateTransferReviewOne(transferReviewVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "편입성공사례 수정", transferReviewVO.getTrSeq(), request);
		}
		
		
		return redirectListPage(message, searchVO, reda);
	}
	
	// 삭제
	@RequestMapping("/qxerpynm/enter/transferReview/admTransferReviewDelete.do")
	public String admTransferReviewDelete(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda, String trSeq, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/enter/transferReview/admTransferReviewDelete.do - 관리자 > 입학안내 > 편입성공사례 삭제");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("trSeq = "+trSeq);
		
		String message = "오류가 발생하였습니다."; 	
		
		if(EgovStringUtil.isEmpty(trSeq)) {
			searchVO.setMessage("신청번호가 존재하지않습니다.");
			return redirectListPage(message, searchVO, reda);
		}
		
		admTRDAO.deleteTransferReviewOne(trSeq);
		message = "삭제되었습니다.";
		
		// 로그등록
		admLogInsert(null, "편입성공사례 삭제", trSeq, request);
		
		return redirectListPage(message, searchVO, reda);
	}
}
