package ctms.adm.ech0702;

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
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0702Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0702Controller.class);
	@Autowired private Ech0702DAO ech0702DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
			
	
	//로그인화면으로 리다이렉트합니다.
	//private String redirectLoginView(RedirectAttributes reda, String message){
	//	reda.addFlashAttribute("message", message);
	//	return "redirect:/qxsepmny/lgn/admLoginView.do";
	//}
	
	/**
	 * 관리자 코딩 화면으로 이동합니다.
	 * @param model
	 * @return 코딩 화면
	 * @throws Exception
	 */
	
	
	// ********************************(기준정보관리) 20201128 관리자 사용자관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0702/ech0702List.do")	
	public String ech0702List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0702/ech0702List.do - 기준정보관리 사용자관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 연구과제 목록만 표시 
		//관리자인 경우 소속지사를 설정하지 않는다 1:관리자권한 2:일반사용자권한
		if(adminVO.getAdminType().equals("2")) { 
			searchVO.setBranchCd(adminVO.getBranchCd());
			searchVO.setSearchCondition7(adminVO.getBranchCd());
			}
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition7())){
			searchVO.setBranchCd(searchVO.getSearchCondition7()); 
		}
		
		EgovMap map = new EgovMap();
		
		map.put("searchYear", searchVO.getSearchYear());
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	 	
	 	if(adminVO.getAdminType().equals("2")) 
		{ 
			map.put("branchCd", adminVO.getBranchCd()); 
			//지사명 (일반대상자) 목록
			List<EgovMap> branchOne = cmmDAO.selectBranchListOne(map);
			model.addAttribute("branch", branchOne);

		}else {
			//지사명  목록 
			List<EgovMap> branch = cmmDAO.selectBranchList(searchVO.getCorpCd());
			model.addAttribute("branch", branch);
			
			if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition7())){
				map.put("branchCd", searchVO.getSearchCondition7());
			}else {
				map.put("branchCd", "");
			}
		}
		

		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0702DAO.selectEch0702List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0702/ech0702List";
	}
	
	// ********************************(기준정보관리) 20201128 관리자 사용자관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0702/ech0702View.do")
	public String ech0702View(@ModelAttribute CmmnSearchVO searchVO , Ct1030mVO ct1030mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0702/ech0702View.do - 기준정보관리 사용자관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//어드민타입 1 어드민 2 일반사용자 
		model.addAttribute("admintype", adminVO.getAdminType());		
		
		ct1030mVO =  ech0702DAO.selectEch0702View(ct1030mVO);
		
		model.addAttribute("ct1030mVO", ct1030mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0702/ech0702View";
	}	

	// ********************************(기준정보관리) 20201128 관리자 사용자관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0702/ech0702Modify.do")
	public String ech0702Modify(@ModelAttribute("ct1030mVO") Ct1030mVO ct1030mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0702/ech0702Modify.do - 관리자 사용자관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	 	//회사코드 설정
	 	ct1030mVO.setCorpCd(adminVO.getCorpCd());
	 	
	 	//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(ct1030mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//공통코드 목록을 한번에 읽어오도록 하자			
		//연구자구분(공통코드) 목록
		List<EgovMap> cm1240 = cmmDAO.selectCmmCdList(ct1030mVO.getCorpCd(), "CM1240");
		model.addAttribute("cm1240", cm1240);
		
		//사원구분(공통코드) 목록			
		List<EgovMap> cm1230 = cmmDAO.selectCmmCdList(ct1030mVO.getCorpCd(), "CM1230");
		model.addAttribute("cm1230", cm1230);
		
		//연구권한(공통코드) 목록
		List<EgovMap> cm1210 = cmmDAO.selectCmmCdList(ct1030mVO.getCorpCd(), "CM1210");
		model.addAttribute("cm1210", cm1210);
		
		//사용상태(공통코드) 목록
		List<EgovMap> cm1250 = cmmDAO.selectCmmCdList(ct1030mVO.getCorpCd(), "CM1250");
		model.addAttribute("cm1250", cm1250);
		
		//부서구분(공통코드) 목록
		List<EgovMap> cm1220 = cmmDAO.selectCmmCdList(ct1030mVO.getCorpCd(), "CM1220");
		model.addAttribute("cm1220", cm1220);

	
	   //등록화면으로
		if (EgovStringUtil.isEmpty(ct1030mVO.getEmpNo())) {
//				
			//지사명  목록 
			//List<EgovMap> branch = ech0702DAO.selectBranchList(ct1030mVO);
			//model.addAttribute("branch", branch);
			
			//연구자구분(공통코드) 목록 
			//List<EgovMap> cm1240 = ech0702DAO.selectCmmCdList(ct1030mVO.getCorpCd(), "CM1240");
			//model.addAttribute("cm1240", cm1240);
			
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(ct1030mVO.getEmpNo())){
					
			ct1030mVO = ech0702DAO.selectEch0702View(ct1030mVO);
			
			//IP번호 분리하기
			if (!EgovStringUtil.isEmpty(ct1030mVO.getAcceIp())) {
				String ip = ct1030mVO.getAcceIp();
				
				String[] spIp = ip.split("\\.");
				ct1030mVO.setIp1(spIp[0].toString());
				ct1030mVO.setIp2(spIp[1].toString());
				ct1030mVO.setIp3(spIp[2].toString());
				ct1030mVO.setIp4(spIp[3].toString());			}
						
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("ct1030mVO", ct1030mVO);
			
		}
		
		return "/adm/ech0702/ech0702Modify";
	}

	// ********************************(기준정보관리) 20201128 관리자 사용자관리 저장 ********************************
	@RequestMapping("/qxsepmny/ech0702/ech0702Update.do")
	public String ech0702Save(@ModelAttribute("ct1030mVO") Ct1030mVO ct1030mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0702/ech0702Update.do - 관리자 사용자관리 저장");
	String message = "";
	
	//세션 호출
	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	
	// 회사코드(CTMS운영) 설정
	ct1030mVO.setCorpCd(adminVO.getCorpCd());
	// 작업자 설정 - EMP_NO
	ct1030mVO.setDataRegnt(adminVO.getEmpNo());
	
	//IP번호 합치기
	if (!EgovStringUtil.isEmpty(ct1030mVO.getIp1())) {
		ct1030mVO.setAcceIp(ct1030mVO.getIp1()+"."+ct1030mVO.getIp2()+"."+ct1030mVO.getIp3()+"."+ct1030mVO.getIp4());
	}
	
	if(EgovStringUtil.isEmpty(ct1030mVO.getEmpNo())){
	    
		ech0702DAO.insertEch0702(ct1030mVO);
		
		message = "등록이 완료되었습니다.";
	}else{
		ech0702DAO.updateEch0702(ct1030mVO);

		message = "수정이 완료되었습니다.";			
		}

	return redirectList(reda, message);

	}

	// ********************************(기준정보관리) 20201128 관리자 사용자관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0702/ech0702Delete.do")
	public String ech0702Delete(@ModelAttribute Ct1030mVO ct1030mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0702/ech0702Delete.do - 관리자 사용자관리 삭제");
	String message = "";
	
	//사용자관리 삭제
	if(!EgovStringUtil.isEmpty(ct1030mVO.getEmpNo())){
	
		ech0702DAO.deleteEch0702(ct1030mVO);
	
		message = "사용자정보가 삭제되었습니다.";
	}
	return redirectList(reda, message);

	}

	// 사용자관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0702/ech0702List.do";
	}

	// 사용자관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0702/ech0702Excel.do")
	public void ech0702Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0702/ech0702Excel.do - 사용자관리 목록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0702DAO.selectEch0702Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "사용자 리스트", "ech0702", request, response);
	}

	// 관리자 비밀번호 재설정
	@RequestMapping("/qxsepmny/ech0702/ech0702AjaxProfClearPw.do")
	public View ech0702AjaxProfClearPw(Ct1030mVO ct1030mVO, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/oper/admAjaxProfClearPw.do - 관리자 비밀번호 재설정");
		LOGGER.debug("ct1030mVO = " + ct1030mVO);
		String message = "";
		
		if(ct1030mVO !=null){
			//아이디를 비밀번호로 설정
			ct1030mVO.setPwNo(EgovFileScrty.encryptPassword(ct1030mVO.getUserId(), ct1030mVO.getUserId()));
			
			ech0702DAO.updateEch0702AjaxProfClearPw(ct1030mVO);
			message = "비밀번호가 초기화되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 관리자 로그인 횟수 초기화
	@RequestMapping("/qxsepmny/ech0702/ech0702AjaxClearLgnFail.do")
	public View ech0702AjaxClearLgnFail(String adminId, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0702/ech0702AjaxClearLgnFail.do - 사용자 로그인 횟수 초기화");
		LOGGER.debug("adminId = " + adminId);
		String message = "";
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("adminId", adminId);
		
		if(!EgovStringUtil.isEmpty(adminId)){ 
			ech0702DAO.updateEch0702AjaxClearLgnFail(map);
			message = "로그인 횟수가 초기화되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 관리자 사용자관리 아이디 중복체크
	@RequestMapping("/qxsepmny/ech0702/ech0702AjaxAdminIdChk.do")
	public View ech0702AjaxAdminIdChk(String adminId, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0702/ech0702AjaxAdminIdChk.do - 관리자 사용자관리 중복체크");
		
		boolean status = false;
		
		if(!EgovStringUtil.isEmpty(adminId)){
			int cnt = ech0702DAO.selectEch0702AdminIdChk(adminId);
			if(cnt > 0){
				status = false;
			}else{
				status = true;
			}
		}
		model.addAttribute("status", status);
		
		return jsonView;
	}
	
	// 관리자 프로필 화면
	@RequestMapping("/qxsepmny/ech0702/ech0702AdminProfileView.do")
	public String ech0702AdminProfileView(@ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0702/ech0702AdminProfileView.do - 관리자 profile 목록");
		//세션 호출
		
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		EgovMap map = new EgovMap();
		map.put("corpCd", adminVO.getCorpCd());
		map.put("empNo", adminVO.getEmpNo());
		
		Ct1030mVO resultVO = ech0702DAO.selectEch0702Profile(map);
		String clientIp = ComStringUtil.getClientIP(request);
		model.addAttribute("ct1030mVO", resultVO);
		model.addAttribute("clientIp", clientIp);
		
		return "/adm/ech0702/ech0702ModifyProfile";
	}
	
	// 사용자 비밀번호 조회
	@RequestMapping("/qxsepmny/ech0702/ech0702AjaxAdminPwChk.do")
	public View ech0702AjaxAdminPwChk(String adminPw, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0702/ech0702AjaxAdminPwChk.do - 관리자 비밀번호 조회");
		
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		EgovMap map = new EgovMap();
		map.put("corpCd", adminVO.getCorpCd());
		map.put("empNo", adminVO.getEmpNo());
		map.put("userId",adminVO.getAdminId());
		map.put("pwNo",adminPw);
		
		Ct1030mVO ct1030mVO = ech0702DAO.selectEch0702Profile(map);
		
		boolean status = false;
		
		if(!EgovStringUtil.isEmpty(ct1030mVO.getPwNo())){
			ct1030mVO.setPwNo(EgovFileScrty.encryptPassword(adminPw, ct1030mVO.getUserId()));
			
			int cnt = ech0702DAO.selectEch0702AjaxAdminPwChk(ct1030mVO);
			
			if(cnt > 0){
				status = true;
			}else{
				status = false;
			}
		}
		
		model.addAttribute("ct1030mVO", ct1030mVO);
		model.addAttribute("status", status);
		
		return jsonView;
	}
	
	// 관리자 비밀번호 수정
	@RequestMapping("/qxsepmny/ech0702/ech0702AjaxPasswordUpdate.do")
	public String ech0702AjaxPasswordUpdate(@ModelAttribute("ct1030mVO") Ct1030mVO ct1030mVO, String adminPw, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/qxsepmny/ech0702/ech0702AjaxPasswordUpdate.do - 관리자 비밀번호 수정");
		String message = "";

		if(ct1030mVO != null){
			ct1030mVO.setPwNo(EgovFileScrty.encryptPassword(adminPw, ct1030mVO.getUserId()));
			LOGGER.debug("setPwNo"+ct1030mVO.getPwNo());
			ech0702DAO.ech0702AjaxPasswordUpdate(ct1030mVO);
			message = "수정이 완료 되었습니다.";
		}
		return redirectEch0702Profile(reda, message);
		
	}
	
	//프로필화면으로 리다이렉트합니다.
	private String redirectEch0702Profile(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0702/ech0702AdminProfileView.do";
	}

	
	
	
		
}
