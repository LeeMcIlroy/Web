package writer.usr.lec;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.usr.cmm.CmmCmmtDAO;
import writer.usr.cmm.CmmDAO;
import writer.valueObject.ClassVO;
import writer.valueObject.ClsNoticeVO;
import writer.valueObject.DepartmentVO;
import writer.valueObject.HomeworkVO;
import writer.valueObject.SemesterVO;
import writer.valueObject.SubjectVO;
import writer.valueObject.cmmn.CmmnCommentVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class LecController {

	private static final Logger LOGGER = LoggerFactory.getLogger(LecController.class);
	
	@Autowired private LecDAO lecDAO;
	@Autowired private CmmDAO cmmDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	@Autowired private CmmCmmtDAO cmmCmmtDAO;
	
	@Resource View jsonView;
	
	/*********************************** 공통 ***********************************/
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda, String type){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		if ("CLS_SBJT".equals(type)) {
			redirectPage = "redirect:/usr/lec/lecSubjectList.do";		// 주제 출제 목록
		}else if ("CLS_NOTI".equals(type)) {
			redirectPage = "redirect:/usr/lec/lecBoardList.do";			// 우리반 게시판 목록
		}
		return redirectPage;
		
	}
	
	// 검색 조건을 가지고 과제 목록으로 이동합니다.	
	private String redirectHmwkListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/usr/lec/lecHomeWorkList.do";
	}
	
	// 학기 목록, 학기&반_교수 정보 가져오기
	private void getSmtrClsInfoAndSmtrList(CmmnSearchVO searchVO, ModelMap model){
		// 학기 & 반_교수 정보
		EgovMap smtrClsInfo = cmmDAO.selectClsOne(searchVO.getSearchClass());
		model.addAttribute("smtrClsInfo", smtrClsInfo);
		
		// 학기 목록
		searchVO.setSearchSemester(smtrClsInfo.get("smtrSeq").toString());
		List<SemesterVO> smtrList = cmmDAO.selectSmtrList(searchVO);
		model.addAttribute("smtrList", smtrList);
	}
	
	/*********************************** 반_교수 ***********************************/
	// 목록
	@RequestMapping("/usr/lec/lecClassList.do")
	public String lecClassList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/lec/lecClassList.do - 사용자 > 강의실 > 반_교수 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("menuNo", "10");
		
		// 학기 목록
		List<SemesterVO> smtrList = cmmDAO.selectSmtrList(searchVO);
		model.addAttribute("smtrList", smtrList);
		for(SemesterVO smtr : smtrList){
			if ("Y".equals(smtr.getChoiceYn())) {
				searchVO.setSearchSemester(smtr.getSmtrSeq());
			}
		}
		
		// 계열 목록
		List<DepartmentVO> deptList = cmmDAO.selectDeptList(searchVO);
		model.addAttribute("deptList", deptList);
		
		// 반_교수 목록
		List<ClassVO> clsList = cmmDAO.selectClsList(searchVO);
		model.addAttribute("clsList", clsList);
		
		// 나의 강의실
		List<ClassVO> myClsList = lecDAO.selectMyLecClassList(searchVO);
		model.addAttribute("myClsList", myClsList);
