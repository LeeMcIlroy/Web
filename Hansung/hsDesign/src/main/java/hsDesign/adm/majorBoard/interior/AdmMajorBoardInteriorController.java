/*package hsDesign.adm.majorBoard.interior;

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
public class AdmMajorBoardInteriorController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmMajorBoardInteriorController.class);
	@Autowired private AdmMajorBoardDAO admMajorBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	@Resource View jsonView;
		
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/majorBoard/interior/admMajorInteriorList.do";
	}
	
	
	// 목록
	@RequestMapping("/qxerpynm/majorBoard/interior/admMajorInteriorList.do")
	public String admMajorInteriorList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) {
		LOGGER.info("/qxerpynm/majorBoard/interior/admMajorInteriorList.do - 관리자 > 전공 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "101");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admMajorBoardDAO.selectMajorBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> boardCode = admMajorBoardDAO.selectBoardCodeList("01");
		model.addAttribute("boardCode", boardCode);
		
		if(!EgovStringUtil.isEmpty(searchVO.getSearchType())) {
			List<EgovMap> headList = admMajorBoardDAO.selectMajorHeadList(searchVO.getSearchType());
			model.addAttribute("headList", headList);
		}
		
		// 로그등록
		admLogInsert(null, "전공-실내디자인", "목록", request);
		
		return "/adm/majorBoard/interior/admMajorInteriorList";
	}
	
	
	// 조회
	@RequestMapping("/qxerpynm/majorBoard/interior/admMajorInteriorView.do")
	public String admMajorInteriorView(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, @RequestParam("mbSeq") String mbSeq, RedirectAttributes reda) {
		LOGGER.info("/qxerpynm/majorBoard/interior/admMajorInteriorView.do - 관리자 > 전공 > 조회");
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
		admLogInsert(null, "전공-실내디자인 조회", mbSeq, request);
		
		return "/adm/majorBoard/interior/admMajorInteriorView";
	}
	
	
	// 등록 & 수정화면
	@RequestMapping("/qxerpynm/majorBoard/interior/admMajorInteriorModify.do")
	public String admNoticeModify(String mbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/interior/admMajorInteriorModify.do - 관리자 > 전공 > 등록&수정화면");
		LOGGER.debug("mbSeq = "+mbSeq);
		
		MajorBoardVO majorBoardVO = null;
		
		List<EgovMap> bCodeList = admMajorBoardDAO.selectBoardCodeList("01");
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
		
		return "/adm/majorBoard/interior/admMajorInteriorModify";
	}
	

	// 등록&수정
	@RequestMapping("/qxerpynm/majorBoard/interior/admMajorInteriorUpdate.do")
	public String admMajorInteriorUpdate(MajorBoardVO majorBoardVO, MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/interior/admMajorInteriorUpdate.do - 관리자 > 전공 >  등록&수정");
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
		majorBoardVO.setmCode("01");
		String rsMbSeq = "";
		
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbSeq())){
			// 등록
			rsMbSeq = admMajorBoardDAO.insertMajorBoardOne(majorBoardVO);
						
			majorBoardVO.setMbSeq(rsMbSeq);
			message = "등록되었습니다.";
			// 로그등록
			admLogInsert(null, "전공-실내디자인 등록", rsMbSeq, request);
			
		}else{
			// 썸네일 삭제
			if(
				!EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && !cmmnFileMngUtil.uploadFileRegiChk(multiRequest) ||
				EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && cmmnFileMngUtil.uploadFileRegiChk(multiRequest)
			){
				EgovMap upfile = admMajorBoardDAO.selectMajorBoardThumbOne(majorBoardVO.getMbthSeq());
				cmmnFileMngUtil.deleteFile(upfile.get("mbthImgPath").toString());	// 파일 삭제
				
				String filePath = upfile.get("mbthImgPath").toString();
				int pos = filePath.lastIndexOf(".");
				String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
				
				
				cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
				
				admMajorBoardDAO.deleteMajorBoardThumbOne(majorBoardVO.getMbthSeq()); // 데이터 삭제
				
			}
			
			// 수정
			admMajorBoardDAO.updateMajorBoardOne(majorBoardVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "전공-실내디자인 수정", majorBoardVO.getMbSeq(), request);
		}
		// 썸네일 등록
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "major");
		//List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "major");
		for(FileInfoVO vo : fileInfoList){
			majorBoardVO.setMbthImgName(vo.getFileName());
			majorBoardVO.setMbthImgPath(vo.getFilePath());
			
		}
		
		admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
		
		return redirectListPage(message, searchVO, reda);
	}
	
	
	// 삭제
	@RequestMapping("/qxerpynm/majorBoard/interior/admMajorInteriorDelete.do")
	public String admMajorInteriorDelete(ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, String mbSeq)throws Exception{
		LOGGER.info("//qxerpynm/majorBoard/interior/admMajorInteriorDelete.do - 관리자 > 전공 > 삭제");
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
		admLogInsert(null, "전공-실내디자인 삭제", mbSeq, request);
		
		return redirectListPage(searchVO.getMessage(), searchVO, reda);
	}
	
	
	// 말머리 목록
	
	@RequestMapping("/qxerpynm/majorBoard/interior/admMajorHeadList.do")
	public View admMajorHeadList(ModelMap model, String mmSeq)throws Exception{
		LOGGER.info("/qxerpynm/majorBoard/interior/admMajorHeadList.do - 관리자 > 전공 > 말머리목록");
		LOGGER.debug("mmSeq - "+mmSeq);
		
		List<EgovMap> listVO = admMajorBoardDAO.selectMajorHeadList(mmSeq);
		
		model.addAttribute("listVO", listVO);
		
		return jsonView;
	}
	
			
	
}
*/