package writer.adm.wcGuide.tips;

import java.util.Map;

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
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.WritingtipsVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmWcGuideTipsController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmWcGuideTipsController.class);
	
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	@Autowired private AdmWcGuideTipsDAO admWcGuideTipsDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	/*********************************** 공통 ***********************************/
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do";
	}
	
	
	/******************************** 라이팅팁스 ********************************/
	// 목록
	@RequestMapping("/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do")
	public String admWcGuideTipsList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do - 관리자 > 글쓰기 길잡이 > 라이팅팁스 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("admMenuNo", "301");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admWcGuideTipsDAO.selectWcGuideTipsList(searchVO);
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
		
		return "/adm/wcGuide/tips/admWcGuideTipsList";
	}
	
	// 등록&수정 화면
	@RequestMapping("/xabdmxgr/wcGuide/tips/admWcGuideTipsModify.do")
	public String admWcGuideTipsModify(String tipSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/tips/admWcGuideTipsModify.do - 관리자 > 글쓰기 길잡이 > 라이팅팁스 등록&수정화면");
		LOGGER.debug("tipSeq = "+tipSeq);
		
		WritingtipsVO writingtipsVO = null;
		if (EgovStringUtil.isEmpty(tipSeq)) {
			// 등록화면
			writingtipsVO = new WritingtipsVO();
			
		}else{
			// 수정화면
			writingtipsVO = admWcGuideTipsDAO.selectWcGuideTipsOne(tipSeq);
		}
		
		model.addAttribute("writingtipsVO", writingtipsVO);
		return "/adm/wcGuide/tips/admWcGuideTipsModify";
	}
	
	// 등록&수정
	@RequestMapping("/xabdmxgr/wcGuide/tips/admWcGuideTipsUpdate.do")
	public String admWcGuideTipsUpdate(WritingtipsVO writingtipsVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/tips/admWcGuideTipsUpdate.do - 관리자 > 글쓰기 길잡이 > 라이팅팁스 등록&수정");
		LOGGER.debug("writingtipsVO = "+writingtipsVO.toString());
		
		String logJob = "";
		if (EgovStringUtil.isEmpty(writingtipsVO.getTipSeq())) {
			// 등록
			
			// 첨부파일 등록
			Map<String, FileInfoVO> fileInfoList = cmmnFileMngUtil.writingtipsFileUpload(multiRequest, "WRITINGTIPS");
			
			if (fileInfoList.size() == 0) {
				LOGGER.debug("파일업로드 중 오류 발생!");
				searchVO.setMessage("파일업로드 중 오류가 발생하였습니다. 관리자에게 문의해주세요.");
				return redirectListPage(searchVO, reda);
			}else{
				// 첨부파일set
				if(fileInfoList.get("titleImg") != null){
					writingtipsVO.setTipImgName(fileInfoList.get("titleImg").getFileName());
					writingtipsVO.setTipImgPath(fileInfoList.get("titleImg").getFilePath());
					writingtipsVO.setTipImgThumbPath(fileInfoList.get("titleImg").getFileThumbPath());
				}
				if(fileInfoList.get("attachedFile_PDF") != null){
					writingtipsVO.setTipFileName(fileInfoList.get("attachedFile_PDF").getFileName());
					writingtipsVO.setTipFilePath(fileInfoList.get("attachedFile_PDF").getFilePath());
				}
			}
			
			// 글 등록
			admWcGuideTipsDAO.wcGuideTipsInsert(writingtipsVO);
			logJob = "글쓰기 길잡이 > 라이팅팁스 > 삭제";
			searchVO.setMessage("등록되었습니다.");
		}else{
			// 수정
			
			// 첨부파일 신규등록
			Map<String, FileInfoVO> fileInfoList = cmmnFileMngUtil.writingtipsFileUpload(multiRequest, "WRITINGTIPS");
			
			if(fileInfoList.size() > 0){
				
				if(fileInfoList.get("titleImg") != null){
					
					// 기존 이미지 삭제
					cmmnFileMngUtil.deleteFile(writingtipsVO.getTipImgPath());			// 원본이미지
					cmmnFileMngUtil.deleteFile(writingtipsVO.getTipImgThumbPath());		// 썸네일이미지
					
					writingtipsVO.setTipImgName(fileInfoList.get("titleImg").getFileName());
					writingtipsVO.setTipImgPath(fileInfoList.get("titleImg").getFilePath());
					writingtipsVO.setTipImgThumbPath(fileInfoList.get("titleImg").getFileThumbPath());
				}
				if(fileInfoList.get("attachedFile_PDF") != null){
					
					// 기존 PDF 삭제
					cmmnFileMngUtil.deleteFile(writingtipsVO.getTipFilePath());
					
					writingtipsVO.setTipFileName(fileInfoList.get("attachedFile_PDF").getFileName());
					writingtipsVO.setTipFilePath(fileInfoList.get("attachedFile_PDF").getFilePath());
				}
				
			}
			
			// 글 수정
			admWcGuideTipsDAO.wcGuideTipsUpdate(writingtipsVO);
			logJob = "글쓰기 길잡이 > 라이팅팁스 > 수정("+writingtipsVO.getTipSeq()+")";
			searchVO.setMessage("수정되었습니다.");
		}
		
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne(logJob, ip);
		
		return redirectListPage(searchVO, reda);
	}
	
	// 삭제
	@RequestMapping("/xabdmxgr/wcGuide/tips/admWcGuideTipsDelete.do")
	public String admWcGuideTipsDelete(@RequestParam String tipDeleteChk, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/xabdmxgr/wcGuide/tips/admWcGuideTipsDelete.do - 관리자 > 글쓰기 길잡이 > 라이팅팁스 삭제");
		LOGGER.debug("tipDeleteChk = "+tipDeleteChk);
		
		String[] arrTipSeq = tipDeleteChk.split(",");
		for(String tipSeq : arrTipSeq){
			WritingtipsVO writingtipsVO = admWcGuideTipsDAO.selectWcGuideTipsOne(tipSeq);
			
			// 파일 삭제
			cmmnFileMngUtil.deleteFile(writingtipsVO.getTipImgPath());			// 대표이미지
			cmmnFileMngUtil.deleteFile(writingtipsVO.getTipImgThumbPath());		// 대표썸네일이미지
			cmmnFileMngUtil.deleteFile(writingtipsVO.getTipFilePath());			// PDF 파일
			
			// 데이터삭제
			admWcGuideTipsDAO.wcGuideTipsDelete(tipSeq);
		}
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("글쓰기 길잡이 > 라이팅팁스 > 삭제("+tipDeleteChk+")", ip );
		searchVO.setMessage("삭제되었습니다.");
		return redirectListPage(searchVO, reda);
	}
}