/*		
		if(clsList.size() == 0){
			LOGGER.debug("학기 강의실이 존재하지 않습니다.(smtrSeq = "+searchVO.getSearchSemester()+")");
			return "redirect:/";
		}
*/
		
		return "/usr/lec/lecClassList";
	}
	
	// 나의 강의실 ajax
	@RequestMapping("/usr/lec/myLecClassAjax.do")
	public View myLecClassAjax(@RequestParam String clsSeq, @RequestParam String type, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/myLecClassAjax.do - 사용자 > 강의실 > 반_교수 조회 > 나의 강의실 ajax");
		LOGGER.debug("clsSeq = "+clsSeq+", type = "+type);
		String result = "0";
		
		if(EgovUserDetailsHelper.isAuthenticatedUser()){	// 로그인여부 확인
			
			if("INSERT".equals(type)){
				// 등록
				ClassVO classVO = lecDAO.selectLecClassOne(clsSeq);
				if(classVO != null){
					lecDAO.myLecClassInsert(clsSeq);
					result = "1";
				}
				
			}else if("DELETE".equals(type)){
				// 삭제
				Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
				EgovMap myLecClassVO = lecDAO.selectMyLecClassOne(clsSeq, userVO.get("memCode"));
				if(myLecClassVO != null && (myLecClassVO.get("myHakbun")).equals(userVO.get("memCode"))){
					lecDAO.myLecClassDelete(myLecClassVO.get("mySeq").toString());
					result = "1";
				}
			}
		}
		
		model.addAttribute("result", result);
		model.addAttribute("type", type);
		return jsonView;
	}

	/*********************************** 주제 ***********************************/
	// 조회_주제 목록
	@RequestMapping("/usr/lec/lecSubjectList.do")
	public String lecSubjectList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.info("/usr/lec/lecSubjectList.do - 사용자 > 강의실 > 반_교수 목록 > 주제 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("menuNo", "10");
		
		// 학기 목록, 학기&반_교수 정보
		getSmtrClsInfoAndSmtrList(searchVO, model);
		
		// 주제 출제
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = lecDAO.selectLecSubjectList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/usr/lec/lecSubjectList";
	}
	
	/*********************************** 과제 ***********************************/
	// 주제 조회화면_과제 목록
	@RequestMapping("/usr/lec/lecHomeWorkList.do")
	public String lecHomeWorkList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/usr/lec/lecHomeWorkList.do - 사용자 > 강의실 > 반_교수목록 > 주제조회_과제목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// 학기 목록, 학기&반_교수 정보
		getSmtrClsInfoAndSmtrList(searchVO, model);
		
		// 주제 조회
		model.addAttribute("subjectVO", lecDAO.selectLecSubjectOne(searchVO.getSearchSubject()));
		model.addAttribute("sbjtUpfileList", lecDAO.selectLecSbjtUpfileList(searchVO.getSearchSubject()));
		
		// 과제 목록
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo2(searchVO);
		CmmnListVO listVO = lecDAO.selectLecHomeworkList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/usr/lec/lecHomeWorkList";
	}
	
	// 과제 조회
	@RequestMapping("/usr/lec/lecHomeWorkView.do")
	public String lecHomeWorkView(@RequestParam String hmwkSeq, @RequestParam(defaultValue="1") String pageCmmtIndex, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecHomeWorkView.do - 사용자 > 강의실 > 반_교수목록 > 주제조회 > 과제 조회");
		LOGGER.debug("hmwkSeq = "+hmwkSeq);
		
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		
				
		// 학기 목록, 학기&반_교수 정보
		getSmtrClsInfoAndSmtrList(searchVO, model);
		
		// 과제
		HomeworkVO homeworkVO = lecDAO.selectLecHomeworkOne(hmwkSeq);
		if(homeworkVO == null){
			LOGGER.debug("조회된 과제가 없습니다.(hmwkSeq = "+hmwkSeq+")");
			return redirectHmwkListPage("조회된 과제가 없습니다.", searchVO, reda);
		}
		
		// 첨삭확인완료 관련 보수 191205
		// 조별과제에 있는 학번에, 로그인 학번이 포함되어 있으면, 확인 가능 토록 수정.
		boolean isAuth = false;
		String hmwkHakbuns = EgovStringUtil.isEmpty(homeworkVO.getHmwkHakbuns()) ? "" : homeworkVO.getHmwkHakbuns().trim();
		String memCode = userVO.get("memCode");
		
		if(!EgovStringUtil.isEmpty(hmwkHakbuns) && hmwkHakbuns.indexOf(memCode) >= 0) {
			isAuth = true;
		}
		
		SubjectVO subjectVO = lecDAO.selectLecSubjectOne(homeworkVO.getSbjtSeq());
		if("N".equals(subjectVO.getSbjtViewYn())){
			if(!(userVO.get("memCode").equals(homeworkVO.getHmwkRegId()))){
				if(!isAuth) {
					LOGGER.debug("작성자만 조회가능 합니다.");
					return redirectHmwkListPage("작성자만 조회가능 합니다.", searchVO, reda);
				}
			}
		}
		
		// 첨삭완료된 글을 글쓴이가 조회하면 첨삭완료확인
		if("2".equals(homeworkVO.getHmwkStatus()) 
			&&
			(userVO.get("memCode").equals(homeworkVO.getHmwkRegId()) || isAuth)
			){
			lecDAO.lecHomeworkStatusUpdate(hmwkSeq);
		}
		
		// 스크립트 치환
		homeworkVO.setHmwkContent((EgovWebUtil.clearXSSMinimum(homeworkVO.getHmwkContent()).replaceAll("\r\n", "<br>")));
		homeworkVO.setHmwkContent2((EgovWebUtil.clearXSSMinimum(homeworkVO.getHmwkContent2()).replaceAll("\r\n", "<br>")));
		
		model.addAttribute("homeworkVO", homeworkVO);
		
		// 첨부파일
		List<EgovMap> hmwkFileList = lecDAO.selectLecHomeworkUpfileList(hmwkSeq);
		model.addAttribute("hmwkFileList", hmwkFileList);
		
		// 댓글
		CmmnListVO cmmtListVO = cmmCmmtDAO.selectLecHomeworkCommentList(hmwkSeq, pageCmmtIndex);
		model.addAttribute("cmmtListCnt", cmmtListVO.getTotalRecordCount());
		model.addAttribute("cmmtList", cmmtListVO.getEgovList());
		
		return "/usr/lec/lecHomeWorkView";
	}
	
	// 과제 등록&수정화면
	@RequestMapping("/usr/lec/lecHomeWorkModify.do")
	public String lecHomeWorkModify(String hmwkSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecHomeWorkModify.do - 사용자 > 강의실 > 반_교수목록 > 주제조회 > 과제 등록&수정화면");
		LOGGER.debug("serachVO = "+searchVO.toString());
		LOGGER.debug("hmwkSeq = "+hmwkSeq);

		// 날짜 검사
		SubjectVO subjectVO = lecDAO.selectLecSubjectOne(searchVO.getSearchSubject());
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String nowDate = format.format(new Date());
		
		String startDate = subjectVO.getSbjtStartDate()+" "+subjectVO.getSbjtStartTime();
		String endDate = subjectVO.getSbjtEndDate()+" "+subjectVO.getSbjtEndTime();
		
		if(startDate.compareTo(nowDate) > 0 || endDate.compareTo(nowDate) < 0){
			LOGGER.debug("제출기간이 아닙니다.");
			return redirectHmwkListPage("제출기간이 아닙니다.", searchVO, reda);
		}
		
		// 학기 목록, 학기&반_교수 정보
		getSmtrClsInfoAndSmtrList(searchVO, model);
		
		// 주제 조회
		model.addAttribute("subjectVO", lecDAO.selectLecSubjectOne(searchVO.getSearchSubject()));
		model.addAttribute("sbjtUpfileList", lecDAO.selectLecSbjtUpfileList(searchVO.getSearchSubject()));
		
		HomeworkVO homeworkVO = null;
		if(EgovStringUtil.isEmpty(hmwkSeq)){
			// 등록화면
			homeworkVO = new HomeworkVO();
		}else{
			// 수정화면
			homeworkVO = lecDAO.selectLecHomeworkOne(hmwkSeq);
			List<EgovMap> hmwkFileList = lecDAO.selectLecHomeworkUpfileList(hmwkSeq);
			model.addAttribute("hmwkFileList", hmwkFileList);
		}
		model.addAttribute("homeworkVO", homeworkVO);
		return "/usr/lec/lecHomeWorkModify";
	}
	
	// 과제 등록&수정
	@RequestMapping("/usr/lec/lecHomeWorkUpdate.do")
	public String lecHomeWorkUpdate(HomeworkVO homeworkVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecHomeWorkUpdate.do - 사용자 > 강의실 > 반_교수목록 > 주제조회 > 과제 등록&수정");
		LOGGER.debug("homework = "+homeworkVO.toString());
		
		// 날짜 검사
		SubjectVO subjectVO = lecDAO.selectLecSubjectOne(searchVO.getSearchSubject());
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String nowDate = format.format(new Date());
		
		String startDate = subjectVO.getSbjtStartDate()+" "+subjectVO.getSbjtStartTime();
		String endDate = subjectVO.getSbjtEndDate()+" "+subjectVO.getSbjtEndTime();
		
		if(startDate.compareTo(nowDate) > 0 || endDate.compareTo(nowDate) < 0){
			LOGGER.debug("제출기간이 아닙니다.");
			return redirectHmwkListPage("제출기간이 아닙니다.", searchVO, reda);
		}
		
		// 첨부파일 조건 확인1 (용량 및 확장자) - start
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("파일첨부 오류");
			return redirectHmwkListPage("업로드 파일이 잘못되었습니다.", searchVO, reda);
		}
		// 첨부파일 조건 확인1 (용량 및 확장자) - end
		
		// 첨부파일 조건 확인2 (파일 수) - start
		boolean fileCntFlag = false;
		int fileCnt = cmmnFileMngUtil.uploadFileCntCheck(multiRequest);
		if(EgovStringUtil.isEmpty(homeworkVO.getHmwkSeq())){
			if(fileCnt == 0) fileCntFlag = true;
		}else{
			if(fileCnt == 0 && !EgovStringUtil.isEmpty(homeworkVO.getFileDeleteChk())) fileCntFlag = true;
		}
		if(fileCntFlag){
			LOGGER.debug("파일이 없습니다.");
			return redirectHmwkListPage("첨부파일이 없습니다.", searchVO, reda);
		}
		// 첨부파일 조건 확인2 (파일 수) - end
		
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		
		homeworkVO.setHmwkRegId(userVO.get("memCode"));
		homeworkVO.setHmwkRegName(userVO.get("memName"));
		homeworkVO.setHmwkRegDept(userVO.get("memDept"));
		
		String message = "";
		String rsHmwkSeq = "";
		if(EgovStringUtil.isEmpty(homeworkVO.getHmwkSeq())){
			// 등록
			homeworkVO.setSbjtSeq(searchVO.getSearchSubject());
			rsHmwkSeq = lecDAO.lecHomeworkInsert(homeworkVO);
			message = "등록되었습니다.";
		}else{
			// 수정
			lecDAO.lecHomeworkUpdate(homeworkVO);
			rsHmwkSeq = homeworkVO.getHmwkSeq();
			message = "수정되었습니다.";
		}
		
		// 첨부파일
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "HOMEWORK");
		for(FileInfoVO fileInfoVO : fileInfoList){
			lecDAO.lecHomeworkUpfileInsert(fileInfoVO, rsHmwkSeq);
		}
