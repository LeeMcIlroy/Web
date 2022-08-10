package lcms.adm.curr;

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
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AdminVO;
import lcms.valueObject.ClstmVO;
import lcms.valueObject.CourVO;
import lcms.valueObject.CurrVO;
import lcms.valueObject.LectureTimeTableVO;
import lcms.valueObject.LectureVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.ProgVO;
import lcms.valueObject.SemesterVO;
import lcms.valueObject.SurveyQuesVO;
import lcms.valueObject.SurveyVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmCurrController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmCurrController.class);
	@Autowired private AdmCurrDAO admCurrDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource View jsonView;
	/*@Autowired private EgovUserDetailsService userDtlService;*/
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectSemeModify(RedirectAttributes reda, SemesterVO semesterVO, String message){
		reda.addFlashAttribute("semesterVO", semesterVO);
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/curr/admSemeModify.do";
	}
	
	// 관리자 학기 목록화면
	@RequestMapping("/qxsepmny/curr/admSemeList.do")
	public String admSemeList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admSemeList.do - 관리자 학기 목록화면");
		request.getSession().setAttribute("admMenuNo", "801");
				
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admCurrDAO.SemeList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("leftMenuType", "801");
		model.addAttribute("topMenuType", "80");

		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		
		return "/adm/curr/admSemeList";
	}

	// 관리자 학기 등록&수정 화면
		@RequestMapping("/qxsepmny/curr/admSemeModify.do")
		public String admSemeModify(@ModelAttribute("semesterVO") SemesterVO semesterVO, HttpServletRequest request, ModelMap model ) throws Exception {
			LOGGER.debug("/qxsepmny/curr/admSemeModify.do - 관리자 학기 등록&수정화면");
			
			request.getSession().setAttribute("admMenuNo", "801");
			
			if(semesterVO.getSem_code() != null){
				String sem_code = semesterVO.getSem_code();
				EgovMap map = admCurrDAO.selectSemeOne(sem_code);
				model.addAttribute("semesterVO", map);
				
			}
			
			model.addAttribute("leftMenuType", "801");
			model.addAttribute("topMenuType", "80");
			
			return "/adm/curr/admSemeModify";
		}
	
	// 관리자 학기 등록&수정
	@RequestMapping("/qxsepmny/curr/addSeme.do")
	public String admAddSeme(HttpServletRequest request, ModelMap model, @ModelAttribute("semesterVO") SemesterVO semesterVO, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/curr/addSeme.do - 관리자 학기 등록&수정");
		LOGGER.debug("semesterVO = " + semesterVO.toString());
		request.getSession().setAttribute("admMenuNo", "801");

		if (EgovStringUtil.isEmpty(semesterVO.getSem_code())){
			admCurrDAO.addSeme(semesterVO);
		}else{
			String message = "";
			EgovMap map = admCurrDAO.selectSemeOne(semesterVO.getSem_code());
			if("Y".equals(semesterVO.getOpen_sem()) && !"Y".equals(map.get("openSem"))){
				String useYn = admCurrDAO.selectSemeUseYn("open");
				if("Y".equals(useYn)){
					message = "개설된 학기가 존재합니다.";
					return redirectSemeModify(reda, semesterVO, message);
				}
			}
			if("Y".equals(semesterVO.getOpen_regi()) && !"Y".equals(map.get("openRegi"))){
				String useYn = admCurrDAO.selectSemeUseYn("regi");
				if("Y".equals(useYn)){
					message = "신청중인 학기가 존재합니다.";
					return redirectSemeModify(reda, semesterVO, message);
				}
			}
			
			admCurrDAO.editSeme(semesterVO);
		}
		
		return "redirect:/qxsepmny/curr/admSemeList.do";
	}
	// 관리자 학기 엑셀 다운로드
		@SuppressWarnings("unchecked")
		@RequestMapping("/qxsepmny/curr/admSemeExcel.do")
		public void admSemeExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/curr/admSemeExcel.do - 관리자 학기 엑셀 다운로드");
			LOGGER.debug("searchVO = " + searchVO.toString());
			EgovMap dataMap = new EgovMap();
			
			List<EgovMap> resultList = admCurrDAO.selectAdmSemeExcel(searchVO);
			dataMap.put("resultList", resultList);
			
			int num = 1;
			for (EgovMap egovMap : resultList) {
				egovMap.put("number", num);
				num++;
			}
			
			AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			dataMap.put("printUser", sessionVO.getName());
			
			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.getPerformanceExcel(dataMap, "학기 리스트", "semeList", request, response);
		}

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 관리자 교육과정 목록화면
	@RequestMapping("/qxsepmny/curr/admCurrList.do")
	public String admCurrList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admCurrList.do - 관리자 교육과정 목록화면");
		request.getSession().setAttribute("admMenuNo", "802");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admCurrDAO.CurrList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("leftMenuType", "802");
		model.addAttribute("topMenuType", "80");

		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/curr/admCurrList";
	}
	
	// 관리자 교육과정 등록&수정화면
	@RequestMapping("/qxsepmny/curr/admCurrModify.do")
	public String admCurrModify(@ModelAttribute("currVO") CurrVO currVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admCurrModify.do - 관리자 교육과정 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "802");
		
		if(currVO.getCurrSeq() != null){
			String currSeq = currVO.getCurrSeq();
			EgovMap map = admCurrDAO.selectCurrOne(currSeq);
			model.addAttribute("currVO", map);
		}
		
		model.addAttribute("leftMenuType", "802");
		model.addAttribute("topMenuType", "80");
		
		return "/adm/curr/admCurrModify";
	}

	// 관리자 교육과정 등록&수정
		@RequestMapping("/qxsepmny/curr/addCurr.do")
		public String admAddCurr(HttpServletRequest request, ModelMap model, @ModelAttribute("currVO") CurrVO currVO) throws Exception {
				
			LOGGER.debug("/qxsepmny/curr/admCurrModify.do - 관리자 교육과정 등록&수정화면");
			request.getSession().setAttribute("admMenuNo", "802");

			if (currVO.getCurrSeq().equals("")) {
				admCurrDAO.addCurr(currVO);
			}
			else {
				admCurrDAO.editCurr(currVO);
			}

			model.addAttribute("leftMenuType", "802");
			model.addAttribute("topMenuType", "80");
			
			return "redirect:/qxsepmny/curr/admCurrList.do";
		}
		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 관리자 프로그램 목록화면
	@RequestMapping("/qxsepmny/curr/admProgList.do")
	public String admProgList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admProgList.do - 관리자 프로그램 목록화면");
		request.getSession().setAttribute("admMenuNo", "803");
		
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admCurrDAO.ProgList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("leftMenuType", "803");
		model.addAttribute("topMenuType", "80");

		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		
		return "/adm/curr/admProgList";
	}
	
	// 관리자 프로그램 등록&수정화면
	@RequestMapping("/qxsepmny/curr/admProgModify.do")
	public String admProgModify(@ModelAttribute("progVO") ProgVO progVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admProgModify.do - 관리자 프로그램 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "803");
		
		if(progVO.getProgSeq() != null){
			String progSeq = progVO.getProgSeq();
			EgovMap map = admCurrDAO.selectProgOne(progSeq);
			model.addAttribute("progVO", map);
		}
		
		model.addAttribute("leftMenuType", "803");
		model.addAttribute("topMenuType", "80");
		
		return "/adm/curr/admProgModify";
	}
	
	// 관리자 프로그램 등록&수정
			@RequestMapping("/qxsepmny/curr/addProg.do")
			public String admAddProg(HttpServletRequest request, ModelMap model,@ModelAttribute("progVO") ProgVO progVO) throws Exception {
					
				LOGGER.debug("/qxsepmny/curr/admProgModify.do - 관리자 프로그램 등록&수정화면");
				request.getSession().setAttribute("admMenuNo", "803");

				if (progVO.getProgSeq().equals("")) {
					admCurrDAO.addProg(progVO);
				}
				else {
					admCurrDAO.editProg(progVO);
				}

				model.addAttribute("leftMenuType", "803");
				model.addAttribute("topMenuType", "80");
				
				return "redirect:/qxsepmny/curr/admProgList.do";
			}
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 관리자 수업시간 목록화면
	@RequestMapping("/qxsepmny/curr/admClstmList.do")
	public String admClstmList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ProgVO progVO) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admClstmList.do - 관리자 수업시간 목록화면");
		request.getSession().setAttribute("admMenuNo", "804");
		
		EgovMap semester = cmmDAO.selectRegiSeme();
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admCurrDAO.ClstmList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		/*프로그램 셀렉트 박스*/
		String progName = progVO.getProgName();
		CmmnListVO mapProg = admCurrDAO.LectProg(progName);
		model.addAttribute("progName",mapProg.getEgovList());
		
		return "/adm/curr/admClstmList";
	}	
	
	// 관리자 수업시간 등록&수정화면
	@RequestMapping("/qxsepmny/curr/admClstmModify.do")
	public String admClstmModify (@ModelAttribute("searchVO") CmmnSearchVO searchVO, String clstmSeq, HttpServletRequest request, ModelMap model, ProgVO progVO) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admClstmModify.do - 관리자 수업시간 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "804");
		
		ClstmVO clstmVO = new ClstmVO();
		EgovMap semester = cmmDAO.selectRegiSeme();
		
		if(clstmSeq != null){
			clstmVO = admCurrDAO.selectClstmOne(clstmSeq);
		}else{
			clstmVO.setClstmYear((String) semester.get("semYear"));
			clstmVO.setClstmSeme((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(clstmVO.getClstmYear());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		model.addAttribute("clstmVO", clstmVO);
		
		/*프로그램 셀렉트 박스*/
		String progName = progVO.getProgName();
		CmmnListVO mapProg = admCurrDAO.LectProg(progName);
		model.addAttribute("progName",mapProg.getEgovList());
		
		return "/adm/curr/admClstmModify";
	}
	
	// 관리자 수업시간 등록&수정
	@RequestMapping("/qxsepmny/curr/addClstm.do")
	public String addClstm(HttpServletRequest request, ModelMap model, @ModelAttribute("clstmVO") ClstmVO clstmVO) throws Exception {
			
		LOGGER.debug("/qxsepmny/curr/addClstm.do - 관리자 수업시간 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "804");
		
		if (clstmVO.getClstmSeq().equals("")) {
			admCurrDAO.addClstm(clstmVO);
		}
		else {
			admCurrDAO.editClstm(clstmVO);
		}
		return "redirect:/qxsepmny/curr/admClstmList.do";
	}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// 관리자 교과목 목록화면
	@RequestMapping("/qxsepmny/curr/admCourList.do")
	public String admCourList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admCourList.do - 관리자 교과목 목록화면");
		request.getSession().setAttribute("admMenuNo", "805");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admCurrDAO.CourList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("leftMenuType", "805");
		model.addAttribute("topMenuType", "80");

		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/curr/admCourList";
	}
	
	// 관리자 교과목 등록&수정화면
	@RequestMapping("/qxsepmny/curr/admCourModify.do")
	public String admCourModify(@ModelAttribute("courVO") CourVO courVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admCourModify.do - 관리자 교과목 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "805");
		
		if(courVO.getCourSeq() != null){
			String courSeq = courVO.getCourSeq();
			EgovMap map = admCurrDAO.selectCourOne(courSeq);
			model.addAttribute("courVO", map);
		}
		
		model.addAttribute("leftMenuType", "805");
		model.addAttribute("topMenuType", "80");
		
		return "/adm/curr/admCourModify";
	}

	
	// 관리자 교과목 등록&수정
	@RequestMapping("/qxsepmny/curr/addCour.do")
	public String admAddCour(HttpServletRequest request, ModelMap model, @ModelAttribute("courVO") CourVO courVO) throws Exception {
			
		LOGGER.debug("/qxsepmny/curr/admCourModify.do - 관리자 교과목 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "805");
		
		if (courVO.getCourSeq().equals("")) {
			admCurrDAO.addCour(courVO);
		}
		else {
			admCurrDAO.editCour(courVO);
		}
		model.addAttribute("leftMenuType", "805");
		model.addAttribute("topMenuType", "80");
		
		return "redirect:/qxsepmny/curr/admCourList.do";
			}
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	// 관리자 강의개설 목록화면
	@RequestMapping("/qxsepmny/curr/admLectList.do")
	public String admLectList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO,LectureVO lectureVO, CurrVO currVO, SemesterVO semesterVO, MemberVO memberVO, LectureTimeTableVO timeTableVO) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admLectList.do - 관리자 강의개설 목록화면");
		request.getSession().setAttribute("admMenuNo", "806");
		
		EgovMap semester = cmmDAO.selectOpenSeme();
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admCurrDAO.LectList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);

		/*교육과정 셀럭트 박스*/
		String currName = currVO.getCurrName();
		CmmnListVO mapCurr = admCurrDAO.LectCurr(currName);
		model.addAttribute("currName",mapCurr.getEgovList());
		
		/*담음교사 셀렉트 박스*/
		String teaName = memberVO.getMemberCode();
		CmmnListVO mapTeac = admCurrDAO.TeacherName(teaName);
		model.addAttribute("teacher",mapTeac.getEgovList());
		
		
		/*교사 셀렉트 박스*/
		String timetable = timeTableVO.getLectCode();
		CmmnListVO maptimetable = admCurrDAO.TimeTable(timetable);
		model.addAttribute("timetable",maptimetable.getEgovList());
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/curr/admLectList";
	}
	
	// 관리자 강의개설 등록&수정화면
	@RequestMapping("/qxsepmny/curr/admLectModify.do")
	public String admLectModify(@ModelAttribute("lectureVO") LectureVO lectureVO, HttpServletRequest request, ModelMap model, MemberVO memberVO, SemesterVO semesterVO, CurrVO currVO , ProgVO progVO, CourVO courVO) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admLectModify.do - 관리자 강의개설 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "806");
		
		if(lectureVO.getLectSeq() != null){
			String lectSeq = lectureVO.getLectSeq();
			EgovMap map = admCurrDAO.selectLectOne(lectSeq);
			model.addAttribute("lectVO", map);
			
			List<LectureTimeTableVO> timeTableList = admCurrDAO.selectLectOneTimetables(lectSeq);
			model.addAttribute("timeTableList", timeTableList);
		}
		
		
		/*교육과정 셀럭트 박스*/
		String currName = currVO.getCurrName();
		CmmnListVO mapCurr = admCurrDAO.LectCurr(currName);
		model.addAttribute("currName",mapCurr.getEgovList());
		
		/*학기 셀럭트 박스*/
		String semCode = semesterVO.getSem_code();
		CmmnListVO mapSeme = admCurrDAO.LectSeme(semCode);
		model.addAttribute("SemeCode",mapSeme.getEgovList());
		
		/*교과목 셀렉트 박스*/
		String courName = courVO.getCourName();
		CmmnListVO mapCour = admCurrDAO.LectCour(courName);
		model.addAttribute("courName",mapCour.getEgovList());

		/*프로그램 셀렉트 박스*/
		String progName = progVO.getProgName();
		CmmnListVO mapProg = admCurrDAO.LectProg(progName);
		model.addAttribute("progName",mapProg.getEgovList());
		
		/*교사 셀렉트 박스*/
		String teaName = memberVO.getMemberCode();
		CmmnListVO mapTeac = admCurrDAO.TeacherName(teaName);
		model.addAttribute("teacher",mapTeac.getEgovList());
		
		/*분반 셀렉트 박스*/
		String purpose = "division";
		List<EgovMap> division = cmmDAO.cName(purpose);
		model.addAttribute("diviList", division);
		/*강의실 셀렉트 박스*/
		String lectClass = "class";
		List<EgovMap> lectclassList = cmmDAO.cName(lectClass);
		model.addAttribute("lectclassList", lectclassList);
		
		model.addAttribute("lectureVO", lectureVO);
		
		return "/adm/curr/admLectModify";
	}		
	
	// 관리자 교과목 등록&수정
	@RequestMapping("/qxsepmny/curr/addLect.do")
	public String admAddLect(@ModelAttribute("lectureVO") LectureVO lectureVO, LectureTimeTableVO timeTableVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda, String[] delSeqList) throws Exception {
		LOGGER.debug("lectureVO = " + lectureVO.toString());
		LOGGER.debug("/qxsepmny/curr/addLect.do - 관리자 강의개설 등록&수정");
		request.getSession().setAttribute("admMenuNo", "806");
		String message = "";
		
		if(EgovStringUtil.isEmpty(lectureVO.getLectSeq())){		
		String lectSeq = admCurrDAO.addLect(lectureVO);
		
		for(LectureTimeTableVO resultVO : timeTableVO.getTimeTableList()){
			resultVO.setLectSeq(lectSeq);
			admCurrDAO.addLectTimetable(resultVO);
		}
		message = "등록이 완료되었습니다.";
		}else{
		admCurrDAO.editLect(lectureVO);
		
		for(LectureTimeTableVO resultVO : timeTableVO.getTimeTableList()){
			resultVO.setLectSeq(lectureVO.getLectSeq());
			admCurrDAO.editLectTimetable(resultVO);
			
			if(!EgovStringUtil.isEmpty(resultVO.getLectTbseq())){
				admCurrDAO.editLectTimetable(resultVO);
				
				if(delSeqList != null){
					for(String delSeq : delSeqList){
						admCurrDAO.delLectTimetable(delSeq);
					}
				}
			}else{
				admCurrDAO.addLectTimetable(resultVO);
			}
			
		}
			message = "수정이 완료되었습니다.";
		}	
		
		return redirecLecList(reda, message);
	}
		

	//분반 중복확인
		@RequestMapping("/qxsepmny/curr/chkLect.do")
		public View admChkLeck(LectureVO lectureVO, ModelMap model){
			LOGGER.info("/qxsepmny/curr/chkLect.do -  중복확인");
			String result = admCurrDAO.chkLect(lectureVO);

			if("1".equals(result)){
				model.addAttribute("result", "Y");
			}else{
				model.addAttribute("result", "N");
			}
			
			return jsonView;
		}
		//학기 셀렉트 박스
		@RequestMapping("/qxsepmny/curr/admAjaxSelectBoxLectSem.do")
		public View admAjaxSelectBoxLectSem(LectureVO lectureVO, ModelMap model){
			LOGGER.info("/qxsepmny/curr/admAjaxSelectBoxLectSem.do -  셀렉트 박스 값");
			EgovMap map = new EgovMap();
			map.put("lectYear", lectureVO.getLectYear());
			List<EgovMap> resultList = admCurrDAO.admAjaxSelectBoxLectSem(map);
			model.addAttribute("resultList",resultList);
			return jsonView;
		}


		//로그인화면으로 리다이렉트합니다.
		private String redirecLecList(RedirectAttributes reda, String message){
			reda.addFlashAttribute("message", message);
			return "redirect:/qxsepmny/curr/admLectList.do";
		}
		
		// 관리자 강의개설 엑셀 다운로드
		@SuppressWarnings("unchecked")
		@RequestMapping("/qxsepmny/curr/admLectExcel.do")
		public void admLectExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/curr/admLectExcel.do - 관리자 강의개설 엑셀 다운로드");
			LOGGER.debug("searchVO = " + searchVO.toString());
			EgovMap dataMap = new EgovMap();
			
			List<EgovMap> resultList = admCurrDAO.selectAdmLectExcel(searchVO);
			dataMap.put("resultList", resultList);
			
			int num = 1;
			for (EgovMap egovMap : resultList) {
				egovMap.put("number", num);
				num++;
			}
			
			AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			dataMap.put("printUser", sessionVO.getName());
			
			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.getPerformanceExcel(dataMap, "개설강의 리스트", "lectList", request, response);
		}
		
		// 강의개설 분반 등록
		@RequestMapping("/qxsepmny/entran/admAjaxDiviUpdate.do")
		public View admAjaxDiviUpdate(String newDivi, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/entran/admAjaxDiviUpdate.do - 강의개설 분반 등록");
			/*AdminVO adminVO = (AdminVO) userDtlService.getAuthenticatedAdmin();
			
			EgovMap map = new EgovMap();
			map.put("adminId", adminVO.getAdminId());
			map.put("newDivi", newDivi);*/
			
			cmmDAO.insertDivi(newDivi);
			
			String purpose = "division";
			List<EgovMap> division = cmmDAO.cName(purpose);
			
			model.addAttribute("diviList", division);
			return jsonView;
		}
		// 강의개설 강의실 등록
		@RequestMapping("/qxsepmny/entran/admAjaxClassUpdate.do")
		public View admAjaxClassUpdate(String newClass, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/entran/admAjaxClassUpdate.do - 강의개설 분반 등록");
		
			cmmDAO.insertClass(newClass);
			
			String purpose = "class";
			List<EgovMap> classRoom = cmmDAO.cName(purpose);
			
			model.addAttribute("classList", classRoom);
			return jsonView;
		}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
		
	//로그인화면으로 리다이렉트합니다.
	private String redirectSatisList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/curr/admSatisList.do";
	}
	
	// 관리자 수업만족도항목 목록화면
	@RequestMapping("/qxsepmny/curr/admSatisList.do")
	public String admSatisList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admSatisList.do - 관리자 수업만족도항목 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "807");
		
		EgovMap semester = cmmDAO.selectOpenSeme();
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admCurrDAO.selectAdmStatisList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/curr/admSatisList";
	}
	
	// 관리자 수업만족도항목 등록&수정화면
	@RequestMapping("/qxsepmny/curr/admSatisModify.do")
	public String admSatisModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String surveySeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admSatisModify.do - 관리자 수업만족도항목 등록&수정화면");
		request.getSession().setAttribute("admMenuNo", "807");
		
		SurveyVO surveyVO = new SurveyVO();
		
		if(!EgovStringUtil.isEmpty(surveySeq)){
			surveyVO = admCurrDAO.selectAdmSatisModify(surveySeq);
			List<SurveyQuesVO> surveyQuesList = admCurrDAO.selectAdmSurveyQuesList(surveySeq);
			
			model.addAttribute("surveyQuesList", surveyQuesList);
		}
		
		model.addAttribute("surveyVO", surveyVO);
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(yearList.get(0));
		model.addAttribute("semeList", semeList);
		
		List<EgovMap> quesPhrList = cmmDAO.selectQuesPhrList();
		model.addAttribute("quesPhrList", quesPhrList);
		
		return "/adm/curr/admSatisModify";
	}

	// 관리자 수업만족도항목 등록&수정
	@RequestMapping("/qxsepmny/curr/admSatisUpdate.do")
	public String admSatisUpdate(@ModelAttribute("surveyVO") SurveyVO surveyVO, SurveyQuesVO surveyQuesVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/curr/admSatisUpdate.do - 관리자 수업만족도항목 등록&수정");
		LOGGER.debug("surveyVO = " + surveyVO.toString());
		request.getSession().setAttribute("admMenuNo", "807");
		String message = "";
		
		if(EgovStringUtil.isEmpty(surveyVO.getSurveySeq())){
			AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			surveyVO.setRegName(sessionVO.getName());
			
			String surveySeq = admCurrDAO.insertAdmSatis(surveyVO);
			
			for(SurveyQuesVO resultVO : surveyQuesVO.getSurveyQuesList()){
				resultVO.setSurveySeq(surveySeq);
				admCurrDAO.insertAdmSurveyQues(resultVO);
			}
			message = "등록이 완료되었습니다.";
		}else{
			admCurrDAO.updateAdmSatisUpdate(surveyVO);
			
			for(SurveyQuesVO resultVO : surveyQuesVO.getSurveyQuesList()){
				resultVO.setSurveySeq(surveyVO.getSurveySeq());
				if(!EgovStringUtil.isEmpty(resultVO.getQuesSeq())){
					admCurrDAO.updateAdmSurveyQues(resultVO);
				}else{
					admCurrDAO.insertAdmSurveyQues(resultVO);
				}
			}
			message = "수정이 완료되었습니다.";
		}
		
		return redirectSatisList(reda, message);
	}
	
}
