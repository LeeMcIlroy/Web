package hsDesign.adm.enter.graduateReview;

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
import hsDesign.valueObject.GraduateReviewVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmGraduateReviewController extends AdmCmmController {

	private final static Logger LOGGER = LoggerFactory.getLogger(AdmGraduateReviewController.class);
	@Autowired private AdmGraduateReviewDAO admGRDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/enter/graduateReview/admGraduateReviewList.do";
	}
	
	// 목록
	@RequestMapping("/qxerpynm/enter/graduateReview/admGraduateReviewList.do")
	public String admGraduateReviewList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/enter/graduateReview/admGraduateReviewList.do - 관리자 > 입학안내 > 대학원&타대학 편입");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "205");
		if(searchVO.getMenuType().equals("")) {
			searchVO.setMenuType("01");
			
		}
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admGRDAO.selectGraduateReviewList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		
		for(EgovMap vo: listVO.getEgovList()) {
			vo.put("grActivity", vo.get("grActivity").toString().replaceAll("\r\n", "<br/>"));
		}
		
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 로그등록
		admLogInsert(null, "대학원&타대학 편입", "목록", request);
		
		return "/adm/enter/graduateReview/admGraduateReviewList";
	}
	
	// 등록 & 수정화면
	@RequestMapping("/qxerpynm/enter/graduateReview/admGraduateReviewModify.do")
	public String admGraduateReviewModify(String grSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.debug("/qxerpynm/enter/graduateReview/admGraduateReviewModify.do - 관리자 > 입학안내 > 대학원&타대학 편입 > 등록&수정화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("grSeq = "+grSeq);
		
		GraduateReviewVO graduateReviewVO;
		
		if(EgovStringUtil.isEmpty(grSeq)){
			// 등록
			graduateReviewVO = new GraduateReviewVO();
		}else{
			// 수정
			graduateReviewVO = admGRDAO.selectGraduateReviewOne(grSeq);
			
		}
		
		List<EgovMap> majorList = admGRDAO.selectMajorList();
		
		model.addAttribute("majorList", majorList);
		model.addAttribute("graduateReviewVO", graduateReviewVO);
		return "/adm/enter/graduateReview/admGraduateReviewModify";
	}
	
	// 등록&수정
	@RequestMapping("/qxerpynm/enter/graduateReview/admGraduateReviewUpdate.do")
	public String admGraduateReviewUpdate(GraduateReviewVO graduateReviewVO , @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/enter/graduateReview/admGraduateReviewUpdate.do - 관리자 > 입학안내 > 대학원&타대학 편입 > 등록&수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("graduateReviewVO = "+graduateReviewVO.toString());
		
		String message = "";
		graduateReviewVO.setGrActivity(EgovWebUtil.clearXSSMinimum(graduateReviewVO.getGrActivity()));
		
		if(EgovStringUtil.isEmpty(graduateReviewVO.getGrSeq())){
			// 등록
			admGRDAO.insertGraduateReviewOne(graduateReviewVO);
			message = "등록되었습니다.";
			
			
			// 로그등록
			admLogInsert(null, "대학원&타대학 편입", "등록", request);
		}else{
			// 수정
			admGRDAO.updateGraduateReviewOne(graduateReviewVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "대학원&타대학 편입 수정", graduateReviewVO.getGrSeq(), request);
		}
		
		
		return redirectListPage(message, searchVO, reda);
	}
	
	// 삭제
	@RequestMapping("/qxerpynm/enter/graduateReview/admGraduateReviewDelete.do")
	public String admGraduateReviewDelete(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda, String grSeq, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/enter/graduateReview/admGraduateReviewDelete.do - 관리자 > 입학안내 > 대학원&타대학 편입 삭제");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("grSeq = "+grSeq);
		
		String message = "오류가 발생하였습니다."; 	
		
		if(EgovStringUtil.isEmpty(grSeq)) {
			searchVO.setMessage("신청번호가 존재하지않습니다.");
			return redirectListPage(message, searchVO, reda);
		}
		
		admGRDAO.deleteGraduateReviewOne(grSeq);
		message = "삭제되었습니다.";
		
		// 로그등록
		admLogInsert(null, "대학원&타대학 편입 삭제", grSeq, request);
		
		return redirectListPage(message, searchVO, reda);
	}
}
