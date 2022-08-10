package lcms.adm.stat;

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
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AdminVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmStatController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmStatController.class);
	@Autowired private AdmStatDAO admStatDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private View jsonView;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//수강생국적통계 목록화면으로 리다이렉트합니다.
	private String redirectAdmNatiStatList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/stat/admNatiStatList.do";
	}
	
	// 업무담당자 수강생국적통계 목록화면
	@RequestMapping("/qxsepmny/stat/admNatiStatList.do")
	public String admAdminList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/stat/admNatiStatList.do - 업무담당자 수강생국적통계 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "601");
		
		List<String> progList = cmmDAO.selectProgList();
		model.addAttribute("progList", progList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectOpenSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
			searchVO.setSearchCondition3(progList.get(0));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		// 국적별 인원수 목록
		List<EgovMap> resultList = admStatDAO.selectAdmNatiStatList(searchVO);
		model.addAttribute("resultList", resultList);
		
		// 성별별 인원수
		EgovMap resultMap = admStatDAO.selectAdmNatiStatTot(searchVO);
		model.addAttribute("resultMap", resultMap);
		
		return "/adm/stat/admNatiStatList";
	}

	// 업무담당자 수강생국적통계 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/stat/admNatiStatExcel.do")
	public void admNatiStatExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/stat/admNatiStatExcel.do - 업무담당자 수강생국적통계 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admStatDAO.selectAdmNatiStatList(searchVO);
		dataMap.put("resultList", resultList);

		EgovMap resultMap = admStatDAO.selectAdmNatiStatTot(searchVO);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			egovMap.put("totCnt", ((Long)egovMap.get("natiCnt")).floatValue()*100/((Long)resultMap.get("totCnt")).floatValue());
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "수강생국적통계 리스트", "natiStatList", request, response);
		
	}

	// 업무담당자 학생구분별통계 목록화면
	@RequestMapping("/qxsepmny/stat/admStdStatList.do")
	public String admStdStatList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/stat/admStdStatList.do - 업무담당자 학생구분별통계 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "602");
		
		List<String> progList = cmmDAO.selectProgList();
		model.addAttribute("progList", progList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectOpenSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2("1");
			searchVO.setSearchCondition3(progList.get(0));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		
		model.addAttribute("yearList", yearList);
		
		// 학생구분별 인원수 목록
		List<EgovMap> resultList = admStatDAO.selectAdmStdStatList(searchVO);
		model.addAttribute("resultList", resultList);
		
		return "/adm/stat/admStdStatList";
	}
	
	// 업무담당자 학생구분별통계 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/stat/admStdStatExcel.do")
	public void admStdStatExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/stat/admStdStatExcel.do - 업무담당자 학생구분별통계 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admStatDAO.selectAdmStdStatList(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			egovMap.put("chanPer", ((Long)egovMap.get("chanCnt")).floatValue()*100/((Long)egovMap.get("totCnt")).floatValue());
			egovMap.put("langPer", ((Long)egovMap.get("langCnt")).floatValue()*100/((Long)egovMap.get("totCnt")).floatValue());
			egovMap.put("undePer", ((Long)egovMap.get("undeCnt")).floatValue()*100/((Long)egovMap.get("totCnt")).floatValue());
			egovMap.put("gradPer", ((Long)egovMap.get("gradCnt")).floatValue()*100/((Long)egovMap.get("totCnt")).floatValue());
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "학생구분별통계 리스트", "stdStatList", request, response);
		
	}

	// 업무담당자 수료형태별통계 목록화면
	@RequestMapping("/qxsepmny/stat/admComplStatList.do")
	public String admComplStatList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/stat/admComplStatList.do - 업무담당자 수료형태별통계 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "603");
		
		List<String> progList = cmmDAO.selectProgList();
		model.addAttribute("progList", progList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectOpenSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2("1");
			searchVO.setSearchCondition3(progList.get(0));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		
		model.addAttribute("yearList", yearList);
		
		// 학생구분별 인원수 목록
		List<EgovMap> resultList = admStatDAO.selectAdmComplStatList(searchVO);
		model.addAttribute("resultList", resultList);
		
		return "/adm/stat/admComplStatList";
	}
	
	// 업무담당자 수료형태별통계 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/stat/admComplStatExcel.do")
	public void admComplStatExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/stat/admComplStatExcel.do - 업무담당자 학생구분별통계 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admStatDAO.selectAdmComplStatList(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "수료형태별통계 리스트", "complStatList", request, response);
		
	}
	
}