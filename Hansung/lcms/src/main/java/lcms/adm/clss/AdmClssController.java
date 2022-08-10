package lcms.adm.clss;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AbsentConsultVO;
import lcms.valueObject.AdminVO;
import lcms.valueObject.AttachVO;
import lcms.valueObject.ConsultVO;
import lcms.valueObject.LectureVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmClssController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmClssController.class);
	@Autowired private AdmClssDAO admClssDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource View jsonView;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//수료산정 목록화면으로 리다이렉트합니다.
	private String redirectComplList(RedirectAttributes reda, String message, CmmnSearchVO searchVO){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxsepmny/clss/admComplList.do";
	}

	//수료산정 목록화면으로 리다이렉트합니다.
	private String redirectConsultList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/clss/admConsulList.do";
	}
	
	// 관리자 수강신청 목록화면
	@RequestMapping("/qxsepmny/clss/admEnroList.do")
	public String admEnroList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admEnroList.do - 관리자 수강신청 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "401");
		
		EgovMap semeMap = cmmDAO.selectOpenSeme();
		
		List<String> currList = cmmDAO.selectCurrList();
		model.addAttribute("currList", currList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semeMap.get("semYear"));
			searchVO.setSearchCondition2((String) semeMap.get("semester"));
			searchVO.setSearchCondition3(currList.get(0));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmEnroList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/clss/admEnroList";
	}
	
	// 관리자 수강신청 조회화면
	@RequestMapping("/qxsepmny/clss/admEnroView.do")
	public String admEnroView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String lectSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admEnroView.do - 관리자 수강신청 조회화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		LOGGER.debug("lectSeq" + lectSeq);
		request.getSession().setAttribute("admMenuNo", "401");
		
		LectureVO lectureVO = admClssDAO.selectAdmEnroView(lectSeq);
		model.addAttribute("lectureVO", lectureVO);
		
		searchVO.setSearchType(lectSeq);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmStdList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/clss/admEnroView";
	}

	// 관리자 수강신청 학생명단 인쇄 팝업
	@RequestMapping("/qxsepmny/clss/admStdPop.do")
	public String admCertiPop(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String lectYear, String lectSem, String lectName, String prtType, HttpServletRequest request
			, ModelMap model, String lectSeq) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admStdPop.do - 관리자 증명서 인쇄 팝업");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "401");
		
		if("STDLIST".equals(prtType)){
			List<EgovMap> listVO = admClssDAO.selectAdmStdPrtList(lectSeq);
			model.addAttribute("resultList", listVO);
			List<EgovMap> stdList = admClssDAO.selectAdmStudent(lectSeq);
			model.addAttribute("stdList", stdList);
		}else if("DVSTBL".equals(prtType)){
			searchVO.setSearchCondition1(lectYear);
			searchVO.setSearchCondition2(lectSem);
			
			CmmnListVO listVO = admClssDAO.selectAdmDvsList(searchVO);
			model.addAttribute("resultList", listVO.getEgovList());

			EgovMap map = new EgovMap();
			map.put("lectYear", lectYear);
			map.put("lectSem", lectSem);
			
			List<EgovMap> stdList = admClssDAO.selectDvsStudent(map);
			model.addAttribute("stdList", stdList);
		}else if("ALLSTD".equals(prtType)){
			searchVO.setSearchCondition1(lectYear);
			searchVO.setSearchCondition2(lectSem);
			searchVO.setSearchCondition3(lectName);

			PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
			CmmnListVO listVO = admClssDAO.selectAdmEnroList(searchVO);
			paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			model.addAttribute("resultList", listVO.getEgovList());
			
			//=================================
			
			for (int i = 0; i < listVO.getTotalRecordCount(); i++) {
				List<EgovMap> stdList = admClssDAO.selectAdmStudent(Integer.toString((int) listVO.getEgovList().get(i).getValue(0)));
				model.addAttribute("stdList"+i, stdList);
			}
		}
		
		model.addAttribute("prtType", prtType);
		
		return "/adm/clss/inc/admStdPop";
	}
	
	
	// 관리자 수강신청 학생 조회
	@RequestMapping("/qxsepmny/clss/admAjaxStdList.do")
	public View admAjaxStdList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxStdList.do - 관리자 수강신청 학생 조회");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		List<EgovMap> resultList = admClssDAO.selectAdmAjaxStdList(searchVO);
		
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}

	// 관리자 수강신청작업
	@RequestMapping("/qxsepmny/clss/admAjaxStdMapSave.do")
	public View admAjaxStdMapSave(String lectSeq, String[] memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxStdMapSave.do - 관리자 수강신청작업");
		LOGGER.debug("lectSeq = " + lectSeq);
		String message = "";
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		
		for(String mCode : memberCode){
			EgovMap map = new EgovMap();
			map.put("lectSeq", lectSeq);
			map.put("memberCode", mCode);
			map.put("funcWriter", sessionVO.getName());
			
			admClssDAO.insertAdmAjaxStdMapSave(map);
			admClssDAO.updateAdmStdStatus(mCode);
			admClssDAO.insertAdmFuncStatusStdMap(map);
			message = "수강신청이 완료되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}

	// 관리자 수강신청취소
	@RequestMapping("/qxsepmny/clss/admAjaxStdMapDel.do")
	public View admAjaxStdMapDel(String[] mapSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxStdMapDel.do - 관리자 수강신청취소");
		LOGGER.debug("mapSeq = " + mapSeq);
		String message = "";
		
		EgovMap map = new EgovMap();
		map.put("mapSeq", mapSeq);
		
		String resultYn = admClssDAO.selectAdmAjaxStdMapDelYn(map);
		
		if("Y".equals(resultYn)){
			admClssDAO.deleteAdmAjaxStdMapDel(map);
			message = "수강신청취소를 완료했습니다.";
		}else{
			message = "강의를 수강중인 학생은 수강신청취소를 할 수 없습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 업무담당자 수료산정 목록화면
	@RequestMapping("/qxsepmny/clss/admComplList.do")
	public String admComplList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admComplList.do - 관리자 수료산정 목록화면");
		request.getSession().setAttribute("admMenuNo", "402");
		
		EgovMap semeMap = cmmDAO.selectOpenSeme();
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semeMap.get("semYear"));
			searchVO.setSearchCondition2((String) semeMap.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		List<String> currList = cmmDAO.selectCurrList();
		model.addAttribute("currList", currList);
		
		List<String> progList = cmmDAO.selectProgList();
		model.addAttribute("progList", progList);
		
		List<String> courList = cmmDAO.selectCourList(searchVO.getSearchCondition4());
		model.addAttribute("courList", courList);
		
		List<EgovMap> diviList = cmmDAO.selectCodeList("division");
		model.addAttribute("diviList", diviList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmComplList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/clss/admComplList";
	}
	
	// 관리자 수료산정 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/clss/admComplExcel.do")
	public void admComplExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admComplExcel.do - 관리자 수료산정 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		searchVO.setSearchType("1");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admClssDAO.selectAdmComplExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "수료산정 리스트", "complList", request, response);
	}
	
	// 업무담당자 수료산정 신청결과 수정
	@RequestMapping("/qxsepmny/clss/admComplUpdate.do")
	public String admComplUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String compleSta, String[] mapSeq, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admComplUpdate.do - 업무담당자 수료산정 신청결과 수정");
		LOGGER.debug("compleSta = " + compleSta);
		String message = "";
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		
		EgovMap map = new EgovMap();
		map.put("compleSta", compleSta);
		map.put("mapSeq", mapSeq);
		map.put("funcWriter", sessionVO.getName());
		
		/*if("1".equals(compleSta)){
			String status = admClssDAO.selectAdmCompleYn(map);
			if("N".equals(status)){
				message = "선택하신 학생 중 수료기준에 합당하지 않은 학생이 존재합니다.\r\n다시 선택해 주세요.";
				return redirectComplList(reda, message);
			}
		}*/
		
		admClssDAO.updateAdmCompl(map);
		admClssDAO.updateMemberStatus(map);
		admClssDAO.insertAdmFuncStatus(map);
		if("1".equals(compleSta)){
			message = "선택 학생을 수료 처리되었습니다";
		}else{
			message = "선택 학생을 유급 처리되었습니다";
		}
		
		return redirectComplList(reda, message, searchVO);
	}
	
	// 업무담당자 수료산정 수료번호일괄부여
	@RequestMapping("/qxsepmny/clss/admAjaxComplNum.do")
	public View admAjaxComplNum(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxComplNum.do - 업무담당자 수료산정 수료번호일괄부여");
		LOGGER.debug("searchVO = " + searchVO.toString());
		String message = "";
		List<EgovMap> resultList = admClssDAO.selectAdmAjaxComplNumList(searchVO);
		
		if(resultList.size() != 0){
			for(EgovMap map : resultList){
				String compleCnt = admClssDAO.selectAdmAjaxComplNumCnt(map);
				String compleNum = "KLP"+map.get("lectYear")+"-"+map.get("lectSem")+"-"+map.get("grade")+"-"+compleCnt;
				map.put("compleNum", compleNum);
				
				admClssDAO.updateAdmAjaxComplNum(map);
			}
			message = "수료번호 부여를 완료했습니다.";
		}else{
			message = "수료번호를 부여할 학생이 존재하지 않습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}

	// 관리자 출결 목록화면
	@RequestMapping("/qxsepmny/clss/admAttendList.do")
	public String admAttendList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAttendList.do - 관리자 출결 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "403");
		
		EgovMap semester = cmmDAO.selectOpenSeme();

		List<String> progList = cmmDAO.selectProgList();
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semester.get("semYear"));
		}
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition5())){
			searchVO.setSearchCondition5(progList.get(0));
		}
		if(EgovStringUtil.isEmpty(searchVO.getStartDate())){
			searchVO.setStartDate(EgovStringUtil.getDateMinus());
		}
		if(EgovStringUtil.isEmpty(searchVO.getEndDate())){
			searchVO.setEndDate(EgovStringUtil.getDateMinus());
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		List<String> currList = cmmDAO.selectCurrList();
		List<String> courList = cmmDAO.selectCourList(searchVO.getSearchCondition5());
		List<EgovMap> diviList = cmmDAO.selectCodeList("division");
		
		model.addAttribute("currList", currList);
		model.addAttribute("progList", progList);
		model.addAttribute("courList", courList);
		model.addAttribute("diviList", diviList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmAttendList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		List<String> clstmList = admClssDAO.selectAdmClstmList(searchVO);
		model.addAttribute("clstmList", clstmList);
		
		searchVO.setSearchList(listVO.getEgovList());
		List<EgovMap> attendList = admClssDAO.selectAdmAtteTimeList(searchVO);
		model.addAttribute("attendList",attendList);
		
		return "/adm/clss/admAttendList";
	}

	// 업무담당자 출결 비고 조회
	@RequestMapping("/qxsepmny/clss/admAjaxAtteEtc.do")
	public View admAjaxAtteEtc(String lectSeq, String attDate, String memberCode, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxAtteEtc.do - 업무담당자 출결 비고 조회");
		LOGGER.debug("lectSeq = " + lectSeq + ", attDate = " + attDate + ", memberCode = " + memberCode);
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("lectSeq", lectSeq);
		paramMap.put("attDate", attDate);
		paramMap.put("memberCode", memberCode);
		
		EgovMap resultMap = admClssDAO.selectAdmAjaxAtteEtc(paramMap);
		model.addAttribute("resultMap", resultMap);
		
		return jsonView;
	}

	// 관리자 성적 목록화면
	@RequestMapping("/qxsepmny/clss/admGradeList.do")
	public String admGradeList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admGradeList.do - 관리자 성적 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "404");
		
		EgovMap semester = cmmDAO.selectOpenSeme();
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semester.get("semYear"));
		}
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmGradeList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/clss/admGradeList";
	}

	// 관리자 성적 상세 목록화면
	@RequestMapping("/qxsepmny/clss/admGradeDtl.do")
	public String admGradeDtl(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String lectSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admGradeDtl.do - 관리자 성적 상세 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		EgovMap semester = cmmDAO.selectOpenSeme();
		model.addAttribute("semester", semester);
		
		searchVO.setSearchLecture(lectSeq);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.admGradeDtl(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/clss/admGradeDtl";
	}

	// 관리자 성적 상세 조회화면
	@RequestMapping("/qxsepmny/clss/admGradeView.do")
	public String admGradeView(String lectSeq, String memberCode, String gradeGubun, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admGradeView.do - 관리자 성적 상세 조회화면");
		LOGGER.debug("lectSeq = " + lectSeq);
		LOGGER.debug("memberCode = " + memberCode);
		
		EgovMap semester = cmmDAO.selectOpenSeme();
		model.addAttribute("semester", semester);
		
		if(EgovStringUtil.isEmpty(gradeGubun)){
			gradeGubun = "1";
		}
		
		EgovMap map = new EgovMap();
		map.put("lectSeq", lectSeq);
		map.put("memberCode", memberCode);
		map.put("gradeGubun", gradeGubun);
		
		EgovMap resultMap = admClssDAO.admGradeView(map);
		model.addAttribute("resultMap", resultMap);
		
		return "/adm/clss/admGradeView";
	}

	// 관리자 성적 승인
	@RequestMapping("/qxsepmny/clss/admAjaxGradeAdmis.do")
	public View admAjaxGradeAdmis(String[] lectSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxGradeAdmis.do - 관리자 성적 승인");
		String message = "";
		String status = "fail";
		String memberCode = EgovUserDetailsHelper.getAuthenticatedAdminId();
		
		EgovMap map = new EgovMap();
		map.put("lectSeq", lectSeq);
		map.put("memberCode", memberCode);
		
		int cnt = admClssDAO.selectAdmAjaxGradeCnt(map);
		
		if(cnt > 0){
			message = "성적을 제출한 강의실만 선택해 주세요.";
			status = "fail";
		}else{
			admClssDAO.updateAdmAjaxGradeAdmis(map);
			message = "승인이 완료되었습니다.";
			status = "success";
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		
		return jsonView;
	}

	// 관리자 상담 목록화면
	@RequestMapping("/qxsepmny/clss/admConsulList.do")
	public String admConsulList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admConsulList.do - 관리자 상담 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "405");
		
		EgovMap semester = cmmDAO.selectOpenSeme();
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		List<String> currList = cmmDAO.selectCurrList();
		model.addAttribute("currList", currList);
		
		List<String> progList = cmmDAO.selectProgList();
		model.addAttribute("progList", progList);
		
		List<String> courList = cmmDAO.selectCourList(searchVO.getSearchCondition4());
		model.addAttribute("courList", courList);
		
		List<EgovMap> diviList = cmmDAO.selectCodeList("division");
		model.addAttribute("diviList", diviList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmConsulList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/clss/admConsulList";
	}

	// 관리자 상담 수정&등록화면
	@RequestMapping("/qxsepmny/clss/admConsulModify.do")
	public String admConsulModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String consultSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admConsulModify.do - 관리자 상담 수정&등록화면");
		LOGGER.debug("consultSeq = " + consultSeq);
		request.getSession().setAttribute("admMenuNo", "405");
		
		ConsultVO consultVO = new ConsultVO();
		
		if(!EgovStringUtil.isEmpty(consultSeq)){
			consultVO = admClssDAO.selectAdmConsulModify(consultSeq);
		}
		
		model.addAttribute("consultVO", consultVO);
		
		List<EgovMap> adminList = admClssDAO.selectAdmAdminList();
		model.addAttribute("adminList", adminList);
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		String year = "";
		if(!EgovStringUtil.isEmpty(consultVO.getYear())){
			year = consultVO.getYear();
		}else{
			year = yearList.get(0);
		}
		List<EgovMap> semeList = cmmDAO.selectSemeList(year);
		model.addAttribute("semeList", semeList);
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", consultSeq);
		map.put("boardType", "CONS");
		
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		return "/adm/clss/admConsulModify";
	}

	// 관리자 상담 수정&등록화면
	@RequestMapping("/qxsepmny/clss/admConsulSubmit.do")
	public String admConsulSubmit(ConsultVO consultVO, String[] delSeqList, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admConsulSubmit.do - 관리자 상담 수정&등록화면");
		LOGGER.debug("consultVO = " + consultVO.toString());
		String message = "";
		
		if(!EgovStringUtil.isEmpty(consultVO.getConsultSeq())){
			admClssDAO.updateAdmConsult(consultVO);
			
			if(delSeqList != null){
				for(String delSeq : delSeqList){
					AttachVO delAttach = cmmDAO.selectAttachOne(delSeq);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
			}
			message = "수정이 완료되었습니다.";
		}else{
			admClssDAO.insertAdmConsult(consultVO);
			message = "등록이 완료되었습니다.";
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.uploadAttachedFiles(request, "CONS");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("CONS");
				attachVO.setBoardSeq(consultVO.getConsultSeq());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectConsultList(reda, message);
	}

	// 관리자 상담 조회화면
	@RequestMapping("/qxsepmny/clss/admConsulView.do")
	public String admConsulView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String consultSeq, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admConsulView.do - 관리자 상담 조회화면");
		LOGGER.debug("consultSeq = " + consultSeq);
		
		ConsultVO consultVO = admClssDAO.selectAdmConsulView(consultSeq);
		model.addAttribute("consultVO", consultVO);
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", consultSeq);
		map.put("boardType", "CONS");
		
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		return "/adm/clss/admConsulView";
	}

	// 관리자 상담 삭제
	@RequestMapping("/qxsepmny/clss/admConsulDelete.do")
	public String admConsulDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String consultSeq, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admConsulDelete.do - 관리자 상담 삭제");
		LOGGER.debug("consultSeq = " + consultSeq);
		
		EgovMap attMap = new EgovMap();
		attMap.put("boardSeq", consultSeq);
		attMap.put("boardType", "CONS");
		
		List<AttachVO> delAttach = cmmDAO.selectAttachList(attMap);
		for (AttachVO attachVO : delAttach) {
			fileUtil.deleteFile(attachVO.getRegFileName());
			cmmDAO.deleteAttachFile(attachVO.getAttachSeq());
		}
		
		EgovMap map = new EgovMap();
		map.put("consultSeq", consultSeq);
		
		admClssDAO.deleteAdmConsul(map);
		
		String message = "삭제가 완료 되었습니다.";
		
		return redirectConsultList(reda, message);
	}
	
	// 관리자 상담 이력 조회
	@RequestMapping("/qxsepmny/clss/admConsulPop.do")
	public String admConsulPop(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admConsulPop.do - 관리자 상담 이력 조회");
		LOGGER.debug("memberCode = " + memberCode);
		
		List<EgovMap> resultList = admClssDAO.selectAdmConsulPop(memberCode);
		model.addAttribute("resultList", resultList);
		
		return "/adm/clss/admConsulPop";
	}
	
	// 관리자 수업만족도(교과과정) 목록화면
	@RequestMapping("/qxsepmny/clss/admSatisList.do")
	public String admSatisList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admSatisList.do - 관리자 수업만족도(교과과정) 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "406");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectOpenSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		List<EgovMap> surveyList = admClssDAO.selectAdmSurveyList(searchVO);
		model.addAttribute("surveyList", surveyList);
		
		List<EgovMap> totalList = admClssDAO.selectAdmStatisTotalList(searchVO);
		model.addAttribute("totalList", totalList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmSatisList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/clss/admSatisList";
	}
	

	// 관리자 결석자현황 목록화면
	@RequestMapping("/qxsepmny/clss/admAbsentStatusList.do")
	public String admAbsentStatusList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAbsentStatusList.do - 관리자 결석자현황 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "408");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectOpenSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition3())){
			String nowDate = EgovStringUtil.getDateMinus();
			searchVO.setSearchCondition3(nowDate);
		}
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition4())){
			searchVO.setSearchCondition4(searchVO.getSearchCondition3());
		}
		//년도
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		//학기
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		//과목/분반
		List<EgovMap> lectList = admClssDAO.selectAbsentLectList(searchVO);
		model.addAttribute("lectList", lectList);
		//상단 학생 숫자 카운트
		List<EgovMap> listVO = admClssDAO.selectAbsentStatusList(searchVO);
		model.addAttribute("resultList", listVO);
		//하단 학생 목록
		List<EgovMap> listVO2 = admClssDAO.selectAbsentStdList(searchVO);
		model.addAttribute("stdList", listVO2);
		
		return "/adm/clss/admAbsentStatusList";
	}
	
	// 관리자 결석자 현황 리스트
		@RequestMapping("/qxsepmny/clss/admAjaxAbsentList.do")
		public View admAjaxAbsentList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/clss/admAjaxAbsentList.do - 관리자 결석자 현황 리스트");
			LOGGER.debug("searchVO = " + searchVO.toString());
			
			List<EgovMap> lectList = admClssDAO.selectAbsentLectList(searchVO);
			model.addAttribute("lectList", lectList);
			
			if(EgovStringUtil.isEmpty(searchVO.getSearchCondition4())){
				searchVO.setSearchCondition4(searchVO.getSearchCondition3());
			}

			//상단 학생 숫자 카운트
			List<EgovMap> listVO = admClssDAO.selectAbsentStatusList(searchVO);
			model.addAttribute("resultList", listVO);
			
			//상단 학생 tot숫자 카운트
			List<EgovMap> tot = admClssDAO.selectAbsentStatusTot(searchVO);
			model.addAttribute("totList", tot);
			return jsonView;
		}
		
		// 관리자 결석자상담 리스트
		@RequestMapping("/qxsepmny/clss/admAjaxAbsentPoPSearchList.do")
		public View admAjaxAbsentPoPSearchList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model
				, String memberCode, String year, String sem, String sDate, String eDate) throws Exception {
			LOGGER.debug("/qxsepmny/clss/admAjaxAbsentPoPSearchList.do - 관리자 결석자상담 리스트");
			LOGGER.debug("searchVO = " + searchVO.toString());

			EgovMap map = new EgovMap();
			map.put("memberCode", memberCode);
			map.put("year", year);
			map.put("sem", sem);
			map.put("sDate", sDate);
			map.put("eDate", eDate);
			
			List<EgovMap> listVO = admClssDAO.admAjaxAbsentPoPSearchList(map);
			model.addAttribute("searchList", listVO);
			
			return jsonView;
		}
		
		// 업무담당자 결석경고 목록화면
		@RequestMapping("/qxsepmny/clss/admAbsWrnList.do")
		public String admAbsWrnList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/clss/admAbsWrnList.do - 관리자 결석경고 목록화면");
			request.getSession().setAttribute("admMenuNo", "40A");
			
			EgovMap semeMap = cmmDAO.selectOpenSeme();

			if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
				searchVO.setSearchCondition1((String) semeMap.get("semYear"));
				searchVO.setSearchCondition2((String) semeMap.get("semester"));
			}
			if(EgovStringUtil.isEmpty(searchVO.getSearchCondition3())){
				searchVO.setSearchCondition3("30");
			}
			if(EgovStringUtil.isEmpty(searchVO.getSearchCondition4())){
				String nowDate = EgovStringUtil.getDateMinus();
				searchVO.setSearchCondition4(nowDate);
			}
			
			List<String> yearList = cmmDAO.selectYearList();
			model.addAttribute("yearList", yearList);
			
			List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
			model.addAttribute("semeList", semeList);
			
			PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
			CmmnListVO listVO = admClssDAO.selectadmAbsWrnList(searchVO);
			paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			
			//하단 학생 목록