/*
		// 첨부파일 삭제
		if (!EgovStringUtil.isEmpty(homeworkVO.getFileDeleteChk())) {
			String[] arrUpSeq = (homeworkVO.getFileDeleteChk()).split(",");
			List<String> upSeqList = new ArrayList<>();
			for(String upSeq : arrUpSeq){
				EgovMap upfile = lecDAO.selectLecHomeworkUpfileOne(upSeq);
				cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
				upSeqList.add(upSeq);
			}
			lecDAO.lecHomeworkUpFilesDelete(upSeqList);	// 데이터 삭제
		}
*/
		return redirectHmwkListPage(message, searchVO, reda);
	}
	
	// 과제 첨부파일 삭제
	@RequestMapping("/usr/lec/lecHomeWorkUpfileDetele.do")
/*
	public String lecHomeWorkUpfileDetele(@RequestParam String upSeq, @RequestParam String hmwkSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecHomeWorkUpfileDetele.do - 사용자 > 강의실 > 반_교수 목록 > 주제조회 > 과제 수정 > 첨부파일 삭제");
		LOGGER.debug("upSeq = {}, hmwkSeq = {}", upSeq, hmwkSeq);
		
		List<EgovMap> fileList = lecDAO.selectLecHomeworkUpfileList(hmwkSeq);
		if(fileList.size() == 1) return redirectHmwkListPage("첨부파일을 모두 삭제하실수 없습니다.", searchVO, reda);
		
		EgovMap upfile = lecDAO.selectLecHomeworkUpfileOne(upSeq);
		cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
		lecDAO.lecHomeworkUpFileDelete(upSeq);	// 데이터 삭제
		
		//reda.addFlashAttribute("hmwkSeq", hmwkSeq);
		reda.addAttribute("hmwkSeq", hmwkSeq);
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addFlashAttribute("message", "선택된 파일이 삭제되었습니다.");
		return "redirect:/usr/lec/lecHomeWorkModify.do";
	}
*/
	public View lecHomeWorkUpfileDetele(@RequestParam String upSeq, @RequestParam String hmwkSeq, ModelMap model) throws Exception {
		LOGGER.info("/usr/lec/lecHomeWorkUpfileDetele.do - 사용자 > 강의실 > 반_교수 목록 > 주제조회 > 과제 수정 > 첨부파일 삭제");
		LOGGER.debug("upSeq = {}, hmwkSeq = {}", upSeq, hmwkSeq);

		// 결과
		int result = 1;
		
		List<EgovMap> fileList = lecDAO.selectLecHomeworkUpfileList(hmwkSeq);
		
		String rsHmwkRegId = fileList.get(0).get("hmwkRegId").toString();
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		
		if((userVO.get("memCode").toString()).equals(rsHmwkRegId)){		// userSession 과 일치여부 확인
			
			if(fileList.size() != 1) {		// 파일 수 확인
				
				EgovMap upfile = lecDAO.selectLecHomeworkUpfileOne(upSeq);
				cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
				lecDAO.lecHomeworkUpFileDelete(upSeq);	// 데이터 삭제
				result = 0;
				
			}
		}else{
			result = 2;
		}
		
		model.addAttribute("result", result);
		return jsonView;
	}
	
	// 과제 삭제
	@RequestMapping("/usr/lec/lecHomeWorkDelete.do")
	public String lecHomeWorkDelete(@RequestParam String hmwkSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecHomeWorkDelete.do - 사용자 > 강의실 > 반_교수 목록 > 주제조회 > 과제 삭제");
		LOGGER.debug("hmwkSeq = "+hmwkSeq);
		
		// 첨부파일 삭제
		List<EgovMap> hmwkFileList = lecDAO.selectLecHomeworkUpfileList(hmwkSeq);
		if(hmwkFileList.size() != 0){
			List<String> upSeqList = new ArrayList<>();
			for(EgovMap hmwkFile : hmwkFileList){
				cmmnFileMngUtil.deleteFile(hmwkFile.get("upSaveFilePath").toString());	// 파일 삭제
				upSeqList.add(hmwkFile.get("upSeq").toString());
			}
			lecDAO.lecHomeworkUpFilesDelete(upSeqList);	// 데이터 삭제
		}
		
		// 글 삭제
		lecDAO.lecHomeworkDelete(hmwkSeq);
		
		return redirectHmwkListPage("삭제되었습니다.", searchVO, reda);
	}
	
	// 과제 댓글 더보기
	@RequestMapping("/usr/lec/lecHmwkCommentAddList.do")
	public View lecHmwkCommentAddList(@RequestParam String hmwkSeq, @RequestParam String pageCmmtIndex, ModelMap model) throws Exception {
		LOGGER.info("/usr/lec/lecHmwkCommentAddList.do - 사용자 > 강의실 > 반_교수 목록 > 주제조회 > 과제 조회 > 댓글 더보기");
		LOGGER.debug("hmwkSeq = "+hmwkSeq+", pageCmmtIndex = "+pageCmmtIndex);
		
		CmmnListVO cmmtListVO = cmmCmmtDAO.selectLecHomeworkCommentList(hmwkSeq, pageCmmtIndex);
		model.addAttribute("cmmtList", cmmtListVO.getEgovList());
		return jsonView;
	}
	
	// 과제 댓글 등록
	@RequestMapping("/usr/lec/lecHmwkCommentInsert.do")
	public String lecHmwkCommentInsert(CmmnCommentVO commentVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecHmwkCommentInsert.do - 사용자 > 강의실 > 반_교수 목록 > 주제조회 > 과제 조회 > 댓글 등록");
		LOGGER.debug("commentVO = "+commentVO.toString());
		
		if (EgovStringUtil.isEmpty(commentVO.getCmtContent()) || EgovStringUtil.isEmpty(commentVO.getHmwkSeq())) {
			LOGGER.debug("내용 또는 원글 번호가 없습니다.(cmtContent = "+commentVO.getCmtContent()+", hmwkSeq = "+commentVO.getHmwkSeq()+")");
			return redirectHmwkListPage("내용 또는 원글 번호가 없습니다.", searchVO, reda);
		}
		// 등록
		cmmCmmtDAO.lecHomeworkCommentInsert(commentVO);
		reda.addFlashAttribute("message", "댓글이 등록되었습니다.");
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addAttribute("hmwkSeq", commentVO.getHmwkSeq());
		return "redirect:/usr/lec/lecHomeWorkView.do";
	}
	
	// 과제 댓글 삭제
	@RequestMapping("/usr/lec/lecHmwkCommentDelete.do")
	public String lecHmwkCommentDelete(@RequestParam String cmtSeq, @RequestParam String hmwkSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecHmwkCommentDelete.do - 사용자 > 강의실 > 반_교수 목록 > 주제조회 > 과제 조회 > 댓글 삭제");
		LOGGER.debug("cmtSeq = "+cmtSeq+", hmwkSeq = "+hmwkSeq);
		
		// 삭제
		cmmCmmtDAO.lecHomeworkCommentDelete(cmtSeq);
		reda.addFlashAttribute("message", "댓글이 삭제되었습니다.");
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addAttribute("hmwkSeq", hmwkSeq);
		return "redirect:/usr/lec/lecHomeWorkView.do";		
	}
	
	/*********************************** 우리반게시판 ***********************************/
	// 우리반게시판 목록
	@RequestMapping("/usr/lec/lecBoardList.do")
	public String lecBoardList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/lec/lecBoardList.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("menuNo", "10");
		
		// 학기 목록, 학기&반_교수 정보
		getSmtrClsInfoAndSmtrList(searchVO, model);
		
		// 우리반게시판
		// 1. 공지
		searchVO.setSearchType("Y"); 
		CmmnListVO notiListVO = lecDAO.selectLecBoardList(searchVO);
		model.addAttribute("notiList", notiListVO.getEgovList());
		
		// 2. 일반글
		searchVO.setSearchType("N"); 
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = lecDAO.selectLecBoardList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/usr/lec/lecBoardList";
	}
	
	// 우리반게시판 조회
	@RequestMapping("/usr/lec/lecBoardView.do")
	public String lecBoardView(@RequestParam String ntSeq, @RequestParam(defaultValue="1") String pageCmmtIndex, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecBoardView.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 조회");
		LOGGER.debug("ntSeq = "+ntSeq);
		
		// 학기 목록, 학기&반_교수 정보
		getSmtrClsInfoAndSmtrList(searchVO, model);
		
		// 우리반게시판
		ClsNoticeVO clsNoticeVO = lecDAO.selectLecBoardOne(ntSeq);
		
		if (clsNoticeVO == null) {
			LOGGER.debug("우리반게시판 글이 없습니다.(ntSeq = "+ntSeq+")");
			return redirectListPage("우리반게시판 글이 없습니다.", searchVO, reda, "CLS_NOTI");
		}
		
		model.addAttribute("clsNoticeVO", clsNoticeVO);
		
		// 첨부파일
		model.addAttribute("notiUpfileList", lecDAO.selectLecBoardUpfileList(ntSeq));
		
		// 댓글
		CmmnListVO cmmtListVO = cmmCmmtDAO.selectLecBoardCommentList(ntSeq, pageCmmtIndex);
		model.addAttribute("cmmtListCnt", cmmtListVO.getTotalRecordCount());
		model.addAttribute("cmmtList", cmmtListVO.getEgovList());
		
		return "/usr/lec/lecBoardView";
	}

	// 우리반게시판 등록&수정 화면
	@RequestMapping("/usr/lec/lecBoardModify.do")
	public String lecBoardModify(String ntSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/usr/lec/lecBoardModify.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 등록&수정화면");
		LOGGER.debug("ntSeq = "+ntSeq);

		// 학기 목록, 학기&반_교수 정보
		getSmtrClsInfoAndSmtrList(searchVO, model);
		
		ClsNoticeVO clsNoticeVO = null;
		if (EgovStringUtil.isEmpty(ntSeq)) {
			// 등록화면
			clsNoticeVO = new ClsNoticeVO();
		}else {
			// 수정화면
			clsNoticeVO = lecDAO.selectLecBoardOne(ntSeq);
			//역치환하여 출력
			clsNoticeVO.setNtContent(EgovWebUtil.notClearXSSMinimum(clsNoticeVO.getNtContent()).replaceAll("<br/>", "\r\n"));
			model.addAttribute("notiUpfileList", lecDAO.selectLecBoardUpfileList(ntSeq));
		}
		
		model.addAttribute("clsNoticeVO", clsNoticeVO);
		return "/usr/lec/lecBoardModify";
	}

	// 우리반게시판 등록&수정
	@RequestMapping("/usr/lec/lecBoardUpdate.do")
	public String lecBoardUpdate(ClsNoticeVO clsNoticeVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecBoardUpdate.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 등록&수정");
		LOGGER.debug("clsNoticeVO = "+clsNoticeVO.toString());
		
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			return redirectListPage("첨부된 파일이 잘못되었습니다.", searchVO, reda, "CLS_NOTI");
		}
		String rsNtSeq = "";
		String message = "";
		
		if("STUD".equals(((Map<String, String>)EgovUserDetailsHelper.getAuthenticatedUser()).get("memType"))){
			//치환하여 입력
			clsNoticeVO.setNtContent(EgovWebUtil.clearXSSMinimum(clsNoticeVO.getNtContent()).replaceAll("\r\n", "<br/>"));
		}
		if (EgovStringUtil.isEmpty(clsNoticeVO.getNtSeq())) {
			// 등록
			clsNoticeVO.setClsSeq(searchVO.getSearchClass());
			rsNtSeq = lecDAO.lecBoardInsert(clsNoticeVO);
			message = "등록되었습니다.";
		}else {
			// 수정
			lecDAO.lecBoardUpdate(clsNoticeVO);
			rsNtSeq = clsNoticeVO.getNtSeq();
			message = "수정되었습니다.";
		}
		
		// 첨부파일
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "CLASS_NOTICE");
		for(FileInfoVO vo : fileInfoList){
			lecDAO.lecBoardUpfileInsert(vo, rsNtSeq);
		}

		// 첨부파일 삭제
		if (!EgovStringUtil.isEmpty(clsNoticeVO.getFileDeleteChk())) {
			String[] arrUpSeq = (clsNoticeVO.getFileDeleteChk()).split(",");
			List<String> upSeqList = new ArrayList<>();
			for(String upSeq : arrUpSeq){
				EgovMap upfile = lecDAO.selectLecBoardUpfileOne(upSeq);
				cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
				upSeqList.add(upSeq);
			}
			lecDAO.lecBoardUpfilesDelete(upSeqList);	// 데이터 삭제
		}
		
		return redirectListPage(message, searchVO, reda, "CLS_NOTI");
	}
	
	// 우리반게시판 첨부파일 삭제
	@RequestMapping("/usr/lec/lecBoardUpfileDetele.do")
	public View lecBoardUpfileDetele(@RequestParam String upSeq, ModelMap model) {
		LOGGER.info("/usr/lec/lecBoardUpfileDetele.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 > 첨부파일 삭제");
		LOGGER.debug("upSeq = {}", upSeq);
		
		int result = 1;
		try{
			EgovMap upfile = lecDAO.selectLecBoardUpfileOne(upSeq);
			cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
			lecDAO.lecBoardUpfileDelete(upSeq);
			result = 0;
		}catch(Exception e){
			LOGGER.debug("우리반게시판 첨부파일 삭제 오류 (message = {})", e.getMessage());
		}finally {
			model.addAttribute("result", result);
		}
		
		return jsonView;
	}
	
	// 우리반게시판 삭제
	@RequestMapping("/usr/lec/lecBoardDelete.do")
	public String lecBoardDelete(@RequestParam String ntSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecBoardDelete.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 삭제");
		LOGGER.debug("ntSeq = "+ntSeq);
		
		// 첨부파일 삭제
		List<EgovMap> upfileList = lecDAO.selectLecBoardUpfileList(ntSeq);
		if(upfileList.size() != 0){
			List<String> upSeqList = new ArrayList<>();
			for(EgovMap upfile : upfileList){
				cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
				upSeqList.add(upfile.get("upSeq").toString());
			}
		lecDAO.lecBoardUpfilesDelete(upSeqList);	// 데이터 삭제
		}
		
		// 주제 삭제
		lecDAO.lecBoardDelete(ntSeq);
		
		return redirectListPage("삭제되었습니다.", searchVO, reda, "CLS_NOTI");
	}
	
	// 우리반게시판 댓글 더보기
	@RequestMapping("/usr/lec/lecBoardCommentAddList.do")
	public View lecBoardCommentAddList(@RequestParam String ntSeq, @RequestParam String pageCmmtIndex, ModelMap model) throws Exception {
		LOGGER.info("/usr/lec/lecBoardCommentAddList.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 조회 > 댓글 더보기");
		LOGGER.debug("ntSeq = "+ntSeq+", pageCmmtIndex = "+pageCmmtIndex);
		
		CmmnListVO cmmtListVO = cmmCmmtDAO.selectLecBoardCommentList(ntSeq, pageCmmtIndex);
		model.addAttribute("cmmtList", cmmtListVO.getEgovList());
		return jsonView;
	}
	
	// 우리반게시판 댓글 등록
	@RequestMapping("/usr/lec/lecBoardCommentInsert.do")
	public String lecBoardCommentInsert(CmmnCommentVO commentVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecBoardCommentInsert.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 조회 > 댓글 등록");
		LOGGER.debug("commentVO = "+commentVO.toString());
		
		if (EgovStringUtil.isEmpty(commentVO.getCmtContent()) || EgovStringUtil.isEmpty(commentVO.getNtSeq())) {
			LOGGER.debug("내용 또는 원글 번호가 없습니다.(cmtContent = "+commentVO.getCmtContent()+", ntSeq = "+commentVO.getNtSeq()+")");
			return redirectListPage("내용 또는 원글 번호가 없습니다.", searchVO, reda, "CLS_NOTI");
		}
		
		// 등록
		cmmCmmtDAO.lecBoardCommentInsert(commentVO);
		reda.addFlashAttribute("message", "댓글이 등록되었습니다.");
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addAttribute("ntSeq", commentVO.getNtSeq());
		return "redirect:/usr/lec/lecBoardView.do";
	}
	
	// 우리반게시판 댓글 삭제
	@RequestMapping("/usr/lec/lecBoardCommentDelete.do")
	public String lecBoardCommentDelete(@RequestParam String cmtSeq, @RequestParam String ntSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/lec/lecBoardCommentDelete.do - 사용자 > 강의실 > 반_교수 목록 > 우리반게시판 조회 > 댓글 삭제");
		LOGGER.debug("cmtSeq = "+cmtSeq+", ntSeq = "+ntSeq);
		
		// 삭제
		cmmCmmtDAO.lecBoardCommentDelete(cmtSeq);
		
		reda.addFlashAttribute("message", "댓글이 삭제되었습니다.");
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addAttribute("ntSeq", ntSeq);
		return "redirect:/usr/lec/lecBoardView.do"; 
	}
}
