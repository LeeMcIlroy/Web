package ctms.adm.ech0205;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import component.file.CmmnFileMngUtil;

import component.excel.ExcelUtil;

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
import ctms.adm.ech0301.Ech0301DAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Cr3200mVO;
import ctms.valueObject.Cr3210mVO;
import ctms.valueObject.Cr3240mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0205Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0205Controller.class);
	@Autowired private Ech0205DAO ech0205DAO;
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
	
	
	// ********************************(기준정보관리) 20201128 관리자 제품사용관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0205/ech0205List.do")	
	public String ech0205List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205List.do - 기준정보관리 제품사용관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//검색항목 설정 시작
		
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

		//시작일자 searchCondition1 종료일자 searchCondition2 기간구분 searchCondition4
		//searchWord 검색어구분 searchCondition3
		//연도목록
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		
		EgovMap map = new EgovMap();
		
		map.put("searchYear", searchVO.getSearchYear());
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());;
	 	
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
		
		//List<EgovMap> rsCdList = ech0101DAO.selectEch0101StaffList(map);
		List<EgovMap> yearRsCdList = cmmDAO.selectCmmYearRsCdList(map);
		
		model.addAttribute("yearRsCdList", yearRsCdList);
		
		//임상분류(공통코드) 목록 searchCondition5
		List<EgovMap> ct2030 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2030");
		model.addAttribute("ct2030", ct2030);
		
		//연구상태(공통코드) 목록 searchCondition5
		List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2050");
		model.addAttribute("ct2050", ct2050);
		
		//-- 검색항목 설정 끝
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0205DAO.selectEch0205List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0205/ech0205List";
	}
	
	// ********************************(기준정보관리) 20201128 관리자 제품사용관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0205/ech0205View.do")
	public String ech0205View(@ModelAttribute("searchVO")CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, Cr3200mVO cr3200mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205View.do - 기준정보관리 제품사용관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		String message = "";
		
		// 회사코드(CTMS운영) 설정
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		cr3200mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		rs1000mVO =  ech0205DAO.selectEch0205RsView(rs1000mVO);
		
		//연구대상자 제품사용정보 조회
		Cr3200mVO chkVO =  ech0205DAO.selectEch0205View(cr3200mVO);
		
		//제품사용정보가 없는 경우 등록화면으로 전환
		if (chkVO == null) {
			
			model.addAttribute("NotiPageGubun","NotiRegist");			
			message = "제품사용관리을 등록해주세요.";
			String rsNo = rs1000mVO.getRsNo();
			
			model.addAttribute("rs1000mVO", rs1000mVO);
			model.addAttribute("cr3200mVO", cr3200mVO);
			return redirectModify(reda, message, rsNo);
		}
		
		//연구대상자 제품사용목록 조회
		cr3200mVO =  ech0205DAO.selectEch0205View(cr3200mVO);
		
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		CmmnListVO listVO = ech0205DAO.selectEch0205ChkList(searchVO);
		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("cr3200mVO", cr3200mVO);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO1="+searchVO.toString());
										
		return "/adm/ech0205/ech0205View";
	}	

	// ********************************(기준정보관리) 20201128 관리자 제품사용관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0205/ech0205Modify.do")
	public String ech0205Modify(@ModelAttribute("cr3200mVO") Cr3200mVO cr3200mVO, Rs1000mVO rs1000mVO, String rsNo, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205Modify.do - 관리자 제품사용관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
		
		// 회사코드(CTMS운영) 설정
		cr3200mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		rs1000mVO =  ech0205DAO.selectEch0205RsView(rs1000mVO);
		
		//제품사용정보 조회
		int totalchkCnt = ech0205DAO.selectEch0205Cnt(cr3200mVO);
		
		if(totalchkCnt <= 0) {
			//model.addAttribute("adminVO", adminVO);
			
			//체크기간 설정
			cr3200mVO.setChkStdt(rs1000mVO.getRsStdt());
			cr3200mVO.setChkEndt(rs1000mVO.getRsEndt());
			
			model.addAttribute("NotiPageGubun","NotiRegist");
		}else {
						
				cr3200mVO = ech0205DAO.selectEch0205View(cr3200mVO);
					
				model.addAttribute("NotiPageGubun","NotiUpdate");
				
		}
		
		model.addAttribute("cr3200mVO", cr3200mVO);
		model.addAttribute("rs1000mVO", rs1000mVO);
		
		return "/adm/ech0205/ech0205Modify";
	}

	// ********************************(기준정보관리) 20201128 관리자 제품사용관리 저장 ********************************
	@RequestMapping("/qxsepmny/ech0205/ech0205Update.do")
	public String ech0205Save(@ModelAttribute("cr3200mVO") Cr3200mVO cr3200mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205Update.do - 관리자 제품사용관리 저장");
		String message = "";
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
		
		// 회사코드(CTMS운영) 설정
		cr3200mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		// 등록수정자 설정
		cr3200mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		if(EgovStringUtil.isEmpty(cr3200mVO.getDataRegdt())){
						
			ech0205DAO.insertEch0205(cr3200mVO);
			
			//제품사용정보가 등록되면 개인별 제품사용데이터도 등록한다. 
			EgovMap map = new EgovMap();
			
			map.put("corpCd", cr3200mVO.getCorpCd());
			map.put("rsNo", cr3200mVO.getRsNo());
			map.put("chkStdt", cr3200mVO.getChkStdt());
			map.put("chkEndt", cr3200mVO.getChkEndt());
			map.put("dataRegnt", cr3200mVO.getDataRegnt());
						
			ech0205DAO.insertEch0205ItemUse(map);
			
			message = "등록이 완료되었습니다.";

		}else{
			ech0205DAO.updateEch0205(cr3200mVO);
	
			message = "수정이 완료되었습니다.";			
			}
	
		return redirectList(reda, message);

	}

	// ********************************(기준정보관리) 20201128 관리자 제품사용관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0205/ech0205Delete.do")
	public String ech0205Delete(@ModelAttribute Cr3200mVO cr3200mVO, Rs1000mVO rs1000mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205Delete.do - 관리자 제품사용관리 삭제");
		String message = "";
		
		//개인사용일정 CR3210M에 실사용체크수 CHK_CNT가 0 이상이면 삭제하지 않는다. 
		int totalchkCnt = ech0205DAO.selectEch0205ChkCnt(cr3200mVO);
		
		if(totalchkCnt > 0) {
			
			model.addAttribute("rs1000mVO", rs1000mVO);
			model.addAttribute("cr3200mVO", cr3200mVO);
			
			message = "실사용체크수가 존재합니다.";
			return redirectList(reda, message);
		}

		//제품사용관리 삭제
		if(!EgovStringUtil.isEmpty(cr3200mVO.getRsNo())){
		
			ech0205DAO.deleteEch0205(cr3200mVO);
			ech0205DAO.deleteEch0205Chk(cr3200mVO);
			
			message = "제품사용정보가 삭제되었습니다.";
		}
		return redirectList(reda, message);

	}

	// 제품사용관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0205/ech0205List.do";
	}
	
	// 제품사용관리 등록/수정화면으로 리다이렉트
		private String redirectModify(RedirectAttributes reda, String message, String rsNo) {
			reda.addFlashAttribute("message", message);
			reda.addFlashAttribute("rsNo", rsNo);
			//return "redirect:/qxsepmny/ech0205/ech0205Modify.do";
			return "forward:/qxsepmny/ech0205/ech0205Modify.do";
	}

	// 제품사용관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0205/ech0205Excel.do")
	public void ech0205Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205Excel.do - 제품사용관리 목록 엑셀 다운로드");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0205DAO.selectEch0205Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "제품사용 리스트", "ech0205", request, response);
	}
	
	
	// 연구대상자 체크시작, 종료일자 일괄등록
	@RequestMapping("/qxsepmny/ech0205/ech0205AjaxSaveStep.do")
	public View ech0205AjaxSaveStep(String corpCd,String rsNo, String step1,String step2, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0205/ech0502AjaxSaveStep.do - 관리자 연구대상자 체크시작, 종료일자 일괄등록");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd()); 
		map.put("rsNo", rsNo);
		map.put("step1", step1);
		map.put("step2", step2);
		map.put("rsjSeq", rsjSeq); // rsNo + rsjNo 
		
		for(int i=0;i<rsjSeq.length;i++) { //출력
		    LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);
		}
		
		LOGGER.debug("map="+map.toString());
		
		//제품사용등록시 연구대상자 제품사용설정도 동시에 일괄등록된다.
		ech0205DAO.updateEch0205AjaxSaveStep(map);
		
		message = "연구대상자별 일정이 저장(변경)되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}

	// 연구대상자 체크시작, 종료일자  신규등록
	@RequestMapping("/qxsepmny/ech0205/ech0205AjaxSaveStep2.do")
	public View ech0205AjaxSaveStep2(String corpCd,String rsNo, String step1,String step2, String[] rsjSeq, Cr3210mVO cr3210mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0205/ech0502AjaxSaveStep2.do - 관리자 연구대상자 체크시작, 종료일자 신규등록(1건)");
		String message = "";
		boolean status = false;
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd()); 
		map.put("rsNo", rsNo);
		map.put("chkStdt", step1);
		map.put("chkEndt", step2);
		map.put("rsjSeq", rsjSeq);
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		for(int i=0;i<rsjSeq.length;i++) { //출력
		    LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);
		}
		
		LOGGER.debug("map="+map.toString());
		
		//일괄등록에서 제외된 연구대상자의 개별 사용정보를 등록한다.
		//이미 등록된 사용자를 선택한 경우는 제외한다.
		int chkcnt = ech0205DAO.selectEch0205AjaxSaveStepCnt(map);
		if(chkcnt > 0) {
			message = "이미 사용일정이 등록된 연구대상자입니다.";
			status = false;
			
		} else {
			ech0205DAO.insertEch0205AjaxSaveStep(map);
			message = "연구대상자의 일정이 저장 되었습니다.";
			status = true;
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		return jsonView;
		
	}	

	// 연구대상자 일괄 회수 등록(회수로 설정)
	@RequestMapping("/qxsepmny/ech0205/ech0205AjaxSaveStep3.do")
	public View ech0205AjaxSaveStep3(String corpCd,String rsNo, String step1,String step2, String[] rsjSeq, Cr3210mVO cr3210mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0205/ech0502AjaxSaveStep3.do - 관리자 연구대상자 일괄 회수 등록(회수로 설정)");
		String message = "";
		boolean status = false;
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd()); 
		map.put("rsNo", rsNo);
		/*
		 * map.put("chkStdt", step1); map.put("chkEndt", step2);
		 */
		map.put("rsjSeq", rsjSeq);
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		for(int i=0;i<rsjSeq.length;i++) { //출력
		    LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);
		}
		
		LOGGER.debug("map="+map.toString());
		
		//제품회수를 일괄 설정한다. 
		ech0205DAO.updateEch0205AjaxSaveStep3(map);
		message = "제품회수 정보가 저장 되었습니다.";
		status = true;
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		return jsonView;
		
	}	
	
	// 연구대상별 제품사용결과 팝업
	@RequestMapping("/qxsepmny/ech0205/ech0205RsjUsePop.do")
	public String ech0205RsjUsePop(String authkey, String corpCd, String rsNo, String rsjNo, Cr3210mVO cr3210mVO, CmmnSearchVO searchVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205RsjUsePop.do - 연구대상자별 제품사용결과 팝업");
		LOGGER.debug("corpCd = " + corpCd);
		LOGGER.debug("rsNo = " + rsNo);
		LOGGER.debug("rsjNo = " + rsjNo);
		String message = "";
		
		/*
		 * //인증키값을 비교한다 //인증키가 일치한 경우 진행, 일치하지 않은 경우 redirect 처리 //인증키가 맞으면 서버의 인증키는
		 * 삭제한다. LOGGER.debug("authkey="+authkey); String chkkey = "123";
		 * 
		 * //if(cmmDAO.selectBranchList(corpCd).equals(authkey)) {
		 * if(chkkey.equals(authkey)) { message = "O.K"; }else { message =
		 * "팝업사용시 잘못된 접근입니다."; //오류화면으로 return redirectList(reda, message); }
		 * LOGGER.debug("message="+message);
		 */		
		
		LOGGER.debug("cr3210mVO="+cr3210mVO.toString());
		EgovMap map1 = new EgovMap();
		map1.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map1.put("rsNo", cr3210mVO.getRsNo());
		map1.put("rsjNo", cr3210mVO.getRsjNo());
		
		List<EgovMap> resultList = ech0205DAO.selectEch0205RsjUseList(map1);
		model.addAttribute("resultList", resultList);
		
		//연구대상자 신상정보 및 제품사용환경 
		cr3210mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//cr3210mVO.setRsNo(rsNo);
		//cr3210mVO.setRsjNo(rsjNo);		
		cr3210mVO = ech0205DAO.selectEch0205Rsj(cr3210mVO);
		
		Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		//연구대상자 설정
		searchVO.setSearchCondition1(cr3210mVO.getRsjNo());
		searchVO.setRsNo(cr3210mVO.getRsNo());
		
		//List<EgovMap> rsList = ecf0201DAO.selectEcf0201RsList(sessionVO);
		//model.addAttribute("rsList", rsList);
		
		if(!EgovStringUtil.isEmpty(searchVO.getRsNo())){
			EgovMap timeMap = ech0205DAO.selectEch0205Map(searchVO);
			
			if(timeMap != null){
				Calendar cal = Calendar.getInstance();
	
				Date chkStdt = getStringByDate((String) timeMap.get("chkStdt"));
				Date chkEndt = getStringByDate((String) timeMap.get("chkEndt"));
				List<EgovMap> timeList = new ArrayList<EgovMap>();
				
				cal.setTime(chkEndt);
				while(true) {
					EgovMap map = new EgovMap();
					map.put("chkDt", getDateByString(cal.getTime(), "1"));
					map.put("chkDt2", getDateByString(cal.getTime(), "2"));
					map.put("chkDtInt", getDateByInteger(cal.getTime()));

					timeList.add(map);
		             
		            // 현재 날짜가 시작일자보다 작으면 종료 
					cal.add(Calendar.DATE, -((int) timeMap.get("chkTrm")));
		            if(getDateByInteger(cal.getTime()) < getDateByInteger(chkStdt)){
		            	break;
		            }
		        }
				model.addAttribute("timeList", timeList);
				model.addAttribute("timeMap", timeMap);
				model.addAttribute("nowDate", EgovStringUtil.getDateMinus());
				model.addAttribute("nowDateInt", getDateByInteger(getStringByDate(EgovStringUtil.getDateMinus())));
				
				List<EgovMap> resultList2 = ech0205DAO.selectEch0205PopList(searchVO); 
				EgovMap resultMap = new EgovMap();
				for(EgovMap map : resultList2){
					resultMap.put((String) map.get("chkDt"), map);
					
				}
				model.addAttribute("resultMap", resultMap);
				model.addAttribute("resultList2", resultList2);
			}
		}
		
		model.addAttribute("cr3210mVO", cr3210mVO);
		
		return "/adm/ech0205/ech0205RsjUsePop";
	}	
	
	
	public static int getDateByInteger(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return Integer.parseInt(sdf.format(date));
	}
    
	public static String getDateByString(Date date, String type) {
		SimpleDateFormat sdf;
		if("1".equals(type)){
			sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
		}else{
			sdf = new SimpleDateFormat("yyyy-MM-dd");
		}
		return sdf.format(date);
	}
	

    
	public static Date getStringByDate(String date) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(date);
	}
	

	// 연구대상별 제품사용결과 팝업
	@RequestMapping("/qxsepmny/ech0205/ech0205RsjUseView1.do")
	public String ech0205RsjUseView1(String corpCd, String rsNo, String rsjNo, Cr3210mVO cr3210mVO, CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205RsjUsePop.do - 연구대상자별 제품사용결과 팝업");
		LOGGER.debug("corpCd = " + corpCd);
		LOGGER.debug("rsNo = " + rsNo);
		LOGGER.debug("rsjNo = " + rsjNo);
		
		EgovMap map1 = new EgovMap();
		
		map1.put("corpCd", corpCd);
		map1.put("rsNo", rsNo);
		map1.put("rsjNo", rsjNo);
		
		List<EgovMap> resultList = ech0205DAO.selectEch0205RsjUseList(map1);
		model.addAttribute("resultList", resultList);
		
		//연구대상자 신상정보 및 제품사용환경 
		cr3210mVO.setCorpCd(corpCd);
		cr3210mVO.setRsNo(rsNo);
		cr3210mVO.setRsjNo(rsjNo);		
		cr3210mVO = ech0205DAO.selectEch0205Rsj(cr3210mVO);
		
		Sb1000mVO sessionVO = (Sb1000mVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		//연구대상자 설정
		searchVO.setSearchCondition1(rsjNo);
		searchVO.setRsNo(rsNo);
		
		//List<EgovMap> rsList = ecf0201DAO.selectEcf0201RsList(sessionVO);
		//model.addAttribute("rsList", rsList);
		
		if(!EgovStringUtil.isEmpty(searchVO.getRsNo())){
			EgovMap timeMap = ech0205DAO.selectEch0205Map(searchVO);
			
			if(timeMap != null){
				Calendar cal = Calendar.getInstance();
	
				Date chkStdt = getStringByDate((String) timeMap.get("chkStdt"));
				Date chkEndt = getStringByDate((String) timeMap.get("chkEndt"));
				List<EgovMap> timeList = new ArrayList<EgovMap>();
				
				cal.setTime(chkEndt);
				while(true) {
					EgovMap map = new EgovMap();
					map.put("chkDt", getDateByString(cal.getTime(), "1"));
					map.put("chkDt2", getDateByString(cal.getTime(), "2"));
					map.put("chkDtInt", getDateByInteger(cal.getTime()));

					timeList.add(map);
		             
		            // 현재 날짜가 시작일자보다 작으면 종료 
					cal.add(Calendar.DATE, -((int) timeMap.get("chkTrm")));
		            if(getDateByInteger(cal.getTime()) < getDateByInteger(chkStdt)){
		            	break;
		            }
		        }
				model.addAttribute("timeList", timeList);
				model.addAttribute("timeMap", timeMap);
				model.addAttribute("nowDate", EgovStringUtil.getDateMinus());
				model.addAttribute("nowDateInt", getDateByInteger(getStringByDate(EgovStringUtil.getDateMinus())));
				
				List<EgovMap> resultList2 = ech0205DAO.selectEch0205PopList(searchVO); 
				EgovMap resultMap = new EgovMap();
				for(EgovMap map : resultList2){
					resultMap.put((String) map.get("chkDt"), map);
					
				}
				model.addAttribute("resultMap", resultMap);
				model.addAttribute("resultList2", resultList2);
			}
		}
		
		model.addAttribute("cr3210mVO", cr3210mVO);
		
		return "/adm/ech0205/ech0205RsjUsePop";
	}	

	@RequestMapping("/qxsepmny/ech0205/ech0205RsjUseView.do")
	public String ech0205RsjUseView(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, Cr3200mVO cr3200mVO, Cr3210mVO cr3210mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205RsjUseView.do - 연구대상자별 제품사용관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		String message = "";
		
		// 회사코드(CTMS운영) 설정
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		cr3200mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//연구과제 정보 
		rs1000mVO =  ech0205DAO.selectEch0205RsView(rs1000mVO);
		//연구대상자 신상정보 및 제품사용환경 
		cr3210mVO = ech0205DAO.selectEch0205Rsj(cr3210mVO);
		
		//연구대상자 제품사용정보 조회
		cr3200mVO =  ech0205DAO.selectEch0205View(cr3200mVO);
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", cr3210mVO.getRsNo());
		map.put("rsjNo", cr3210mVO.getRsjNo());
		
		List<EgovMap> resultList = ech0205DAO.selectEch0205RsjUseList(map);
		model.addAttribute("resultList", resultList);
		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("cr3200mVO", cr3200mVO);
		model.addAttribute("cr3210mVO", cr3210mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0205/ech0205RsjUseView";
	}	
	
	// 사용일정(연구대상자의) 일괄삭제
	@RequestMapping("/qxsepmny/ech0205/ech0205AjaxSaveDel.do")
	public View ech0205AjaxSaveDel(String corpCd, String rsNo, String rsjNo, String step1,String step2, String[] rsjSeq, Cr3210mVO cr3210mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0205/ech0205AjaxSaveDel.do - 사용일정 일괄삭제");
		String message = "";

		EgovMap map = new EgovMap();
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("rsjNo", rsjNo);
		
		LOGGER.debug("corpCd="+corpCd);
		LOGGER.debug("rsNo="+rsNo);
		LOGGER.debug("rsjNo="+rsjNo);
		
		for(int i=0;i<rsjSeq.length;i++) { // 일괄 삭제
			map.put("chkDt", rsjSeq[i]);
		    LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);			
			ech0205DAO.deleteEch0205AjaxChkDtDel(map);		    
		}
		
		//실사용횟수를 갱신한다 CR3240M -> CR3210M 
		cr3210mVO.setCorpCd(corpCd);
		cr3210mVO.setRsNo(rsNo);
		cr3210mVO.setRsjNo(rsjNo);
		ech0205DAO.updateEch0205ChkCnt(cr3210mVO);
		
		message = "선택하신 사용일정이 삭제되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	
	// 사용일정(연구대상자의) 일괄등록
	@RequestMapping("/qxsepmny/ech0205/ech0205AjaxSaveChkdt.do")
	public View ech0205AjaxSaveChkdt(String corpCd, String rsNo, String rsjNo, String chkTrm, String chkCnt, String chkStdt,String chkEndt, String[] rsjSeq, CmmnSearchVO searchVO, Cr3240mVO cr3240mVO, Cr3210mVO cr3210mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0205/ech0205AjaxSaveChkdt.do - 사용일정 일괄등록");
		String message = "";
		
		EgovMap map = new EgovMap();
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("rsjNo", rsjNo);
		
		//for(int i=0;i<rsjSeq.length;i++) { // 일괄 삭제
			//map.put("chkDt", rsjSeq[i]);
		    //LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);			
			//ech0205DAO.deleteEch0205AjaxChkDtDel(map);		    
		//}
		
		//연구대상자 설정
		searchVO.setCorpCd(corpCd);
		searchVO.setRsNo(rsNo);
		searchVO.setSearchCondition1(rsjNo);
		
		EgovMap timeMap = ech0205DAO.selectEch0205Map(searchVO);
		
		if(timeMap != null){//개인사용설정이 있는 경우  
			Calendar cal = Calendar.getInstance();
			
			Date cchkStdt = getStringByDate((String) timeMap.get("chkStdt"));
			Date cchkEndt = getStringByDate((String) timeMap.get("chkEndt"));

			List<EgovMap> timeList = new ArrayList<EgovMap>();
						
			cal.setTime(cchkStdt);
			while(true) {

				String c1 = getDateByString(cal.getTime(), "1");
				String c2 = getDateByString(cal.getTime(), "2");
				int c3 = getDateByInteger(cal.getTime());
	            
				//사용내역에 해당일자 없으면 새로 등록한다.
				cr3240mVO.setCorpCd(corpCd);
				cr3240mVO.setRsNo(rsNo);
				cr3240mVO.setRsjNo(rsjNo);
				cr3240mVO.setChkDt(c2);
				int chkDtCnt = ech0205DAO.selectEch0205ChkDtCnt(cr3240mVO);
				if(chkDtCnt == 0) {//
					//새로 등록한다.
					int useCnt = (int) timeMap.get("chkCnt");
					cr3240mVO.setChkCnt(Integer.toString(useCnt));
			        switch (useCnt) {
			            case 1:
			            	cr3240mVO.setChk1("Y");
			            	//cr3240mVO.setChk1Dt("");
			            	cr3240mVO.setChk2("");
			            	cr3240mVO.setChk3("");
			            	cr3240mVO.setChk4("");
			            	cr3240mVO.setChk5("");
			                break;
			            case 2:
			            	cr3240mVO.setChk1("Y");
			            	//cr3240mVO.setChk1Dt(c2);
			            	cr3240mVO.setChk2("Y");
			            	//cr3240mVO.setChk2Dt(c2);
			            	cr3240mVO.setChk3("");
			            	cr3240mVO.setChk4("");
			            	cr3240mVO.setChk5("");
			                break;
			            case 3:
			            	cr3240mVO.setChk1("Y");
			            	//cr3240mVO.setChk1Dt("");
			            	cr3240mVO.setChk2("Y");
			            	//cr3240mVO.setChk2Dt("");
			            	cr3240mVO.setChk3("Y");
			            	//cr3240mVO.setChk3Dt("");
			            	cr3240mVO.setChk4("");
			            	cr3240mVO.setChk5("");
			            	break;
			            case 4:
			            	cr3240mVO.setChk1("Y");
			            	//cr3240mVO.setChk1Dt("");
			            	cr3240mVO.setChk2("Y");
			            	//cr3240mVO.setChk2Dt("");
			            	cr3240mVO.setChk3("Y");
			            	//cr3240mVO.setChk3Dt("");
			            	cr3240mVO.setChk4("Y");
			            	//cr3240mVO.setChk4Dt("");
			            	cr3240mVO.setChk5("");
			                break;
			            case 5:
			            	cr3240mVO.setChk1("Y");
			            	//cr3240mVO.setChk1Dt("");
			            	cr3240mVO.setChk2("Y");
			            	//cr3240mVO.setChk2Dt("");
			            	cr3240mVO.setChk2("Y");
			            	//cr3240mVO.setChk2Dt("");
			            	cr3240mVO.setChk3("Y");
			            	//cr3240mVO.setChk3Dt("");
			            	cr3240mVO.setChk4("Y");
			            	//cr3240mVO.setChk4Dt("");
			            	cr3240mVO.setChk5("Y");
			            	//cr3240mVO.setChk5Dt("");
			                break;
			            default: 
			            	cr3240mVO.setChk1("Y");
			            	//cr3240mVO.setChk1Dt("");
			            	cr3240mVO.setChkCnt("1");
			            	break;
			        }
			        cr3240mVO.setRemk("");
			        cr3240mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
			        ech0205DAO.insertEch0205ChkDt(cr3240mVO);
				}
				
	            // 현재 날짜가 시작일자보다 작으면 종료 
				cal.add(Calendar.DATE, +((int) timeMap.get("chkTrm")));
				
	            if(getDateByInteger(cal.getTime()) > getDateByInteger(cchkEndt)){
	            	break;
	            }
	        }
		}else {
			message = "먼저 개인 사용정보를 설정해주세요.";
			model.addAttribute("message", message);
			
			return jsonView;
		}
		
		//실사용횟수를 갱신한다 CR3240M -> CR3210M 
		cr3210mVO.setCorpCd(corpCd);
		cr3210mVO.setRsNo(rsNo);
		cr3210mVO.setRsjNo(rsjNo);
		ech0205DAO.updateEch0205ChkCnt(cr3210mVO);	
		
		message = "일괄 사용처리 되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 사용내역관리 팝업
	@RequestMapping("/qxsepmny/ech0205/ech0205ChkmgPop.do")
	public String ech0205ChkmgPop(String corpCd, String rsNo, String rsjNo, String chkDt, Cr3240mVO cr3240mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205ChkmgPop.do - 연구대상자별 사용내역관리");
		//세션 호출
	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		cr3240mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//연구대상자  사용내역 정보 설정
		cr3240mVO.setRsNo(rsNo);
		cr3240mVO.setRsjNo(rsjNo);
		cr3240mVO.setChkDt(chkDt);
		
		cr3240mVO = ech0205DAO.selectEch0205ChkmgView(cr3240mVO);
		
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("cr3240mVO", cr3240mVO);				

		return "/adm/ech0205/ech0205ChkmgPop";
		
	}
	
	// 연구대상자 사용내역 수정 
	@RequestMapping("/qxsepmny/ech0205/ech0205AjaxSaveChkmg.do")
	public View ech0205AjaxSaveChkmg(String corpCd,String rsNo, String rsjNo, String chkDt, String chkCnt, String chk1, String chk2, String chk3, String chk4, String chk5, String chk1Dt, String chk2Dt, String chk3Dt, String chk4Dt, String chk5Dt, String remk, Cr3210mVO cr3210mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0205/ech0205AjaxSaveChkmg.do - 사용내역 수정");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		// 회사코드 설정 
		map.put("corpCd",EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", rsNo);
		map.put("rsjNo", rsjNo);
		map.put("chkDt", chkDt);
		map.put("chkCnt", chkCnt);
		map.put("chk1", chk1);
		map.put("chk2", chk2);
		map.put("chk3", chk3);
		map.put("chk4", chk4);
		map.put("chk5", chk5);
		map.put("chk1Dt", chk1Dt);
		map.put("chk2Dt", chk2Dt);
		map.put("chk3Dt", chk3Dt);
		map.put("chk4Dt", chk4Dt);
		map.put("chk5Dt", chk5Dt);
		map.put("remk", remk);
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//사용내역 수정
		ech0205DAO.updateEch0205AjaxSaveChkmg(map);
		
		//실사용횟수를 갱신한다 CR3240M -> CR3210M 
		cr3210mVO.setCorpCd(corpCd);
		cr3210mVO.setRsNo(rsNo);
		cr3210mVO.setRsjNo(rsjNo);
		ech0205DAO.updateEch0205ChkCnt(cr3210mVO);
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	

	// 연구대상자별 제품사용내역 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0205/ech0205RsjUseExcel.do")
	public void ech0205RsjUseExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205RsjUseExcel.do - 연구대상자 제품사용내역 목록 엑셀 다운로드");
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0205DAO.selectEch0205RsjUseExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "연구대상자 제품사용 리스트", "ech0205RsjUse", request, response);
	}
	
	// ********************************(기준정보관리) 20201128 관리자 제품사용관리 연구대상자 수정 화면(등록 일괄등록)********************************
	@RequestMapping("/qxsepmny/ech0205/ech0205RsjUseModify.do")
	public String ech0205RsjUseModify(@ModelAttribute("cr3210mVO") Cr3210mVO cr3210mVO, Rs1000mVO rs1000mVO, String rsNo, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205RsjUseModify.do - 관리자 제품사용관리 연구대상자 수정 화면(등록 일괄등록)");
		
		//세션 호출
	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
		
		// 회사코드(CTMS운영) 설정
		cr3210mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		rs1000mVO =  ech0205DAO.selectEch0205RsView(rs1000mVO);
		cr3210mVO = ech0205DAO.selectEch0205RsjUseView(cr3210mVO);
					
		model.addAttribute("NotiPageGubun","NotiUpdate");		
		model.addAttribute("cr3210mVO", cr3210mVO);
		model.addAttribute("rs1000mVO", rs1000mVO);
		
		return "/adm/ech0205/ech0205RsjUseModify";
	}

	// ********************************(기준정보관리) 관리자 연구대상자 제품사용관리 수정 ********************************
	@RequestMapping("/qxsepmny/ech0205/ech0205RsjUseUpdate.do")
	public String ech0205RsjUseSave(@ModelAttribute("cr3210mVO") Cr3210mVO cr3210mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0205/ech0205RsjUseUpdate.do - 관리자 연구대상자 제품사용관리 수정");
		String message = "";
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
		
		// 회사코드(CTMS운영) 설정
		cr3210mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());		
		// 등록수정자 설정
		cr3210mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		ech0205DAO.updateEch0205Rsjuse(cr3210mVO);
		
		message = "수정이 완료되었습니다.";			
	
		return redirectList(reda, message);

	}
	
	
}