//			List<EgovMap> hstrList = admClssDAO.selectAbsWrnHstrList(searchVO);
//			model.addAttribute("hstrList", hstrList);
			
			model.addAttribute("resultList", listVO.getEgovList());
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
			return "/adm/clss/admAbsWrnList";
		}
	// 관리자 결석경고 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/clss/admAbsWrnExcel.do")
	public void admAbsWrnExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admAbsWrnExcel.do - 관리자 수료산정 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admClssDAO.selectadmAbsWrnExcelList(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "결석경고 리스트", "absWrnList", request, response);
	}	
	// 관리자 결석경고 추가
	@RequestMapping("/qxsepmny/clss/admAjaxAddWrn.do")
	public View admAjaxAddWrn(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model 
			,String year,String sem,String wrnDate,String prs,String trgPrs, String lectName) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxAddWrn.do - 관리자 결석경고 추가");
		LOGGER.debug("searchVO = " + searchVO.toString());

		int absTbSeq = admClssDAO.selectadmAbsWrnTbSeq();
		
		EgovMap map = new EgovMap();
		map.put("absTbSeq", absTbSeq+1);
		
		EgovMap lectMap = new EgovMap();
		lectMap.put("lectName", lectName);
		lectMap.put("lectYear", year);
		lectMap.put("lectSem", sem);
		
		int cnt = Integer.parseInt(prs);
		String[] arr1 = trgPrs.split(",");
		for (int i = 0; i < cnt; i++) {
			String[] arr2 = arr1[i].split(" ");

			lectMap.put("lectDivi", arr2[1]);
			String lectSeq = admClssDAO.selectAbsWrnLectSeq(lectMap);
			
			map.put("absYear", year);
			map.put("absSem", sem);
			map.put("absDate", wrnDate);
			map.put("absPrs", prs);
			map.put("absGrade", arr2[0]);
			map.put("absDivi", arr2[1]);
			map.put("absName", arr2[2]);
			map.put("absAbseCnt", arr2[4]);
			map.put("memberCode", arr2[3]);
			map.put("lectSeq", lectSeq);
			admClssDAO.admAjaxAddWrn(map); 
		}

		searchVO.setSearchCondition1(year);
		searchVO.setSearchCondition2(sem);
		List<EgovMap> hstrList = admClssDAO.selectAbsWrnHstrList(searchVO);
		model.addAttribute("hstrList", hstrList);
		
		return jsonView;
	}
	// 관리자 결석경고 하단 경고 목록
	@RequestMapping("/qxsepmny/clss/admSelectAjaxWrn.do")
	public View admSelectAjaxWrn(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admSelectAjaxWrn.do - 관리자 결석경고 하단 경고 목록");
		
		List<EgovMap> hstrList = admClssDAO.selectAbsWrnHstrList(searchVO);
		model.addAttribute("hstrList", hstrList);
		
		return jsonView;
	}	
	// 관리자 경고이력 삭제
	@RequestMapping("/qxsepmny/clss/deleteAdmAjaxAbsWrnDel.do")
	public View deleteAdmAjaxAbsWrnDel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String[] absSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/deleteAdmAjaxAbsWrnDel.do - 관리자 경고이력 삭제");
		LOGGER.debug("absSeq = " + absSeq);
		
		EgovMap map = new EgovMap();
		map.put("absSeq", absSeq);
		
		admClssDAO.deleteAdmAjaxAbsWrnDel(map);
		
		List<EgovMap> hstrList = admClssDAO.selectAbsWrnHstrList(searchVO);
		model.addAttribute("hstrList", hstrList);
		return jsonView;
	}
	// 학기별 결석경고 인쇄 팝업
		@RequestMapping("/qxsepmny/clss/admPtrAbsWrn.do")
		public String admPtrAbsWrn(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String prtType, HttpServletRequest request, ModelMap model, String memberCode
			, String seq, String year, String seme) throws Exception {
			LOGGER.debug("/qxsepmny/clss/admPtrAbsWrn.do - 학기별 결석경고 인쇄 팝업");
			LOGGER.debug("searchVO = " + searchVO.toString());
			request.getSession().setAttribute("admMenuNo", "40A");
			
			EgovMap map = new EgovMap();
			if("ABSWRN".equals(prtType)){
				map.put("year", year);
				map.put("seme", seme);

				String[] arr = seq.split(",");
				map.put("absSeq", arr);
			
			}
			List<EgovMap> resultList = admClssDAO.selectAdmPopWrnList(map);
			model.addAttribute("resultList", resultList);

			model.addAttribute("prtType", prtType);
			
			return "/adm/clss/inc/admWrnListPop";
		}
	// 관리자 수업만족도(교과과정) 조회화면
	@RequestMapping("/qxsepmny/clss/admSatisView.do")
	public String admSatisView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admSatisView.do - 관리자 수업만족도(교과과정) 조회화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "406");
		
		EgovMap resultMap = admClssDAO.selectAdmSatisView(searchVO);
		model.addAttribute("resultMap", resultMap);

		searchVO.setSearchType("LEC");
		searchVO.setSearchCondition8(String.valueOf(resultMap.get("surveySeq")));
		
		List<EgovMap> scoreList = admClssDAO.selectAdmSatisScoreList(searchVO);
		model.addAttribute("scoreList", scoreList);
		
		// 오점척도
		searchVO.setSearchCondition7("1");
		List<EgovMap> quesList = admClssDAO.selectAdmSatisQuesList(searchVO);
		model.addAttribute("quesList", quesList);

		// 단답형
		searchVO.setSearchCondition7("2");
		List<EgovMap> shortList = admClssDAO.selectAdmSatisQuesList(searchVO);
		model.addAttribute("shortList", shortList);
		
		// 자유기재형
		List<EgovMap> txtList = admClssDAO.selectAdmStatisTxtList(searchVO);
		model.addAttribute("txtList", txtList);
		
		return "/adm/clss/admSatisView";
	}
	
	// 관리자 수업만족도(교사) 목록화면
	@RequestMapping("/qxsepmny/clss/admSatisPrfList.do")
	public String admSatisPrfList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admSatisPrfList.do - 관리자 수업만족도(교사) 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "407");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectOpenSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		List<EgovMap> lectList = admClssDAO.selectAdmStatisLectList(searchVO);
		model.addAttribute("quelectList", lectList);
		
		List<EgovMap> prfQuesList = admClssDAO.selectAdmStatisPrfQuesList(searchVO);
		model.addAttribute("prfQuesList", prfQuesList);

		List<EgovMap> prfLectQuesList = admClssDAO.selectAdmStatisPrfLectQuesList(searchVO);
		model.addAttribute("prfLectQuesList", prfLectQuesList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmSatisPrfList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("prfList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		PaginationInfo paginationInfo2 = PaginationController.getPaginationInfo2(searchVO);
		CmmnListVO listVO2 = admClssDAO.selectAdmSatisPrfLectList(searchVO);
		paginationInfo2.setTotalRecordCount(listVO2.getTotalRecordCount());
		
		model.addAttribute("lectList", listVO2.getEgovList());
		model.addAttribute("paginationInfo2", paginationInfo2);
		model.addAttribute("totalPageCount2", paginationInfo2.getTotalPageCount());
		
		return "/adm/clss/admSatisPrfList";
	}
	
	// 관리자 수업만족도(교사) 조회화면
	@RequestMapping("/qxsepmny/clss/admSatisPrfView.do")
	public String admSatisPrfView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admSatisPrfView.do - 관리자 수업만족도(교사) 조회화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "407");
		
		EgovMap resultMap = admClssDAO.selectAdmSatisView(searchVO);
		model.addAttribute("resultMap", resultMap);
		
		searchVO.setSearchType("PRF");
		searchVO.setSearchCondition8(String.valueOf(resultMap.get("surveySeq")));
		
		List<EgovMap> scoreList = admClssDAO.selectAdmSatisScoreList(searchVO);
		model.addAttribute("scoreList", scoreList);
		
		// 오점척도
		searchVO.setSearchCondition7("1");
		List<EgovMap> quesList = admClssDAO.selectAdmSatisQuesList(searchVO);
		model.addAttribute("quesList", quesList);

		// 단답형
		searchVO.setSearchCondition7("2");
		List<EgovMap> shortList = admClssDAO.selectAdmSatisQuesList(searchVO);
		model.addAttribute("shortList", shortList);
		
		// 자유기재형
		List<EgovMap> txtList = admClssDAO.selectAdmStatisTxtList(searchVO);
		model.addAttribute("txtList", txtList);
		
		return "/adm/clss/admSatisPrfView";
	}
	
	//수료산정 목록화면으로 리다이렉트합니다.
	private String redirectAbsCounselList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/clss/admAbsCounselList.do";
	}
	
	// 관리자 결석자상담 목록화면
	@RequestMapping("/qxsepmny/clss/admAbsCounselList.do")
	public String admAbsCounselList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAbsCounselList.do - 관리자 결석자상담 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "409");
		
		EgovMap semeMap = cmmDAO.selectOpenSeme();
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semeMap.get("semYear"));
			searchVO.setSearchCondition2((String) semeMap.get("semester"));
			
			searchVO.setStartDate(EgovStringUtil.getDateMinus());
			searchVO.setEndDate(EgovStringUtil.getDateMinus());
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		List<String> currList = cmmDAO.selectCurrList();
		model.addAttribute("currList", currList);
		
		List<String> progList = cmmDAO.selectProgList();
		model.addAttribute("progList", progList);
		
		List<String> courList = cmmDAO.selectCourList(searchVO.getSearchCondition4());
		model.addAttribute("courList", courList);
		
		List<EgovMap> diviList = cmmDAO.selectCodeList("division");
		model.addAttribute("diviList", diviList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admClssDAO.selectAdmAbsCounselList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/clss/admAbsCounselList";
	}
	
	// 관리자 결석자상담 등록&수정 화면
	@RequestMapping("/qxsepmny/clss/admAbsCounselModify.do")
	public String admAbsCounselModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String lectSeq, String attDate, String memberCode, String absentSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAbsCounselModify.do - 관리자 결석자상담 등록&수정 화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "409");
		
		AbsentConsultVO absentConsultVO = new AbsentConsultVO();
		
		if(!EgovStringUtil.isEmpty(absentSeq)){
			// 상담내용 조회
			absentConsultVO = admClssDAO.selectAdmAbsCounselModify(absentSeq);
		}else{
			EgovMap map = new EgovMap();
			map.put("attDate", attDate);
			map.put("memberCode", memberCode);
			map.put("lectSeq", lectSeq);
			// 학생 및 결석정보 조회
			absentConsultVO = admClssDAO.selectAdmAbsCounselNew(map);
		}
		
		if(absentConsultVO.getSecondSelorCode() == null || EgovStringUtil.isEmpty(absentConsultVO.getSecondSelorCode())){
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
			absentConsultVO.setSecondSelorCode(adminVO.getAdminId());
			absentConsultVO.setSecondSelorName(adminVO.getName());
		}
		
		model.addAttribute("absentConsultVO", absentConsultVO);
		
		return "/adm/clss/admAbsCounselModify";
	}

	// 관리자 결석자상담 등록&수정
	@RequestMapping("/qxsepmny/clss/admAbsCounselSubmit.do")
	public String admAbsCounselSubmit(@ModelAttribute("absentConsultVO") AbsentConsultVO absentConsultVO, HttpSession session, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAbsCounselSubmit.do - 관리자 결석자상담 등록&수정");
		LOGGER.debug("absentConsultVO = " + absentConsultVO.toString());
		request.getSession().setAttribute("admMenuNo", "409");
		String message = "";
		
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
		absentConsultVO.setSecondSelorCode(adminVO.getAdminId());
		absentConsultVO.setSecondSelorName(adminVO.getName());
		
		admClssDAO.updateAdmAbsCounselSubmit(absentConsultVO);
		message = "수정이 완료되었습니다.";
		
		/*if(!EgovStringUtil.isEmpty(absentConsultVO.getAbsentSeq())){
			admClssDAO.updateAdmAbsCounselSubmit(absentConsultVO);
			message = "수정이 완료되었습니다.";
		}else{
			admClssDAO.insertAdmAbsCounselSubmit(absentConsultVO);
			message = "등록이 완료되었습니다.";
		}*/
		
		
		return redirectAbsCounselList(reda, message);
	}
	
	// 관리자 결석자상담 비고 목록 조회
	@RequestMapping("/qxsepmny/clss/admAjaxAbsCounselEtcList.do")
	public View admAjaxAbsCounselEtcList(String memberCode, String lectSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxAbsCounselEtcList.do - 관리자 결석자상담 비고 목록 조회");
		LOGGER.debug("lectSeq = " + lectSeq);
		
		EgovMap map = new EgovMap();
		map.put("memberCode", memberCode);
		map.put("lectSeq", lectSeq);
		
		List<EgovMap> resultList = admClssDAO.admAjaxAbsCounselEtcList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 관리자 결석자상담 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/clss/admAbsComplExcel.do")
	public void admAbsComplExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAbsComplExcel.do - 관리자 결석자상담 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		searchVO.setSearchType("1");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admClssDAO.selectAdmAbsComplExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition5()) || EgovStringUtil.isEmpty(searchVO.getSearchCondition6())){
			excelUtil.getPerformanceExcel(dataMap, "결석자상담 리스트", "complAbsListNoCndt", request, response);
		}else{
			dataMap.put("lectGrade", searchVO.getSearchCondition5());
			dataMap.put("lectDivi", searchVO.getSearchCondition6());
			excelUtil.getPerformanceExcel(dataMap, "결석자상담 리스트", "complAbsList", request, response);
		}
	}
	
	// 관리자 강의평가 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/clss/admAdmSatisPrfLectExcel.do")
	public void admAdmSatisPrfLectExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admAdmSatisPrfLectExcel.do - 관리자 강의평가 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		searchVO.setSearchType("1");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> lectList = admClssDAO.selectAdmStatisLectList(searchVO);
		dataMap.put("lectList",	lectList);
		
		List<EgovMap> prfLectQuesList = admClssDAO.selectAdmStatisPrfLectQuesList(searchVO);
		
		List<EgovMap> prfList = admClssDAO.selectAdmSatisPrfExcelList(searchVO);
		
		List<EgovMap> resultList = new ArrayList<EgovMap>();

		int num = 1;
		for(EgovMap prfMap : prfList){
			List<EgovMap> colsList = new ArrayList<EgovMap>();
			EgovMap resultMap = new EgovMap();
			resultMap.put("number", num);
			resultMap.put("lectTea", prfMap.get("lectTea"));
			resultMap.put("name", prfMap.get("name"));
			
			double avgSum = 0.0;
			int count = 0;
			for(EgovMap lectMap : lectList){
				EgovMap colsMap = new EgovMap();
				String chk = "N";
				for(EgovMap prfLectQuesMap : prfLectQuesList){
					if(prfLectQuesMap.get("profCode").equals(prfMap.get("lectTea")) && lectMap.get("lectSeq").equals(prfLectQuesMap.get("lectSeq"))){
						count++;
						chk = "Y";
						avgSum = avgSum + (double) prfLectQuesMap.get("avgAnsw");
						colsMap.put("avgAnsw", prfLectQuesMap.get("avgAnsw"));
					}
				}
				
				if(!"Y".equals(chk)){
					colsMap.put("avgAnsw", "");
				}
				
				colsList.add(colsMap);
			}
			if(avgSum != 0 && count != 0){
				resultMap.put("avgSum", avgSum/count);
			}
			resultMap.put("colsList", colsList);
			resultList.add(resultMap);
			num++;
		}
		
		dataMap.put("resultList", resultList);
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "강의평가 리스트", "satisPrfLectList", request, response);
	}
	// 관리자 강의평가 미참여 학생 엑셀 다운로드
		@SuppressWarnings("unchecked")
		@RequestMapping("/qxsepmny/clss/admAdmSatisListExcel.do")
		public void admAdmSatisListExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/entran/admAdmSatisListExcel.do - 관리자 강의평가 엑셀 다운로드!!");
			LOGGER.debug("searchVO = " + searchVO.toString());
			searchVO.setSearchType("1");
			EgovMap dataMap = new EgovMap();
			
			List<EgovMap> lectList = admClssDAO.selectAdmSatiExcelList(searchVO);
			dataMap.put("lectList",	lectList);
			List<EgovMap> resultList = new ArrayList<EgovMap>();

			int num = 1;
			for(EgovMap prfMap : lectList){
				
				EgovMap resultMap = new EgovMap();
				
				resultMap.put("number", num);
				resultList.add(resultMap);

				num++;
			}
			
			AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			dataMap.put("printUser", sessionVO.getName());
			dataMap.put("resultList",resultList);

			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.getPerformanceExcel(dataMap, "미참여 학생 리스트", "satisList", request, response);
		}
	// 관리자 급별회의록 목록 화면
	@RequestMapping("/qxsepmny/clss/admMeetLogList.do")
	public String admMeetLogList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admMeetLogList.do - 관리자 급별회의록 목록 화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "40B");
		
		List<String> progList = cmmDAO.selectProgList();
		model.addAttribute("progList", progList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectOpenSeme();
			
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
			searchVO.setSearchCondition3("1");
			searchVO.setSearchCondition4(progList.get(0));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		List<String> weekList = admClssDAO.selectAdmMeetLogWeekList(searchVO);
		model.addAttribute("weekList", weekList);
		
		List<EgovMap> resultList = admClssDAO.selectAdmMeetLogList(searchVO);
		model.addAttribute("resultList", resultList);
		
		return "/adm/clss/admMeetLogList";
	}
	
	@RequestMapping("/qxsepmny/clss/admAjaxWeekList.do")
	public View admAjaxProgList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/clss/admAjaxWeekList.do - 관리자 급별회의록 주차 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		List<String> weekList = admClssDAO.selectAdmMeetLogWeekList(searchVO);
		model.addAttribute("weekList", weekList);
		
		return jsonView;
	}
}
