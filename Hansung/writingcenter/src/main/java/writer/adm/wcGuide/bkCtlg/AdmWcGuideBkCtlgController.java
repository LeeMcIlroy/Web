package writer.adm.wcGuide.bkCtlg;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.BookcatalogVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmWcGuideBkCtlgController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmWcGuideBkCtlgController.class);
	
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	@Autowired private AdmWcGuideBkCtlgDAO admWcGuideBkCtlgDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	/**************************************** 공통 ****************************************/
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, String message, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogList.do";
	}
	
	// 삭제
	private void bookcatalogDelete(String ctlSeq, String ip) throws Exception{
		// 이미지 삭제
		BookcatalogVO bookcatalogVO = admWcGuideBkCtlgDAO.selectWcGuideBkCtlgOne(ctlSeq);
		cmmnFileMngUtil.deleteFile(bookcatalogVO.getCtlImgPath());		// 대표이미지 삭제
		cmmnFileMngUtil.deleteFile(bookcatalogVO.getCtlImgThumbPath());	// 썸네일이미지 삭제
		
		// 글 삭제
		admWcGuideBkCtlgDAO.wcGuideBkCtlgDelete(ctlSeq);
		
		// 로그 등록
		admCmmLogDAO.insertLogOne("글쓰기 길잡이 > 도서목록 > 삭제("+ctlSeq+")", ip);
	}
	
	/**************************************** 도서목록 ****************************************/
	// 목록
	@RequestMapping("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogList.do")
	public String admWcGuideBookCatalogList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogList.do - 관리자 > 글쓰기 길잡이 > 도서목록 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("admMenuNo", "303");
		
		if (EgovStringUtil.isEmpty(searchVO.getSearchType())) {
			searchVO.setSearchType("NORMAL");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admWcGuideBkCtlgDAO.selectWcGuideBkCtlgList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/wcGuide/bkCtlg/admWcGuideBookCatalogList";
	}
	
	// 조회
	@RequestMapping("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogView.do")
	public String admWcGuideBookCatalogView(@RequestParam String ctlSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogView.do - 관리자 > 글쓰기 길잡이 > 도서목록 조회");
		LOGGER.debug("ctlSeq ="+ctlSeq);
		
		BookcatalogVO bookcatalogVO = admWcGuideBkCtlgDAO.selectWcGuideBkCtlgOne(ctlSeq);
		if (bookcatalogVO == null) {
			LOGGER.debug("선택한 글이 없습니다.(ctlSeq = "+ctlSeq+")");
			return redirectListPage(searchVO, "선택한 글이 없습니다.", reda);
		}
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("글쓰기 길잡이 > 도서목록 > 조회("+ctlSeq+")", ip);
		model.addAttribute("bookcatalogVO", bookcatalogVO);
		return "/adm/wcGuide/bkCtlg/admWcGuideBookCatalogView";
	}
	
	// 등록&수정화면
	@RequestMapping("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogModify.do")
	public String admWcGuideBookCatalogModify(String ctlSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogModify.do - 관리자 > 글쓰기 길잡이 > 도서목록 등록&수정 화면");
		LOGGER.debug("ctlSeq = "+ctlSeq);
		
		BookcatalogVO bookcatalogVO = null;
		if (EgovStringUtil.isEmpty(ctlSeq)) {
			// 등록화면
			bookcatalogVO = new BookcatalogVO();
		}else{
			// 수정화면
			bookcatalogVO = admWcGuideBkCtlgDAO.selectWcGuideBkCtlgOne(ctlSeq);
		}
		
		model.addAttribute("bookcatalogVO", bookcatalogVO);
		return "/adm/wcGuide/bkCtlg/admWcGuideBookCatalogModify";
	}
	
	// 등록&수정
	@RequestMapping("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogUpdate.do")
	public String admWcGuideBookCatalogUpdate(BookcatalogVO bookcatalogVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogUpdate.do - 관리자 > 글쓰기 길잡이 > 도서목록 등록&수정");
		LOGGER.debug("bookcatalogVO = "+bookcatalogVO.toString());
		String message = "";
		String logJob = "";
		if(EgovStringUtil.isEmpty(bookcatalogVO.getCtlSeq())){
			// 등록
			
			// 첨부파일 등록
			FileInfoVO fileInfoVO = cmmnFileMngUtil.uploadAttachedImgFile(multiRequest, "BOOKCATALOG");
			
			if (fileInfoVO == null) {
				LOGGER.debug("파일업로드에 실패하였습니다.");
				message = "파일업로드에 실패하였습니다.";
				return redirectListPage(searchVO, message, reda);
			}
			
			bookcatalogVO.setCtlImgName(fileInfoVO.getFileName());
			bookcatalogVO.setCtlImgPath(fileInfoVO.getFilePath());
			bookcatalogVO.setCtlImgThumbPath(fileInfoVO.getFileThumbPath());
			
			admWcGuideBkCtlgDAO.wcGuideBkCtlgInsert(bookcatalogVO);
			
			logJob = "글쓰기 길잡이 > 도서목록 > 등록";
			
			message = "등록되었습니다.";
		}else{
			// 수정
			
			// 첨부파일 등록
			FileInfoVO fileInfoVO = cmmnFileMngUtil.uploadAttachedImgFile(multiRequest, "BOOKCATALOG");
			
			if(fileInfoVO != null){
				
				// 기존 파일 삭제
				cmmnFileMngUtil.deleteFile(bookcatalogVO.getCtlImgPath());		// 대표이미지 삭제
				cmmnFileMngUtil.deleteFile(bookcatalogVO.getCtlImgThumbPath());	// 썸네일이미지 삭제
				
				bookcatalogVO.setCtlImgName(fileInfoVO.getFileName());
				bookcatalogVO.setCtlImgPath(fileInfoVO.getFilePath());
				bookcatalogVO.setCtlImgThumbPath(fileInfoVO.getFileThumbPath());
			}
			
			admWcGuideBkCtlgDAO.wcGuideBkCtlgUpdate(bookcatalogVO);
			
			logJob = "글쓰기 길잡이 > 도서목록 > 수정("+bookcatalogVO.getCtlSeq()+")";
			
			message = "수정되었습니다.";
		}
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne(logJob, ip);
		
		return redirectListPage(searchVO, message, reda);
	}
	
	// 삭제_조회_삭제
	@RequestMapping("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogDelete.do")
	public String admWcGuideBookCatalogDelete(@RequestParam String ctlSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogDelete.do - 관리자 > 글쓰기 길잡이 > 도서목록 삭제");
		LOGGER.debug("ctlSeq = "+ctlSeq);
		
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		bookcatalogDelete(ctlSeq, ip);
	
		return redirectListPage(searchVO, "삭제되었습니다.", reda);
	}
	
	// 삭제_목록_일괄삭제
	@RequestMapping("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogDeleteAll.do")
	public String admWcGuideBookCatalogDeleteAll(@RequestParam String ctlDeleteChk, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogDeleteAll.do - 관리자 > 글쓰기 길잡이 > 도서목록 일괄삭제");
		LOGGER.debug("ctlDeleteChk = "+ctlDeleteChk);

		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		
		String[] arrCtlSeq = ctlDeleteChk.split(",");
		for(String ctlSeq : arrCtlSeq){
			bookcatalogDelete(ctlSeq, ip);
		}
		
		return redirectListPage(searchVO, "일괄삭제되었습니다.", reda);
	}
}
