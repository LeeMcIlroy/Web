package ctms.adm.ech0902;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.text.DecimalFormat;
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
import ctms.validator.MemberValidator;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs1020mVO;
import ctms.valueObject.Rs1030mVO;
import ctms.valueObject.Rs1040mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Cs1020mVO;
import ctms.valueObject.Cs2000mVO;
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
public class Ech0902Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0902Controller.class);
	@Autowired private Ech0902DAO ech0902DAO;
	@Autowired private Ech0104DAO ech0104DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//견적관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0902List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0902/ech0902List.do";
	}
	
	//견적관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0902View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0902/ech0902View.do";
	}
	
	//견적관리 일괄등록 목록으로 이동합니다.
	private String redirectListPage(RedirectAttributes reda, String message, String gubun){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0902/ech0902RsUpload"+gubun+".do";
	}
	
	/**
	 * 견적관리 목록
	 * 
	 * @param model
	 * @return 견적관리 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/qxsepmny/ech0902/ech0902List.do")
	public String ech0902List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0902/ech0902List.do -  견적관리 목록");
		LOGGER.debug("searchVO List= " + searchVO.toString());
		//request.getSession().setAttribute("usrMenuNo", "101");
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 견적관리 목록만 표시 
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
		//List<String> yearList = cmmDAO.selectYearList();
		//model.addAttribute("yearList", yearList);
		
		
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
		
	 	//견적분류(공통코드) 목록
		List<EgovMap> cm1360 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CM1360");
		model.addAttribute("cm1360", cm1360);
	 	
		//List<EgovMap> rsCdList = ech0902DAO.selectEch0902StaffList(map);
		//List<EgovMap> yearRsCdList = cmmDAO.selectCmmYearRsCdList(map);
		
		//model.addAttribute("yearRsCdList", yearRsCdList);
		
		//임상분류(공통코드) 목록 searchCondition5
		//List<EgovMap> ct2030 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2030");
		//model.addAttribute("ct2030", ct2030);
		
		//연구상태(공통코드) 목록 searchCondition5
		//List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2050");
		//model.addAttribute("ct2050", ct2050);
		
		//-- 검색항목 설정 끝
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = ech0902DAO.selectEch0902List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0902/ech0902List";
		
	}

	/**
	 * 견적관리 조회
	 * 
	 * @param model
	 * @return 견적관리 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0902/ech0902View.do")
	public String ech0902View(@ModelAttribute CmmnSearchVO searchVO, Cs1020mVO cs1020mVO, String paramKeyNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0902/ech0902View.do -  견적관리 조회");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cs1020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cs1020mVO.setOpNo(paramKeyNo);
			//}	
		//}
		
		cs1020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//견적정보 조회 
		cs1020mVO =  ech0902DAO.selectEch0902View(cs1020mVO);
		
		DecimalFormat formatter = new DecimalFormat("###,###");
		//누적입금액,잔금,연구비,부가세,계약금액 숫자변환 
		cs1020mVO.setRsPay(formatter.format(Integer.parseInt(cs1020mVO.getRsPay())));
		cs1020mVO.setRsPayvt(formatter.format(Integer.parseInt(cs1020mVO.getRsPayvt())));
		cs1020mVO.setRsTpay(formatter.format(Integer.parseInt(cs1020mVO.getRsTpay())));
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("vendNo", cs1020mVO.getVendNo());
		
		//상담정보 목록
		CmmnListVO csList = ech0902DAO.selectEch0902CsList(map);
		
		//견적정보 목록
		//CmmnListVO opList = ech0902DAO.selectEch0902OpList(map);		
		
		//계약정보 목록
		//CmmnListVO ctrtList = ech0902DAO.selectEch0902CtrtList(map);
				
		//연구과제 정보 목록
		//CmmnListVO rsList = ech0902DAO.selectEch0902RsList(map);		
		
		//작업권한 설정 
		//관리자 권한인지 여부 설정 isAdminType
		cs1020mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
		LOGGER.debug("setIsAdminType="+cs1020mVO.getIsAdminType());
		
		//해당 견적관리의 연구책임자 Y 연구담당자 Y 삭제가능여부 Y - 상담등록자인 경우   
		if(cs1020mVO.getEmpNo().equals(adminVO.getEmpNo())) {
			cs1020mVO.setIsRsDrt("Y");
			cs1020mVO.setIsRsStaff("Y");
			cs1020mVO.setIsDelCntr("Y");
		}else {
			cs1020mVO.setIsRsDrt("N");
			cs1020mVO.setIsRsStaff("N");
			cs1020mVO.setIsDelCntr("N");
		}
		LOGGER.debug("setIsRsDrt="+cs1020mVO.getIsRsDrt());
		LOGGER.debug("setIsRsStaff="+cs1020mVO.getIsRsStaff());
		LOGGER.debug("setIsDelCntr="+cs1020mVO.getIsDelCntr());		
		
		//첨부파일 확인 - 기능없음
		//EgovMap map1 = new EgovMap();
		//map1.put("boardSeq", cs1020mVO.getOpNo());
		//map1.put("boardType", "CS");
	
		//List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map1);
		//model.addAttribute("attachList", attachList);

		//EgovMap attachMap = new EgovMap();
		
		//for(Ct7000mVO attach : attachList){
			//attachMap.put(attach.getFileKey(), attach);
		//}
		
		//model.addAttribute("attachMap", attachMap);
		
		//첨부파일 확인 
		EgovMap map2 = new EgovMap();
		map2.put("boardSeq", cs1020mVO.getOpNo());
		map2.put("boardType", "OP");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
		model.addAttribute("attachList", attachList);
		
		EgovMap attachMap = new EgovMap();
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		model.addAttribute("attachMap", attachMap);
		
		model.addAttribute("cs1020mVO", cs1020mVO);
		model.addAttribute("csList", csList.getEgovList());
		//model.addAttribute("opList", opList.getEgovList());
		//model.addAttribute("ctrtList", ctrtList.getEgovList());
		//model.addAttribute("rsList", rsList.getEgovList());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO View="+searchVO.toString());
		
		return "/adm/ech0902/ech0902View";
		
	}

	/**
	 * 견적관리 수정&등록화면
	 * 
	 * @param model
	 * @return 견적관리 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0902/ech0902Modify.do")
	public String ech0902Modify(@ModelAttribute("cs1020mVO") Cs1020mVO cs1020mVO, String paramKeyNo, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0902/ech0902Modify.do -  견적관리 수정&등록화면");
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정
		cs1020mVO.setCorpCd(adminVO.getCorpCd());
		
		//견적분류(공통코드) 목록
		List<EgovMap> cm1360 = cmmDAO.selectCmmCdList(cs1020mVO.getCorpCd(), "CM1360");
		model.addAttribute("cm1360", cm1360);
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(cs1020mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//초기값 설정 
		cs1020mVO.setOpDt(EgovStringUtil.getDateMinus());
		cs1020mVO.setEmpNo(adminVO.getEmpNo());
		cs1020mVO.setEmpName(adminVO.getName());
		cs1020mVO.setBranchCd(adminVO.getBranchCd());
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cs1020mVO.setOpNo(paramKeyNo);
			//}	
		//}
		
		if(!EgovStringUtil.isEmpty(cs1020mVO.getOpNo())){
			
			cs1020mVO = ech0902DAO.selectEch0902View(cs1020mVO);
			
			DecimalFormat formatter = new DecimalFormat("###,###");
			//누적입금액,잔금,연구비,부가세,계약금액 숫자변환 
			cs1020mVO.setRsPay(formatter.format(Integer.parseInt(cs1020mVO.getRsPay())));
			cs1020mVO.setRsPayvt(formatter.format(Integer.parseInt(cs1020mVO.getRsPayvt())));
			cs1020mVO.setRsTpay(formatter.format(Integer.parseInt(cs1020mVO.getRsTpay())));
	
			EgovMap map = new EgovMap();
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("vendNo", cs1020mVO.getVendNo());
			
			//견적서정보 목록
			//CmmnListVO opList = ech0902DAO.selectEch0902OpList(map);		
			
			//계약정보 목록
			//CmmnListVO ctrtList = ech0902DAO.selectEch0902CtrtList(map);
					
			//연구과제 정보 목록
			//CmmnListVO rsList = ech0902DAO.selectEch0902RsList(map);
			
			//model.addAttribute("opList", opList.getEgovList());
			//model.addAttribute("ctrtList", ctrtList.getEgovList());
			//model.addAttribute("rsList", rsList.getEgovList());
			
			//첨부파일 확인
			EgovMap map2 = new EgovMap();
			map2.put("boardSeq", cs1020mVO.getOpNo());
			map2.put("boardType", "OP");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);

		}
		
		model.addAttribute("cs1020mVO", cs1020mVO);
		
		return "/adm/ech0902/ech0902Modify";
	}
	
	/**
	 * 견적관리 수정&등록
	 * 
	 * @param model
	 * @return 견적관리 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0902/ech0902Update.do")
	public String ech0902Update(@ModelAttribute("cs1020mVO") Cs1020mVO cs1020mVO, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0902/ech0902Update.do -  견적관리 수정&등록");
		LOGGER.debug("+++++++++++++++++++++++++++++++++");
		//LOGGER.debug(rsPos.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		cs1020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		cs1020mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//복수 지사가 참여하는 견적관리도 등록하는 연구담당자의 지사코드를 설정한다.
		cs1020mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(cs1020mVO.getOpNo())){
			
			//견적고유번호 설정
			cs1020mVO.setOpNo1(adminVO.getOpNo1());
			LOGGER.debug("getOpNo1()= "+cs1020mVO.getOpNo1());
			String csNo = ech0902DAO.insertEch0902(cs1020mVO);
			cs1020mVO.setOpNo(csNo);
			
			message = "등록이 완료되었습니다.";
		}else{
			ech0902DAO.updateEch0902(cs1020mVO);
			
			message = "수정이 완료되었습니다.";
			
			if(delFile != null){
				for(String seq : delFile){
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "OP");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("OP");
				attachVO.setBoardNo(cs1020mVO.getOpNo());
				attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
				attachVO.setRegDate(EgovStringUtil.getDateMinus());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectEch0902List(reda, message);
	}
	
	/**
	 * 견적관리 삭제
	 * 
	 * @param model
	 * @return 견적관리 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0902/ech0902Delete.do")
	public String ech0902Delete(@ModelAttribute("cs1020mVO") Cs1020mVO cs1020mVO, Cs2000mVO cs2000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0902/ech0902Delete.do -  견적관리 삭제");
		LOGGER.debug("cs1020mVO = " + cs1020mVO.toString());
		String message = "존재하지 않는 견적관리입니다.";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(cs1020mVO.getOpNo())){
			
			//계약정보를 확인한다
			cs2000mVO.setCorpCd(cs1020mVO.getCorpCd());
			cs2000mVO.setOpNo(cs1020mVO.getOpNo());
			int chkCtrt = ech0902DAO.selectEch0902CtrtCnt(cs2000mVO);
			if(chkCtrt > 0) {
				message = "계약정보가 존재해서 해당 견적정보 삭제를 할 수 없습니다.";
			}else {
				int chk = ech0902DAO.deleteEch0902(cs1020mVO);
				LOGGER.debug("chk = " +chk);
				
				//첨부파일 삭제
				if(chk > 0){
					EgovMap map = new EgovMap();
					map.put("boardSeq", cs1020mVO.getOpNo());
					map.put("boardType", "OP");
					List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
					
					for(Ct7000mVO attachVO : attachList){
						cmmDAO.deleteAttachFile(attachVO.getAttachNo());
						fileUtil.deleteFile(attachVO.getRegFileName());
					}
				}
				
				message = "해당 견적정보 삭제가 완료되었습니다.";
			}
		}
		return redirectEch0902List(reda, message);
	}
	
	/**
	 * 견적관리 엑셀다운로드
	 * 
	 * @param model
	 * @return 견적관리 목록 엑셀다운로드
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0902/ech0902Excel.do")
	public void ech0902Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0902/ech0902Excel.do - 견적관리 엑셀 다운로드");
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
		 * println("<script>alert('엑셀다운로드권한이 허용되지 않습니다.관리자에게 문의하세요!'); location.href='/qxsepmny/ech0902/ech0902List.do';</script>"
		 * ); out.flush(); } else {
		 * 
		 * //엑셀다운로드 로직 }
		 */
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0902DAO.selectEch0902Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "견적관리 리스트", "ech0902", request, response);
		
	}
		
	// 견적정보 일괄삭제
	@RequestMapping("/qxsepmny/ech0902/ech0902AjaxOpDel.do")
	public View ech0902AjaxOpDel(String corpCd, String step1,String step2, String[] keySeq, Cs1020mVO cs1020mVO, Cs2000mVO cs2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0902/ech0902AjaxOpDel.do - 견적정보 일괄삭제");
		LOGGER.debug("keySeq="+keySeq.toString());
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("step1", step1);
		//map.put("step2", step2);
		map.put("keySeq", keySeq);
		
		//삭제대상이 있는지 확인한다. 
		int chkCnt = ech0902DAO.selectEch0902AjaxOpDel(map);
		LOGGER.debug("chkCnt="+chkCnt);
		
		if(chkCnt == 0) {
			message = "삭제대상이 없습니다.";
		}else {
			//계약정보 일괄삭제
			ech0902DAO.deleteEch0902AjaxOpDel(map);
			message = chkCnt+" 건 삭제되었습니다.";

			for(int i=0;i<keySeq.length;i++) {
				//계약정보를 확인한다
				cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				cs2000mVO.setOpNo(keySeq[i]);
				int chkCtrt = ech0902DAO.selectEch0902CtrtCnt(cs2000mVO);
				if(chkCtrt == 0) { //계약정보가 없는 경우만 첨부파일 삭제 
					EgovMap map2 = new EgovMap();
					map2.put("boardSeq", keySeq[i]);
					map2.put("boardType", "OP");
					List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
					
					for(Ct7000mVO attachVO : attachList){
						cmmDAO.deleteAttachFile(attachVO.getAttachNo());
						fileUtil.deleteFile(attachVO.getRegFileName());
					}					
				}	
			}
			
			//작업 로그 등록 
			String dspCnt = chkCnt+"건";
			admLogInsert("영업관리 > 견적정보 일괄삭제", dspCnt, "1010", request);
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
			
		}
	
}
