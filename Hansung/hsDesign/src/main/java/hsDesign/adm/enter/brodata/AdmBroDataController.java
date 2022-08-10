package hsDesign.adm.enter.brodata;

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
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.BrodataVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmBroDataController extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmBroDataController.class);
	
	@Autowired private AdmBroDataDAO admBroDataDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	@SuppressWarnings("unused")
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/enter/brodata/admBroDataList.do";
	}
	
	// 목록
	@RequestMapping("/qxerpynm/enter/brodata/admBroDataList.do")
	public String admBroDataList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/enter/brodata/admBroDataList.do - 관리자 > 입학안내 > 작품자료실 목록");
		LOGGER.debug("searchVO.toString = {}", searchVO.toString());
		
		// incLeft menu
		session.setAttribute("admMenuNo", "204");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admBroDataDAO.selectBroDataList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		admLogInsert(null, "브로셔자료", "목록", request);
		
		return "/adm/enter/brodata/admBroDataList";
	}
	
	// 조회
	@RequestMapping("/qxerpynm/enter/brodata/admBroDataView.do")
	public String admBroDataView(@RequestParam String bdSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/enter/brodata/admBroDataView.do");
		LOGGER.debug("bdSeq = {}", bdSeq);
		
		BrodataVO resultVO = admBroDataDAO.selectBroDataOne(bdSeq);
		model.addAttribute("resultVO", resultVO);
		
		admLogInsert(null, "브로셔자료", "조회", request);
		return "/adm/enter/brodata/admBroDataView";
	}
	
	// 등록&수정 화면
	@RequestMapping("/qxerpynm/enter/brodata/admBroDataModify.do")
	public String admBroDataModify(String bdSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/enter/brodata/admBroDataModify.do - 관리자 > 입학안내 > 브록셔 자료 등록&수정 화면");
		LOGGER.debug("bdSeq = {}", bdSeq);
		
		BrodataVO brodataVO = null;
		if (EgovStringUtil.isEmpty(bdSeq)) {
			// 등록
			brodataVO = new BrodataVO();
		} else {
			// 수정
			brodataVO = admBroDataDAO.selectBroDataOne(bdSeq);
		}
		
		model.addAttribute("brodataVO", brodataVO);
		return "/adm/enter/brodata/admBroDataModify";
	}
	
	// 등록&수정
	@RequestMapping("/qxerpynm/enter/brodata/admBroDataUpdate.do")
	public String admBroDataUpdate(BrodataVO brodataVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/enter/brodata/admBroDataUpdate.do - 관리자 > 입학안내 > 작품자료실 등록&수정");
		LOGGER.debug("");
		
		String message = "오류발생(-1)";
		String rsBdSeq = "";
		
		// 파일 용량 검사
		if(!cmmnFileMngUtil.uploadFileSizeChk(multiRequest)){
			LOGGER.debug("/qxerpynm/enter/brodata/admBroDataUpdate.do - 오류발생(-4) : fileSize check...");
			return redirectListPage("오류발생(-4)", searchVO, reda);
		}
		
		// 파일 확장자 검사
		if(!cmmnFileMngUtil.uploadFileImgExtChk(multiRequest)){
			LOGGER.debug("/qxerpynm/enter/brodata/admBroDataUpdate.do - 오류발생(-5) : fileExt check...");
			return redirectListPage("오류발생(-5)", searchVO, reda);
		}
		
		if(EgovStringUtil.isEmpty(brodataVO.getBdSeq())){
			// 등록
			rsBdSeq = admBroDataDAO.broDataInsert(brodataVO);
			message = "등록되었습니다.";
			admLogInsert(null, "브로셔자료", "등록", request);
		}else{
			// 수정
			
			if(cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
				// 원본파일 삭제
				cmmnFileMngUtil.deleteFile(brodataVO.getBdSaveFilePath());
				
				// 썸네일 삭제
				String fileExt = brodataVO.getBdSaveFilePath().substring(brodataVO.getBdSaveFilePath().lastIndexOf(".")+1);
				String filePath = brodataVO.getBdSaveFilePath().substring(0, brodataVO.getBdSaveFilePath().lastIndexOf("."));
				String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
				cmmnFileMngUtil.deleteFile(fileThumbPath);
			}
			admBroDataDAO.broDataUpdate(brodataVO);
			
			rsBdSeq = brodataVO.getBdSeq();
			message = "수정되었습니다.";
			admLogInsert(null, "브로셔자료", "수정", request);
		}
		
		// 첨부파일 등록
		FileInfoVO fileInfoVO = cmmnFileMngUtil.uploadAttachedImgFile(multiRequest, "BRODATA");
		if(fileInfoVO != null){
			admBroDataDAO.broDataImgUpdate(fileInfoVO, rsBdSeq);
		}
		
		return redirectListPage(message, searchVO, reda);
	}
	
	// 삭제
	@RequestMapping("/qxerpynm/enter/brodata/admBroDataDelete.do")
	public String admBroDataDelete(@RequestParam String bdSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/enter/brodata/admBroDataDelete.do - 관리자 > 입학안내 > 작품자료실 - 삭제");
		LOGGER.debug("bdSeq = {}", bdSeq);
		BrodataVO resultVO = admBroDataDAO.selectBroDataOne(bdSeq);
		
		// 원본파일 삭제
		cmmnFileMngUtil.deleteFile(resultVO.getBdSaveFilePath());
		
		// 썸네일 삭제
		String fileExt = resultVO.getBdSaveFilePath().substring(resultVO.getBdSaveFilePath().lastIndexOf(".")+1);
		String filePath = resultVO.getBdSaveFilePath().substring(0, resultVO.getBdSaveFilePath().lastIndexOf("."));
		String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
		cmmnFileMngUtil.deleteFile(fileThumbPath);
		
		// 글 삭제
		admBroDataDAO.broDataDelete(bdSeq);
		
		admLogInsert(null, "브로셔자료", "삭제", request);
		
		return redirectListPage("삭제되었습니다.", searchVO, reda);
	}
}
