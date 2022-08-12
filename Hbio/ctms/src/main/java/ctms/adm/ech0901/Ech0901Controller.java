package ctms.adm.ech0901;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.adm.ech0104.Ech0104DAO;
import ctms.adm.ech0704.Ech0704DAO;
import ctms.validator.MemberValidator;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs1020mVO;
import ctms.valueObject.Rs1030mVO;
import ctms.valueObject.Rs1040mVO;
import ctms.valueObject.Rs3000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Cs1000mVO;
import ctms.valueObject.Cs1020mVO;
import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.Ct2000mVO;
import ctms.valueObject.RsUploadVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import component.file.CmmnFileMngUtil;
import egovframework.com.cmm.web.EgovWebUtil;
import ctms.cmm.CtmsCmmMethods;

@Controller
public class Ech0901Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0901Controller.class);
	@Autowired private Ech0901DAO ech0901DAO;
	@Autowired private Ech0704DAO ech0704DAO;
	@Autowired private Ech0104DAO ech0104DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//상담관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0901List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0901/ech0901List.do";
	}
	
	//상담관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0901View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0901/ech0901View.do";
	}
	
	//상담관리 일괄등록 목록으로 이동합니다.
	private String redirectListPage(RedirectAttributes reda, String message, String gubun){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("flag", "CS");
		LOGGER.debug("gubun= "+gubun);
		if(gubun.isEmpty()) {
			return "redirect:/qxsepmny/ech0901/ech0901List.do";	
		}else {
			return "redirect:/qxsepmny/cmm/CmmUplsUpload"+gubun+".do";
		}

	}
	
	/**
	 * 상담관리 목록
	 * 
	 * @param model
	 * @return 상담관리 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/qxsepmny/ech0901/ech0901List.do")
	public String ech0901List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901List.do -  상담관리 목록");
		LOGGER.debug("searchVO List= " + searchVO.toString());
		//request.getSession().setAttribute("usrMenuNo", "101");
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 상담관리 목록만 표시 
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
		
		//상담분류(공통코드) 목록
		List<EgovMap> cm1360 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CM1360");
		model.addAttribute("cm1360", cm1360);
		
		//-- 검색항목 설정 끝
		//searchVO.setRecordCountPerPage(30);
				
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = ech0901DAO.selectEch0901List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0901/ech0901List";
		
	}

	/**
	 * 상담관리 조회
	 * 
	 * @param model
	 * @return 상담관리 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0901/ech0901View.do")
	public String ech0901View(@ModelAttribute CmmnSearchVO searchVO, Cs1000mVO cs1000mVO, String paramKeyNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901View.do -  상담관리 조회");
		LOGGER.debug("paramKeyNo= "+paramKeyNo);
		LOGGER.debug("getCsNo= "+cs1000mVO.getCsNo());
		LOGGER.debug("cs1000mVO="+cs1000mVO.toString());
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cs1000mVO.setCsNo(paramKeyNo);
			//}	
		//}
		
		cs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//상담정보 조회 
		cs1000mVO =  ech0901DAO.selectEch0901View(cs1000mVO);		
		LOGGER.debug("cs1000mVO="+cs1000mVO.toString());
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("vendNo", cs1000mVO.getVendNo());
		map.put("csNo", cs1000mVO.getCsNo());
		
		//상담정보 목록
		CmmnListVO csList = ech0901DAO.selectEch0901CsList(map);
		model.addAttribute("csList", csList.getEgovList());
		
		//견적정보 목록
		//CmmnListVO opList = ech0901DAO.selectEch0901OpList(map);		
		//model.addAttribute("opList", opList.getEgovList());
		
		//계약정보 목록
		//CmmnListVO ctrtList = ech0901DAO.selectEch0901CtrtList(map);
				
		//연구과제 정보 목록
		//CmmnListVO rsList = ech0901DAO.selectEch0901RsList(map);		
		
		//작업권한 설정 
		//관리자 권한인지 여부 설정 isAdminType
		cs1000mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
		LOGGER.debug("setIsAdminType="+cs1000mVO.getIsAdminType());
		
		//해당 상담관리의 연구책임자 Y 연구담당자 Y 삭제가능여부 Y - 상담등록자인 경우   
		if(cs1000mVO.getEmpNo().equals(adminVO.getEmpNo())) {
			cs1000mVO.setIsRsDrt("Y");
			cs1000mVO.setIsRsStaff("Y");
			cs1000mVO.setIsDelCntr("Y");
		}else {
			cs1000mVO.setIsRsDrt("N");
			cs1000mVO.setIsRsStaff("N");
			cs1000mVO.setIsDelCntr("N");
		}
		LOGGER.debug("setIsRsDrt="+cs1000mVO.getIsRsDrt());
		LOGGER.debug("setIsRsStaff="+cs1000mVO.getIsRsStaff());
		LOGGER.debug("setIsDelCntr="+cs1000mVO.getIsDelCntr());		
		
		//첨부파일 확인 
		EgovMap map2 = new EgovMap();
		map2.put("boardSeq", cs1000mVO.getCsNo());
		map2.put("boardType", "CS");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
		model.addAttribute("attachList", attachList);
		
		EgovMap attachMap = new EgovMap();
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		model.addAttribute("attachMap", attachMap);
		
		model.addAttribute("cs1000mVO", cs1000mVO);
		
		//model.addAttribute("ctrtList", ctrtList.getEgovList());
		//model.addAttribute("rsList", rsList.getEgovList());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO View="+searchVO.toString());
		
		return "/adm/ech0901/ech0901View";
		
	}

	/**
	 * 상담관리 수정&등록화면
	 * 
	 * @param model
	 * @return 상담관리 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0901/ech0901Modify.do")
	public String ech0901Modify(@ModelAttribute("cs1000mVO") Cs1000mVO cs1000mVO, String paramKeyNo, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901Modify.do -  상담관리 수정&등록화면");
		LOGGER.debug("csNo1= "+paramKeyNo );
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정
		cs1000mVO.setCorpCd(adminVO.getCorpCd());
		
		//상담분류(공통코드) 목록
		List<EgovMap> cm1360 = cmmDAO.selectCmmCdList(cs1000mVO.getCorpCd(), "CM1360");
		model.addAttribute("cm1360", cm1360);
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(cs1000mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//초기값 설정 
		cs1000mVO.setCsDt(EgovStringUtil.getDateMinus());
		cs1000mVO.setEmpNo(adminVO.getEmpNo());
		cs1000mVO.setEmpName(adminVO.getName());
		cs1000mVO.setBranchCd(adminVO.getBranchCd());
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cs1000mVO.setCsNo(paramKeyNo);
			//}	
		//}
		
		if(!EgovStringUtil.isEmpty(cs1000mVO.getCsNo())){
			
			cs1000mVO = ech0901DAO.selectEch0901View(cs1000mVO);
	
			EgovMap map = new EgovMap();
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("vendNo", cs1000mVO.getVendNo());
			map.put("csNo", cs1000mVO.getCsNo());
			
			//상담정보 목록
			CmmnListVO csList = ech0901DAO.selectEch0901CsList(map);
			model.addAttribute("csList", csList.getEgovList());
			
			//첨부파일 확인
			EgovMap map2 = new EgovMap();
			map2.put("boardSeq", cs1000mVO.getCsNo());
			map2.put("boardType", "CS");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);
			
			//견적서정보 목록
			//CmmnListVO opList = ech0901DAO.selectEch0901OpList(map);
			//model.addAttribute("opList", opList.getEgovList());
			
			//계약정보 목록
			//CmmnListVO ctrtList = ech0901DAO.selectEch0901CtrtList(map);
					
			//연구과제 정보 목록
			//CmmnListVO rsList = ech0901DAO.selectEch0901RsList(map);
			
			//model.addAttribute("opList", opList.getEgovList());
			//model.addAttribute("ctrtList", ctrtList.getEgovList());
			//model.addAttribute("rsList", rsList.getEgovList());

		}
		
		model.addAttribute("cs1000mVO", cs1000mVO);
		
		return "/adm/ech0901/ech0901Modify";
	}
	
	/**
	 * 상담관리 수정&등록
	 * 
	 * @param model
	 * @return 상담관리 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0901/ech0901Update.do")
	public String ech0901Update(@ModelAttribute("cs1000mVO") Cs1000mVO cs1000mVO, String[] rsPos, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901Update.do -  상담관리 수정&등록");
		LOGGER.debug("+++++++++++++++++++++++++++++++++");
		//LOGGER.debug(rsPos.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		cs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		cs1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//복수 지사가 참여하는 상담관리도 등록하는 연구담당자의 지사코드를 설정한다.
		cs1000mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(cs1000mVO.getCsNo())){
			
			String csNo = ech0901DAO.insertEch0901(cs1000mVO);
			cs1000mVO.setCsNo(csNo);
			
			message = "등록이 완료되었습니다.";
		}else{
			ech0901DAO.updateEch0901(cs1000mVO);
			
			message = "수정이 완료되었습니다.";
			
			//삭제 설정된 파일 
			if(delFile != null){
				for(String seq : delFile){
					System.out.println(seq);
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		}
		
		//등록, 수정 공통 - 첨부파일로 등록 
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "CS");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("CS");
				attachVO.setBoardNo(cs1000mVO.getCsNo());
				attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
				attachVO.setRegDate(EgovStringUtil.getDateMinus());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectEch0901List(reda, message);
	}
	
	/**
	 * 상담관리 삭제
	 * 
	 * @param model
	 * @return 상담관리 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0901/ech0901Delete.do")
	public String ech0901Delete(@ModelAttribute("cs1000mVO") Cs1000mVO cs1000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901Delete.do -  상담관리 삭제");
		LOGGER.debug("cs1000mVO = " + cs1000mVO.toString());
		String message = "존재하지 않는 상담관리입니다.";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(cs1000mVO.getCsNo())){
			
			int chk = ech0901DAO.deleteEch0901(cs1000mVO);
			LOGGER.debug("chk= "+chk);
			
			if(chk > 0){
				EgovMap map = new EgovMap();
				map.put("boardSeq", cs1000mVO.getCsNo());
				map.put("boardType", "CS");
				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				
				for(Ct7000mVO attachVO : attachList){
					cmmDAO.deleteAttachFile(attachVO.getAttachNo());
					fileUtil.deleteFile(attachVO.getRegFileName());
				}
			}
			
			message = "해당 상담정보 삭제가 완료되었습니다.";
		}
		
		return redirectEch0901List(reda, message);
	}
	
	/**
	 * 상담관리 엑셀다운로드
	 * 
	 * @param model
	 * @return 상담관리 목록 엑셀다운로드
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0901/ech0901Excel.do")
	public void ech0901Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901Excel.do - 상담관리 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		String message = "";
		
		//세션 호출
		/*
		 * AdminVO adminVO = (AdminVO)
		 * request.getSession().getAttribute("adminSessionCtms");
		 * LOGGER.debug("adminVO = " + adminVO.toString());
		 * if(adminVO.getExauth().equals("N")) {
		 * response.setContentType("text/html; charset=UTF-8"); PrintWriter out =
		 * response.getWriter(); out.
		 * println("<script>alert('엑셀다운로드권한이 허용되지 않습니다.관리자에게 문의하세요!'); location.href='/qxsepmny/ech0901/ech0901List.do';</script>"
		 * ); out.flush(); } else {
		 * 
		 * //엑셀다운로드 로직 }
		 */
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0901DAO.selectEch0901Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "상담관리 리스트", "ech0901", request, response);
		
	}
	
	// 상담정보 일괄등록 - 1)엑셀파일 업로드 화면 호출 
	@RequestMapping("/qxsepmny/ech0901/ech0901CsUpload.do")
	public String ech0901CsUpload(@ModelAttribute CmmnSearchVO searchVO, Ct7000mVO ct7000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901CsUpload.do -  상담정보 일괄등록");
		String message = "";		
		//회사코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		searchVO.setSearchParam2(adminVO.getAdminType());
		
		// 엑셀 데이터 삭제
		session.removeAttribute("insertMemList");
		session.removeAttribute("excelDupMemList");
		
		//양식파일의 ATTACH_NO을 획득한다.
		EgovMap map = new EgovMap();
		map.put("boardSeq", "CSUPLS");
		map.put("boardType", "UPLS");
		map.put("fileKey", "attachRpt01");
		ct7000mVO = cmmDAO.selectAttachListFileKeyOne(map);
		if(ct7000mVO != null) {
			searchVO.setSearchParam1(ct7000mVO.getAttachNo());
			message = "양식파일이 등록되여 있습니다. 다운로드해서 사용해주세요";
		}else {
			message = "양식파일이 없습니다. 먼저 양식파일을 첨부해주세요(관리자권한 필요)";	
		}
		
		model.addAttribute("message", message);
		model.addAttribute("searchVO", searchVO);

		return "/adm/ech0901/ech0901CsUpload";
		
	}
	
	// 상담정보 일괄등록 - 2)엑셀파일 파싱 
	@RequestMapping("/qxsepmny/ech0901/ech0901UploadMemData.do")
	public String ech0901UploadMemData(MultipartHttpServletRequest multiRequest, Cs1000mVO cs1000mVO, Ct1030mVO ct1030mVO, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901UploadMemData.do -  상담정보 일괄등록 엑셀파일 파싱");
		
		String message = "";
		String gubun = "";
		
		//첨부파일 확인
		/*첨부파일 존재할시 등록*/
		if(fileUtil.uploadFileRegiChk(multiRequest)){
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile2(multiRequest, "UPL");
			
			//파일 확인
			if(fileInfoVO == null){
				LOGGER.info("첨부된 파일의 확장자가 잘못되었습니다.");
				message = "첨부된 파일의 확장자가 잘못되었습니다.";
			}else {
				
				//파일 업로드
				String filePath = fileInfoVO.getFilePath();
				LOGGER.debug(filePath);
	
				// 엑셀 데이터 파싱  filePath, 업로드타입 - 상담 cs
				List<EgovMap> excelMemList = excelUtil.getExcelUploadData(filePath, "cs");
				
				// 업로드된 파일 삭제
				//fileUtil.deleteFile(filePath);
				
				// 중복 목록 저장용도
				List<EgovMap> excelDupMemList = new ArrayList<EgovMap>();
				
				// 중복 제거한  목록 저장용도
				List<Cs1000mVO> insertMemList = new ArrayList<>();
				
				if(excelMemList.size() == 0) {
					message = "업로드 데이터 미존재";
				}else {
					boolean isValid = true;
					
					for(EgovMap memMap : excelMemList) {
						LOGGER.debug("memMap="+memMap.toString());
						String name = (String)memMap.get("corpCd");
						
						if(EgovStringUtil.isEmpty(name)) {
							message = "회사고유번호가  없는 데이터가 존재합니다.";
							break; 
						}else {
							Cs1000mVO rsUploadVO = new Cs1000mVO();
							//조건에 따른 값 설정 예시
							//if("core".equals(key)) rsUploadVO.setCore("Y");
							//else if("corr".equals(key)) rsUploadVO.setCorr("Y");
							//else if("reporter".equals(key)) rsUploadVO.setReporter("Y");
							//else if("tot".equals(key)) rsUploadVO.setTot("Y");
							//else if("payb".equals(key)) rsUploadVO.setPayb("Y");
							
							//값 매칭 예시
							//rsUploadVO.setName(EgovWebUtil.removeTag(memMap.get("name").toString()));			

							//작업자 확인  
							///EgovMap map2 = new EgovMap();
							
							//map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							//map2.put("empNo", EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
							
							//ct1030mVO = ech0901DAO.selectEch0901EmpCheck(map2);

							rsUploadVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
							rsUploadVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
							
							rsUploadVO.setCorpCd(EgovWebUtil.removeTag(memMap.get("corpCd").toString()));
							rsUploadVO.setCsDt(EgovWebUtil.removeTag(memMap.get("csDt").toString()));
							rsUploadVO.setVendNo(EgovWebUtil.removeTag(memMap.get("vendNo").toString()));
							rsUploadVO.setCsCls(EgovWebUtil.removeTag(memMap.get("csCls").toString()));							
							rsUploadVO.setCsCont(EgovWebUtil.removeTag(memMap.get("csCont").toString()));
							rsUploadVO.setRcsName(EgovWebUtil.removeTag(memMap.get("rcsName").toString()));
							rsUploadVO.setRcsTel(EgovWebUtil.removeTag(memMap.get("rcsTel").toString()));
							rsUploadVO.setRcsEmail(EgovWebUtil.removeTag(memMap.get("rcsEmail").toString()));
							rsUploadVO.setRemk(EgovWebUtil.removeTag(memMap.get("remk").toString()));
							
							// 유효성 검사
							//Map<String, String> errors = MemberValidator.validate(rsUploadVO);
							//if(errors.size()!=0) {
								//message = "데이터 형식에 오류가 있어 업로드 등록에 실패하였습니다.";
								//reda.addFlashAttribute("errors", errors);
								//return redirectListPage(reda, message, "");
							//}
							
							// 중복검사 - 고객사,상담일자,내용 
							EgovMap map = new EgovMap();
							
							map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							map.put("vendNo", rsUploadVO.getVendNo());
							map.put("csDt", rsUploadVO.getCsDt());
							map.put("csCont", rsUploadVO.getCsCont());
							List<EgovMap> list = ech0901DAO.selectEch0901DupCsList(map);
							
							if(list != null && list.size() >= 1) {
								memMap.put("dupMemList", list);
								excelDupMemList.add(memMap);
							}else {
								insertMemList.add(rsUploadVO);
							}
						}
					}
					
					if(isValid) {
						session.setAttribute("insertMemList", insertMemList);	// 중복 제거 신규  목록
						LOGGER.debug("insertMemList="+insertMemList.toString());
						session.setAttribute("excelDupMemList", excelDupMemList);	// 중복 목록
						LOGGER.debug("excelDupMemList="+excelDupMemList.toString());
						message = "검증 완료. 다음 버튼을 클릭하세요.";
						gubun = "2"; // 데이터 검증 탭으로 이동
					}
				}
			}
			
		}else{
			message = "첨부 파일 미존재";
		}

		//model.addAttribute("message", message);
		//model.addAttribute("searchVO", searchVO);
		
		return redirectListPage(reda, message, gubun);
		
	}
	

	// 상담정보 일괄등록 - Data 검증 화면
	@RequestMapping("/qxsepmny/ech0901/ech0901CsUpload2.do")
	public String ech0901CsUpload2(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxsepmny/ech0901/ech0901CsUpload2.do - 상담정보 일괄등록 > Data 검증 화면");
		LOGGER.debug("searchVO = "+searchVO.toString());

		// CSRF 토큰 공유
		CtmsCmmMethods.setCsrfToken(session);
		
		//if(!CtmsCmmMethods.checkMemPermit(key)) {
			//return CtmsCmmMethods.redirectProfileView;
		//}
		LOGGER.debug("================+++++++++++++++++++++++++");
		
		return "/adm/ech0901/ech0901CsUpload";
	}
		
	//상담정보 일괄등록 - 상담정보 일괄 등록 처리 	
	@RequestMapping("/qxsepmny/ech0901/ech0901SaveCsData.do")
	public String ech0901SaveCsData(HttpServletRequest request, ModelMap model, Cs1000mVO cs1000mVO, HttpSession session, RedirectAttributes reda, String memType) throws Exception {
		LOGGER.info("/qxsepmny/ech0901/ech0901SaveCsData.do - 상담정보 일괄 등록 처리");
	
		// CSRF 토큰 검사
		if(!CtmsCmmMethods.isCsrfToken(request, reda)){
		  return CtmsCmmMethods.redirectLoginView;
		}
		
		List<Cs1000mVO> insertMemList = (List<Cs1000mVO>) session.getAttribute("insertMemList");
		
		// 유효성 검사 통과 등록 작업.
		for(Cs1000mVO rsUploadVO : insertMemList) {
			//상담분야 1000 마케팅용 1010 과제용  명칭/코드 분리하기
			if (!EgovStringUtil.isEmpty(rsUploadVO.getCsCls())) {
				String tempCls = rsUploadVO.getCsCls();
				
				String[] sptempCls = tempCls.split("/");
				rsUploadVO.setCsCls(sptempCls[1].toString());
			}
			
			rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
			LOGGER.info("rsUploadVO="+rsUploadVO.toString());
			
			ech0901DAO.insertEch0901(rsUploadVO);
			
		}
		
		//작업 로그 등록 
		String dspCnt = insertMemList.size()+"건";
		admLogInsert("영업관리 > 상담정보 일괄등록", dspCnt, "1010", request);
		
		String message = "등록 완료되었습니다.";
		
		return redirectListPage(reda, message, "");
	}	

	// 상담정보 일괄삭제
	@RequestMapping("/qxsepmny/ech0901/ech0901AjaxCsDel.do")
	public View ech0901AjaxCsDel(String corpCd, String step1,String step2, String[] keySeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0901/ech0901AjaxCsDel.do - 상담정보 일괄삭제");
		LOGGER.debug("csSeq="+keySeq.toString());
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("step1", step1);
		//map.put("step2", step2);
		map.put("keySeq", keySeq);
		
		//삭제대상이 있는지 확인한다. 
		int chkCnt = ech0901DAO.selectEch0901AjaxCsDel(map);
		LOGGER.debug("chkCnt="+chkCnt);
		
		if(chkCnt == 0) {
			message = "삭제대상이 없습니다.";
		}else {
			//상담정보 일괄삭제
			ech0901DAO.deleteEch0901AjaxCsDel(map);
			message = chkCnt+" 건 삭제되었습니다.";
			
			//첨부파일 삭제 
			for(int i=0;i<keySeq.length;i++) {
			    EgovMap map2 = new EgovMap();
				map2.put("boardSeq", keySeq[i]);
				map2.put("boardType", "CS");
				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
				
				for(Ct7000mVO attachVO : attachList){
					cmmDAO.deleteAttachFile(attachVO.getAttachNo());
					fileUtil.deleteFile(attachVO.getRegFileName());
				}
				LOGGER.debug("keySeq="+keySeq[i]);
			}
			
			//작업 로그 등록 
			String dspCnt = chkCnt+"건";
			admLogInsert("상담정보 일괄삭제", dspCnt, "1010", request);
		}

		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 고객사상담 찾기
	@RequestMapping("/qxsepmny/ech0901/ech0901AjaxSearchCs.do")
	public View ech0901AjaxSearchCs(String searchWord, String csNo, String vendNo, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901AjaxSearchCs.do - 고객사상담 찾기");
		LOGGER.debug("searchWord = " + searchWord);
		LOGGER.debug("vendNo = " + vendNo);
		LOGGER.debug("csNo = " + csNo);
		
		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("vendNo", vendNo);
		if(csNo.equals("")) {
			map.put("csNo", "");
		}else {
			map.put("csNo", csNo);
		}
		
		List<EgovMap> resultList = ech0901DAO.selectEch0901AjaxCsList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 고객사 간편등록 팝업
	@RequestMapping("/qxsepmny/ech0901/ech0901VendmgPop.do")
	public String ech0901VendmgPop(String corpCd, Ct2000mVO ct2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901VendmgPop.do - 고객사 간편등록 팝업");
		//세션 호출
	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		ct2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		// 고객사구분(공통코드) 목록 CM1010
		List<EgovMap> cm1010 = cmmDAO.selectCmmCdList(ct2000mVO.getCorpCd(), "CM1010");
		model.addAttribute("cm1010", cm1010);
		
		//등록화면으로
		model.addAttribute("NotiPageGubun","NotiRegist");
		model.addAttribute("ct2000mVO", ct2000mVO);
			
		return "/adm/ech0901/ech0901VendmgPop";
		
	}
	
	// 고객사 간편등록 
	@RequestMapping("/qxsepmny/ech0901/ech0901AjaxSaveVend.do")
	public View ech0901AjaxSaveVend(String corpCd, String vendCls, String vendName, String vendSm, String excutName, String regno1, String regno2, String regno3, String mngName, String mngOrg, Ct2000mVO ct2000mVO,  HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0901/ech0901AjaxSaveVend.do - 고객사 간편등록");
		String message = "";

		ct2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		ct2000mVO.setVendCls(vendCls);
		ct2000mVO.setVendName(vendName);
		ct2000mVO.setVendSm(vendSm);
		ct2000mVO.setExcutName(excutName);
		//즉시사용
		ct2000mVO.setUseYn("Y");
		ct2000mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		ct2000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//추가정보
		ct2000mVO.setRegno1(regno1);
		ct2000mVO.setRegno2(regno2);
		ct2000mVO.setRegno3(regno3);
		// 사업자등록번호 3-2-5 -> 10자리로			
		if (!EgovStringUtil.isEmpty(ct2000mVO.getRegno1())) {
			ct2000mVO.setBregRsno(ct2000mVO.getRegno1()+ct2000mVO.getRegno2()+ct2000mVO.getRegno3());
		}
		ct2000mVO.setMngName(mngName);
		ct2000mVO.setMngOrg(mngOrg);
		
		//고객사 등록
		ech0704DAO.insertEch0704(ct2000mVO);	
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 첨부파일 삭제 
	@RequestMapping("/qxsepmny/ech0901/ech0901DeleteFileUpload.do")
	public View ech0901DeleteFileUpload(Ct7000mVO ct7000mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901DeleteFileUpload.do - 첨부파일 삭제");
		
		String message = "";
		
		//파일 저장 path조회
		ct7000mVO = cmmDAO.selectAttachOne(ct7000mVO.getAttachNo());
		// 원본파일 삭제
		String deldisp = fileUtil.deleteFile(ct7000mVO.getRegFileName());
		LOGGER.debug("deldisp= "+deldisp);
		
		//String result2 = "";
		//int pos2 = fileDeletePath.lastIndexOf( "." );
    	//String fileExt2 = fileDeletePath.substring( pos2 + 1 );
		//if (fileExtCheck(fileExt2, "IMG")) { // 파일 확장자 검사 이미지 파일인 경우 
			//String delthumnail = fileDeletePath.substring( 0, pos2 );
			//delthumnail = delthumnail + "_thumbnail"+"."+fileExt2;
			//File file2 = new File(filePathBlackList( UPLOAD_HOME + delthumnail ));
			//if (file2.isFile()) {
				//result2 = deletePath( UPLOAD_HOME + delthumnail );
			//} else {
				//result2 = "";
			//}
		//}
		
		
		// 데이터 베이스 파일업로드 삭제 ct7000mVO.getAttachNo() 를 사용해야한다.
		cmmDAO.deleteAttachFile(ct7000mVO.getAttachNo());
		
		message = "첨부파일이 삭제되었습니다.";
		model.addAttribute("message", message);
		
		LOGGER.debug("jsonView= "+jsonView.toString());
		
		return jsonView;
	}
	
	// 양식파일 업로드  - 추가 -> 삭제해도 됨
	@RequestMapping("/qxsepmny/ech0901/ech0901AjaxUploadFile.do")
	public View ech0901AjaxUploadFile(String[] delFile, Ct7000mVO ct7000mVO, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0901/ech0901AjaxUploadFile.do -  양식파일업로드");
		LOGGER.debug("request.getParameter('upls')= "+request.getParameter("upls"));
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		String message = "";
		
		//양식파일 등록여부를 확인 > 등록된 경우 기존 파일을 삭제한다.
		//CT7000M 확인 UPLS CSUPLS -> ATTACH_NO 확인하여 seq에 설정한다.
		EgovMap map = new EgovMap();
		//map.put("boardSeq", "CSUPLS");
		map.put("boardSeq", request.getParameter("upls"));
		map.put("boardType", "UPLS");
		map.put("fileKey", "attachRpt01");
		ct7000mVO = cmmDAO.selectAttachListFileKeyOne(map);

		if(ct7000mVO != null) {
			Ct7000mVO delAttach = cmmDAO.selectAttachOne(ct7000mVO.getAttachNo());
			cmmDAO.deleteAttachFile(delAttach.getAttachNo());
			fileUtil.deleteFile(delAttach.getRegFileName());
		}
				
		//양식파일 첨부 
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "UPLS");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("UPLS");
				/*attachVO.setBoardNo("CSUPLS");*/
				attachVO.setBoardNo(request.getParameter("upls"));
				attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
				attachVO.setRegDate(EgovStringUtil.getDateMinus());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return jsonView;
	}
	
	
}
