package ctms.adm.ech0102;

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
import component.sms.SmsSendUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rm2000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class Ech0102Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0102Controller.class);
	@Autowired private Ech0102DAO ech0102DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//피험자선정 목록화면으로 리다이렉트합니다.
	private String redirectEch0102List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0102/ech0102List.do";
	}
	
	/**
	 * 피험자선정 목록
	 * 
	 * @param model
	 * @return 피험자선정 목록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0102/ech0102List.do")
	public String admEch0102List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102List.do -  피험자선정 목록");
		//request.getSession().setAttribute("usrMenuNo", "101");
		
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
		List<EgovMap> yearRsCdList = cmmDAO.selectCmmYearRsCdList2(map);
		
		model.addAttribute("yearRsCdList", yearRsCdList);
		
		//임상분류(공통코드) 목록 searchCondition5
		List<EgovMap> ct2030 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2030");
		model.addAttribute("ct2030", ct2030);
		
		//연구상태(공통코드) 목록 searchCondition5
		List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2050");
		model.addAttribute("ct2050", ct2050);
		
		//-- 검색항목 설정 끝
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0102DAO.selectEch0102List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		

		return "/adm/ech0102/ech0102List";
	}

	/**
	 * 피험자선정 조회
	 * 
	 * @param model
	 * @return 피험자선정 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0102/ech0102View.do")
	public String admEch0102View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102View.do -  피험자선정 조회");
		
		LOGGER.debug("rs1010mVO="+rs1010mVO.toString());
		//RS1000M -> RS1010M으로 변경하여 조회한다.
		rs1010mVO =  ech0102DAO.selectEch0102RsView(rs1010mVO);
		
		if(!EgovStringUtil.isEmpty(rs1010mVO.getRsNo())){
			
			//연구대상자(피험자)선정 목록 조회
			searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			//RS_NO에 RS_CD(공통연구코드)를 설정
			searchVO.setRsNo(rs1010mVO.getRsNo());

			CmmnListVO listVO = ech0102DAO.selectEch0102RsjList(searchVO);
			
			model.addAttribute("rs1010mVO", rs1010mVO);
			model.addAttribute("resultList", listVO.getEgovList());
			model.addAttribute("pageIndex", searchVO.getPageIndex());
			EgovMap paramMap = new EgovMap();        
	        EgovMap resultMap = new EgovMap();

	        for(EgovMap map1 : listVO.getEgovList()){
	        	String mapKey = (String) map1.get("rsNo")+map1.get("rsjNo");
	        	LOGGER.debug("String mapKey="+mapKey);
	        	String mapKey2 = (String) map1.get("mapkey");
	        	LOGGER.debug("map1 mapKey="+ mapKey2);
	        	paramMap.put("corpCd", map1.get("corpCd"));
	           	paramMap.put("rsNo", map1.get("rsNo"));
	           	paramMap.put("rsjNo", map1.get("rsjNo"));
	            List<EgovMap> mtList = ech0102DAO.selectEch0102MtScrList(paramMap);
	            resultMap.put(mapKey, mtList);
	        }
	        LOGGER.debug("resultMap"+resultMap.toString());
	        model.addAttribute("mtList", resultMap);

		}else{
			String message = "존재하지 않는 연구과제입니다.";
			return redirectEch0102List(reda, message);
		}
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO1="+searchVO.toString());
		
		return "/adm/ech0102/ech0102View";
	}

	@RequestMapping("/qxsepmny/ech0102/ech0102View2.do")
	public String admEch0102View2(@ModelAttribute("searchVO") CmmnSearchVO searchVO, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, String setVal, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {		
		LOGGER.debug("/qxsepmny/ech0102/ech0102View2.do -  피험자선정 조회");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		LOGGER.debug("rs1010mVO="+rs1010mVO.toString());
		rs1010mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		rs1010mVO =  ech0102DAO.selectEch0102RsView(rs1010mVO);
		
		if(!EgovStringUtil.isEmpty(rs1010mVO.getRsNo())){
			//연구대상자(피험자)선정 목록 조회
			searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			searchVO.setRsNo(rs1010mVO.getRsNo());
			//setVal 1: 전체, 2:지원자, 3:풀선별, 4:1차선정, 5:스크리닝, 6:피험자확정
			switch (setVal) 
			{ 
				case "2": 	
					searchVO.setAppYn("Y");
					searchVO.setPoolYn("");
					searchVO.setFirstSt("");
					searchVO.setCfmYn("");
					searchVO.setSearchType("");
					break;
				case "3":
					searchVO.setAppYn("");
					searchVO.setPoolYn("Y");
					searchVO.setFirstSt("");
					searchVO.setCfmYn("");
					searchVO.setSearchType("");
					break;
				case "4":
					searchVO.setAppYn("");
					searchVO.setPoolYn("");
					searchVO.setFirstSt("Y");
					searchVO.setCfmYn("");
					searchVO.setSearchType("");
					break;
				case "5":
					searchVO.setAppYn("");
					searchVO.setPoolYn("");
					searchVO.setFirstSt("Y");
					searchVO.setCfmYn("");
					searchVO.setSearchType("Y");
					break;
				case "6":
					searchVO.setAppYn("");
					searchVO.setPoolYn("");
					searchVO.setFirstSt("");
					searchVO.setCfmYn("Y");
					searchVO.setSearchType("");
					break;	
			 	default :
			 		searchVO.setAppYn("Y");
					searchVO.setPoolYn("");
					searchVO.setFirstSt("");
					searchVO.setCfmYn("");
					searchVO.setSearchType("");
			}
			
			// 탭구분 설정
			searchVO.setSetVal(setVal);
			
			CmmnListVO listVO = ech0102DAO.selectEch0102RsjList2(searchVO);
			
			//관리자 권한인지 여부 설정 isAdminType
			rs1000mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
			
			//해당 연구과제의 연구책임자 Y 
			if(rs1000mVO.getRsDrt().equals(adminVO.getEmpNo())) {
				rs1000mVO.setIsRsDrt("Y");
			}else {
				rs1000mVO.setIsRsDrt("N");
			}
			
			//연구담당자인지 확인 CORP, RS_NO, EMP_NO
			EgovMap map = new EgovMap();
			map.put("corpCd", rs1000mVO.getCorpCd());
			map.put("rsNo", rs1000mVO.getRsNo());
			map.put("empNo", adminVO.getEmpNo());
			int chk1 = cmmDAO.selectRsControlCnt(map);
			if(chk1 > 0) {
				rs1000mVO.setIsRsStaff("Y");
			}else {
				rs1000mVO.setIsRsStaff("N");
			}
			
			//해당 연구과제가 삭제가능한지 설정 isDelControl Y 삭제가능   N 삭제불가능 - 피험자가 있는 경우 - 삭제에서 처리가능함
			int chk2 = cmmDAO.selectRsDelControlCnt(map);
			if(chk2 > 0) {
				rs1000mVO.setIsDelCntr("N");
			}else {
				rs1000mVO.setIsDelCntr("Y");
			}
			
	        EgovMap paramMap = new EgovMap();        
	        EgovMap resultMap = new EgovMap();
	        for(EgovMap map1 : listVO.getEgovList()){
	        	String mapKey = (String) map1.get("rsNo")+map1.get("rsjNo");
	        	LOGGER.debug("String mapKey="+mapKey);
	        	LOGGER.debug("map1 mapKey="+(String) map1.get("mapKey"));
	        	paramMap.put("corpCd", map1.get("corpCd"));
	           	paramMap.put("rsNo", map1.get("rsNo"));
	           	paramMap.put("rsjNo", map1.get("rsjNo"));
	            List<EgovMap> mtList = ech0102DAO.selectEch0102MtScrList(paramMap);
	            resultMap.put(mapKey, mtList);
	        }
	        model.addAttribute("mtList", resultMap);
			
			model.addAttribute("rs1010mVO", rs1010mVO);
			model.addAttribute("resultList", listVO.getEgovList());			
			model.addAttribute("pageIndex", searchVO.getPageIndex());	
		}else{
			String message = "존재하지 않는 연구과제입니다.";
			return redirectEch0102List(reda, message);
		}
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO2="+searchVO.toString());
		
		return "/adm/ech0102/ech0102ViewTab";
	}
	
	
	/**
	 * 피험자선정 수정&등록화면
	 * 
	 * @param model
	 * @return 피험자선정 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0102/ech0102Modify.do")
	public String admEch0102Modify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rsNo, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102Modify.do -  피험자선정 수정&등록화면");
		LOGGER.debug("rsNo = " + rsNo);
		
		Rs1000mVO resultVO = new Rs1000mVO();
		
		if(!EgovStringUtil.isEmpty(resultVO.getRsNo())){
			//resultVO = ech0102DAO.selectEch0102View(resultVO);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", resultVO.getRsNo());
			map.put("boardType", "RESE");
			
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);

			EgovMap attachMap = new EgovMap();
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			model.addAttribute("attachMap", attachMap);
		}
		
		model.addAttribute("rs1000mVO", resultVO);
		
		return "/adm/ech0102/ech0102Modify";
	}
	
	/**
	 * 피험자선정 수정&등록
	 * 
	 * @param model
	 * @return 피험자선정 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0102/ech0102Update.do")
	public String admEch0102Update(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO, Rs2000mVO rs2000mVO, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102Update.do -  피험자선정 수정&등록");
		LOGGER.debug("rs1000mVO = " + rs1000mVO.toString());
		String message = "";
		
		if(EgovStringUtil.isEmpty(rs2000mVO.getRsNo())){
			String rsNo = ech0102DAO.insertEch0102(rs2000mVO);
			rs2000mVO.setRsNo(rsNo);
			message = "등록이 완료되었습니다.";
		}else{
			ech0102DAO.updateEch0102(rs2000mVO);
			message = "수정이 완료되었습니다.";
			
			if(delFile != null){
				for(String seq : delFile){
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "RESE");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("RESE");
				attachVO.setBoardNo(rs1000mVO.getRsNo());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectEch0102List(reda, message);
	}
	
	/**
	 * 피험자선정 삭제
	 * 
	 * @param model
	 * @return 피험자선정 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0102/ech0102Delete.do")
	public String admEch0102Delete(@ModelAttribute("rs1000mVO") Rs2000mVO rs2000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102Delete.do -  피험자선정 삭제");
		String message = "존재하지 않는 피험자입니다.";
		
//		if(!EgovStringUtil.isEmpty(rs2000mVO.getRsNo())){
//			
//			int chk = ech0102DAO.deleteEch0102(rs2000mVO.getRsNo());
//			
//			if(chk > 0){
//				EgovMap map = new EgovMap();
//				//map.put("boardSeq", rs1000mVO.getRsNo());
//				map.put("boardType", "RESE");
//				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
//				
//				for(Ct7000mVO attachVO : attachList){
//					cmmDAO.deleteAttachFile(attachVO.getAttachNo());
//					fileUtil.deleteFile(attachVO.getRegFileName());
//				}
//				
//				message = "해당 피험자의 삭제가 완료되었습니다.";
//			}
//		}
		
		return redirectEch0102List(reda, message);
	}
	
	// 피험자선정 목록 엑셀다운로드 	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0102/ech0102Excel.do")
	public void ech0102Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/ech0102Excel.do - 피험자선정 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0102DAO.selectEch0102Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "피험자선정 리스트", "ech0102", request, response);
	}
	
	// 피험자선정-스크리닝대상자엑셀 다운로드 	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0102/ech0102ExcelScrList.do")
	public void ech0102ExcelScrList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String setVal, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/ech0102ExcelScrList.do - 피험자선정-스크리닝대상자엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		switch (setVal) 
		{ 
			case "2": 	
				searchVO.setAppYn("Y");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("");
				searchVO.setCfmYn("");
				break;
			case "3":
				searchVO.setAppYn("");
				searchVO.setPoolYn("Y");
				searchVO.setFirstSt("");
				searchVO.setCfmYn("");
				break;
			case "4":
				searchVO.setAppYn("");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("Y");
				searchVO.setCfmYn("");
				break;
			case "5":
				searchVO.setAppYn("");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("Y");
				searchVO.setCfmYn("");
				break;
			case "6":
				searchVO.setAppYn("");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("");
				searchVO.setCfmYn("Y");
				break;	
		 	default :
		 		searchVO.setAppYn("Y");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("");
				searchVO.setCfmYn("");
		}
		
		// 탭구분 설정
		searchVO.setSetVal(setVal);

		EgovMap dataMap = new EgovMap();
		List<EgovMap> resultList = ech0102DAO.selectEch0102ExcelScrList(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "피험자선정-스크리닝대상자 리스트", "ech0102ScrList", request, response);
	}
	
	// 피험자선정-확정자명단 엑셀 다운로드 	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0102/ech0102ExcelCfmList.do")
	public void ech0102ExcelCfmList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String setVal, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/ech0102ExcelCfmList.do - 피험자선정-확정자명단 엑셀 다운로드");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		switch (setVal) 
		{ 
			case "2": 	
				searchVO.setAppYn("Y");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("");
				searchVO.setCfmYn("");
				break;
			case "3":
				searchVO.setAppYn("");
				searchVO.setPoolYn("Y");
				searchVO.setFirstSt("");
				searchVO.setCfmYn("");
				break;
			case "4":
				searchVO.setAppYn("");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("Y");
				searchVO.setCfmYn("");
				break;
			case "5":
				searchVO.setAppYn("");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("Y");
				searchVO.setCfmYn("");
				break;
			case "6":
				searchVO.setAppYn("");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("");
				searchVO.setCfmYn("Y");
				break;	
		 	default :
		 		searchVO.setAppYn("Y");
				searchVO.setPoolYn("");
				searchVO.setFirstSt("");
				searchVO.setCfmYn("");
		}
		
		// 탭구분 설정
		searchVO.setSetVal(setVal);

		//관리자 권한인지 여부 설정 isAdminType
		String adminType 	= adminVO.getAdminType();
		String isRsDrt 		= "";
		String isRsStaff 	= "";
		
		EgovMap chkmap = new EgovMap();
		//해당 연구과제의 연구책임자 Y
		chkmap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		chkmap.put("rsNo", searchVO.getRsNo() );
		chkmap.put("rsDrt", EgovUserDetailsHelper.getAuthenticatedAdminEmpNo() );
		int chkcnt = ech0102DAO.selectEch0102RsDrtCnt(chkmap);
		if(chkcnt > 0) { 
			isRsDrt = "Y";
		}else {
			isRsDrt = "N";
		}
		LOGGER.debug("isRsDrt="+isRsDrt);
		
		//연구담당자인지 확인 CORP, RS_NO, EMP_NO
		chkmap.put("empNo", adminVO.getEmpNo());
		int chk1 = cmmDAO.selectRsControlCnt2(chkmap);
		if(chk1 > 0) {
			isRsStaff = "Y";
		}else {
			isRsStaff = "N";
		}
		LOGGER.debug("isRsStaff="+isRsStaff);
		
		EgovMap dataMap = new EgovMap();
		List<EgovMap> resultList = ech0102DAO.selectEch0102ExcelCfmList(searchVO);
		
		dataMap.put("resultList", resultList);

		int num = 1;
		String rsCd = "";
		String vendName = "";
		String infotype1 = "";
		String infotype2 = "";
		for (EgovMap egovMap : resultList) {
			
			//주민번호 decode
			if (!EgovStringUtil.isEmpty(egovMap.get("jregNo").toString())) {
				egovMap.put("jregNo", EgovFileScrty.decode(egovMap.get("jregNo").toString()));
				infotype1 = "주민등록번호포함";
			}
			//계좌번호 decode
			if (!EgovStringUtil.isEmpty(egovMap.get("acctNo").toString())) {
				infotype2 = "계좌번호포함";
				egovMap.put("acctNo", EgovFileScrty.decode(egovMap.get("acctNo").toString()));
			}
			//관리자권한,연구과제 책임자, 담당자만 주민번호, 계좌번호 표시
			if(adminType.equals("2")) {
				if(isRsDrt.equals("N")) {
					if(isRsStaff.equals("N")) {
						egovMap.put("jregNo", "주민등록번호보호");
						egovMap.put("acctNo", "계좌번호보호");
					}
				}
			}
			if (!EgovStringUtil.isEmpty(egovMap.get("rsCd").toString())) {
				rsCd = egovMap.get("rsCd").toString();
				vendName = egovMap.get("vendName").toString();
			}
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "피험자선정-피험자확정 리스트", "ech0102CfmList", request, response);
		
		//개인정보처리 로그 등록 
		String tmpLogCont = "피험자확정 > 피험자확정 명단 엑셀다운로드 "+infotype1+" "+infotype2+" 연구과제:"+rsCd;
		tmpLogCont = tmpLogCont + ", 고객사:"+vendName; 
		admLogInsert(tmpLogCont, "엑셀다운로드", "검색조건", request);
		
	}
	
	// 연구대상자 최종확정 일괄수정
	@RequestMapping("/qxsepmny/ech0102/ech0102AjaxSaveCfm.do")
	public View ech0102AjaxSaveCfm(String corpCd,String rsNo, String step1,String step2, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveCfm.do - 관리자 연구대상자 최종확정 일괄등록");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("step1", step1);
		map.put("step2", step2);
		map.put("rsjSeq", rsjSeq);
		map.put("dataRegnt", "aid");
		
		//연구대상자의 최종확정을 동시에 일괄등록된다.
		ech0102DAO.updateEch0102AjaxSaveCfm(map);
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 연구대상자 1차선정 일괄수정
	@RequestMapping("/qxsepmny/ech0102/ech0102AjaxSaveFirst.do")
	public View ech0102AjaxSaveFirst(String corpCd,String rsNo, String step1,String step2, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveFirst.do - 관리자 연구대상자 1차선정 일괄등록");
		String message = "";
		boolean status = false;
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("step1", step1);
		map.put("step2", step2);
		map.put("rsjSeq", rsjSeq);
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//연구대상자의 1차선정(스크리닝대상자)을 동시에 일괄등록된다.		
		ech0102DAO.updateEch0102AjaxSaveFirst(map);
		
		//스크리닝번호를 부여한다.
		List<Rs2000mVO> resultList = ech0102DAO.selectEch0102StNoBat(map);
		
		if(resultList.size() != 0){
			for(Rs2000mVO rs2000mVO : resultList){
				if(EgovStringUtil.isEmpty(rs2000mVO.getFirstStNo())){
					
					//동일 RS_NO내에서 FIRST_ST_NO 순번으로 일련번호를 산출한다.
					String totCnt = ech0102DAO.selectEch0102StNoCnt(rs2000mVO);
										
					//스크리닝번호를 설정
					rs2000mVO.setFirstStNo(totCnt);
					LOGGER.debug("getFirstStNo()="+rs2000mVO.getFirstStNo());
					
					ech0102DAO.updateEch0102StNo(rs2000mVO);
					
					message = "스크리닝대상자로 확정되었습니다.";
					status = true;
				}
			}
		}else{
			message = "스크리닝대상자로 확정할 연구대상자가 없습니다.";
			status = false;
		}

		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 연구대상자 선정 일괄삭제
	@RequestMapping("/qxsepmny/ech0102/ech0102AjaxSaveDel.do")
	public View ech0102AjaxSaveDel(String corpCd,String rsNo, String step1,String step2, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveDel.do - 관리자 연구대상자 선정정보 일괄삭제");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("step1", step1);
		map.put("step2", step2);
		map.put("rsjSeq", rsjSeq);
		
		//연구대상자의 1차선정을 동시에 일괄등록된다.
		ech0102DAO.updateEch0102AjaxSaveDel(map);
		
		message = "삭제되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 연구대상자 식별번호 일괄 부여 Ajax
	@RequestMapping("/qxsepmny/ech0102/ech0102AjaxRsiCodeBat.do")
	public View ech0102AjaxRsiCodeBat(String corpCd, String rsNo, String rsCd, String step1, String step2, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxRsiCodeBat.do - 연구대상자 식별번호 일괄등록 Ajax");
		String message = "";
		boolean status = false;
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", rsNo);
		map.put("rsjSeq", rsjSeq);
		
		List<Rs2000mVO> resultList = ech0102DAO.selectEch0102RsiCodeBat(map);
		
		if(resultList.size() != 0){
			for(Rs2000mVO rs2000mVO : resultList){
				if(EgovStringUtil.isEmpty(rs2000mVO.getRsiNo())){
					
					//동일 RS_NO내에서 rsi_no3 순번으로 일련번호를 산출한다.
					String totCnt = ech0102DAO.selectEch0102RsiCodeCnt(rs2000mVO);
										
					//식별번호를 설정
					rs2000mVO.setRsiNo3(totCnt);
					//공통연구코드5+6+식별번호순번으로 설정
					rs2000mVO.setRsiNo(rs2000mVO.getRsiNo1()+'-'+totCnt);
					
					//연구대상자선정 테이블 업데이트(식별번호) 
					ech0102DAO.updateEch0102RsiCode(rs2000mVO);
					
					//RS2000M을 연구번호별 등록한다. - 추가해야 함
					EgovMap map2 = new EgovMap();
					map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
					map2.put("rsCd", rs2000mVO.getRsCd());
					List<Rs1000mVO> resultList2 = ech0102DAO.selectEch0102RsList(map2);
					if(resultList2.size() != 0){
						//RS2010M 를 읽는다.
						rs2000mVO = ech0102DAO.selectEch0102(rs2000mVO);
						
						for(Rs1000mVO rs1000mVO : resultList2){
							rs2000mVO.setRsNo(rs1000mVO.getRsNo());
							rs2000mVO.setRsiNo2(rs1000mVO.getRsNo7());
							rs2000mVO.setRsiNo(rs2000mVO.getRsiNo1()+'-'+rs1000mVO.getRsNo7()+'-'+rs2000mVO.getRsiNo3());
							//연구대상자번호, 참여상태, 스크리닝번호 설정 
							
							String rsNo2 = ech0102DAO.insertEch0102(rs2000mVO);
							LOGGER.debug("rsNo2= "+rsNo2); 
						}
					}	
					
					message = "식별번호가 일괄등록이 완료되었습니다.";
					status = true;
				}
			}
		}else{
			message = "식별번호를 등록 할 연구대상자가 없습니다.";
			status = false;
		}
		
		//연구과제의 피험자수를 업데이트한다  RS1000M RS_SCNT
		ech0102DAO.updateEch0102RsScnt(map);
		ech0102DAO.updateEch0102RsScnt2(map);
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		return jsonView;
	}
	
	
	// 연구대상자선정 목록화면 리다이렉트
	private String redirectList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0102/ech0102List.do";
	}
	

	
	// 연구대상자선정 최종확정 목록 리다이렉트
	private String redirectTab(RedirectAttributes reda, String message, boolean status){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("status", status);
		return "redirect:/qxsepmny/ech0102/ech0102View2.do";
	}

	// 일괄스크리닝예약관리 팝업
	@RequestMapping("/qxsepmny/ech0102/ech0102ScrMtmgAllPop.do")
	public String ech0102ScrMtmgAllPop(String corpCd, String rsNo, String resrNo,  String[] rsjSeq, Rs4000mVO rs4000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102ScrMtmgAllPop.do - 연구대상자별 일괄스크리닝예약관리");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		rs4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rs4000mVO.setRsNo(rsNo);
	
		LOGGER.debug("corpCd="+corpCd);
		LOGGER.debug("rsNo="+rsNo);
		//대상자 목록을 표시한다.
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", rsNo);
		map.put("rsjSeq", rsjSeq);
		
		List<EgovMap> resultList = ech0102DAO.selectEch0102SendList(map);
		
		
		model.addAttribute("resultList", resultList);
		
		model.addAttribute("adminVO", adminVO);
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("rs4000mVO", rs4000mVO);
		
		return "/adm/ech0102/ech0102ScrMtmgAllPop";
		
	}
	
	// 일괄스크리닝예약등록 
	@RequestMapping("/qxsepmny/ech0102/ech0102AjaxSaveAllScr.do")
	public View ech0102AjaxSaveAllScr(String corpCd,String rsNo, String resrDt, String resrHr, String resrMm, String mtSt, String mtCnt, String resrNo, String regDt, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveAllScr.do - 일괄스크리닝예약등록");
		String message = "";
		
		LOGGER.debug("corpCd="+corpCd);
		LOGGER.debug("rsNo="+rsNo);
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("resrDt", resrDt);
		map.put("resrHr", resrHr);
		map.put("resrMm", resrMm);
		map.put("mtSt", mtSt);
		map.put("mtCnt", mtCnt);
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		map.put("regDt", regDt);
		map.put("scrYn", "Y"); //스크린예약여부
		map.put("rsNo", rsNo);
		
		String trsNo = "";
		String trsjNo = "";
		
		for(int i=0;i<rsjSeq.length;i++) {
		    //trsNo = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리
			//trsjNo = rsjSeq[i].substring(8, 16); // 연구대상자번호 8자리
			trsjNo = rsjSeq[i].toString();

		    map.put("rsjNo", trsjNo);
		    
		    LOGGER.debug("rsjSeq[i]="+rsjSeq[i]);
		    ech0102DAO.insertEch0102AjaxSaveScr(map);		
		}

		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}

	// 에약관리 팝업
	@RequestMapping("/qxsepmny/ech0102/ech0102ScrMtmgPop.do")
	public String ech0102ScrMtmgPop(String corpCd, String resrNo,  Rs4000mVO rs4000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102ScrMtmgPop.do - 연구대상자별 스크리인 예약관리");
		//세션 호출
	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		rs4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//연구대상자 예약번호 설정
		rs4000mVO.setResrNo(resrNo);
		
		//resrNo 값이 없으면 등록화면 있으면 수정화면을 표시 
		//등록화면으로
	 	if (EgovStringUtil.isEmpty(rs4000mVO.getResrNo())) {
			
			//model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rs4000mVO.getResrNo())){

				rs4000mVO = ech0102DAO.selectEch0102MtView(rs4000mVO);
							
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("rs4000mVO", rs4000mVO);				
		}
			
		return "/adm/ech0102/ech0102ScrMtmgPop";
		
	}

	// 일괄SMS발송 팝업
	@RequestMapping("/qxsepmny/ech0102/ech0102SmsAllPop.do")
	public String ech0102SmsAllPop(String corpCd, String rsNo, String resrNo,  String[] rsjSeq, Rm2000mVO rm2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102SmsAllPop.do - 피험자선정 일괄SMS발송");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		rm2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	
		//대상자 목록을 표시한다.
		String[] trsjSeq = new String[rsjSeq.length];
		String[] trsSeq = new String[rsjSeq.length];
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//for(int i=0;i<rsjSeq.length;i++) {
			//trsSeq[i] = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리;
			//trsjSeq[i] = rsjSeq[i].substring(8, 16); // 연구대상자번호 8자리;
		    //LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);
		//}
		
		map.put("rsjSeq", rsjSeq);
		map.put("rsNo", rsNo);
		LOGGER.debug("corpCd="+corpCd);
		LOGGER.debug("rsNo="+rsNo);
		map.put("rsSeq", trsSeq);

		List<EgovMap> resultList = ech0102DAO.selectEch0102SmsSendList(map);
		
		//SMS예시 문항 목록을 구성한다.
		List<EgovMap> smsList = cmmDAO.selectSmsSplList(map);
		
		model.addAttribute("smsList", smsList);
		model.addAttribute("resultList", resultList);
		rm2000mVO.setRecsDt(EgovStringUtil.getDateMinus());
		model.addAttribute("adminVO", adminVO);
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("rm2000mVO", rm2000mVO);
		
		return "/adm/cmm/admSmsAllPop";
		
	}	
	
	
	// 예약SMS발송 팝업
	@RequestMapping("/qxsepmny/ech0102/ech0102SmsMtPop.do")
	public String ech0102SmsMtPop(String corpCd, String rsNo, String resrNo,  String[] rsjSeq, Rm2000mVO rm2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102SmsMtPop - 연구대상자별 예약SMS발송");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//대상자 목록을 표시한다.
		String trsSeq = "";
		String trsjSeq = "";
		LOGGER.debug("rsjSeq.length="+rsjSeq.length);
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", rsNo);
		map.put("rsjSeq", rsjSeq);
		for(int i=0;i<rsjSeq.length;i++) {
			//LOGGER.debug("rsjSeq["+i+"]"+rsjSeq[i]);
			//trsSeq = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리;
			trsjSeq = rsjSeq[i]; // 피험자선정순번
		}
		
		List<EgovMap> resultList = ech0102DAO.selectEch0102SendSmsMtList(map);
		
		//SMS예시 문항 목록을 구성한다.
		List<EgovMap> smsList = cmmDAO.selectSmsSplList(map);

		model.addAttribute("smsList", smsList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("adminVO", adminVO);
		model.addAttribute("NotiPageGubun","NotiUpdate");

		//rm2000mVO 설정
		rm2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rm2000mVO.setRsNo(rsNo);
		rm2000mVO.setRsjNo(trsjSeq);
		
		rm2000mVO = ech0102DAO.selectEch0102RsjDetail(rm2000mVO);
		rm2000mVO.setRsNo(rsNo);
		rm2000mVO.setRecsDt(EgovStringUtil.getDateMinus());	
		LOGGER.debug("rm2000mVO="+rm2000mVO.toString());
		model.addAttribute("rm2000mVO", rm2000mVO);
		
		return "/adm/cmm/admSmsMtPop";
		
	}

	// 피험자관리 팝업
	@RequestMapping("/qxsepmny/ech0102/ech0102RsjmgPop.do")
	public String ech0102RsjmgPop(String corpCd, String rsNo, String subNo, String rsjNo, Rs2000mVO rs2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0102/ech0102RsjmgPop.do - 피험자관리 팝업");
		//세션 호출
	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	//회사코드 설정 
		rs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());		
		//피험자 설정  
		rs2000mVO.setRsNo(rsNo);
		rs2000mVO.setSubNo(subNo);
		rs2000mVO = ech0102DAO.selectEch0102RsjmgView(rs2000mVO);
		LOGGER.debug("rs2000mVO="+rs2000mVO.toString());

		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("rs2010mVO", rs2000mVO);				
			
		return "/adm/ech0102/ech0102RsjmgPop";
	}

	// 피험자정보 등록 
	@RequestMapping("/qxsepmny/ech0102/ech0102AjaxSaveRsjmg.do")
	public View ech0102AjaxSaveRsjmg(String corpCd,String rsNo, String subNo, String etc, String appstaCls, String appStdt, String appEndt, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveRsjmg.do - 피험자정보 등록");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("subNo", subNo);
		map.put("etc", etc);
		map.put("appstaCls", appstaCls);
		map.put("appStdt", appStdt);
		map.put("appEndt", appEndt);
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//피험자정보 등록
		ech0102DAO.updateEch0102AjaxSaveRsjmg(map);
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	

}



