package lcms.adm.student;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AdminVO;
import lcms.valueObject.AttachVO;
import lcms.valueObject.CountryVO;
import lcms.valueObject.FuncVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmStudentController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmStudentController.class);
	@Autowired private AdmStudentDAO admStudentDAO;
	@Resource private View jsonView;
	@Resource private CmmnFileMngUtil fileUtil;
	@Autowired private CmmDAO cmmDAO;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	// 관리자 학생현황 목록화면
	@RequestMapping("/qxsepmny/student/admStatusList.do")
	public String admStatusList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MemberVO memberVO) throws Exception {
		LOGGER.debug("/qxsepmny/student/admStatusList.do - 관리자 학생현황 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "301");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition6()) && EgovStringUtil.isEmpty(searchVO.getSearchCondition7()) && EgovStringUtil.isEmpty(searchVO.getSearchCondition8())){
			searchVO.setSearchCondition6("DESC");
		}

		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admStudentDAO.StudList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		model.addAttribute("leftMenuType", "301");
		model.addAttribute("topMenuType", "30");
		
		//조건항목검색
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		String year = "";
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			year = searchVO.getSearchCondition1();
		}else{
			year = yearList.get(0);
		}
		List<EgovMap> semeList = cmmDAO.selectSemeList(year);
		model.addAttribute("semeList", semeList);

		String seme = "";
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			seme = searchVO.getSearchCondition2();
		}else if(semeList.size() > 0){
			seme = semeList.get(0).get("semester").toString();
		}
		List<EgovMap> gradeList = cmmDAO.selectGradeList(seme);
		model.addAttribute("gradeList", gradeList);
		
		String grade = "";
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition3())){
			grade = searchVO.getSearchCondition3();
		}else if(gradeList.size() > 0){
			grade = gradeList.get(0).get("grade").toString();
		}
		List<EgovMap> diviList = cmmDAO.selectDiviList(grade);
		model.addAttribute("diviList", diviList);
		// //조건항목검색
		return "/adm/student/admStatusList";
	}

	// 급수 찾기
	@RequestMapping("/qxsepmny/student/ajaxSearchGrade.do")
	public View ajaxSearchGrade(String seme,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/ajaxSearchGrade.do - 급수찾기");
		
		List<EgovMap> gradeList = cmmDAO.selectGradeList(seme);
		model.addAttribute("gradeList", gradeList);
		
		return jsonView;
	}
	// 분반찾기
	@RequestMapping("/qxsepmny/student/ajaxSearchDivi.do")
	public View ajaxSearchDivi(String grade,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/ajaxSearchDivi.do - 분반찾기");
		
		List<EgovMap> diviList = cmmDAO.selectDiviList(grade);
		model.addAttribute("diviList", diviList);
		
		return jsonView;
	}
	
	// 관리자 학생현황 조회화면
	@RequestMapping("/qxsepmny/student/admStatusView.do")
	public String admStatusView(HttpServletRequest request, ModelMap model,MemberVO memberVO,@ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/student/admStatusView.do - 관리자 학생현황 조회화면");
		request.getSession().setAttribute("admMenuNo", "301");
		
		String memberSeq = memberVO.getMemberSeq();

		MemberVO resultVO =  admStudentDAO.selectStudMember(memberSeq);
		model.addAttribute("leftMenuType", "301");
		model.addAttribute("topMenuType", "30");
		model.addAttribute("result", resultVO);
		
		if(!EgovStringUtil.isEmpty(memberSeq)){
			memberVO = admStudentDAO.selectStudMember(memberSeq);

			List<EgovMap> lectList = admStudentDAO.selectStudLectList(memberVO);
			model.addAttribute("lectList", lectList);
			List<EgovMap> regiList = admStudentDAO.selectStudRegiList(memberVO);
			model.addAttribute("regiList", regiList);
			List<EgovMap> gradeList = admStudentDAO.selectGradeList(memberVO);
			model.addAttribute("gradeList", gradeList);
			List<EgovMap> consulList = admStudentDAO.selectStudConsulList(memberVO);
			model.addAttribute("consulList", consulList);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", memberSeq);
			map.put("boardType", "STD");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
					
			model.addAttribute("attachList", attachList);
			
		}
		
		return "/adm/student/admStatusView";
	}
	// 관리자 학생현황 visa 조회
	@RequestMapping("/qxsepmny/student/openVisa.do")
	public View openVisa(HttpServletRequest request, ModelMap model,MemberVO memberVO) throws Exception {
		LOGGER.debug("/qxsepmny/student/admopenVisa.do - 관리자 학생현황 조회화면 >로그처리");

		admLogInsert("운영담당자 > 학생 > 학생현황 : 비자및 여권 정보조회", memberVO.getMemberCode(), request);

		return jsonView;
	}

	// 관리자 학생현황 ins 조회
	@RequestMapping("/qxsepmny/student/openIns.do")
	public View openIns(HttpServletRequest request, ModelMap model,MemberVO memberVO) throws Exception {
		LOGGER.debug("/qxsepmny/student/admopenVisa.do - 관리자 학생현황 조회화면 >로그처리");

		admLogInsert("운영담당자 > 학생 > 학생현황 : 보험증권 및 은행 정보조회", memberVO.getMemberCode(), request);

		return jsonView;
	}

	// 관리자 학생현황 파일 다운로드
	@RequestMapping("/qxsepmny/student/insFileDown.do")
	public View insFileDown(HttpServletRequest request, ModelMap model,MemberVO memberVO) throws Exception {
		LOGGER.debug("/qxsepmny/student/insFileDown.do - 관리자 학생현황 조회화면 >로그처리");
		
		admLogInsert("운영담당자 > 학생 > 학생현황 : 보험증권 및 은행 첨부파일 다운로드", memberVO.getMemberCode(), request);
		
		return jsonView;
	}

	// 관리자 학생현황 등록&수정화면
	@RequestMapping("/qxsepmny/student/admStatusModify.do")
	public String admStatusModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String deleteFile,HttpServletRequest request, ModelMap model, CountryVO countryVO, String memberSeq) throws Exception {
		LOGGER.debug("memberSeq = " + memberSeq);
		LOGGER.debug("/qxsepmny/student/admStatusModify.do - 관리자 학생현황 등록&수정화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "301");
		
		MemberVO memberVO = new MemberVO();
		
		if(!EgovStringUtil.isEmpty(memberSeq)){
			memberVO = admStudentDAO.selectStudMember(memberSeq);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", memberSeq);
			map.put("boardType", "STD");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			
			model.addAttribute("attachList", attachList);
		}
		
//		나라이름
		String purpose = "nation";
		List<EgovMap> country = cmmDAO.cName(purpose);
		model.addAttribute("Country", country);
		
		model.addAttribute("memberVO", memberVO);
		
		return "/adm/student/admStatusModify";
	}
	
	// 관리자 학생현황 등록&수정
	@RequestMapping("/qxsepmny/student/admStudUpdate.do")
	public String admStudUpdate(@ModelAttribute("memberVO") MemberVO memberVO, MultipartHttpServletRequest request, String[] deleteFile, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admStudUpdate.do - 관리자 학생현황 등록&수정");
		LOGGER.debug("memberVO = " + memberVO.toString());
		request.getSession().setAttribute("admMenuNo", "301");
		String message = "";
		
		if(!EgovStringUtil.isEmpty(memberVO.getMemberSeq())){

			memberVO.setMemberPw(EgovFileScrty.encryptPassword(memberVO.getMemberCode(), memberVO.getMemberPw()));
			
			admStudentDAO.updateStudent(memberVO);
			message = "수정이 완료되었습니다.";
			admLogInsert("운영담당자 > 학생 > 학생현황 : 학생 수정", memberVO.getMemberCode(), request);
		}else{
			
			memberVO.setMemberPw(EgovFileScrty.encryptPassword(memberVO.getMemberCode(), memberVO.getMemberPw()));
				
			admStudentDAO.insertStudent(memberVO);
			
			message = "등록이 완료되었습니다.";
			admLogInsert("운영담당자 > 학생 > 학생현황 : 학생 등록", memberVO.getMemberCode(), request);
		}
		
		if(deleteFile != null){
			for(String dFileSeq : deleteFile){
				if(!EgovStringUtil.isEmpty(dFileSeq)){
					AttachVO delAttach = cmmDAO.selectAttachOne(dFileSeq);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
			}
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "STD");
		
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				if("upload_img".equals(fileInfoVO.getFileKey())){
					if(!EgovStringUtil.isEmpty(memberVO.getImgPath())){
						fileUtil.deleteFile(memberVO.getImgPath());
					}
					memberVO.setImgPath(fileInfoVO.getFilePath());
					memberVO.setImgName(fileInfoVO.getFileName());
					
					admStudentDAO.updateStudentImg(memberVO);
				}else{
					AttachVO attachVO = new AttachVO(fileInfoVO);
					attachVO.setBoardType("STD");
					attachVO.setBoardSeq(memberVO.getMemberSeq());				
					
					cmmDAO.insertAttachFile(attachVO);
				}
			}
		}
		
		return redirectStudList(reda, message);
	}
	
	// 관리자 학생현황 이미지 수정
	@RequestMapping("/qxsepmny/student/admStudImgUpdate.do")
	public String admStudImgUpdate(@ModelAttribute("memberVO") MemberVO memberVO, MultipartHttpServletRequest request, String deleteFile, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admStudUpdate.do - 관리자 학생현황 상세보기에서 이미지 수정");
		LOGGER.debug("memberVO = " + memberVO.toString());
		request.getSession().setAttribute("admMenuNo", "301");
		String message = "";
		
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedImgFile(request, "STD");
			memberVO.setMemberPw(EgovFileScrty.encryptPassword(memberVO.getMemberCode(), memberVO.getMemberPw()));
			
			if(fileInfoVO != null){
				if(!EgovStringUtil.isEmpty(memberVO.getImgPath())){
					fileUtil.deleteFile(memberVO.getImgPath());
				}
				memberVO.setImgPath(fileInfoVO.getFilePath());
				memberVO.setImgName(fileInfoVO.getFileName());
				
				admStudentDAO.updateStudentImg(memberVO);
			}
		return redirectStudList(reda, message);
	}
	
	// 관리자 학생현황 삭제
	@RequestMapping("/qxsepmny/student/admStatusDelete.do")
	public String admStatusDelete(@ModelAttribute("memberVO") MemberVO memberVO, String deleteFile, HttpServletRequest request, ModelMap model, RedirectAttributes reda,String[] delStdList) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admStatusDelete.do - 관리자 학생현황 삭제");
		LOGGER.debug("memberVO = " + memberVO.toString());
		request.getSession().setAttribute("admMenuNo", "301");
		String message = "";
		
		if(!EgovStringUtil.isEmpty(deleteFile)){
			AttachVO delAttach = cmmDAO.selectAttachOne(deleteFile);
			fileUtil.deleteFile(delAttach.getRegFileName());
			cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
		}

		if(delStdList != null){
			for(String memberCode : delStdList){
				admLogInsert("운영담당자 > 학생 > 학생현황 : 학생삭제", memberCode, request);
				admStudentDAO.deleteStudent(memberCode);
			}
		}else{
			String memberCode = memberVO.getMemberCode();
			admLogInsert("운영담당자 > 학생 > 학생현황 : 학생삭제", memberVO.getMemberCode(), request);
			admStudentDAO.deleteStudent(memberCode);
			
		}
		
		return redirectStudList(reda, message);
	}

	private String redirectStudList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/student/admStatusList.do";
	}
	
	// 관리자 학생 코드 중복확인
	@RequestMapping("/qxsepmny/student/admAjaxStudCheck.do")
	public View admAjaxStudCheck(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/admAjaxStudCheck.do - 관리자 학생 코드 중복확인");
		LOGGER.debug("memberCode = " + memberCode);
		String message = "";
		boolean status = false;
		
		if(!EgovStringUtil.isEmpty(memberCode)){
			int cnt = admStudentDAO.selectAdmAjaxStudCheck(memberCode);
			if(cnt > 0){
				message = "이미 사용중인 학번입니다.";
				status = false;
			}else{
				message = "사용 가능한 학번입니다.";
				status = true;
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		
		return jsonView;
	}
	
	// 관리자 학생 비밀번호 초기화
	@RequestMapping("/qxsepmny/student/admAjaxStudClearPw.do")
	public View admAjaxStudClearPw(MemberVO memberVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/admAjaxStudClearPw.do - 관리자 학생 비밀번호 초기화");
		LOGGER.debug("memberVO = " + memberVO);
		String message = "";
		
		if(memberVO != null){
			memberVO.setMemberPw(EgovFileScrty.encryptPassword(memberVO.getMemberCode(), memberVO.getMemberCode()));
			admStudentDAO.updateAdmAjaxStudClearPw(memberVO);
		}
		
		model.addAttribute("message", message);

		admLogInsert("운영담당자 > 학생 > 학생현황 : 학생 수정", memberVO.getMemberCode(), request);
		return jsonView;
	}
	
	// 관리자 학생 학번 만들기
	@RequestMapping("/qxsepmny/student/admAjaxStudCreateHakbun.do")
	public View admAjaxStudCreateHakbun(MemberVO memberVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/admAjaxStudCreateHakbun.do - 관리자 학생 학번 자동생성");
		LOGGER.debug("memberVO = " + memberVO);
		String stdCode = "";
		
		String totCnt = admStudentDAO.selectAdmMemTotCnt(memberVO);
		
		stdCode = memberVO.getAppDate().substring(2,4)+"K"+memberVO.getStdType()+totCnt;
		model.addAttribute("stdCode",stdCode);
		
		return jsonView;
	}
	// 관리자 학생현황 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/student/admStatusExcel.do")
	public void admStatusExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/admStatusExcel.do - 관리자 학생현황 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admStudentDAO.selectAdmStatusExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "학생현황 리스트", "statusList", request, response);
		admLogInsert("운영담당자 > 학생 > 학생현황 : 학생현황 다운로드", "", request);
	}
	/////////////////////////////////////////////////////////////////////////////

	// 관리자 학적변동 목록화면
	@RequestMapping("/qxsepmny/student/admFuncList.do")
	public String admFuncList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/student/admFuncList.do - 관리자 학적변동 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "302");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			String nowDate = EgovStringUtil.getDateMinus();
			String date = nowDate.substring(0,8) + "01";
			searchVO.setSearchCondition1(date);
			searchVO.setSearchCondition2(nowDate);
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admStudentDAO.FuncList(searchVO); 
		model.addAttribute("resultList", listVO.getEgovList());	
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/student/admFuncList";
	}

	// 관리자 학적변동 조회화면
	@RequestMapping("/qxsepmny/student/admFuncView.do")
	public String admFuncView(String funcSeq, HttpServletRequest request, ModelMap model,MemberVO memberVO,FuncVO funcVO, AttachVO attachVO) throws Exception {
		LOGGER.debug("/qxsepmny/student/admFuncView.do - 관리자 학적변동 조회화면");
		request.getSession().setAttribute("admMenuNo", "302");

		String memberSeq = memberVO.getMemberSeq();

		MemberVO memMap =  admStudentDAO.selectMemberOne(memberSeq);
		FuncVO funcmap =  admStudentDAO.selectFuncList(funcSeq);
		
		model.addAttribute("result", memMap);
		model.addAttribute("funcResult", funcmap);
		
		if(!EgovStringUtil.isEmpty(memberSeq)){
			funcVO = admStudentDAO.selectFuncList(funcSeq);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", funcSeq);
			map.put("boardType", "FUNC");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
					
			model.addAttribute("attachList", attachList);
		}
		
		String maxSeq = admStudentDAO.selectAdmFuncMaxSeq(memberSeq);
		model.addAttribute("maxSeq", maxSeq);
		
		
		return "/adm/student/admFuncView";
	}
	
	
	// 관리자 학적변동 등록&수정화면
	@RequestMapping("/qxsepmny/student/admFuncModify.do")
	public String admFuncModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String deleteFile,HttpServletRequest request, ModelMap model, String funcSeq, String memberSeq) throws Exception {
		LOGGER.debug("/qxsepmny/student/admFuncModify.do - 관리자 학적변동 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "302");
		
		MemberVO memberVO = new MemberVO();
		
		EgovMap semester = cmmDAO.selectOpenSeme();
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList((String) semester.get("semYear"));
		
		model.addAttribute("semester", semester);
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		if(!EgovStringUtil.isEmpty(memberSeq)){
			memberVO = admStudentDAO.selectMemberOne(memberSeq);
			
			if(!EgovStringUtil.isEmpty(deleteFile)){
				AttachVO delAttach = cmmDAO.selectAttachOne(deleteFile);
				fileUtil.deleteFile(delAttach.getRegFileName());
				cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
			}
			
//			List<AttachVO> attachList = cmmDAO.selectAttachList(funcSeq);
			EgovMap map = new EgovMap();
			map.put("boardSeq", memberSeq);
			map.put("boardType", "FUNC");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			
			model.addAttribute("attachList", attachList);
			
			List<FuncVO> funcList = admStudentDAO.selectAdmFuncList(memberSeq);
			model.addAttribute("funcList", funcList);
		}
				
//		팝업창 멤버 조회
		CmmnListVO member = admStudentDAO.memberList(searchVO);
		model.addAttribute("member",member.getEgovList());
		model.addAttribute("memberVO", memberVO);
		
		return "/adm/student/admFuncModify";
	}

	// 관리자 학적변동 등록
	@RequestMapping("/qxsepmny/student/admFuncUpdate.do")
	public String admFuncUpdate(@ModelAttribute("funcVO") FuncVO funcVO, MultipartHttpServletRequest request, String deleteFile, ModelMap model, RedirectAttributes reda, MemberVO memberVO) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admFuncUpdate.do - 관리자 학적 등록&수정");
		LOGGER.debug("funcVO = " + funcVO.toString());
		request.getSession().setAttribute("admMenuNo", "302");
		String message = "";
		
			
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(request, "FUNC",memberVO.getMemberSeq());
			//funcVO.setFuncState(memberVO.getStatus());
			
			funcVO.setMemberSeq(memberVO.getMemberSeq());
			admStudentDAO.insertFunc(funcVO);
			memberVO.setStatus(funcVO.getFuncState());
			admStudentDAO.updateFuncState(memberVO);
			
			if(fileInfoVO != null){
				if(!EgovStringUtil.isEmpty(deleteFile)){
					AttachVO delAttach = cmmDAO.selectAttachOne(deleteFile);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("FUNC");
				attachVO.setBoardSeq(funcVO.getFuncSeq());				
				
				cmmDAO.insertAttachFile(attachVO);
				
			}
			message = "등록이 완료되었습니다.";

			admLogInsert("운영담당자 > 학생 > 학적변동 : 학생 등록", memberVO.getMemberCode(), request);
		
		return redirectFuncList(reda, message);
	}
	
	// 관리자 학적변동 삭제
	@RequestMapping("/qxsepmny/student/admFuncDelete.do")
	public String admFuncDelete(FuncVO funcVO, String deleteFile, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admFuncDelete.do - 관리자 학적변동 삭제");
		LOGGER.debug("funcVO = " + funcVO.toString());
		request.getSession().setAttribute("admMenuNo", "302");
		String message = "";
		
		String funcSeq = funcVO.getFuncSeq();
		admLogInsert("운영담당자 > 학생 > 학적변동 : 학적변동 삭제", funcVO.getMemberCode(), request);		
		admStudentDAO.deleteFuncFile(funcSeq);
		admStudentDAO.deleteFunc(funcSeq);
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberSeq(funcVO.getMemberSeq());
		memberVO.setStatus(funcVO.getFuncBefState());
		admStudentDAO.updateFuncState(memberVO);

		return redirectFuncList(reda, message);
	}
		
	private String redirectFuncList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/student/admFuncList.do";
	}
			
	// 관리자 학적변동 학생 조회
	@RequestMapping("/qxsepmny/student/admAjaxStudSearch.do")
	public View admAjaxStudSearch(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/admAjaxStudSearch.do - 관리자 학적변동 학생 조회");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		List<EgovMap> resultList = admStudentDAO.admAjaxStudSearch(searchVO);
		
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
			
	// 관리자 학적변동 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/student/admFuncExcel.do")
	public void admFuncExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/admFuncExcel.do - 관리자 학적변동 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admStudentDAO.selectAdmFuncExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "학적변동 리스트", "funcList", request, response);
	}
			
	// 관리자 학생 체크박스 선택
	@RequestMapping("/qxsepmny/student/admAjaxStudSelect.do")
	public View admAjaxStudSelect(MemberVO memberVO, HttpServletRequest request, ModelMap model, String popSeq) throws Exception {
		LOGGER.debug("/qxsepmny/student/admAjaxStudSelect.do - 관리자 학적 선택");
		LOGGER.debug("memberVO = " + memberVO);
		
		memberVO = admStudentDAO.selectStudMember(popSeq);
		model.addAttribute("popResult", memberVO);
		
		return jsonView;
	}
	
	@RequestMapping("/qxsepmny/student/admMbPwClear.do")
	public String admMbPwClear(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		String message = "성공쓰";
		searchVO.setSearchCondition1("2020");
		searchVO.setSearchCondition2("2");
		
		List<EgovMap> clearList = admStudentDAO.clearList(searchVO);
		
		for(EgovMap clear : clearList){
			String encrypt = EgovFileScrty.encryptPassword((String) clear.get("memberCode"), (String) clear.get("memberCode"));
			
			clear.put("encrypt", encrypt);
			
			admStudentDAO.clearUpdate(clear);
		}
		
		return redirectFuncList(reda, message);
	}
	
	// 관리자 학생 로그인 횟수 초기화
	@RequestMapping("/qxsepmny/student/admAjaxStdClearLogin.do")
	public View admAjaxStdClearLogin(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/admAjaxStdClearLogin.do - 관리자 학생 로그인 횟수 초기화");
		LOGGER.debug("memberCode = " + memberCode);
		String message = "";
		
		admStudentDAO.updateLoginFailClear(memberCode);
		message = "로그인 횟수가 초기화되었습니다.";

		model.addAttribute("message", message);
		admLogInsert("운영담당자 > 학생 > 학생현황 : 학생 로그인횟수 초기화", memberCode, request);
		return jsonView;
	}
}
