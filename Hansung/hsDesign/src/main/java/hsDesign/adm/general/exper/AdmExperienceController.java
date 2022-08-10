package hsDesign.adm.general.exper;

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
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.adm.majorBoard.AdmMajorBoardDAO;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmExperienceController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmExperienceController.class);
	
	@Autowired private AdmExperienceDAO admExperienceDAO;
	@Autowired private AdmMajorBoardDAO admMajorBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	/***************************************** 진로체험 신청 *****************************************/
	// 진로체험 신청 - 목록
	@RequestMapping("/qxerpynm/general/exper/admExperList.do")
	public String admExperList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/qxerpynm/general/exper/admExperList.do - 진로&교양과정 - 진로체험신청 목록");
		LOGGER.debug("searchVO = {}", searchVO.toString());
			
		// incLeft menu
		session.setAttribute("admMenuNo", "503");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admExperienceDAO.selectExperAplyList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/general/exper/admExperList";
	}
	
	// 진로체험 신청 - 삭제
	@RequestMapping("/qxerpynm/general/exper/admExperDelete.do")
	public String admExperDelete(@RequestParam String exaSeq, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/general/exper/admExperDelete.do - 진로&교양과정 - 진로체험신청 - 삭제");
		LOGGER.debug("exaSeq = {}", exaSeq);
	
		// 삭제
		admExperienceDAO.experDelete(exaSeq);
		
		reda.addFlashAttribute("message", "삭제되었습니다.");
		return "redirect:/qxerpynm/general/exper/admExperList.do";
	}
	
	/***************************************** 진로체험 소식 *****************************************/
	
	private String bCode = "21";
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/general/exper/admExperNewsList.do";
	}
	
	// 진로체험 소식 - 목록
	@RequestMapping("/qxerpynm/general/exper/admExperNewsList.do")
	public String admExperNewsList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/qxerpynm/general/exper/admExperNewsList.do - 진로&교양과정 > 진로체험 소식 - 목록");		
		
		// incLeft menu
		session.setAttribute("admMenuNo", "504");
		
		// 진로체험소식 set value = 21 (tb_hda_major m_code)
		searchVO.setSearchCondition1(bCode);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admMajorBoardDAO.selectMajorBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 구분1
		List<EgovMap> boardCode = admMajorBoardDAO.selectBoardCodeList(bCode);
		model.addAttribute("boardCode", boardCode);
		
		if(!EgovStringUtil.isEmpty(searchVO.getSearchType())) {
			// 구분2
			List<EgovMap> headList = admMajorBoardDAO.selectMajorHeadList(searchVO.getSearchType());
			model.addAttribute("headList", headList);
		}
		
		// 로그등록
		admLogInsert(null, "진로체험소식", "목록", request);
		
		return "/adm/general/exper/admExperNewsList";
	}
	
	// 진로체험 소식 - 조회
	@RequestMapping("/qxerpynm/general/exper/admExperNewsView.do")
	public String admExperNewsView(@RequestParam String mbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/general/exper/admExperNewsView.do - 진로&교양과정 > 진로체험 소식 - 조회");
		LOGGER.debug("mbSeq = {}", mbSeq);
		
		MajorBoardVO resultVO = admMajorBoardDAO.selectMajorBoardOne(mbSeq);

		if(resultVO == null) return redirectListPage("게시글이 존재하지 않습니다.", searchVO, reda);

		resultVO.setMbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getMbContent())); // style 수정
		model.addAttribute("resultVO", resultVO);
		
		// 로그등록
		admLogInsert(null, "진로체험 소식 조회", mbSeq, request);
		
		return "/adm/general/exper/admExperNewsView";
	}
	
	// 진로체험 소식 - 등록&수정 화면
	@RequestMapping("/qxerpynm/general/exper/admExperNewsModify.do")
	public String admExperNewsModify(String mbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/general/exper/admExperNewsModify.do - 진로&교양과정 > 진로체험 소식 - 등록&수정화면");
		LOGGER.debug("mbSeq = "+mbSeq);
		
		MajorBoardVO majorBoardVO = null;
		
		List<EgovMap> bCodeList = admMajorBoardDAO.selectBoardCodeList(bCode);
		model.addAttribute("bCodeList", bCodeList);
		
		if(EgovStringUtil.isEmpty(mbSeq)){
			// 등록화면
			majorBoardVO = new MajorBoardVO();
		}else{
			// 수정화면
			majorBoardVO = admMajorBoardDAO.selectMajorBoardOne(mbSeq);
			
			List<EgovMap> listVO = admMajorBoardDAO.selectMajorHeadList(majorBoardVO.getMbGubun1());
			model.addAttribute("listVO", listVO);
		}
		model.addAttribute("majorBoardVO", majorBoardVO);
		
		return "/adm/general/exper/admExperNewsModify";
	}
	
	// 진로체험 소식 - 등록&수정
	@RequestMapping("/qxerpynm/general/exper/admExperNewsUpdate.do")
	public String admExperNewsUpdate(MajorBoardVO majorBoardVO, MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/general/exper/admExperNewsUpdate.do - 진로&교양과정 > 진로체험 소식 - 등록&수정");
		LOGGER.debug("majorBoardVO = {}", majorBoardVO.toString());
		
		String message = "오류가 발생하였습니다.";
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbContent().trim())) {
			searchVO.setMessage("내용이 없습니다");
			return redirectListPage(message, searchVO, reda);
		}else if(EgovStringUtil.isEmpty(majorBoardVO.getMbTitle().trim())) {
			searchVO.setMessage("제목이 없습니다");
			return redirectListPage(message, searchVO, reda);
		}
		
		majorBoardVO.setMbTitle(EgovWebUtil.clearXSSMinimum(majorBoardVO.getMbTitle()));
		
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
			return redirectListPage(message, searchVO, reda);
		}
		
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSession");
		
		majorBoardVO.setMbRegSeq(adminVO.getAdmSeq());
		majorBoardVO.setMbRegName(adminVO.getAdmName());
		majorBoardVO.setmCode(bCode);
		String rsMbSeq = "";
		
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbSeq())){
			// 등록
			rsMbSeq = admMajorBoardDAO.insertMajorBoardOne(majorBoardVO);
						
			majorBoardVO.setMbSeq(rsMbSeq);
			message = "등록되었습니다.";
			// 로그등록
			admLogInsert(null, "진로체험 소식 등록", rsMbSeq, request);
			
		}else{
			// 수정
			
			// 썸네일 삭제
			if(
				!EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && !cmmnFileMngUtil.uploadFileRegiChk(multiRequest) ||
				EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && cmmnFileMngUtil.uploadFileRegiChk(multiRequest)
			){
				
				EgovMap upfile = admMajorBoardDAO.selectMajorBoardThumbOne(majorBoardVO.getMbthSeq());
				if("IMAGE".equals(upfile.get("mbthType").toString())){
					
					cmmnFileMngUtil.deleteFile(upfile.get("mbthImgPath").toString());	// 파일 삭제
					
					String filePath = upfile.get("mbthImgPath").toString();
					int pos = filePath.lastIndexOf(".");
					String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
					
					
					cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
					
				}
				admMajorBoardDAO.deleteMajorBoardThumbOne(majorBoardVO.getMbthSeq()); // 데이터 삭제
				
			}
			
			// 수정
			admMajorBoardDAO.updateMajorBoardOne(majorBoardVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "진로체험 소식 수정", majorBoardVO.getMbSeq(), request);
		}
		// 썸네일 등록
		
		if(majorBoardVO.getMbthType().equals("IMAGE")) {
			// 썸네일이 이미지 타입
			List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "EXPER");
			
			if(fileInfoList != null) {
				for(FileInfoVO vo : fileInfoList){
					majorBoardVO.setMbthImgName(vo.getFileName());
					majorBoardVO.setMbthImgPath(vo.getFilePath());
					
					admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
				}
				
			}
			
		}else if(majorBoardVO.getMbthType().equals("VIDEO")) {
			// 썸네일이 비디오 타입
			admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
		}
		
		return redirectListPage(message, searchVO, reda);
	}
	
	// 진로체험 소식 - 삭제
	@RequestMapping("/qxerpynm/general/exper/admExperNewsDelete.do")
	public String admExperNewsDelete(@RequestParam String mbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/general/exper/admExperNewsDelete.do - 진로&교양과정 > 진로체험 소식 - 삭제");
		// 첨부파일 삭제
		EgovMap upfileOne = admMajorBoardDAO.selectMajorBoardThumbList(mbSeq);
		if(!(upfileOne==null)){
			if(!EgovStringUtil.isEmpty(upfileOne.get("mbthImgPath").toString())) {
				
				cmmnFileMngUtil.deleteFile(upfileOne.get("mbthImgPath").toString());	// 파일 삭제
				
				String filePath = upfileOne.get("mbthImgPath").toString();
				int pos = filePath.lastIndexOf(".");
				String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
				
				
				cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
			}
			
			admMajorBoardDAO.deleteMajorBoardThumbOne(upfileOne.get("mbthSeq")+""); // 데이터 삭제
		}
		admMajorBoardDAO.deleteMajorBoardOne(mbSeq);// 주제 삭제
	
		searchVO.setMessage("삭제되었습니다.");
		
		// 로그등록
		admLogInsert(null, "진로체험 소식 삭제", mbSeq, request);
		
		return redirectListPage(searchVO.getMessage(), searchVO, reda);
	}
}