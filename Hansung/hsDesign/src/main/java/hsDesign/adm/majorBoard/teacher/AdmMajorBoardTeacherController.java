package hsDesign.adm.majorBoard.teacher;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.TeacherVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmMajorBoardTeacherController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmMajorBoardTeacherController.class);
	@Autowired private AdmMajorBoardTeacherDAO admTeacherDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/majorBoard/teacher/admMajorTeacherList.do";
	}
	
	
	// 목록
	@RequestMapping("/qxerpynm/majorBoard/teacher/admMajorTeacherList.do")
	public String admMajorTeacherList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) throws Exception{
		LOGGER.info("/qxerpynm/majorBoard/teacher/admMajorTeacherList.do - 관리자 > 교수소개 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "109");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) {
			searchVO.setSearchCondition1("01");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admTeacherDAO.selectAdmTeacherList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> majorList = admTeacherDAO.selectMajorList();
		
		model.addAttribute("majorList", majorList);
		
		// 로그등록
		admLogInsert(null, "전공-교수소개", "목록", request);
		
		return "/adm/majorBoard/teacher/admMajorTeacherList";
	}
	
	// 등록 & 수정화면
	@RequestMapping("/qxerpynm/majorBoard/teacher/admMajorTeacherModify.do")
	public String admMajorTeacherModify(String tcSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/teacher/admMajorTeacherModify.do - 관리자 > 교수소개 > 등록&수정화면");
		LOGGER.debug("tcSeq = "+tcSeq);
		
		TeacherVO teacherVO = null;
		
		
		if(EgovStringUtil.isEmpty(tcSeq)){
			// 등록화면
			teacherVO = new TeacherVO();
		}else{
			// 수정화면
			teacherVO = admTeacherDAO.selectAdmTeacherOne(tcSeq);
			String[] subjectList = teacherVO.getTcSubject().split(",");
			model.addAttribute("subjectList", subjectList);
			model.addAttribute("tcUpfileList",admTeacherDAO.selectTeacherUpfileList(tcSeq));
		}
		
		List<EgovMap> majorList = admTeacherDAO.selectMajorList();
		
		model.addAttribute("majorList", majorList);
		model.addAttribute("teacherVO", teacherVO);
		return "/adm/majorBoard/teacher/admMajorTeacherModify";
	}
	
	// 등록&수정
	@RequestMapping("/qxerpynm/majorBoard/teacher/admMajorTeacherUpdate.do")
	public String admMajorTeacherUpdate(TeacherVO teacherVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request,ModelMap model, RedirectAttributes reda, MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/teacher/admMajorTeacherUpdate.do - 관리자 > 전공 > 교수소개 > 등록&수정");
		LOGGER.debug("teacherVO = "+teacherVO.toString());
		String message = "오류가 발생하였습니다.";
		
		//내용 여부 확인
		if(EgovStringUtil.isEmpty(teacherVO.getTcContent().trim())){
			searchVO.setMessage("내용이 없습니다");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(message, searchVO, reda);
		}
		if(EgovStringUtil.isEmpty(teacherVO.getTcName().trim())){
			searchVO.setMessage("이름이 없습니다");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(message ,searchVO, reda);
		}
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
			return redirectListPage(message, searchVO, reda);
		}
		
		
		String rsTcSeq = "";
		if(EgovStringUtil.isEmpty(teacherVO.getTcSeq())){
			// 등록
			rsTcSeq = admTeacherDAO.insertTeacherOne(teacherVO);
			message = "등록되었습니다.";
			
			// 로그등록
			admLogInsert(null, "전공-교수소개 등록", rsTcSeq, request);		
		}else{
			
			// 썸네일 삭제
			if(cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
				
				List<String> upSeqList = new ArrayList<>();
				
				EgovMap upfile = admTeacherDAO.selectTeacherUpfileList(teacherVO.getTcSeq());
					
				cmmnFileMngUtil.deleteFile(upfile.get("tcupSaveFilepath").toString());	// 파일 삭제
				
				String filePath = upfile.get("tcupSaveFilepath").toString();
				int pos = filePath.lastIndexOf(".");
				String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
				
				
				cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
					
				upSeqList.add(upfile.get("tcupSeq").toString()); // 삭제할 썸네일 리스트 읃록
				
				admTeacherDAO.deleteTeacherUpfileList(upSeqList); // 데이터 삭제
				
			}
			
			
			// 수정
			rsTcSeq = teacherVO.getTcSeq();
			admTeacherDAO.updateTeacherOne(teacherVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "전공-교수소개 수정", rsTcSeq, request);
			
		}
		
		// 첨부파일
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "teacher");
		for(FileInfoVO vo : fileInfoList){
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("fileInfoVO", vo);
			map.put("tcSeq", rsTcSeq);
			
			
			admTeacherDAO.insertTeacherUpfileOne(map);
		}
		
		
		return redirectListPage(message, searchVO, reda);
	}
	
	//삭제
	@RequestMapping("/qxerpynm/majorBoard/teacher/admMajorTeacherDelete.do")
	public String admMajorTeacherDelete(ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, String tcSeq)throws Exception{
		LOGGER.info("/qxerpynm/majorBoard/teacher/admMajorTeacherDelete.do - 관리자 > 전공 > 교수소개 > 삭제");
		LOGGER.debug("searchVO - "+searchVO);
		LOGGER.debug("tcSeq - "+tcSeq);
		
		// 첨부파일 삭제
			
		EgovMap upfileList = admTeacherDAO.selectTeacherUpfileList(tcSeq);
		if(upfileList!=null){
			List<String> upSeqList = new ArrayList<>();
			
			cmmnFileMngUtil.deleteFile(upfileList.get("tcupSaveFilepath").toString());	// 파일 삭제
			
			String filePath = upfileList.get("tcupSaveFilepath").toString();
			int pos = filePath.lastIndexOf(".");
			String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
			
			
			cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
			
			upSeqList.add(upfileList.get("tcupSeq").toString());
		
			admTeacherDAO.deleteTeacherUpfileList(upSeqList);// 데이터 삭제
		}
		admTeacherDAO.deleteAdmTeacherOne(tcSeq);// 주제 삭제
	
		searchVO.setMessage("삭제되었습니다.");
		
		// 로그등록
		admLogInsert(null, "전공-교수소개 삭제", tcSeq, request);
		
		return redirectListPage(searchVO.getMessage(), searchVO, reda);
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*******************************************일학습 엘리트과정*******************************************/
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectEliteListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/elite/teacher/admEliteTeacherList.do";
	}
	
	
	// 목록
	@RequestMapping("/qxerpynm/elite/teacher/admEliteTeacherList.do")
	public String admEliteTeacherList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) throws Exception{
		LOGGER.info("/qxerpynm/elite/teacher/admEliteTeacherList.do - 관리자 > 교수소개 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("admMenuNo", "805");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) {
			searchVO.setSearchCondition1("14");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admTeacherDAO.selectAdmTeacherList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> majorList = admTeacherDAO.selectMajorList();
		
		model.addAttribute("majorList", majorList);
		
		// 로그등록
		admLogInsert(null, "일학습엘리트과정-교수소개", "목록", request);
		
		return "/adm/elite/teacher/admEliteTeacherList";
	}
	
	// 등록 & 수정화면
	@RequestMapping("/qxerpynm/elite/teacher/admEliteTeacherModify.do")
	public String admEliteTeacherModify(String tcSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/elite/teacher/admEliteTeacherModify.do - 관리자 > 교수소개 > 등록&수정화면");
		LOGGER.debug("tcSeq = "+tcSeq);
		
		TeacherVO teacherVO = null;
		
		
		if(EgovStringUtil.isEmpty(tcSeq)){
			// 등록화면
			teacherVO = new TeacherVO();
		}else{
			// 수정화면
			teacherVO = admTeacherDAO.selectAdmTeacherOne(tcSeq);
			String[] subjectList = teacherVO.getTcSubject().split(",");
			model.addAttribute("subjectList", subjectList);
			model.addAttribute("tcUpfileList",admTeacherDAO.selectTeacherUpfileList(tcSeq));
		}
		
		List<EgovMap> majorList = admTeacherDAO.selectMajorList();
		
		model.addAttribute("majorList", majorList);
		model.addAttribute("teacherVO", teacherVO);
		return "/adm/elite/teacher/admEliteTeacherModify";
	}
	
	// 등록&수정
	@RequestMapping("/qxerpynm/elite/teacher/admEliteTeacherUpdate.do")
	public String admEliteTeacherUpdate(TeacherVO teacherVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request,ModelMap model, RedirectAttributes reda, MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.info("/qxerpynm/elite/teacher/admEliteTeacherUpdate.do - 관리자 > 일학습엘리트과정 > 교수소개 > 등록&수정");
		LOGGER.debug("teacherVO = "+teacherVO.toString());
		String message = "오류가 발생하였습니다.";
		
		//내용 여부 확인
		if(EgovStringUtil.isEmpty(teacherVO.getTcContent().trim())){
			searchVO.setMessage("내용이 없습니다");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(message, searchVO, reda);
		}
		if(EgovStringUtil.isEmpty(teacherVO.getTcName().trim())){
			searchVO.setMessage("이름이 없습니다");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(message ,searchVO, reda);
		}
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
			return redirectListPage(message, searchVO, reda);
		}
		
		
		String rsTcSeq = "";
		if(EgovStringUtil.isEmpty(teacherVO.getTcSeq())){
			// 등록
			rsTcSeq = admTeacherDAO.insertTeacherOne(teacherVO);
			message = "등록되었습니다.";
			
			// 로그등록
			admLogInsert(null, "일학습엘리트과정-교수소개 등록", rsTcSeq, request);		
		}else{
			
			// 썸네일 삭제
			if(cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
				
				List<String> upSeqList = new ArrayList<>();
				
				EgovMap upfile = admTeacherDAO.selectTeacherUpfileList(teacherVO.getTcSeq());
					
				cmmnFileMngUtil.deleteFile(upfile.get("tcupSaveFilepath").toString());	// 파일 삭제
				
				String filePath = upfile.get("tcupSaveFilepath").toString();
				int pos = filePath.lastIndexOf(".");
				String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
				
				
				cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
					
				upSeqList.add(upfile.get("tcupSeq").toString()); // 삭제할 썸네일 리스트 읃록
				
				admTeacherDAO.deleteTeacherUpfileList(upSeqList); // 데이터 삭제
				
			}
			
			
			// 수정
			rsTcSeq = teacherVO.getTcSeq();
			admTeacherDAO.updateTeacherOne(teacherVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "일학습엘리트과정-교수소개 수정", rsTcSeq, request);
			
		}
		
		// 첨부파일
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "teacher");
		for(FileInfoVO vo : fileInfoList){
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("fileInfoVO", vo);
			map.put("tcSeq", rsTcSeq);
			
			
			admTeacherDAO.insertTeacherUpfileOne(map);
		}
		
		
		return redirectEliteListPage(message, searchVO, reda);
	}
	
	//삭제
	@RequestMapping("/qxerpynm/elite/teacher/admEliteTeacherDelete.do")
	public String admEliteTeacherDelete(ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, String tcSeq)throws Exception{
		LOGGER.info("/qxerpynm/elite/teacher/admEliteTeacherDelete.do - 관리자 > 일학습엘리트과정 > 교수소개 > 삭제");
		LOGGER.debug("searchVO - "+searchVO);
		LOGGER.debug("tcSeq - "+tcSeq);
		
		// 첨부파일 삭제
			
		EgovMap upfileList = admTeacherDAO.selectTeacherUpfileList(tcSeq);
		if(upfileList!=null){
			List<String> upSeqList = new ArrayList<>();
			
			cmmnFileMngUtil.deleteFile(upfileList.get("tcupSaveFilepath").toString());	// 파일 삭제
			
			String filePath = upfileList.get("tcupSaveFilepath").toString();
			int pos = filePath.lastIndexOf(".");
			String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
			
			
			cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
			
			upSeqList.add(upfileList.get("tcupSeq").toString());
		
			admTeacherDAO.deleteTeacherUpfileList(upSeqList);// 데이터 삭제
		}
		admTeacherDAO.deleteAdmTeacherOne(tcSeq);// 주제 삭제
	
		searchVO.setMessage("삭제되었습니다.");
		
		// 로그등록
		admLogInsert(null, "일학습엘리트과정-교수소개 삭제", tcSeq, request);
		
		return redirectEliteListPage(searchVO.getMessage(), searchVO, reda);
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*******************************************일학습 엘리트과정*******************************************/
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/*
	// 썸네일 삭제
	@RequestMapping("/qxerpynm/majorBoard/teacher/admMajorTeacherThumbDelete.do")
	public String admMajorTeacherThumbDelete(String tcupSeq, String tcSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda, MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/teacher/admMajorTeacherUpdate.do - 관리자 > 전공 >  썸네일 삭제");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("tcupSeq = "+tcupSeq.toString());
						
		// 썸네일 삭제
		if (!EgovStringUtil.isEmpty(tcupSeq)) {
			EgovMap upfile = admTeacherDAO.selectTeacherUpfileOne(tcupSeq);
			List<String> upSeqList = new ArrayList<String>();
			
			upSeqList.add(tcupSeq);
			
			cmmnFileMngUtil.deleteFile(upfile.get("tcupSaveFilepath").toString());	// 파일 삭제
			String filePath = upfile.get("tcupSaveFilepath").toString();
			int pos = filePath.lastIndexOf(".");
			String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
			
			
			cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
			admTeacherDAO.deleteTeacherUpfileList(upSeqList);// 데이터 삭제
		}
		TeacherVO teacherVO = admTeacherDAO.selectAdmTeacherOne(tcSeq);
		List<EgovMap> majorList = admTeacherDAO.selectMajorList();
		
		model.addAttribute("majorList", majorList);
		
		model.addAttribute("teacherVO", teacherVO);
		
		
		return "/adm/majorBoard/teacher/admMajorTeacherModify";
	}
	*/	
}
