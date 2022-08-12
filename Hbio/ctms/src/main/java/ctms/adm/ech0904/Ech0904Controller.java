package ctms.adm.ech0904;

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
import ctms.valueObject.Cs1000mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs1020mVO;
import ctms.valueObject.Rs1030mVO;
import ctms.valueObject.Rs1040mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Cs2000mVO;
import ctms.valueObject.Cs2020mVO;
import ctms.valueObject.Ct1030mVO;
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
public class Ech0904Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0904Controller.class);
	@Autowired private Ech0904DAO ech0904DAO;
	@Autowired private Ech0104DAO ech0104DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//입금관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0904List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0904/ech0904List.do";
	}
	
	//입금관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0904View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0904/ech0904View.do";
	}
	
	/**
	 * 입금관리 목록
	 * 
	 * @param model
	 * @return 입금관리 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/qxsepmny/ech0904/ech0904List.do")
	public String ech0904List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0904/ech0904List.do -  입금관리 목록");
		LOGGER.debug("searchVO List= " + searchVO.toString());
		//request.getSession().setAttribute("usrMenuNo", "101");
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 입금관리 목록만 표시 
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
		
		//List<EgovMap> rsCdList = ech0904DAO.selectEch0904StaffList(map);
		List<EgovMap> yearRsCdList = cmmDAO.selectCmmYearRsCdList(map);
		
		model.addAttribute("yearRsCdList", yearRsCdList);
		
		//임상분류(공통코드) 목록 searchCondition5
		//List<EgovMap> ct2030 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2030");
		//model.addAttribute("ct2030", ct2030);
		
		//연구상태(공통코드) 목록 searchCondition5
		//List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT2050");
		//model.addAttribute("ct2050", ct2050);
		
		//계약분류(공통코드) 목록
		List<EgovMap> cm1360 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CM1360");
		model.addAttribute("cm1360", cm1360);
		
		//-- 검색항목 설정 끝
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = ech0904DAO.selectEch0904List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0904/ech0904List";
		
	}

	/**
	 * 입금관리 조회
	 * 
	 * @param model
	 * @return 입금관리 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0904/ech0904View.do")
	public String ech0904View(@ModelAttribute CmmnSearchVO searchVO, Cs2020mVO cs2020mVO, String paramKeyNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0904/ech0904View.do -  입금관리 조회");
		LOGGER.debug("cs2020mVO="+cs2020mVO.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cs2020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cs2020mVO.setInNo(paramKeyNo);
			//}	
		//}
		cs2020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//입금정보 조회 
		cs2020mVO =  ech0904DAO.selectEch0904View(cs2020mVO);
		
		DecimalFormat formatter = new DecimalFormat("###,###");
		//입금액,누적입금액,잔금,연구비,부가세 숫자변환 
		cs2020mVO.setInAmt(formatter.format(Integer.parseInt(cs2020mVO.getInAmt())));
		cs2020mVO.setInTamt(formatter.format(Integer.parseInt(cs2020mVO.getInTamt())));
		cs2020mVO.setInBamt(formatter.format(Integer.parseInt(cs2020mVO.getInBamt())));
		cs2020mVO.setRsPay(formatter.format(Integer.parseInt(cs2020mVO.getRsPay())));
		cs2020mVO.setRsPayvt(formatter.format(Integer.parseInt(cs2020mVO.getRsPayvt())));
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("vendNo", cs2020mVO.getVendNo());
		
		//상담정보 목록
		CmmnListVO csList = ech0904DAO.selectEch0904CsList(map);
		
		//견적정보 목록
		CmmnListVO opList = ech0904DAO.selectEch0904OpList(map);		
		
		//계약정보 목록
		//CmmnListVO ctrtList = ech0904DAO.selectEch0904CtrtList(map);
				
		//연구과제 정보 목록
		//CmmnListVO rsList = ech0904DAO.selectEch0904RsList(map);		
		
		//작업권한 설정 
		//관리자 권한인지 여부 설정 isAdminType
		cs2020mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
		LOGGER.debug("setIsAdminType="+cs2020mVO.getIsAdminType());
		
		//해당 입금관리의 연구책임자 Y 연구담당자 Y 삭제가능여부 Y - 상담등록자인 경우   
		if(cs2020mVO.getEmpNo().equals(adminVO.getEmpNo())) {
			cs2020mVO.setIsRsDrt("Y");
			cs2020mVO.setIsRsStaff("Y");
			cs2020mVO.setIsDelCntr("Y");
		}else {
			cs2020mVO.setIsRsDrt("N");
			cs2020mVO.setIsRsStaff("N");
			cs2020mVO.setIsDelCntr("N");
		}
		LOGGER.debug("setIsRsDrt="+cs2020mVO.getIsRsDrt());
		LOGGER.debug("setIsRsStaff="+cs2020mVO.getIsRsStaff());
		LOGGER.debug("setIsDelCntr="+cs2020mVO.getIsDelCntr());		
				
		//첨부파일 확인 
		EgovMap map2 = new EgovMap();
		map2.put("boardSeq", cs2020mVO.getInNo());
		map2.put("boardType", "IN");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
		model.addAttribute("attachList", attachList);
		
		EgovMap attachMap = new EgovMap();
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		model.addAttribute("attachMap", attachMap);
		
		model.addAttribute("cs2020mVO", cs2020mVO);
		model.addAttribute("csList", csList.getEgovList());
		model.addAttribute("opList", opList.getEgovList());
		//model.addAttribute("ctrtList", ctrtList.getEgovList());
		//model.addAttribute("rsList", rsList.getEgovList());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO View="+searchVO.toString());
		
		return "/adm/ech0904/ech0904View";
		
	}

	/**
	 * 입금관리 수정&등록화면
	 * 
	 * @param model
	 * @return 입금관리 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0904/ech0904Modify.do")
	public String ech0904Modify(@ModelAttribute("cs2020mVO") Cs2020mVO cs2020mVO, Cs2000mVO cs2000mVO, String paramKeyNo, String ctrtNo1, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0904/ech0904Modify.do -  입금관리 수정&등록화면");
		LOGGER.debug("cs2020mVO="+cs2020mVO.toString());
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정
		cs2020mVO.setCorpCd(adminVO.getCorpCd());
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(cs2020mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//계약분류(공통코드) 목록
		List<EgovMap> cm1360 = cmmDAO.selectCmmCdList(cs2020mVO.getCorpCd(), "CM1360");
		model.addAttribute("cm1360", cm1360);
		
		//초기값 설정 
		cs2020mVO.setInDt(EgovStringUtil.getDateMinus());
		cs2020mVO.setReciDt(EgovStringUtil.getDateMinus());
		cs2020mVO.setEmpNo(adminVO.getEmpNo());
		cs2020mVO.setEmpName(adminVO.getName());
		cs2020mVO.setBranchCd(adminVO.getBranchCd());
		
		//ctrtNo값이 있으면 inNo값이 없는 경우 - 계약화면에서 입금바로등록을 선택한 경우
		if(!cs2020mVO.getCtrtNo().isEmpty()) {
			if(cs2020mVO.getInNo().isEmpty()) {
				cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cs2000mVO.setCtrtNo(ctrtNo1);
				cs2000mVO = ech0904DAO.selectEch0904Ctrt2(cs2000mVO);
				cs2020mVO.setCtrtNo(cs2000mVO.getCtrtNo());
				cs2020mVO.setCtrtCd(cs2000mVO.getCtrtCd());
				
				DecimalFormat formatter = new DecimalFormat("###,###");
				//입금액 <- 잔금설정 숫자변환
				cs2020mVO.setInAmt(formatter.format(Integer.parseInt(cs2000mVO.getInBamt())));
				
				cs2020mVO.setInTamt(formatter.format(Integer.parseInt(cs2000mVO.getInTamt())));
				cs2020mVO.setInBamt(formatter.format(Integer.parseInt(cs2000mVO.getInBamt())));
				
				
				cs2020mVO.setRsPay(formatter.format(Integer.parseInt(cs2000mVO.getRsPay())));
				cs2020mVO.setRsPayvt(formatter.format(Integer.parseInt(cs2000mVO.getRsPayvt())));
				cs2020mVO.setRsTpay(formatter.format(Integer.parseInt(cs2000mVO.getRsTpay())));
				
				cs2020mVO.setVendNo(cs2000mVO.getVendNo());
				cs2020mVO.setVendName(cs2000mVO.getVendName());
				
				cs2020mVO.setCtrtName(cs2000mVO.getCtrtName());
				cs2020mVO.setInSq(Integer.toString((Integer.parseInt(cs2000mVO.getInSq())+1)));
			}
		}
		
		//ctrtNo1값이 있으면 계약조회하여 초기값을 설정한다.
		//if(ctrtNo1 != null) {
			//if(!ctrtNo1.isEmpty()) {
				//cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cs2000mVO.setCtrtNo(ctrtNo1);
				//cs2000mVO = ech0904DAO.selectEch0904Ctrt2(cs2000mVO);
				//cs2020mVO.setCtrtNo(cs2000mVO.getCtrtNo());
				//cs2020mVO.setCtrtCd(cs2000mVO.getCtrtCd());
				
				//DecimalFormat formatter = new DecimalFormat("###,###");
				//입금액 <- 잔금설정 숫자변환
				//cs2020mVO.setInAmt(formatter.format(Integer.parseInt(cs2000mVO.getInBamt())));
				
				//cs2020mVO.setInTamt(formatter.format(Integer.parseInt(cs2000mVO.getInTamt())));
				//cs2020mVO.setInBamt(formatter.format(Integer.parseInt(cs2000mVO.getInBamt())));
				
				
				//cs2020mVO.setRsPay(formatter.format(Integer.parseInt(cs2000mVO.getRsPay())));
				//cs2020mVO.setRsPayvt(formatter.format(Integer.parseInt(cs2000mVO.getRsPayvt())));
				//cs2020mVO.setRsTpay(formatter.format(Integer.parseInt(cs2000mVO.getRsTpay())));
				
				//cs2020mVO.setVendNo(cs2000mVO.getVendNo());
				//cs2020mVO.setVendName(cs2000mVO.getVendName());
				
				//cs2020mVO.setCtrtName(cs2000mVO.getCtrtName());
				//cs2020mVO.setInSq(Integer.toString((Integer.parseInt(cs2000mVO.getInSq())+1)));
			//}
		//}
		
		//contextMenu 호출
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cs2020mVO.setInNo(paramKeyNo);
			//}	
		//}
		
		if(!EgovStringUtil.isEmpty(cs2020mVO.getInNo())){
			
			cs2020mVO = ech0904DAO.selectEch0904View(cs2020mVO);
			
			DecimalFormat formatter = new DecimalFormat("###,###");
			//입금액,누적입금액,잔금,계약금액,부가세 숫자변환 
			cs2020mVO.setInAmt(formatter.format(Integer.parseInt(cs2020mVO.getInAmt())));
			cs2020mVO.setInTamt(formatter.format(Integer.parseInt(cs2020mVO.getInTamt())));
			cs2020mVO.setInBamt(formatter.format(Integer.parseInt(cs2020mVO.getInBamt())));
			cs2020mVO.setRsPay(formatter.format(Integer.parseInt(cs2020mVO.getRsPay())));
			cs2020mVO.setRsPayvt(formatter.format(Integer.parseInt(cs2020mVO.getRsPayvt())));

			EgovMap map = new EgovMap();
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("vendNo", cs2020mVO.getVendNo());
			
			//견적서정보 목록
			//CmmnListVO opList = ech0904DAO.selectEch0904OpList(map);		
			
			//계약정보 목록
			//CmmnListVO ctrtList = ech0904DAO.selectEch0904CtrtList(map);
					
			//연구과제 정보 목록
			//CmmnListVO rsList = ech0904DAO.selectEch0904RsList(map);
			
			//model.addAttribute("opList", opList.getEgovList());
			//model.addAttribute("ctrtList", ctrtList.getEgovList());
			//model.addAttribute("rsList", rsList.getEgovList());
			
			//첨부파일 확인
			EgovMap map2 = new EgovMap();
			map2.put("boardSeq", cs2020mVO.getInNo());
			map2.put("boardType", "IN");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);
			
		}
		
		model.addAttribute("cs2020mVO", cs2020mVO);
		
		return "/adm/ech0904/ech0904Modify";
	}
	
	/**
	 * 입금관리 수정&등록
	 * 
	 * @param model
	 * @return 입금관리 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0904/ech0904Update.do")
	public String ech0904Update(@ModelAttribute("cs2020mVO") Cs2020mVO cs2020mVO, Cs2000mVO cs2000mVO, String[] rsPos, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0904/ech0904Update.do -  입금관리 수정&등록");
		LOGGER.debug("+++++++++++++++++++++++++++++++++");
		//LOGGER.debug(rsPos.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		cs2020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		cs2020mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//복수 지사가 참여하는 입금관리도 등록하는 연구담당자의 지사코드를 설정한다.
		cs2020mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(cs2020mVO.getInNo())){

			//현재까지 입금액 산출
			//Cs2020mVO cs2020mVO2 = ech0904DAO.selectEch0904InAmt(cs2020mVO);
			
			//if(cs2020mVO2.getInSq().equals("0")) {
				//누적입금액 설정
				//cs2020mVO.setInTamt(cs2020mVO.getInAmt());
				
				//LOGGER.debug("getRsTpay= "+cs2020mVO.getRsTpay());
				//LOGGER.debug("getInAmt= "+cs2020mVO.getInAmt());
				//잔금 설정
				//int bamt = Integer.parseInt(cs2020mVO.getRsTpay()) - Integer.parseInt(cs2020mVO.getInAmt());
				//LOGGER.debug("bamt= "+bamt);
				//cs2020mVO.setInBamt(Integer.toString(bamt));
			//}else {
				//누적입금액 설정
				//int hTamt = Integer.parseInt(cs2020mVO.getInAmt())+Integer.parseInt(cs2020mVO2.getInAmt());
				//cs2020mVO.setInTamt(Integer.toString(hTamt));
				
				//잔금 설정 
				//int bamt = Integer.parseInt(cs2020mVO.getRsTpay()) - hTamt;
				//cs2020mVO.setInBamt(Integer.toString(bamt));
			//}
			
			String inNo = ech0904DAO.insertEch0904(cs2020mVO);
			
			//계약정보에 누적입금액과 잔금을 Update한다.
			//계약정보 확인
			cs2000mVO.setCorpCd(cs2020mVO.getCorpCd());
			cs2000mVO.setCtrtNo(cs2020mVO.getCtrtNo());
			cs2000mVO = ech0904DAO.selectEch0904Ctrt(cs2000mVO);
			
			//누적입금액 설정
			cs2000mVO.setInTamt(Integer.toString(Integer.parseInt(cs2020mVO.getInTamt()) + Integer.parseInt(cs2020mVO.getInAmt())));
			
			//잔금 설정
			cs2000mVO.setInBamt(Integer.toString(Integer.parseInt(cs2000mVO.getRsTpay()) - Integer.parseInt(cs2000mVO.getInTamt())));

			ech0904DAO.updateEch0904Ctrt(cs2000mVO);
			
			message = "등록이 완료되었습니다.";
		}else{
			
			ech0904DAO.updateEch0904(cs2020mVO);
			
			//계약정보에 누적입금액과 잔금을 Update한다.
			//계약정보 확인
			cs2000mVO.setCorpCd(cs2020mVO.getCorpCd());
			cs2000mVO.setCtrtNo(cs2020mVO.getCtrtNo());
			cs2000mVO = ech0904DAO.selectEch0904Ctrt(cs2000mVO);
			
			//현재까지 입금액 산출 - 현재 입금번호 제외
			Cs2020mVO cs2020mVO2 = ech0904DAO.selectEch0904InAmt2(cs2020mVO);
			
			//누적입금액 설정
			if(cs2020mVO2 == null) {
				cs2000mVO.setInTamt(cs2020mVO.getInAmt());
			}else {
				if(cs2020mVO2.getInAmt()==null) {
					cs2000mVO.setInTamt(Integer.toString(Integer.parseInt(cs2020mVO.getInAmt()) + 0));
				}else {
					cs2000mVO.setInTamt(Integer.toString(Integer.parseInt(cs2020mVO.getInAmt()) + Integer.parseInt(cs2020mVO2.getInAmt())));	
				}
			}
			
			//잔금 설정
			cs2000mVO.setInBamt(Integer.toString(Integer.parseInt(cs2000mVO.getRsTpay()) - Integer.parseInt(cs2000mVO.getInTamt())));

			ech0904DAO.updateEch0904Ctrt(cs2000mVO);
			
			message = "수정이 완료되었습니다.";
			
			if(delFile != null){
				for(String seq : delFile){
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "IN");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("IN");
				attachVO.setBoardNo(cs2020mVO.getInNo());
				attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
				attachVO.setRegDate(EgovStringUtil.getDateMinus());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectEch0904List(reda, message);
	}
	
	/**
	 * 입금관리 삭제
	 * 
	 * @param model
	 * @return 입금관리 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0904/ech0904Delete.do")
	public String ech0904Delete(@ModelAttribute("cs2020mVO") Cs2020mVO cs2020mVO, Cs2000mVO cs2000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0904/ech0904Delete.do -  입금관리 삭제");
		LOGGER.debug("cs2020mVO = " + cs2020mVO.toString());
		String message = "존재하지 않는 입금관리입니다.";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(cs2020mVO.getInNo())){
			
			String ctrtNo = cs2020mVO.getCtrtNo();
			int chk = ech0904DAO.deleteEch0904(cs2020mVO);
			LOGGER.debug("chk= "+chk);
			
			if(chk > 0){
				EgovMap map = new EgovMap();
				map.put("boardSeq", cs2020mVO.getInNo());
				map.put("boardType", "IN");
				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				
				for(Ct7000mVO attachVO : attachList){
					cmmDAO.deleteAttachFile(attachVO.getAttachNo());
					fileUtil.deleteFile(attachVO.getRegFileName());
				}
			}
			
			//계약정보에 누적입금액과 잔금을 Update한다.
			//계약정보 확인
			cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			cs2000mVO.setCtrtNo(ctrtNo);
			cs2000mVO = ech0904DAO.selectEch0904Ctrt2(cs2000mVO);
			
			//현재까지 입금액 산출
			cs2020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			cs2020mVO.setCtrtNo(ctrtNo);
			Cs2020mVO cs2020mVO2 = ech0904DAO.selectEch0904InAmt(cs2020mVO);
			
			if(cs2020mVO2.getInSq().equals("0")) {
				cs2000mVO.setInTamt("0");
				cs2000mVO.setInBamt("0");
			}else {
				//누적입금액 설정
				cs2000mVO.setInTamt(cs2020mVO2.getInAmt());
				
				//잔금 설정
				cs2000mVO.setInBamt(Integer.toString(Integer.parseInt(cs2000mVO.getRsTpay()) - Integer.parseInt(cs2000mVO.getInTamt())));
			}

			ech0904DAO.updateEch0904Ctrt(cs2000mVO);			 
			
			message = "해당 입금정보 삭제가 완료되었습니다.";
		}
		
		return redirectEch0904List(reda, message);
	}
	
	/**
	 * 입금관리 엑셀다운로드
	 * 
	 * @param model
	 * @return 입금관리 목록 엑셀다운로드
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0904/ech0904Excel.do")
	public void ech0904Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0904/ech0904Excel.do - 입금관리 엑셀 다운로드");
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
		 * println("<script>alert('엑셀다운로드권한이 허용되지 않습니다.관리자에게 문의하세요!'); location.href='/qxsepmny/ech0904/ech0904List.do';</script>"
		 * ); out.flush(); } else {
		 * 
		 * //엑셀다운로드 로직 }
		 */
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0904DAO.selectEch0904Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "입금관리 리스트", "ech0904", request, response);
		
	}
		
	// 입금정보 일괄등록 - 1)엑셀파일 업로드 화면 호출 
	@RequestMapping("/qxsepmny/ech0904/ech0904InUpload.do")
	public String ech0904InUpload(@ModelAttribute CmmnSearchVO searchVO, Ct7000mVO ct7000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/ech0904/ech0904InUpload.do -  입금정보 일괄등록");
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
		map.put("boardSeq", "INUPLS");
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
		
		return "/adm/ech0904/ech0904InUpload";
		
	}

	// 입금정보 일괄삭제
	@RequestMapping("/qxsepmny/ech0904/ech0904AjaxInDel.do")
	public View ech0904AjaxInDel(String corpCd, String step1,String step2, String[] keySeq, Cs2020mVO cs2020mVO, Cs2000mVO cs2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0901/ech0904AjaxInDel.do - 입금정보 일괄삭제");
		LOGGER.debug("inSeq="+keySeq.toString());
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("inSeq", keySeq);
		
		//입금정보 일괄삭제
		//ech0904DAO.deleteEch0904AjaxInDel(map);
		int delCnt = 0;
		
		for(int i=0;i<keySeq.length;i++) {
			
			//입금정보 조회 
			cs2020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			cs2020mVO.setInNo(keySeq[i]);
			cs2020mVO =  ech0904DAO.selectEch0904View(cs2020mVO);
			
			//입금정보 삭제 
		    ech0904DAO.deleteEch0904(cs2020mVO);
		    
		    //첨부파일 삭제 
		    EgovMap map2 = new EgovMap();
			map2.put("boardSeq", keySeq[i]);
			map2.put("boardType", "IN");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
			
			for(Ct7000mVO attachVO : attachList){
				cmmDAO.deleteAttachFile(attachVO.getAttachNo());
				fileUtil.deleteFile(attachVO.getRegFileName());
			}
		    
		    delCnt++;
		    
		    //계약정보 확인
		    cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			cs2000mVO.setCtrtNo(cs2020mVO.getCtrtNo());
		    cs2000mVO = ech0904DAO.selectEch0904Ctrt2(cs2000mVO);
		    
		    //누적입금액 설정
			cs2000mVO.setInTamt(Integer.toString(Integer.parseInt(cs2000mVO.getInTamt()) - Integer.parseInt(cs2020mVO.getInAmt())));
			
			//잔금 설정
			cs2000mVO.setInBamt(Integer.toString(Integer.parseInt(cs2000mVO.getRsTpay()) - Integer.parseInt(cs2000mVO.getInTamt())));
		    ech0904DAO.updateEch0904Ctrt(cs2000mVO);
		    
		}
		if(delCnt == 0) {
			message = "삭제대상이 없습니다.";
		}else {
			message = delCnt+" 건 삭제되었습니다.";
			
			//작업 로그 등록 
			String dspCnt = delCnt+"건";
			admLogInsert("입금정보 일괄삭제", dspCnt, "1010", request);
		}
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
}
