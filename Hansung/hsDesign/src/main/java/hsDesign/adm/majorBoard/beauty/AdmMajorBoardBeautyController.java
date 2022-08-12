/*package hsDesign.adm.majorBoard.beauty;

import java.util.List;

import javax.annotation.Resource;
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
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.util.ComStringUtil;
import component.web.PaginationController;
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
public class AdmMajorBoardBeautyController extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmMajorBoardBeautyController.class);
	@Autowired private AdmMajorBoardDAO admMajorBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	@Resource View jsonView;
		
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/majorBoard/beauty/admMajorBeautyList.do";
	}
	
	
	// 목록
	@RequestMapping("/qxerpynm/majorBoard/beauty/admMajorBeautyList.do")
	public String admMajorBeautyList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) {
		LOGGER.info("/qxerpynm/majorBoard/beauty/admMajorBeautyList.do - 관리자 > 전공 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "107");
		searchVO.setSearchCondition1("07");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admMajorBoardDAO.selectMajorBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> boardCode = admMajorBoardDAO.selectBoardCodeList("07");
		model.addAttribute("boardCode", boardCode);
		
		if(!EgovStringUtil.isEmpty(searchVO.getSearchType())) {
			List<EgovMap> headList = admMajorBoardDAO.selectMajorHeadList(searchVO.getSearchType());
			model.addAttribute("headList", headList);
		}
		
		// 로그등록
		admLogInsert(null, "전공-미용학", "목록", request);
		
		return "/adm/majorBoard/beauty/admMajorBeautyList";
	}
	
	
	// 조회
	@RequestMapping("/qxerpynm/majorBoard/beauty/admMajorBeautyView.do")
	public String admMajorBeautyView(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, @RequestParam("mbSeq") String mbSeq, RedirectAttributes reda) {
		LOGGER.info("/qxerpynm/majorBoard/beauty/admMajorBeautyView.do - 관리자 > 전공 > 조회");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("mbSeq = "+mbSeq);
		
		MajorBoardVO resultVO = admMajorBoardDAO.selectMajorBoardOne(mbSeq);
		
		if(resultVO == null) {
			String message = "게시글이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		
		resultVO.setMbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getMbContent())); // style 수정
		model.addAttribute("resultVO", resultVO);
		
		// 로그등록
		admLogInsert(null, "전공-미용학 조회", mbSeq, request);
		
		return "/adm/majorBoard/beauty/admMajorBeautyView";
	}
	
	
	// 등록 & 수정화면
	@RequestMapping("/qxerpynm/majorBoard/beauty/admMajorBeautyModify.do")
	public String admNoticeModify(String mbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/beauty/admMajorBeautyModify.do - 관리자 > 전공 > 등록&수정화면");
		LOGGER.debug("mbSeq = "+mbSeq);
		
		MajorBoardVO majorBoardVO = null;
		
		List<EgovMap> bCodeList = admMajorBoardDAO.selectBoardCodeList("07");
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
		
		return "/adm/majorBoard/beauty/admMajorBeautyModify";
	}
	

	// 등록&수정
	@RequestMapping("/qxerpynm/majorBoard/beauty/admMajorBeautyUpdate.do")
	public String admMajorBeautyUpdate(MajorBoardVO majorBoardVO, MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/beauty/admMajorBeautyUpdate.do - 관리자 > 전공 >  등록&수정");
		LOGGER.debug("majorBoardVO = "+majorBoardVO.toString());
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		String message = "오류가 발생하였습니다.";
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbContent())) {
			searchVO.setMessage("내용이 없습니다");
			return redirectListPage(message, searchVO, reda);
		}else if(EgovStringUtil.isEmpty(majorBoardVO.getMbTitle())) {
			searchVO.setMessage("제목이 없습니다");
			return redirectListPage(message, searchVO, reda);
		}
		
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
		majorBoardVO.setmCode("07");
		String rsMbSeq = "";
		
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbSeq())){
			// 등록
			rsMbSeq = admMajorBoardDAO.insertMajorBoardOne(majorBoardVO);
			majorBoardVO.setMbSeq(rsMbSeq);
			message = "등록되었습니다.";
			
			// 로그등록
			admLogInsert(null, "전공-미용학 등록", rsMbSeq, request);
			
		}else{
			// 수정
			admMajorBoardDAO.updateMajorBoardOne(majorBoardVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "전공-미용학 수정", majorBoardVO.getMbSeq(), request);
			
		}
		
		// 썸네일
		
		EgovMap thumbnail = admMajorBoardDAO.selectMajorBoardThumbList(majorBoardVO.getMbSeq());
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "major");
		//List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "major");
		for(FileInfoVO vo : fileInfoList){
			majorBoardVO.setMbthImgName(vo.getFileName());
			majorBoardVO.setMbthImgPath(vo.getFilePath());
			
		}
		
		
		if(thumbnail == null) {
			// 등록된 썸네일이 없다
			admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
		}else {
			// 등록된 썸네일이 있다
			majorBoardVO.setMbthSeq(thumbnail.get("mbthSeq").toString());
			admMajorBoardDAO.updateMajorBoardThumbOne(majorBoardVO);
			
		}
		
		// 썸네일 삭제
		
		if (!EgovStringUtil.isEmpty(majorBoardVO.getFileDeleteChk())) {
			EgovMap upfile = admMajorBoardDAO.selectMajorBoardThumbOne(majorBoardVO.getFileDeleteChk());
			cmmnFileMngUtil.deleteFile(upfile.get("mbthImgPath").toString());	// 파일 삭제
			admMajorBoardDAO.deleteMajorBoardThumbOne(majorBoardVO.getFileDeleteChk()); // 데이터 삭제
		}
		
		return redirectListPage(message, searchVO, reda);
	}
	
	// 썸네일 삭제
	@RequestMapping("/qxerpynm/majorBoard/beauty/admMajorBeautyThumbDelete.do")
	public String admMajorBeautyThumbDelete(String mbthSeq, String mbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda, MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/beauty/admMajorBeautyUpdate.do - 관리자 > 전공 >  썸네일 삭제");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("mbthSeq = "+mbthSeq.toString());
		LOGGER.debug("mbSeq = "+mbSeq.toString());
						
		// 썸네일 삭제
		if (!EgovStringUtil.isEmpty(mbthSeq)) {
			EgovMap upfile = admMajorBoardDAO.selectMajorBoardThumbOne(mbthSeq);
			cmmnFileMngUtil.deleteFile(upfile.get("mbthImgPath").toString());	// 파일 삭제
			
			String filePath = upfile.get("mbthImgPath").toString();
			int pos = filePath.lastIndexOf(".");
			String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
			
			
			cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
			
			
			admMajorBoardDAO.deleteMajorBoardThumbOne(mbthSeq); // 데이터 삭제
		}
		MajorBoardVO majorBoardVO = admMajorBoardDAO.selectMajorBoardOne(mbSeq);
		model.addAttribute("majorBoardVO", majorBoardVO);
		
		List<EgovMap> bCodeList = admMajorBoardDAO.selectBoardCodeList("07");
		model.addAttribute("bCodeList", bCodeList);
		
		return "/adm/majorBoard/beauty/admMajorBeautyModify";
	}
	
	// 삭제
	@RequestMapping("/qxerpynm/majorBoard/beauty/admMajorBeautyDelete.do")
	public String admMajorBeautyDelete(ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, String mbSeq)throws Exception{
		LOGGER.info("//qxerpynm/majorBoard/beauty/admMajorBeautyDelete.do - 관리자 > 전공 > 삭제");
		LOGGER.debug("searchVO - "+searchVO);
		LOGGER.debug("mbSeq - "+mbSeq);
		
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
		admLogInsert(null, "전공-미용학 삭제", mbSeq, request);
		
		return redirectListPage(searchVO.getMessage(), searchVO, reda);
	}
	
	
	// 말머리 목록
	
	@RequestMapping("/qxerpynm/majorBoard/beauty/admMajorHeadList.do")
	public View admMajorHeadList(ModelMap model, String mmSeq)throws Exception{
		LOGGER.info("/qxerpynm/majorBoard/beauty/admMajorHeadList.do - 관리자 > 전공 > 말머리목록");
		LOGGER.debug("mmSeq - "+mmSeq);
		
		List<EgovMap> listVO = admMajorBoardDAO.selectMajorHeadList(mmSeq);
		
		model.addAttribute("listVO", listVO);
		
		return jsonView;
	}
	
			
	
}
*/