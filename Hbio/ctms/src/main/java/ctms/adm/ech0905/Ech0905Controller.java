package ctms.adm.ech0905;

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

import org.apache.catalina.tribes.util.Arrays;
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
import ctms.valueObject.Ct3000mVO;
import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.Ct2000mVO;
import ctms.valueObject.Ct3000mVO;
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
public class Ech0905Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0905Controller.class);
	@Autowired private Ech0905DAO ech0905DAO;
	@Autowired private Ech0704DAO ech0704DAO;
	@Autowired private Ech0104DAO ech0104DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//자산관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0905List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0905/ech0905List.do";
	}
	
	//자산관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0905View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0905/ech0905View.do";
	}
		
	/**
	 * 자산관리 목록
	 * 
	 * @param model
	 * @return 자산관리 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/qxsepmny/ech0905/ech0905List.do")
	public String ech0905List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905List.do -  자산관리 목록");
		LOGGER.debug("searchVO List= " + searchVO.toString());
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 자산관리 목록만 표시 
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
		
		//자산분류(공통코드) 목록
		List<EgovMap> cm1370 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CM1370");
		model.addAttribute("cm1370", cm1370);
		
		//-- 검색항목 설정 끝
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = ech0905DAO.selectEch0905List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0905/ech0905List";
		
	}

	/**
	 * 자산관리 조회
	 * 
	 * @param model
	 * @return 자산관리 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0905/ech0905View.do")
	public String ech0905View(@ModelAttribute CmmnSearchVO searchVO, Ct3000mVO ct3000mVO, String paramKeyNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905View.do -  자산관리 조회");
		LOGGER.debug("csNo1= "+paramKeyNo);
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		if(paramKeyNo != null) {
			if(!paramKeyNo.isEmpty()) {
				ct3000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				ct3000mVO.setAstNo(paramKeyNo);
			}	
		}
		
		//자산정보 조회 
		ct3000mVO =  ech0905DAO.selectEch0905View(ct3000mVO);		
		LOGGER.debug("ct3000mVO="+ct3000mVO.toString());
		
		DecimalFormat formatter = new DecimalFormat("###,###");
		//구매가격,부가세,합계금액 숫자변환 
		ct3000mVO.setPchAmt(formatter.format(Integer.parseInt(ct3000mVO.getPchAmt())));
		ct3000mVO.setPchAmtvt(formatter.format(Integer.parseInt(ct3000mVO.getPchAmtvt())));
		ct3000mVO.setPchTamt(formatter.format(Integer.parseInt(ct3000mVO.getPchTamt())));
		
		//EgovMap map = new EgovMap();
		//map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("vendNo", ct3000mVO.getVendNo());
		//map.put("csNo", ct3000mVO.getAstNo());
		
		//자산정보 목록
		//CmmnListVO csList = ech0905DAO.selectEch0905CsList(map);
		//model.addAttribute("csList", csList.getEgovList());
		
		//견적정보 목록
		//CmmnListVO opList = ech0905DAO.selectEch0905OpList(map);		
		//model.addAttribute("opList", opList.getEgovList());
		
		//계약정보 목록
		//CmmnListVO ctrtList = ech0905DAO.selectEch0905CtrtList(map);
				
		//연구과제 정보 목록
		//CmmnListVO rsList = ech0905DAO.selectEch0905RsList(map);		
		
		//작업권한 설정 
		//관리자 권한인지 여부 설정 isAdminType
		ct3000mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
		LOGGER.debug("setIsAdminType="+ct3000mVO.getIsAdminType());
		
		//해당 자산관리의 연구책임자 Y 연구담당자 Y 삭제가능여부 Y - 자산등록자인 경우   
		if(ct3000mVO.getEmpNo().equals(adminVO.getEmpNo())) {
			ct3000mVO.setIsRsDrt("Y");
			ct3000mVO.setIsRsStaff("Y");
			ct3000mVO.setIsDelCntr("Y");
		}else {
			ct3000mVO.setIsRsDrt("N");
			ct3000mVO.setIsRsStaff("N");
			ct3000mVO.setIsDelCntr("N");
		}
		LOGGER.debug("setIsRsDrt="+ct3000mVO.getIsRsDrt());
		LOGGER.debug("setIsRsStaff="+ct3000mVO.getIsRsStaff());
		LOGGER.debug("setIsDelCntr="+ct3000mVO.getIsDelCntr());		
		
		//첨부파일 확인 - 기능없음
		//EgovMap map1 = new EgovMap();
		//map1.put("boardSeq", ct3000mVO.getAstNo());
		//map1.put("boardType", "CS");
	
		//List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map1);
		//model.addAttribute("attachList", attachList);

		//EgovMap attachMap = new EgovMap();
		
		//for(Ct7000mVO attach : attachList){
			//attachMap.put(attach.getFileKey(), attach);
		//}
		
		//model.addAttribute("attachMap", attachMap);
		
		model.addAttribute("ct3000mVO", ct3000mVO);
		
		//model.addAttribute("ctrtList", ctrtList.getEgovList());
		//model.addAttribute("rsList", rsList.getEgovList());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO View="+searchVO.toString());
		
		return "/adm/ech0905/ech0905View";
		
	}

	/**
	 * 자산관리 수정&등록화면
	 * 
	 * @param model
	 * @return 자산관리 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0905/ech0905Modify.do")
	public String ech0905Modify(@ModelAttribute("ct3000mVO") Ct3000mVO ct3000mVO, String paramKeyNo, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905Modify.do -  자산관리 수정&등록화면");
		LOGGER.debug("csNo1= "+paramKeyNo );
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정
		ct3000mVO.setCorpCd(adminVO.getCorpCd());
		
		//자산분류(공통코드) 목록
		List<EgovMap> cm1370 = cmmDAO.selectCmmCdList(ct3000mVO.getCorpCd(), "CM1370");
		model.addAttribute("cm1370", cm1370);
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(ct3000mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//초기값 설정 
		ct3000mVO.setPchDt(EgovStringUtil.getDateMinus());
		ct3000mVO.setEmpNo(adminVO.getEmpNo());
		ct3000mVO.setEmpName(adminVO.getName());
		ct3000mVO.setBranchCd(adminVO.getBranchCd());
		
		if(paramKeyNo != null) {
			if(!paramKeyNo.isEmpty()) {
				ct3000mVO.setAstNo(paramKeyNo);
			}	
		}
		
		if(!EgovStringUtil.isEmpty(ct3000mVO.getAstNo())){
			
			ct3000mVO = ech0905DAO.selectEch0905View(ct3000mVO);

			DecimalFormat formatter = new DecimalFormat("###,###");
			//구매가격,부가세,합계금액 숫자변환 
			ct3000mVO.setPchAmt(formatter.format(Integer.parseInt(ct3000mVO.getPchAmt())));
			ct3000mVO.setPchAmtvt(formatter.format(Integer.parseInt(ct3000mVO.getPchAmtvt())));
			ct3000mVO.setPchTamt(formatter.format(Integer.parseInt(ct3000mVO.getPchTamt())));
			
			//EgovMap map = new EgovMap();
			//map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			//map.put("vendNo", ct3000mVO.getVendNo());
			//map.put("csNo", ct3000mVO.getAstNo());
			
			//자산정보 목록
			//CmmnListVO csList = ech0905DAO.selectEch0905CsList(map);
			//model.addAttribute("csList", csList.getEgovList());
			
			//견적서정보 목록
			//CmmnListVO opList = ech0905DAO.selectEch0905OpList(map);
			//model.addAttribute("opList", opList.getEgovList());
			
			//계약정보 목록
			//CmmnListVO ctrtList = ech0905DAO.selectEch0905CtrtList(map);
					
			//연구과제 정보 목록
			//CmmnListVO rsList = ech0905DAO.selectEch0905RsList(map);
			
			//model.addAttribute("opList", opList.getEgovList());
			//model.addAttribute("ctrtList", ctrtList.getEgovList());
			//model.addAttribute("rsList", rsList.getEgovList());

		}
		
		model.addAttribute("ct3000mVO", ct3000mVO);
		
		return "/adm/ech0905/ech0905Modify";
	}
	
	/**
	 * 자산관리 수정&등록
	 * 
	 * @param model
	 * @return 자산관리 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0905/ech0905Update.do")
	public String ech0905Update(@ModelAttribute("ct3000mVO") Ct3000mVO ct3000mVO, String[] rsPos, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905Update.do -  자산관리 수정&등록");
		LOGGER.debug("+++++++++++++++++++++++++++++++++");
		//LOGGER.debug(rsPos.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		ct3000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		ct3000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//복수 지사가 참여하는 자산관리도 등록하는 연구담당자의 지사코드를 설정한다.
		ct3000mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(ct3000mVO.getAstNo())){
			
			String csNo = ech0905DAO.insertEch0905(ct3000mVO);
			ct3000mVO.setAstNo(csNo);
			
			message = "등록이 완료되었습니다.";
		}else{
			ech0905DAO.updateEch0905(ct3000mVO);
			
			message = "수정이 완료되었습니다.";
			
			if(delFile != null){
				for(String seq : delFile){
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "CS");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("CS");
				attachVO.setBoardNo(ct3000mVO.getAstNo());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectEch0905List(reda, message);
	}
	
	/**
	 * 자산관리 삭제
	 * 
	 * @param model
	 * @return 자산관리 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0905/ech0905Delete.do")
	public String ech0905Delete(@ModelAttribute("ct3000mVO") Ct3000mVO ct3000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905Delete.do -  자산관리 삭제");
		LOGGER.debug("ct3000mVO = " + ct3000mVO.toString());
		String message = "존재하지 않는 자산관리입니다.";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(ct3000mVO.getAstNo())){
			
			ech0905DAO.deleteEch0905(ct3000mVO);
			
			message = "해당 자산정보 삭제가 완료되었습니다.";
		}
		
		return redirectEch0905List(reda, message);
	}
	
	/**
	 * 자산관리 엑셀다운로드
	 * 
	 * @param model
	 * @return 자산관리 목록 엑셀다운로드
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0905/ech0905Excel.do")
	public void ech0905Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905Excel.do - 자산관리 엑셀 다운로드");
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
		 * println("<script>alert('엑셀다운로드권한이 허용되지 않습니다.관리자에게 문의하세요!'); location.href='/qxsepmny/ech0905/ech0905List.do';</script>"
		 * ); out.flush(); } else {
		 * 
		 * //엑셀다운로드 로직 }
		 */
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0905DAO.selectEch0905Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "자산관리 리스트", "ech0905", request, response);
		
	}
	
	// 자산정보 일괄등록 - 1)엑셀파일 업로드 화면 호출 
	@RequestMapping("/qxsepmny/ech0905/ech0905AstUpload.do")
	public String ech0905AstUpload(@ModelAttribute CmmnSearchVO searchVO, Ct7000mVO ct7000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905AstUpload.do -  자산정보 일괄등록");
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
		map.put("boardSeq", "ASTUPLS");
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
		
		return "/adm/ech0905/ech0905AstUpload";
		
	}

	// 자산정보 일괄삭제
	@RequestMapping("/qxsepmny/ech0905/ech0905AjaxAstDel.do")
	public View ech0905AjaxAstDel(String corpCd, String step1,String step2, String[] keySeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0905/ech0905AjaxAstDel.do - 자산정보 일괄삭제");
		LOGGER.debug("csSeq="+keySeq.toString());
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("step1", step1);
		//map.put("step2", step2);
		//시험제품 번호 
		map.put("keySeq", keySeq);
		
		//삭제대상이 있는지 확인한다. 
		int chkCnt = ech0905DAO.selectEch0905AjaxAstDel(map);
		LOGGER.debug("chkCnt="+chkCnt);
		
		if(chkCnt == 0) {
			message = "삭제대상이 없습니다.";
		}else {
			//자산 일괄삭제
			ech0905DAO.deleteEch0905AjaxAstDel(map);
			message = chkCnt+" 건 삭제되었습니다.";
			
			//작업 로그 등록 
			String dspCnt = chkCnt+"건";
			admLogInsert("자산정보 일괄삭제", dspCnt, "1010", request);
		}

		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 고객사자산 찾기
	@RequestMapping("/qxsepmny/ech0905/ech0905AjaxSearchCs.do")
	public View ech0905AjaxSearchCs(String searchWord, String csNo, String vendNo, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905AjaxSearchCs.do - 고객사자산 찾기");
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
		
		//List<EgovMap> resultList = ech0905DAO.selectEch0905AjaxCsList(map);
		//model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 고객사 간편등록 팝업
	@RequestMapping("/qxsepmny/ech0905/ech0905VendmgPop.do")
	public String ech0905VendmgPop(String corpCd, Ct2000mVO ct2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0905/ech0905VendmgPop.do - 고객사 간편등록 팝업");
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
			
		return "/adm/ech0905/ech0905VendmgPop";
		
	}
	
	// 고객사 간편등록 
	@RequestMapping("/qxsepmny/ech0905/ech0905AjaxSaveVend.do")
	public View ech0905AjaxSaveVend(String corpCd, String vendCls, String vendName, String vendSm, String excutName, String regno1, String regno2, String regno3, String mngName, String mngOrg, Ct2000mVO ct2000mVO,  HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0905/ech0905AjaxSaveVend.do - 고객사 간편등록");
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
	
	// 자산관리 - 일괄폐기등록
	@RequestMapping("/qxsepmny/ech0905/ech0905AjaxSaveDisDt.do")
	public View ech0905AjaxSaveDisDt(String corpCd, String step1, String[] keySeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0905/ech0905AjaxSaveDisDt.do - 연구대상자 관리자확인일자 일괄등록");
		LOGGER.debug("corpCd= "+corpCd);
		LOGGER.debug("step1= "+step1);
		LOGGER.debug("keySeq= "+keySeq.toString());
		LOGGER.debug("length= "+keySeq.length);
		String message = "";
		
		EgovMap map = new EgovMap();
		
		// 회사코드 설정 
		//sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("step1", step1);
		// 등록수정자 설정
		map.put("step2", EgovUserDetailsHelper.getAuthenticatedAdminId());
		map.put("keySeq", keySeq);
		
		ech0905DAO.updateEch0905AjaxSaveDisDt(map);
		
		message = "선택한 자산정보가 일괄폐기되었습니다.";
		model.addAttribute("message", message);
		
		//작업 로그 등록 
		String dspCnt = keySeq.length+"건";
		admLogInsert("자산정보 일괄폐기", dspCnt, "1010", request);
		
		return jsonView;
		
	}
	
	
}
