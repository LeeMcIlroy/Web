package hsDesign.adm.general.info;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.GEUpfileVO;
import hsDesign.valueObject.GeneralEduVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmGeneralInfoController extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmGeneralInfoController.class);
	
	@Autowired private AdmGeneralInfoDAO admGeneralInfoDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/general/info/admGeneralInfoList.do";
	}
	
	// 목록
	@RequestMapping("/qxerpynm/general/info/admGeneralInfoList.do")
	public String admGeneralInfoList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/general/info/admGeneralInfoList.do - 관리자 > 교양과정 > 교양과정안내 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft menu
		session.setAttribute("admMenuNo", "501");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		CmmnListVO listVO = admGeneralInfoDAO.selectGeneralInfoList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 로그등록
		admLogInsert(null, "교양과정안내", "목록", request);
		
		return "/adm/general/info/admGeneralInfoList";
	}
	
	// 조회
	@RequestMapping("/qxerpynm/general/info/admGeneralInfoView.do")
	public String admGeneralInfoView(@RequestParam String geSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/general/info/admGeneralInfoView.do - 관리자 > 교양과정 > 교양과정안내 조회");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("geSeq = "+geSeq);
		
		GeneralEduVO generalEduVO = admGeneralInfoDAO.selectGeneralInfoOne(geSeq);
		model.addAttribute("generalEduVO", generalEduVO);
		
		// 첨부파일
		CmmnListVO geUpfileListVO = admGeneralInfoDAO.selectGeneralInfoUpfileList(geSeq);
		model.addAttribute("geUpfileList", geUpfileListVO.getEgovList());
		
		// 로그등록
		admLogInsert(null, "교양과정안내 조회", geSeq, request);
		
		return "/adm/general/info/admGeneralInfoView";
	}
	
	// 등록&수정 화면
	@RequestMapping("/qxerpynm/general/info/admGeneralInfoModify.do")
	public String admGeneralInfoModify(String geSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/general/info/admGeneralInfoModify.do - 관리자 > 교양과정 > 교양과정안내 등록&수정화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		GeneralEduVO generalEduVO = null;
		
		if(EgovStringUtil.isEmpty(geSeq)){
			// 등록
			generalEduVO = new GeneralEduVO();
		}else{
			// 수정
			generalEduVO = admGeneralInfoDAO.selectGeneralInfoOne(geSeq);
			
			// 첨부파일
			CmmnListVO geUpfileListVO = admGeneralInfoDAO.selectGeneralInfoUpfileList(geSeq);
			model.addAttribute("geUpfileListVO", geUpfileListVO);
		}
		
		model.addAttribute("generalEduVO", generalEduVO);
		return "/adm/general/info/admGeneralInfoModify";
	}
	
	// 등록&수정
	@RequestMapping("/qxerpynm/general/info/admGeneralInfoUpdate.do")
	public String admGeneralInfoUpdate(GeneralEduVO generalEduVO, String[] geUpfileDelChk, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/general/info/admGeneralInfoUpdate.do - 관리자 > 교양과정 > 교양과정안내 등록&수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("generalEduVO = "+generalEduVO.toString());
		
		String message = "오류발생(-1)";
		String rsGenSeq = "";
		
		if(EgovStringUtil.isEmpty(generalEduVO.getGeContent().trim())) {
			LOGGER.debug("/qxerpynm/general/info/admGeneralInfoUpdate.do - 오류발생(-3) : content empty...");
			message = "오류발생(-3)";
			return redirectListPage(message, searchVO, reda);
		}
		
		
		// 수강시간 set
		/*
		generalEduVO.setGeLectureBeginTm(generalEduVO.getGeLectureBeginTm1()+":"+generalEduVO.getGeLectureBeginTm2());
		generalEduVO.setGeLectureEndTm(generalEduVO.getGeLectureEndTm1()+":"+generalEduVO.getGeLectureEndTm2());
		*/
		// xss 치환(제목)
		generalEduVO.setGeName(EgovWebUtil.clearXSSMinimum(generalEduVO.getGeName()));
		
		// 파일 용량 검사
		if(!cmmnFileMngUtil.uploadFileSizeChk(multiRequest)){
			LOGGER.debug("/qxerpynm/general/info/admGeneralInfoUpdate.do - 오류발생(-4) : fileSize check...");
			return redirectListPage("오류발생(-4)", searchVO, reda);
		}
		
		// 파일 확장자 검사
		if(!cmmnFileMngUtil.uploadFileExtChk(multiRequest)){
			LOGGER.debug("/qxerpynm/general/info/admGeneralInfoUpdate.do - 오류발생(-5) : fileExt check...");
			return redirectListPage("오류발생(-5)", searchVO, reda);
		}
		
		if(EgovStringUtil.isEmpty(generalEduVO.getGeSeq())){
			// 등록
			rsGenSeq = admGeneralInfoDAO.generalInfoInsert(generalEduVO);
			message = "등록되었습니다.";
			
			// 로그등록
			admLogInsert(null, "교양과정안내 등록", rsGenSeq, request);
		}else{
			// 수정
			if(geUpfileDelChk != null){
				// 첨부파일 삭제
				if(geUpfileDelChk.length > 0){
					for (int i = 0; i < geUpfileDelChk.length; i++) {
						GEUpfileVO geUpfileVO = admGeneralInfoDAO.selectGeneralInfoUpfileOne(geUpfileDelChk[i]);
						// 원본파일 삭제
						cmmnFileMngUtil.deleteFile(geUpfileVO.getGeupSaveFilepath());
						
						// thumbnail 삭제
						String fileExt = geUpfileVO.getGeupSaveFilepath().substring(geUpfileVO.getGeupSaveFilepath().lastIndexOf(".")+1);
						if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
							String filePath = geUpfileVO.getGeupSaveFilepath().substring(0, geUpfileVO.getGeupSaveFilepath().lastIndexOf("."));
							String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
							cmmnFileMngUtil.deleteFile(fileThumbPath);
						}
						
						// DB 삭제
						admGeneralInfoDAO.generalInfoUpfileDelete(geUpfileDelChk[i]);			
					}
				}
			}
			
			admGeneralInfoDAO.generalInfoUpdate(generalEduVO);
			rsGenSeq = generalEduVO.getGeSeq();
			
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "교양과정안내 수정", rsGenSeq, request);
		}
		
		// 첨부파일 등록
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "GENERALEDU");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				admGeneralInfoDAO.generalInfoUpfileInsert(fileInfoVO, rsGenSeq);
			}
		}		
		
		return redirectListPage(message, searchVO, reda);
	}
	
	// 삭제
	@RequestMapping("/qxerpynm/general/info/admGeneralInfoDelete.do")
	public String admGeneralInfoDelete(@RequestParam String geSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/general/info/admGeneralInfoDelete.do - 관리자 > 교양과정 > 교양과정안내 삭제");
		LOGGER.debug("geSeq = "+geSeq);
		
		// 첨부파일 삭제
		CmmnListVO geUpfileListVO = admGeneralInfoDAO.selectGeneralInfoUpfileList(geSeq);
		for(EgovMap geUpfile : geUpfileListVO.getEgovList()){
			// 원본파일 삭제
			String geupSaveFilepath = geUpfile.get("geupSaveFilepath").toString();
			cmmnFileMngUtil.deleteFile(geupSaveFilepath);
			
			// thumbnail 삭제
			String fileExt = geupSaveFilepath.substring(geupSaveFilepath.lastIndexOf(".")+1);
			if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
				String filePath = geupSaveFilepath.substring(0, geupSaveFilepath.lastIndexOf("."));
				String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
				cmmnFileMngUtil.deleteFile(fileThumbPath);
			}
			
			// DB 삭제
			admGeneralInfoDAO.generalInfoUpfileDelete(geUpfile.get("geupSeq").toString());
			
		}
		
		// 글삭제
		admGeneralInfoDAO.generalInfoDelete(geSeq);
		
		// 로그등록
		admLogInsert(null, "교양과정안내 삭제", geSeq, request);
		
		return redirectListPage("삭제되었습니다.", searchVO, reda);
	}
}