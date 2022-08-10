package lcms.adm.regist;

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
import lcms.valueObject.AdminVO;
import lcms.valueObject.RefFeeVO;
import lcms.valueObject.RegFeeVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmRegistController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmRegistController.class);
	@Autowired private AdmRegistDAO admRegistDAO;
	@Resource View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//등록금고지화면으로 리다이렉트합니다.
	private String redirectTuinotiList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/regist/admTuinotiList.do";
	}

	//등록금납부화면으로 리다이렉트합니다.
	private String redirectTuipayList(RedirectAttributes reda, String message, CmmnSearchVO searchVO){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxsepmny/regist/admTuipayList.do";
	}
	
	// 관리자 가상계좌발급 목록화면
	@RequestMapping("/qxsepmny/regist/admAccoList.do")
	public String admAccoList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admAccoList.do - 관리자 가상계좌발급 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "201");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectRegiSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		if(EgovStringUtil.isEmpty(searchVO.getMenuType())){
			searchVO.setMenuType("1");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admRegistDAO.selectAdmAccoList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/regist/admAccoList";
	}
	
	// 관리자 가상계좌 일괄발급
	@RequestMapping("/qxsepmny/regist/admAjaxAdmAccoSave.do")
	public View admAjaxAdmAccoSave(String[] enterSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admAjaxAdmAccoSave.do - 관리자 가상계좌 일괄발급");
		
		String message = "";
		
		for(String seq: enterSeq){
			admRegistDAO.updateAdmAccoSave(seq);
			admRegistDAO.insertAdmAccoEmr(seq);
			message = "계좌 발급이 완료되었습니다.";
		}
		
		model.addAttribute("message", message);
		return jsonView;
	}

	// 관리자 가상계좌 발급
	@RequestMapping("/qxsepmny/regist/admAjaxAdmAccoSaveOne.do")
	public View admAjaxAdmAccoSaveOne(String enterNum, String enterCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admAjaxAdmAccoSaveOne.do - 관리자 가상계좌 발급");
		LOGGER.debug("enterNum = " + enterNum);
		LOGGER.debug("enterCode = " + enterCode);
		
		String message = "";
		String studentCode = "";
		
		if(EgovStringUtil.isEmpty(enterCode)){
			studentCode = enterNum;
		}else{
			studentCode = enterCode;
		}
		
		admRegistDAO.updateAdmAccoSaveOne(studentCode);
		String account = admRegistDAO.selectAdmAccount(studentCode);
		message = "계좌 발급이 완료되었습니다.";
		
		model.addAttribute("account", account);
		model.addAttribute("message", message);
		return jsonView;
	}

	// 관리자 등록금고지 목록화면
	@RequestMapping("/qxsepmny/regist/admTuinotiList.do")
	public String admTuinotiList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuinotiList.do - 관리자 등록금고지 목록화면");
		request.getSession().setAttribute("admMenuNo", "202");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectRegiSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admRegistDAO.selectAdmTuinotiList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/regist/admTuinotiList";
	}

	// 관리자 등록금고지 등록&수정 화면
	@RequestMapping("/qxsepmny/regist/admTuinotiModify.do")
	public String admTuinotiModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String regSeq, String enterNum, String addYn, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuinotiModify.do - 관리자 등록금고지 등록&수정 화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		LOGGER.debug("regSeq = " + regSeq);
		LOGGER.debug("addYn = " + addYn);
		LOGGER.debug("enterNum = " + enterNum);
		request.getSession().setAttribute("admMenuNo", "202");
		
		RegFeeVO regFeeVO = new RegFeeVO();
		
		if(!EgovStringUtil.isEmpty(regSeq)){
			regFeeVO = admRegistDAO.selectAdmTuinotiModify(regSeq);
		}else{
			regFeeVO = admRegistDAO.selectAdmTuinotiEnter(enterNum);

			EgovMap semester = cmmDAO.selectRegiSeme();
			
			regFeeVO.setRegStYear((String) semester.get("semYear"));
			regFeeVO.setRegStSeme((String) semester.get("semester"));
			regFeeVO.setRegStDate((String) semester.get("registS"));
			regFeeVO.setRegEdDate((String) semester.get("registE"));

			if(!EgovStringUtil.isEmpty(addYn)){
				regFeeVO.setAddYn(addYn);
			}
		}
		String studentCode = "";
		
		if(EgovStringUtil.isEmpty(regFeeVO.getEnterCode())){
			studentCode = regFeeVO.getEnterNum();
		}else{
			studentCode = regFeeVO.getEnterCode();
		}
		
		String account = admRegistDAO.selectAdmAccount(studentCode);
		model.addAttribute("account", account);
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(regFeeVO.getRegStYear());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		model.addAttribute("regFeeVO", regFeeVO);
		
		return "/adm/regist/admTuinotiModify";
	}

	// 관리자 등록금고지 학생 조회
	@RequestMapping("/qxsepmny/regist/admAjaxSearchStdList.do")
	public View admAjaxSearchStdList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admAjaxSearchStdList.do - 관리자 등록금고지 학생 조회");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		List<EgovMap> resultList = null;
		
		if("ENTR".equals(searchVO.getSearchType())){
			resultList = admRegistDAO.selectAdmAjaxEnterList(searchVO);
		}else{
			resultList = admRegistDAO.selectAdmAjaxStdList(searchVO);
		}
		
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 관리자 등록금고지 고지서 인쇄 팝업
	@RequestMapping("/qxsepmny/regist/admTuinotiPop.do")
	public String admTuinotiPop(String[] regSeqList, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuinotiPop.do - 관리자 등록금고지 고지서 인쇄 팝업");
		LOGGER.debug("regSeqList = " + regSeqList.toString());
		request.getSession().setAttribute("admMenuNo", "202");
		
		EgovMap map = new EgovMap();
		map.put("regSeqList", regSeqList);
		
		List<EgovMap> resultList = admRegistDAO.selectTuinotiPopList(map);
		model.addAttribute("resultList", resultList);
		
		return "/adm/regist/admTuinotiPop";
	}

	// 관리자 등록금고지 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/regist/admTuinotiExcel.do")
	public void admTuinotiExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuinotiExcel.do - 관리자 등록금고지 고지서 인쇄 팝업");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admRegistDAO.selectAdmTuinotiExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "등록금고지 리스트", "tuinotiList", request, response);
	}

	// 관리자 등록금고지 등록
	@RequestMapping("/qxsepmny/regist/admTuinotiUpdate.do")
	public String admTuinotiUpdate(@ModelAttribute("regFeeVO") RegFeeVO regFeeVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuinotiUpdate.do - 관리자 등록금납부 등록");
		LOGGER.debug("regFeeVO = " + regFeeVO.toString());
		String message = "";
		if(EgovStringUtil.isEmpty(regFeeVO.getRegSeq())){
			admRegistDAO.insertAdmTuinoti(regFeeVO);
			message = "등록이 완료되었습니다.";
		}else{
			admRegistDAO.updateAdmTuinoti(regFeeVO);
			message = "수정이 완료되었습니다.";
		}
		
		return redirectTuinotiList(reda, message);
	}

	// 관리자 등록금납부 목록화면
	@RequestMapping("/qxsepmny/regist/admTuipayList.do")
	public String admTuipayList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuipayList.do - 관리자 등록금납부 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "203");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectRegiSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admRegistDAO.selectAdmTuipayList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/regist/admTuipayList";
	}

	// 관리자 등록금납부 엑셀다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/regist/admTuipayExcel.do")
	public void admTuipayExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuipayExcel.do - 관리자 등록금납부 엑셀다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admRegistDAO.selectAdmTuipayExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "등록금납부 리스트", "tuipayList", request, response);
	}
	
	// 관리자 등록금납부 수정 화면
	@RequestMapping("/qxsepmny/regist/admTuipayModify.do")
	public String admTuipayModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String regSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuipayModify.do - 관리자 등록금납부 등록&수정 화면");
		LOGGER.debug("regSeq = " + regSeq);
		request.getSession().setAttribute("admMenuNo", "203");
		
		RegFeeVO regFeeVO = admRegistDAO.selectAdmTuipayModify(regSeq);
		model.addAttribute("regFeeVO", regFeeVO);
		
		return "/adm/regist/admTuipayModify";
	}

	// 관리자 등록금납부 수정
	@RequestMapping("/qxsepmny/regist/admTuipayUpdate.do")
	public String admTuipayUpdate(@ModelAttribute("regFeeVO") RegFeeVO regFeeVO, CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuipayUpdate.do - 관리자 등록금납부 수정");
		LOGGER.debug("regFeeVO = " + regFeeVO.toString());
		String message = "";
		
		admRegistDAO.updateAdmTuipayUpdate(regFeeVO);
		message = "납부정보가 저장되었습니다.";
		
		return redirectTuipayList(reda, message, searchVO);
	}
	
	// 업무담당자 환불 목록화면으로 리다이렉트합니다.
	private String redirectRefList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/regist/admRefList.do";
	}

	// 관리자 환불 목록화면
	@RequestMapping("/qxsepmny/regist/admRefList.do")
	public String admRefList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admRefList.do - 관리자 환불 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "204");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectRegiSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admRegistDAO.selectAdmRefList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/regist/admRefList";
	}
	
	// 관리자 환불 등록&수정 화면
	@RequestMapping("/qxsepmny/regist/admRefModify.do")
	public String admRefModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String refSeq, String enterNum, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admRefModify.do - 관리자 환불 등록&수정 화면");
		request.getSession().setAttribute("admMenuNo", "204");
		
		RefFeeVO refFeeVO = new RefFeeVO();
		
		if(!EgovStringUtil.isEmpty(refSeq)){
			refFeeVO = admRegistDAO.selectAdmRefModify(refSeq);
		}
		
		model.addAttribute("refFeeVO", refFeeVO);
		
		return "/adm/regist/admRefModify";
	}

	// 관리자 환불 등록&수정
	@RequestMapping("/qxsepmny/regist/admRefUpdate.do")
	public String admRefUpdate(@ModelAttribute("refFeeVO") RefFeeVO refFeeVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admRefUpdate.do - 관리자 환불 등록&수정");
		LOGGER.debug("refFeeVO = " + refFeeVO.toString());
		String message = "";
		
		if(!EgovStringUtil.isEmpty(refFeeVO.getRefSeq())){
			admRegistDAO.updateAdmRefUpdate(refFeeVO);
			message = "수정이 완료되었습니다.";
		}else{
			admRegistDAO.insertAdmRefUpdate(refFeeVO);
			message = "등록이 완료되었습니다.";
		}
		
		return redirectRefList(reda, message);
	}
	
	// 관리자 가상계좌 발급현황 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/regist/admAccoExcel.do")
	public void admAccoExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admAccoExcel.do - 관리자 가상계좌 발급현황 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admRegistDAO.selectAdmAccoExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "가상계좌 발급현황 리스트", "accoList", request, response);
	}
	
	// 관리자 환불 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/regist/admRefExcel.do")
	public void admRefExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admRefExcel.do - 관리자 환불 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admRegistDAO.selectAdmRefExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "환불 리스트", "refList", request, response);
	}
	
	// 관리자 등록금납부 일괄 납부 처리
	@RequestMapping("/qxsepmny/regist/admTuipayBat.do")
	public String admTuipayBat(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String[] regSeq, String payDate, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/regist/admTuipayBat.do - 관리자 등록금납부 일괄 납부 처리");
		request.getSession().setAttribute("admMenuNo", "204");
		String message = "등록금 일괄 납부 처리가 완료되었습니다.";
		
		for(String seq : regSeq){
			EgovMap paramMap = new EgovMap();
			paramMap.put("regSeq", seq);
			paramMap.put("payDate", payDate);
			admRegistDAO.updateAdmTuipayBat(paramMap);
		}
		
		return redirectTuipayList(reda, message, searchVO);
	}
}
