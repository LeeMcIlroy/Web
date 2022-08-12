package ctms.adm.ech0101;

import java.io.BufferedReader;
import java.io.DataOutputStream;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
public class Ech0101Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0101Controller.class);
	@Autowired private Ech0101DAO ech0101DAO;
	@Autowired private Ech0104DAO ech0104DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//연구차수관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0101List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0101/ech0101List.do";
	}
	
	//연구차수관리 수정화면으로 리다이렉트합니다.
	private String redirectEch0101Modify(RedirectAttributes reda, String message, Rs1000mVO rs1000mVO){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("rs1000mVO", rs1000mVO);
		return "redirect:/qxsepmny/ech0101/ech0101Modify.do";
	}
	
	//연구차수관리 수정화면으로 리다이렉트합니다.
	private String redirectEch0105View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0105/ech0105View.do";
	}
	
	//연구관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0105List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0105/ech0105List.do";
	}
	
	//연구과제 목록화면으로 리다이렉트합니다.
	private String redirectEch0101View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0101/ech0101View.do";
	}
	
	//연구과제 일괄등록 목록으로 이동합니다.
	private String redirectListPage(RedirectAttributes reda, String message, String gubun){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0101/ech0101RsUpload"+gubun+".do";
	}
	
	/**
	 * 연구과제 목록
	 * 
	 * @param model
	 * @return 연구과제 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/qxsepmny/ech0101/ech0101List.do")
	public String ech0101List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101List.do -  연구과제 목록");
		LOGGER.debug("searchVO List= " + searchVO.toString());
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
		
		CmmnListVO listVO = ech0101DAO.selectEch0101List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0101/ech0101List";
		
	}

	/**
	 * 연구과제 조회
	 * 
	 * @param model
	 * @return 연구과제 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0101/ech0101View.do")
	public String ech0101View(@ModelAttribute CmmnSearchVO searchVO ,  Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO,Rs5000mVO rs5000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101View.do -  연구과제 조회");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		rs1000mVO =  ech0101DAO.selectEch0101View(rs1000mVO);
		
		EgovMap map2 = new EgovMap();
		map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map2.put("rsCd", rs1000mVO.getRsCd());
		map2.put("mrsNo", rs1000mVO.getMrsNo());
		
		rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
		
		if(rs1010mVO != null) {
			//IRB심의정보 설정
			rs5000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			rs5000mVO.setRsNo(rs1010mVO.getRsNo());
			
			rs5000mVO = ech0101DAO.selectEch0101IrbView(rs5000mVO);

			model.addAttribute("rs5000mVO", rs5000mVO);
		}
				
		//rs1000mVO.setRsPayvt(String.valueOf(Integer.parseInt(rs1000mVO.getRsPay()) * 0.1));
		
		//시험물질 목록
		searchVO.setRsNo(rs1000mVO.getRsNo());
		CmmnListVO listVOMtl = ech0101DAO.selectEch0101MtlList(searchVO);
		
		//참여연구지사 목록
		searchVO.setRsNo(rs1000mVO.getRsNo());
		CmmnListVO listVO1 = ech0101DAO.selectEch0101JoinBranchList(searchVO); 
		
		//참여연구대상자 목록
		searchVO.setRsNo(rs1000mVO.getRsNo());
		CmmnListVO listVO2 = ech0101DAO.selectEch0101JoinEmpList(searchVO);
		
		if(!EgovStringUtil.isEmpty(rs1000mVO.getRsNo())){
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", rs1000mVO.getRsNo());
			map.put("boardType", "RESE");
			
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			
			EgovMap attachMap = new EgovMap();
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			model.addAttribute("attachMap", attachMap);
		}else{
			String message = "존재하지 않는 연구과제입니다.";
			return redirectEch0101List(reda, message);
		}
		
		//관리자 권한인지 여부 설정 isAdminType
		rs1000mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
		LOGGER.debug("setIsAdminType="+rs1000mVO.getIsAdminType());
		
		//해당 연구과제의 연구책임자 Y 
		if(rs1000mVO.getRsDrt().equals(adminVO.getEmpNo())) {
			rs1000mVO.setIsRsDrt("Y");
		}else {
			rs1000mVO.setIsRsDrt("N");
		}
		LOGGER.debug("setIsRsDrt="+rs1000mVO.getIsRsDrt());
		
		
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
		LOGGER.debug("setIsRsStaff="+rs1000mVO.getIsRsStaff());
		
		//해당 연구과제가 삭제가능한지 설정 isDelControl Y 삭제가능   N 삭제불가능 - 피험자가 있는 경우 - 삭제에서 처리가능함
		int chk2 = cmmDAO.selectRsDelControlCnt(map);
		if(chk2 > 0) {
			rs1000mVO.setIsDelCntr("N");
		}else {
			rs1000mVO.setIsDelCntr("Y");
		}
		LOGGER.debug("setIsDelCntr="+rs1000mVO.getIsDelCntr());
		
		//첨부파일 확인
		EgovMap map1 = new EgovMap();
		map1.put("boardSeq", rs1000mVO.getRsNo());
		map1.put("boardType", "REPORT");
	
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map1);
		model.addAttribute("attachList", attachList);

		EgovMap attachMap = new EgovMap();
		
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		
		model.addAttribute("attachMap", attachMap);
		
		model.addAttribute("rs1000mVO", rs1000mVO);		
		model.addAttribute("joinBranchList", listVO1.getEgovList());
		model.addAttribute("joinEmpList", listVO2.getEgovList());
		model.addAttribute("mtlList", listVOMtl.getEgovList());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO View="+searchVO.toString());
		
		return "/adm/ech0101/ech0101View";
		
	}

	/**
	 * 연구과제 수정&등록화면
	 * 
	 * @param model
	 * @return 연구과제 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0101/ech0101Modify.do")
	public String ech0101Modify(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO, Rs5000mVO rs5000mVO, CmmnSearchVO searchVO, String rsCd, String rsNo, String type, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101Modify.do -  연구과제 수정&등록화면");
		//request.getSession().setAttribute("admMenuNo", "505");
		LOGGER.debug("rs1000mVO= "+rs1000mVO.toString());
		LOGGER.debug("rsNo= "+rsNo); //RS1000M RS_NO
		LOGGER.debug("rsCd= "+rsCd); //RS1000M RS_CD
		LOGGER.debug("type= "+type);
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정
		rs1000mVO.setCorpCd(adminVO.getCorpCd());
		
		//연구과제 고유번호 설정 CT1000M에 설정된 값  
		rs1000mVO.setRsNo1(adminVO.getRsNo1());
		
		//임상종류(공통코드) 목록
		List<EgovMap> ct2020 = cmmDAO.selectCmmCdList(rs1000mVO.getCorpCd(), "CT2020");
		model.addAttribute("ct2020", ct2020);
		
		//임상분류(공통코드) 목록
		List<EgovMap> ct2030 = cmmDAO.selectCmmCdList(rs1000mVO.getCorpCd(), "CT2030");
		model.addAttribute("ct2030", ct2030);

		//프로토콜(공통코드) 목록
		List<EgovMap> ct2060 = cmmDAO.selectCmmCdList(rs1000mVO.getCorpCd(), "CT2060");
		model.addAttribute("ct2060", ct2060);
		
		//연구상태(공통코드) 목록
		List<EgovMap> ct2050 = cmmDAO.selectCmmCdList(rs1000mVO.getCorpCd(), "CT2050");
		model.addAttribute("ct2050", ct2050);
		
		//제품구분(공통코드) 목록
		List<EgovMap> ct2040 = cmmDAO.selectCmmCdList(rs1000mVO.getCorpCd(), "CT2040");
		model.addAttribute("ct2040", ct2040);
		
		//시험물질 목록
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		CmmnListVO listVOMtl = ech0101DAO.selectEch0101MtlList(searchVO);
		
		if(!EgovStringUtil.isEmpty(rs1000mVO.getRsNo())){
			
			rs1000mVO = ech0101DAO.selectEch0101ViewRsCd(rs1000mVO);
			rs1000mVO.setRsNo(rs1000mVO.getRsNo());
			
			
			//rs5000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			//rs5000mVO.setRsNo(rs1000mVO.getRsNo());
			//rs5000mVO = ech0101DAO.selectEch0101IrbView(rs5000mVO);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", rs1000mVO.getRsNo());
			map.put("boardType", "RESE");
			
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);

			EgovMap attachMap = new EgovMap();
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			model.addAttribute("attachMap", attachMap);
		}
		
		LOGGER.debug("rs1000mVO2= "+rs1000mVO.toString());
		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("rs5000mVO", rs5000mVO);
		model.addAttribute("mtlList", listVOMtl.getEgovList());
		
		return "/adm/ech0101/ech0101Modify";
	}
	
	/**
	 * 연구과제 수정&등록
	 * 
	 * @param model
	 * @return 연구과제 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0101/ech0101Update.do")
	public String ech0101Update(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO, Rs5000mVO rs5000mVO, String[] rsPos, String[] delFile, MultipartHttpServletRequest  request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101Update.do -  연구과제 수정&등록");
		LOGGER.debug("+++++++++++++++++++++++++++++++++");
		//LOGGER.debug(rsPos.toString());
		LOGGER.debug("rs1000mVO3= "+rs1000mVO.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rs1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//초기값으로 설정함 
		rs1000mVO.setDataLockYn("N");
		rs1000mVO.setDelYn("N");
		//복수 지사가 참여하는 연구과제도 등록하는 연구담당자의 지사코드를 설정한다.
		rs1000mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		String message = "";
		
		//연구금액, 부가세 , 삭제 
		//rs1000mVO.setRsPay(rs1000mVO.getRsPay().replace(",", ""));
		//rs1000mVO.setRsPayvt(rs1000mVO.getRsPayvt().replace(",", ""));
		
		if(EgovStringUtil.isEmpty(rs1000mVO.getRsNo())){
			
			//연구과제 추가
			if(!rs1000mVO.getRsplDt().isEmpty()) {
				rs1000mVO.setRsTstdt(rs1000mVO.getRsplDt());
			}
			if(!rs1000mVO.getRepDt().isEmpty()) {
				rs1000mVO.setRsTendt(rs1000mVO.getRepDt());
			}
			
			String rsNo = ech0101DAO.insertEch0101(rs1000mVO);
			rs1000mVO.setRsNo(rsNo);
			
			//IRB심의정보 추가 --> 연구계획서 메뉴에서 등록 처리 
			//if(!rs5000mVO.getRvNo2().isEmpty()) {
				//rs5000mVO.setRvNo1(adminVO.getRvNo1());
				//rs5000mVO.setRvNo(rs5000mVO.getRvNo1()+rs5000mVO.getRvNo2()+rs5000mVO.getRvNo3()+rs5000mVO.getRvNo4()+rs5000mVO.getRvNo5());
				//rs5000mVO.setRsNo(rsNo);
				//rs5000mVO.setDataRegnt(adminVO.getEmpNo());
				//if(!rs1000mVO.getRsirbDt().isEmpty()) {
					//rs5000mVO.setPlrvDt(rs1000mVO.getRsirbDt());
				//}
				//ech0101DAO.insertEch0101Irb(rs5000mVO);
			//}
			
			message = "등록이 완료되었습니다.";
		}else{
			
			//연구과제 수정 - 연구계획서 메뉴에서 처리함 
			if(!rs1000mVO.getRsplDt().isEmpty()) {
				rs1000mVO.setRsTstdt(rs1000mVO.getRsplDt());
			}
			if(!rs1000mVO.getRepDt().isEmpty()) {
				rs1000mVO.setRsTendt(rs1000mVO.getRepDt());
			}
			
			ech0101DAO.updateEch0101RsCd(rs1000mVO);
			
			//if(!rs5000mVO.getRvNo2().isEmpty()) {
				//IRB심의정보 추가, 수정
				//rs5000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//rs5000mVO.setRvNo1(adminVO.getRvNo1());
				//rs5000mVO.setRsNo(rs1000mVO.getRsNo());
				
				//if(!rs1000mVO.getRsirbDt().isEmpty()) {
					//rs5000mVO.setPlrvDt(rs1000mVO.getRsirbDt());
				//}
				//EgovMap map = new EgovMap();
				//map.put("corpCd", rs1000mVO.getCorpCd());
				//map.put("rsNo", rs1000mVO.getRsNo());
				//map.put("rvNo1", rs5000mVO.getRvNo1());
				//map.put("rvNo2", rs5000mVO.getRvNo2());
				//map.put("rvNo3", rs5000mVO.getRvNo3());
				//map.put("rvNo4", rs5000mVO.getRvNo4());
				//map.put("rvNo5", rs5000mVO.getRvNo5());
				//int checkIrb = ech0101DAO.selectEch0101IrbCheck(map);
				//rs5000mVO.setDataRegnt(adminVO.getEmpNo());
				//if(checkIrb == 0) {//추가
					//rs5000mVO.setRvNo(rs5000mVO.getRvNo1()+rs5000mVO.getRvNo2()+rs5000mVO.getRvNo3()+rs5000mVO.getRvNo4()+rs5000mVO.getRvNo5());
					//ech0101DAO.insertEch0101Irb(rs5000mVO);
				//}else {
					//ech0101DAO.updateEch0101Irb(rs5000mVO);
				//}
			//}
			
			message = "수정이 완료되었습니다.";
			
			//if(delFile != null){
				//for(String seq : delFile){
					//Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					//cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					//fileUtil.deleteFile(delAttach.getRegFileName());
				//}
			//}
		}
		
		//심의결과가 승인인 경우 해당 연구과제를 진행상태로 변경한다.
		//연구과제, 참여지사, 참여자 
		//단, 예정인 경우만 변경 
		if(rs5000mVO.getRvRs().equals("1")) {
			ech0104DAO.updateEch0104RvRs(rs5000mVO);
			ech0104DAO.updateEch0104BrSt(rs5000mVO);
			ech0104DAO.updateEch0104EmpSt(rs5000mVO);
		}
		
		//List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "RESE");
		//if(fileInfoList != null){
			//for(FileInfoVO fileInfoVO : fileInfoList){
				//LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				//Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				//attachVO.setBoardType("RESE");
				//attachVO.setBoardNo(rs1000mVO.getRsNo());
				//cmmDAO.insertAttachFile(attachVO);
			//}
		//}

		LOGGER.debug("rs1000mVO3= "+rs1000mVO.toString());
		return redirectEch0101Modify(reda, message, rs1000mVO);
		
		//model.addAttribute("message", message);
		//return "/adm/ech0101/ech0101Modify";
	}
	
	/**
	 * 연구과제 삭제
	 * 
	 * @param model
	 * @return 연구과제 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0101/ech0101Delete.do")
	public String ech0101Delete(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101Delete.do -  연구과제 삭제");
		LOGGER.debug("rs1000mVO = " + rs1000mVO.toString());
		String message = "존재하지 않는 연구과제입니다.";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(rs1000mVO.getRsNo())){
			
			//연구과제 삭제여부(DEL_YN ="Y") 설정
			//EgovMap map = new EgovMap();
			//map.put("corpCd", rs1000mVO.getCorpCd());
			//map.put("rsNo", rs1000mVO.getRsNo());
			//map.put("dataRegnt", adminVO.getEmpNo());
			
			//ech0101DAO.updateEch0101DelYn(map);
			
			ech0101DAO.deleteEch0101(rs1000mVO);
			
			message = "해당 연구과제의 삭제가 완료되었습니다.";
			
			//int chk = ech0101DAO.deleteEch0101(rs1000mVO);
			
			//if(chk > 0){
				//EgovMap map = new EgovMap();
				//map.put("boardSeq", rs1000mVO.getRsNo());
				//map.put("boardType", "RESE");
				//List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				
				//for(Ct7000mVO attachVO : attachList){
					//cmmDAO.deleteAttachFile(attachVO.getAttachNo());
					//fileUtil.deleteFile(attachVO.getRegFileName());
				//}
				
				//message = "해당 연구과제의 삭제가 완료되었습니다.";
			//}
		}
		
		return redirectEch0105List(reda, message);
	}
	
	/**
	 * 연구과제 엑셀다운로드
	 * 
	 * @param model
	 * @return 연구과제 삭제
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0101/ech0101Excel.do")
	public void ech0101Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101Excel.do - 연구과제 엑셀 다운로드");
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
		 * println("<script>alert('엑셀다운로드권한이 허용되지 않습니다.관리자에게 문의하세요!'); location.href='/qxsepmny/ech0101/ech0101List.do';</script>"
		 * ); out.flush(); } else {
		 * 
		 * //엑셀다운로드 로직 }
		 */
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0101DAO.selectEch0101Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "연구과제 리스트", "ech0101", request, response);
		
	}
		
	// 참여지사관리(연구과제관리) 팝업
	@RequestMapping("/qxsepmny/ech0101/ech0101BrmgPop.do")
	public String ech0101BrmgPop(String mode, String corpCd, String rsNo, String rsCd, String branchCd, Rs1000mVO rs1000mVO, Rs1020mVO rs1020mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101MtmgPop.do - 참여지사관리(연구과제)");
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드 설정 
		rs1020mVO.setCorpCd(adminVO.getCorpCd());
		
		//연구과제번호 설정
		rs1020mVO.setRsNo(rsNo);
		rs1020mVO.setRsCd(rsCd);
		rs1020mVO.setBranchCd(branchCd);
		rs1020mVO.setMode(mode);
		
		//연구시작, 종료일자 설정
		rs1000mVO.setCorpCd(rs1020mVO.getCorpCd());
		rs1000mVO.setRsNo(rs1020mVO.getRsNo());
		rs1000mVO = ech0101DAO.selectEch0101View(rs1000mVO);
		rs1020mVO.setJnStdt(rs1000mVO.getRsStdt());
		rs1020mVO.setJnEndt(rs1000mVO.getRsEndt());
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(rs1020mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//등록화면으로
	 	if (EgovStringUtil.isEmpty(rs1020mVO.getBranchCd())) {
			
			//model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rs1020mVO.getBranchCd())){
						
				rs1020mVO = ech0101DAO.selectEch0101BrView(rs1020mVO);
				rs1020mVO.setMode(mode);
				
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("rs1020mVO", rs1020mVO);				
		}
			
		return "/adm/ech0101/ech0101BrmgPop";
		
	}
	
	// 참여지사 추가/수정(연구과제관리)
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxSaveStep.do")
	public View ech0101AjaxSaveStep(String mode, String corpCd, String rsNo, String branchCd, String jnStdt, String jnEndt, String rsstCls, String branchName,String rsCd, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0101/ech0101AjaxSaveStep.do - 참여지사등록(연구과제)");
		String message = "";

		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("branchCd", branchCd);
		map.put("branchName", branchName);
		map.put("jnStdt", jnStdt);
		map.put("jnEndt", jnEndt);
		map.put("rsstCls", rsstCls);
		map.put("dataRegnt", adminVO.getEmpNo());
		
		EgovMap brmgMap = new EgovMap();
		brmgMap.put("rsCd", rsCd);
		brmgMap.put("branchCd", branchCd);
		
		List<EgovMap> brmgList = ech0101DAO.selectEch0101BrmgInfo(brmgMap);
		
		//지사 등록여부  체크
		EgovMap brmgChk = new EgovMap();

		brmgChk.put("rsCd", rsCd);
		brmgChk.put("branchCd", branchCd);
		
		int results = ech0101DAO.selectEch0101AjaxBrmgChk(brmgChk);
		EgovMap brmgChkOne = new EgovMap();
		brmgChkOne.put("rsNo", rsNo);
		brmgChkOne.put("branchCd", branchCd);
		
		int resultOne = ech0101DAO.selectEch0101AjaxBrmgChkOne(brmgChkOne);

			
		//모든 차수 등록
		if("i".equals(mode)){
			
			if(results > 0){
				
				message="이미 지사가 등록되어있습니다.";
				
			//등록되어있지않다면 등록진행
			}else{
				
		 		
				for(EgovMap brmg: brmgList){
					map.put("rsNo", brmg.get("rsNo"));
					ech0101DAO.insertEch0101AjaxSaveStep(map);
				}
				message = "저장되었습니다.";
			}
		}else if("one".equals(mode)){
			
			if(resultOne > 0 ) {
				message="이미 지사가 등록되어있습니다.";

			}else{
				
				map.put("rsNo", rsNo);
				ech0101DAO.insertEch0101AjaxSaveStep(map);
				message = "저장되었습니다.";
			}
		}
		else if("u".equals(mode)) {
			//수정 
			for(EgovMap brmg: brmgList){
				map.put("rsNo", brmg.get("rsNo"));
				ech0101DAO.updateEch0101AjaxSaveStep(map);
			}
			message = "수정되었습니다.";
		}else{
			map.put("rsNo", rsNo);
			ech0101DAO.updateEch0101AjaxSaveStep(map);
			message = "수정되었습니다.";

		}
		
		model.addAttribute("map", map);

		model.addAttribute("message", message);
		return jsonView;
		
	}

	// 참여지사(연구과제) 일괄삭제
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxSaveDel.do")
	public View ech0101AjaxSaveDel(String corpCd,String rsNo, String step1,String step2,String rsCd, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveDel.do - 참여지사 일괄삭제");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		//map.put("rsNo", rsNo);
		map.put("step1", step1);
		map.put("step2", step2);
		map.put("rsjSeq", rsjSeq);
		map.put("rsCd", rsCd);
		
		EgovMap brmgMap = new EgovMap();
		

		ech0101DAO.updateEch0101AjaxSaveDel(map);
		
		//연구대상자의 1차선정을 동시에 일괄등록된다.
		
		message = "삭제되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
		
	}

	// 참여연구담당자(연구과제관리) 팝업
	@RequestMapping("/qxsepmny/ech0101/ech0101StmgPop.do")
	public String ech0101StmgPop(String mode, String corpCd, String rsNo, String rsCd, String empNo, Rs1000mVO rs1000mVO, Rs1030mVO rs1030mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101StmgPop.do - 참여지사관리(연구과제)");
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드 설정 
		rs1030mVO.setCorpCd(adminVO.getCorpCd());
		
		//연구과제번호 설정
		rs1030mVO.setRsNo(rsNo);
		rs1030mVO.setRsCd(rsCd);
		rs1030mVO.setEmpNo(empNo);
		rs1030mVO.setMode(mode);
		LOGGER.debug("mode"+mode);
		
		//연구시작, 종료일자 설정
		rs1000mVO.setCorpCd(rs1030mVO.getCorpCd());
		rs1000mVO.setRsNo(rs1030mVO.getRsNo());
		rs1000mVO = ech0101DAO.selectEch0101View(rs1000mVO);
		rs1030mVO.setJnStdt(rs1000mVO.getRsStdt());
		rs1030mVO.setJnEndt(rs1000mVO.getRsEndt());

		//구성원  목록 
		List<EgovMap> staff = cmmDAO.selectStaffList(rs1030mVO.getCorpCd());
		model.addAttribute("staff", staff);
		
		//등록화면으로
	 	if (EgovStringUtil.isEmpty(rs1030mVO.getEmpNo())) {
			
			//model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rs1030mVO.getEmpNo())){
						
				rs1030mVO = ech0101DAO.selectEch0101StView(rs1030mVO);
				rs1030mVO.setMode(mode);
							
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("rs1030mVO", rs1030mVO);				
		}
			
		return "/adm/ech0101/ech0101StmgPop";
		
	}
	
	// 참여연구담당자 추가/수정(연구과제관리)
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxSaveStaff.do")
	public View ech0101AjaxSaveStaff(String mode, String corpCd, String rsNo, String empNo, String jnStdt, String jnEndt, String rsstCls, String empName,String rsCd, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0101/ech0101AjaxSaveStaff.do - 참여연구담당자등록/수정(연구과제)");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("empNo", empNo);
		map.put("empName", empName);
		map.put("jnStdt", jnStdt);
		map.put("jnEndt", jnEndt);
		map.put("rsstCls", rsstCls);
		map.put("dataRegnt", "aid");
		
		EgovMap stmgMap = new EgovMap();
		stmgMap.put("rsCd", rsCd);
		stmgMap.put("empNo", empNo);

		List<EgovMap> stmgList = ech0101DAO.selectEch0101StmgInfo(stmgMap);
		
		//중복체크
		EgovMap stmgChk = new EgovMap();
		stmgChk.put("rsCd", rsCd);
		stmgChk.put("empNo", empNo);
		int result = ech0101DAO.selectEch0101AjaxStmgChk(stmgChk);
		
		if(result > 0){
			
			message="이미 등록된 연구원입니다.";
			
		}else{
			
		
			//추가
			if("i".equals(mode)){
		 		//추가
				for(EgovMap stmg : stmgList){
					
					map.put("rsNo", stmg.get("rsNo"));
					
					
					ech0101DAO.insertEch0101AjaxSaveStaff(map);
				}
					message = "저장되었습니다.";
				
			} else {
				for(EgovMap stmg : stmgList){
					
					map.put("rsNo", stmg.get("rsNo"));
	
					ech0101DAO.updateEch0101AjaxSaveStaff(map);
				}
			    //수정 
				message = "수정되었습니다.";
			}
		
		}
		model.addAttribute("message", message);
		return jsonView;
		
	}

	// 참여연구담당자(연구과제) 일괄삭제
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxSaveDelStaff.do")
	public View ech0101AjaxSaveDelStaff(String corpCd,String rsNo, String step1,String step2, String rsCd,String[] rsjSeq2, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveDelStaff.do - 참여연구담당자 일괄삭제");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("step1", step1);
		map.put("step2", step2);
		map.put("rsjSeq", rsjSeq2);
		map.put("rsCd",rsCd);
		
		//참여연구담당사 삭제
		ech0101DAO.updateEch0101AjaxSaveDelStaff(map);
		
		message = "삭제되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 연구코드 중복확인
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxRsCdCheck.do")
	public View ech0101AjaxRsCdCheck(String rsCd, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/student/admAjaxStudCheck.do - 연구코드 중복확인");
		LOGGER.debug("rsCd = " + rsCd);
		String message = "";
		boolean status = false;
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(rsCd)){
			
			EgovMap map = new EgovMap();
			//회사코드(CTMS운영) 설정
			map.put("corpCd", adminVO.getCorpCd());
			map.put("rsCd", rsCd);
			
			int cnt = ech0101DAO.selectEch0101AjaxRsCdCheck(map);
			
			if(cnt > 0){
				message = "이미 사용중인 연구코드입니다.";
				status = false;
			}else{
				message = "사용 가능한 연구코드입니다.";
				status = true;
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		
		return jsonView;
	}

	// 연구코드 중복확인
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxDataLock.do")
	public View ech0101AjaxDataLock(String corpCd, String rsNo, String lock, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101AjaxDataLock.do - DATA LOCK 설정");
		LOGGER.debug("lock = " + lock);
		String message = "";
		boolean status = false;
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(lock)){
			
			EgovMap map = new EgovMap();
			//회사코드(CTMS운영) 설정
			map.put("corpCd", adminVO.getCorpCd());
			map.put("rsNo", rsNo);
			map.put("lock", lock);
			map.put("dataRegnt", adminVO.getEmpNo());
			
			ech0101DAO.updateEch0101AjaxDataLock(map);
			
			if("Y".equals(lock)){
				message = "DATA LOCK을 설정 하였습니다.";
				status = true;
				
			}else {
				message = "DATA LOCK을 해지 하였습니다.";
				status = false;
				
			}
			
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		
		return jsonView;
	}
	
	
	// 연구코드/연구명칭 찾기
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxSearchStaff.do")
	public View ech0101AjaxSearchStaff(String searchYear, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101AjaxSearchStaff.do - 연구코드/명칭 찾기-연도");
		LOGGER.debug("searchYear = " + searchYear);
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 연구과제 목록만 표시 
		//관리자인 경우 소속지사를 설정하지 않는다 1:관리자권한 2:일반사용자권한
	 	EgovMap map = new EgovMap();
	 	
	 	if(adminVO.getAdminType().equals("2")) 
		{ 
			map.put("branchCd", adminVO.getBranchCd()); 
		}else {	
			map.put("branchCd", "");
		}
		map.put("searchYear", searchYear);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());;
		
		List<EgovMap> resultList = cmmDAO.selectCmmYearRsCdList(map);

		LOGGER.debug("resultList = " + resultList.toString());
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 시험물질정보(연구과제관리) 팝업
	@RequestMapping("/qxsepmny/ech0101/ech0101MtlmgPop.do")
	public String ech0101MtlmgPop(String mode, String corpCd, String rsNo, String rsCd, String mtlNo, String mrsNo, Rs1000mVO rs1000mVO, Rs1040mVO rs1040mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101MtmgPop.do - 시험물질정보(연구과제)");
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드 설정 
		rs1040mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//연구과제번호 설정
		rs1040mVO.setRsNo(rsNo);
		rs1040mVO.setRsCd(rsCd);
		rs1040mVO.setMtlNo(mtlNo);
		LOGGER.debug("mtlNo="+mtlNo);
			
		rs1040mVO.setMode(mode);
		
		//NC시험물질(공통코드) 목록
		List<EgovMap> ct2080 = cmmDAO.selectCmmCdList(rs1000mVO.getCorpCd(), "CT2080");
		model.addAttribute("ct2080", ct2080);
		
		//등록화면으로
	 	if (EgovStringUtil.isEmpty(rs1040mVO.getMtlNo())) {
			
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rs1040mVO.getMtlNo())){
						
				rs1040mVO = ech0101DAO.selectEch0101MtlView(rs1040mVO);
				rs1040mVO.setMode(mode);
				
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("rs1040mVO", rs1040mVO);				
		}
			
		return "/adm/ech0101/ech0101MtlmgPop";
		
	}
	
	// 시험물질정보 추가/수정(연구과제관리)
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxSaveMtl.do")
	public View ech0101AjaxSaveMtl(String mode, String corpCd, String rsNo, String mtlNo, String mtlDsp, String mtlName, String lotNo, String mtlShp, String remk, String remk1, String ncYn, String mtlName2,String rsCd, String mrsNo, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0101/ech0101AjaxSaveMtl.do - 시험물질정보 등록(연구과제)");
		LOGGER.debug("mrsNo= "+mrsNo);
		LOGGER.debug("mode= "+mode);
		String message = "";
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		EgovMap map = new EgovMap();
		EgovMap mtlMap = new EgovMap();
		EgovMap mtlParams = new EgovMap();
		mtlParams.put("mtlDsp",mtlDsp);
		mtlParams.put("mrsNo", mrsNo);
	
			
		List<EgovMap> mtl = ech0101DAO.selectEch0101MtlInfo(mtlParams);
	
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", rsNo);		 
		map.put("mtlNo",mtlNo);
		map.put("mtlDsp", mtlDsp);
		map.put("ncYn", ncYn);
	
		//ncYn 여부 판단 Y : NC, N : 시험물질
		if(ncYn.equals("Y")) {
			map.put("mtlName", mtlName);
		}else {
			map.put("mtlName", mtlName2);
		}
		
		map.put("lotNo", lotNo);
		map.put("mtlShp", mtlShp);
		LOGGER.debug("remk="+remk);
		LOGGER.debug("remk1="+remk1);
	
		map.put("remk", remk1);
		map.put("dataRegnt", adminVO.getAdminId());
		map.put("mrsNo", mrsNo);

		//등록전 중복여부 확인 필요함
		
		//추가
		if("i".equals(mode)){
			//차수로 나뉘어진 모든연구과제 N/C타입 시험물질 일괄등록
			if(ncYn.equals("Y")){
				for(EgovMap mtls: mtl){				
					 mtlMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
					 mtlMap.put("rsNo", mtls.get("rsNo"));		 
					 mtlMap.put("mtlNo",mtlNo);
					 mtlMap.put("mtlDsp", mtlDsp);
					 mtlMap.put("mtlName", mtlName);
					 mtlMap.put("ncYn", ncYn);
					 mtlMap.put("lotNo", lotNo);
					 mtlMap.put("mtlShp", mtlShp);
					 mtlMap.put("remk", remk1);
					 mtlMap.put("dataRegnt", adminVO.getAdminId());
					 mtlMap.put("mrsNo", mrsNo);
				 ech0101DAO.insertEch0101AjaxSaveMtl(mtlMap);
				}
				message = "저장되었습니다.";
			}else{

				//일반 추가
				ech0101DAO.insertEch0101AjaxSaveMtl(map);
				message = "저장되었습니다.";
	
			}
			
		} else {
			if(ncYn.equals("Y")){
				for(EgovMap mtls: mtl){				
					 mtlMap.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
					 mtlMap.put("rsNo", mtls.get("rsNo"));		 
					 mtlMap.put("mtlNo",mtlNo);
					 mtlMap.put("mtlDsp", mtlDsp);
					 mtlMap.put("mtlName", mtlName);
					 mtlMap.put("ncYn", ncYn);
					 mtlMap.put("lotNo", lotNo);
					 mtlMap.put("mtlShp", mtlShp);
					 mtlMap.put("remk", remk1);
					 mtlMap.put("dataRegnt", adminVO.getAdminId());
				 ech0101DAO.updateEch0101AjaxSaveMtl(mtlMap);
				}
				message = "수정되었습니다.";
			}else{
		    //수정 
				ech0101DAO.updateEch0101AjaxSaveMtl(map);
				message = "수정되었습니다.";
			}
		}
	
		
		model.addAttribute("message", message);
		return jsonView;
		
	}
	
	
	//시험물질 중복체크
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxMtlDspCheck.do")
	public View ech0101AjaxMtlDspCheck(String mrsNo, String rsCd, String mtlDsp, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/AjaxMtlDspCheck.do - 연구코드 중복확인");
		LOGGER.debug("rsCd = " + rsCd);
		String message = "";
		boolean status = false;
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(rsCd)){
			
			EgovMap mtlChk = new EgovMap();
			//회사코드(CTMS운영) 설정
		
			//mtlDsp 중복체크
			mtlChk.put("mrsNo", mrsNo);
			mtlChk.put("mtlDsp", "#"+mtlDsp);
			
			int result = ech0101DAO.selectEch0101AjaxMtlDspChk(mtlChk);
			
			if(result > 0){
				
				message="중복되는 번호입니다.";
				status = false;
			}else{
		
				message = "사용 가능한 번호입니다.";
				status = true;
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		
		return jsonView;
	}

	// 시험물질정보(연구과제) 일괄삭제	
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxSaveDelMtl.do")
	public View ech0101AjaxSaveDelMtl(String mrsNo, String corpCd,String rsNo,String rsCd,String[] mtlDsp, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveDel.do - 시험물질정보(연구과제) 일괄삭제");
		
		String message = "";
		EgovMap map = new EgovMap();
	
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("mrsNo", mrsNo);
		map.put("mtlDsp", mtlDsp);
		
		EgovMap mtlMap = new EgovMap();

		mtlMap.put("corpCd", corpCd);
		mtlMap.put("mrsNo", mrsNo);
		mtlMap.put("rsCd", rsCd);
		mtlMap.put("mtlDsp", mtlDsp);
		
		//NC물질 일괄 삭제 
	 	ech0101DAO.updateEch0101AjaxSaveDelMtlNC(mtlMap);

		//시험물질 일괄 삭제
		ech0101DAO.updateEch0101AjaxSaveDelMtl(map);
		
		message = "삭제되었습니다.";
		model.addAttribute("message", message);
		
		

		return jsonView;
		
	}
	
	// IRB심의정보 삭제
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxDelIrb.do")
	public View ech0101AjaxDelIrb(String corpCd,String rsNo, String step1,String step2, String rvNo1, String rvNo2, String rvNo3, String rvNo4, String rvNo5, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0102/ech0102AjaxSaveDel.do - 참여지사 일괄삭제");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", corpCd);
		map.put("rsNo", rsNo);
		map.put("step1", step1);
		map.put("step2", step2);
		map.put("rvNo1", rvNo1);
		map.put("rvNo2", rvNo2);
		map.put("rvNo3", rvNo3);
		map.put("rvNo4", rvNo4);
		map.put("rvNo5", rvNo5);
		
		//연구코드의 IRB심의정보 삭제 
		ech0101DAO.updateEch0101AjaxDelIrb(map);
		
		message = "삭제되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 연구과제 일괄등록 - 엑셀파일 업로드 
	@RequestMapping("/qxsepmny/ech0101/ech0101RsUpload.do")
	public String ech0101RsUpload(@ModelAttribute CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101RsUpload.do -  연구과제 일괄등록");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		// 엑셀 데이터 삭제
		session.removeAttribute("insertMemList");
		session.removeAttribute("excelDupMemList");

		return "/adm/ech0101/ech0101RsUpload";
		
	}
	
	// 연구과제 일괄등록 - 엑셀파일 파싱 
	@RequestMapping("/qxsepmny/ech0101/ech0101UploadMemData.do")
	public String ech0101UploadMemData(MultipartHttpServletRequest multiRequest, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101UploadMemData.do -  연구과제 일괄등록 엑셀파일 파싱");
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		//searchVO.setCorpCd(adminVO.getCorpCd());
		
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
	
				// 엑셀 데이터 파싱
				List<EgovMap> excelMemList = excelUtil.getExcelUploadData(filePath, "rs");
				
				// 업로드된 파일 삭제
				//fileUtil.deleteFile(filePath);
				
				// 중복 연구과제 목록 저장용도
				List<EgovMap> excelDupMemList = new ArrayList<EgovMap>();
				
				// 중복 제거한 연구과제 목록 저장용도
				List<RsUploadVO> insertMemList = new ArrayList<>();
				
				if(excelMemList.size() == 0) {
					message = "연구과제 데이터 미존재";
				}else {
					boolean isValid = true;
					
					for(EgovMap memMap : excelMemList) {
						LOGGER.debug("memMap="+memMap.toString());
						String name = (String)memMap.get("corpCd");
						
						if(EgovStringUtil.isEmpty(name)) {
							message = "회사고유번호가  없는 데이터가 존재합니다.";
							break; 
						}else {
							RsUploadVO rsUploadVO = new RsUploadVO();
							//조건에 따른 값 설정 예시
							//if("core".equals(key)) rsUploadVO.setCore("Y");
							//else if("corr".equals(key)) rsUploadVO.setCorr("Y");
							//else if("reporter".equals(key)) rsUploadVO.setReporter("Y");
							//else if("tot".equals(key)) rsUploadVO.setTot("Y");
							//else if("payb".equals(key)) rsUploadVO.setPayb("Y");
							
							//값 매칭 예시
							//rsUploadVO.setName(EgovWebUtil.removeTag(memMap.get("name").toString()));			
							//rsUploadVO.setBirthyear(EgovWebUtil.removeTag(memMap.get("birthyear").toString()));		
							//rsUploadVO.setGender(EgovWebUtil.removeTag(memMap.get("gender").toString()));			
							//rsUploadVO.setRespect(EgovWebUtil.removeTag(memMap.get("respect").toString()));			
							//rsUploadVO.setPhoneNo(EgovWebUtil.removeTag(memMap.get("phoneNo").toString()));			
							//rsUploadVO.setMphoneNo(EgovWebUtil.removeTag(memMap.get("mphoneNo").toString()));			
							//rsUploadVO.setFaxNo(EgovWebUtil.removeTag(memMap.get("faxNo").toString()));			
							rsUploadVO.setCorpCd(EgovWebUtil.removeTag(memMap.get("corpCd").toString()));			
							rsUploadVO.setRsNo1(EgovWebUtil.removeTag(memMap.get("rsNo1").toString()));
							rsUploadVO.setRsNo2(EgovWebUtil.removeTag(memMap.get("rsNo2").toString()));
							rsUploadVO.setRsNo3(EgovWebUtil.removeTag(memMap.get("rsNo3").toString()));
							rsUploadVO.setRsNo4(EgovWebUtil.removeTag(memMap.get("rsNo4").toString()));
							rsUploadVO.setRsNo5(EgovWebUtil.removeTag(memMap.get("rsNo5").toString()));
							rsUploadVO.setRsNo6(EgovWebUtil.removeTag(memMap.get("rsNo6").toString()));
							rsUploadVO.setRsNo7(EgovWebUtil.removeTag(memMap.get("rsNo7").toString()));
							rsUploadVO.setRegDt(EgovWebUtil.removeTag(memMap.get("regDt").toString()));
							rsUploadVO.setVendNo(EgovWebUtil.removeTag(memMap.get("vendNo").toString()));
							rsUploadVO.setVmngName(EgovWebUtil.removeTag(memMap.get("vmngName").toString()));
							rsUploadVO.setVmnghpNo(EgovWebUtil.removeTag(memMap.get("vmnghpNo").toString()));
							rsUploadVO.setVmngEmail(EgovWebUtil.removeTag(memMap.get("vmngEmail").toString()));
							rsUploadVO.setItemCls(EgovWebUtil.removeTag(memMap.get("itemCls").toString()));
							rsUploadVO.setItemName(EgovWebUtil.removeTag(memMap.get("itemName").toString()));
							
							//비교 예시
							//if("Y".equals(rsUploadVO.getCorr()) || "Y".equals(rsUploadVO.getReporter())) {
								// 현지통신원, KREI리포터
								//rsUploadVO.setNote(EgovWebUtil.removeTag(memMap.get("note").toString()));				
							//}else {
								// 핵심고객, 통합배부처
								//rsUploadVO.setNote2(EgovWebUtil.removeTag(memMap.get("note").toString()));				
							//}
							
							// 유효성 검사
							Map<String, String> errors = MemberValidator.validate(rsUploadVO);
							if(errors.size()!=0) {
								message = "데이터 형식에 오류가 있어 연구과제 등록에 실패하였습니다.";
								reda.addFlashAttribute("errors", errors);
								return redirectListPage(reda, message, "");
							}
							
							// 중복검사
							EgovMap map = new EgovMap();
							
							map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							map.put("rsNo1", rsUploadVO.getRsNo1());
							map.put("rsNo2", rsUploadVO.getRsNo2());
							map.put("rsNo3", rsUploadVO.getRsNo3());
							map.put("rsNo4", rsUploadVO.getRsNo4());
							map.put("rsNo5", rsUploadVO.getRsNo5());
							map.put("rsNo6", rsUploadVO.getRsNo6());
							map.put("rsNo7", rsUploadVO.getRsNo7());
							List<EgovMap> list = ech0101DAO.selectEch0101DupRsList(map);
							
							if(list != null && list.size() >= 1) {
								memMap.put("dupMemList", list);
								excelDupMemList.add(memMap);
							}else {
								insertMemList.add(rsUploadVO);
							}
							
						}
						
					}
					
					if(isValid) {
						session.setAttribute("insertMemList", insertMemList);	// 중복 제거 신규 회원 목록
						LOGGER.debug("insertMemList="+insertMemList.toString());
						session.setAttribute("excelDupMemList", excelDupMemList);	// 중복 회원 목록
						LOGGER.debug("excelDupMemList="+excelDupMemList.toString());
						message = "검증 완료. 다음 버튼을 클릭하세요.";
						gubun = "2"; // 데이터 검증 탭으로 이동
					}
				}
			}
			
		}else{
			message = "첨부 파일 미존재";
		}

		return redirectListPage(reda, message, gubun);
		
	}
	

	// 연구과제 일괄등록 - Data 검증 화면
	@RequestMapping("/qxsepmny/ech0101/ech0101RsUpload2.do")
	public String ech0101RsUpload2(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxsepmny/ech0101/ech0101RsUpload2.do - {} 연구과제 일괄등록 > Data 검증 화면");
		LOGGER.debug("searchVO = "+searchVO.toString());

		// CSRF 토큰 공유
		CtmsCmmMethods.setCsrfToken(session);
		
		//if(!CtmsCmmMethods.checkMemPermit(key)) {
			//return CtmsCmmMethods.redirectProfileView;
		//}
		
		// 서브 메뉴설정
		//CtmsCmmMethods.setMenu(key, "03", session);
		
		// 쓰레기통 전체 회원 수.
		//CtmsCmmMethods.shareTrashMemCnt(model);
				
		return "/adm/ech0101/ech0101RsUpload";
	}
		
	//연구과제 일괄등록 - 연구과제 일괄 등록 처리 	
	@RequestMapping("/qxsepmny/ech0101/ech0101SaveRsData.do")
	public String ech0101SaveRsData(HttpServletRequest request, ModelMap model, Rs1010mVO rs1010mVO, HttpSession session, RedirectAttributes reda, String memType) throws Exception {
		LOGGER.info("/usr/mng/member/{}/saveMemData.do - {}, 회원 일괄 등록 - 연구과제 일괄 등록 처리");
	
		// CSRF 토큰 검사
		if(!CtmsCmmMethods.isCsrfToken(request, reda)){
		  return CtmsCmmMethods.redirectLoginView;
		}
		
		List<RsUploadVO> insertMemList = (List<RsUploadVO>) session.getAttribute("insertMemList");
		
		// 유효성 검사 통과 등록 작업.
		EgovMap map = new EgovMap();
		for(RsUploadVO rsUploadVO : insertMemList) {
			//연구계획서 정보 확인 
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("rsNo1", rsUploadVO.getRsNo1());
			map.put("rsNo2", rsUploadVO.getRsNo2());
			map.put("rsNo3", rsUploadVO.getRsNo3());
			map.put("rsNo4", rsUploadVO.getRsNo4());
			map.put("rsNo5", rsUploadVO.getRsNo5());
			map.put("rsNo6", rsUploadVO.getRsNo6());

			rs1010mVO = ech0101DAO.selectEch0101AjaxRsCdCheck2(map);
			
			if(!(rs1010mVO == null)) {
				rsUploadVO.setRsDrt(rs1010mVO.getRsDrt());
				rsUploadVO.setRsGrt(rs1010mVO.getRsGrt());
				rsUploadVO.setRsMscnt(rs1010mVO.getRsMscnt());
				rsUploadVO.setVisitCnt(rs1010mVO.getVisitCnt());
				rsUploadVO.setAgeSt(rs1010mVO.getAgeSt());
				rsUploadVO.setAgeEn(rs1010mVO.getAgeEn());
				rsUploadVO.setRsPos(rs1010mVO.getRsPos());
				rsUploadVO.setRsstCls(rs1010mVO.getRsstCls());
				rsUploadVO.setIrbsmYn(rs1010mVO.getIrbsmYn());
				rsUploadVO.setDuplYn(rs1010mVO.getDuplYn());
				rsUploadVO.setGenYn(rs1010mVO.getGenYn());
				rsUploadVO.setRsName(rs1010mVO.getRsName());
				rsUploadVO.setRsPps(rs1010mVO.getRsPps());
				rsUploadVO.setRsPtc(rs1010mVO.getRsPtc());
				rsUploadVO.setRsplDt(rs1010mVO.getRsplDt());
				rsUploadVO.setRsitDt(rs1010mVO.getRsitDt());
				rsUploadVO.setRsirbDt(rs1010mVO.getRsirbDt());
				rsUploadVO.setRsrStdt(rs1010mVO.getRsrStdt());
				rsUploadVO.setRsrEndt(rs1010mVO.getRsrEndt());
				rsUploadVO.setRsStdt(rs1010mVO.getRsStdt());
				rsUploadVO.setRsEndt(rs1010mVO.getRsEndt());
				rsUploadVO.setRep2Dt(rs1010mVO.getRep2Dt());
				rsUploadVO.setRepDt(rs1010mVO.getRepDt());
				
				rsUploadVO.setDelYn(rs1010mVO.getDelYn());
				rsUploadVO.setDataLockYn(rs1010mVO.getDataLockYn());
				rsUploadVO.setEcrfState(rs1010mVO.getEcrfState());
				rsUploadVO.setBranchCd(rs1010mVO.getBranchCd());
				
			}else {
				rsUploadVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				rsUploadVO.setRsDrt(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
				rsUploadVO.setRsGrt(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
				rsUploadVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
				rsUploadVO.setDelYn("N");
				rsUploadVO.setDataLockYn("N");
				rsUploadVO.setEcrfState("WAIT");
			}
			//기본값 설정 
			
			//제품정보 1010 화장품 1020 보습제 1030 수분제 코드(명칭) 분리하기
			if (!EgovStringUtil.isEmpty(rsUploadVO.getItemCls())) {
				String itemCls = rsUploadVO.getItemCls();
				
				String[] spitemCls = itemCls.split("/");
				rsUploadVO.setItemCls(spitemCls[1].toString());
			}
			
			rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
			LOGGER.info("rsUploadVO="+rsUploadVO.toString());
			
			ech0101DAO.insertEch0101RsUpload(rsUploadVO);
			
		}
		
		//작업 로그 등록 
		String dspCnt = insertMemList.size()+"건";
		admLogInsert("연구관리 > 연구과제 일괄등록", dspCnt, "", request);
		
		String message = "등록 완료되었습니다.";
		
		return redirectListPage(reda, message, "");
	}	

	// 연구계획서 가져오기 
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxRsCdCheck2.do")
	public View ech0105AjaxRsCdCheck2(String rsCd, String rsNo1, String rsNo2, String rsNo3, String rsNo4, String rsNo5, String rsNo6, Rs1010mVO rs1010mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0101/ech0101AjaxRsCdCheck2.do - 연구계획서 가져오기");
		LOGGER.debug("rsCd = " + rsCd);
		LOGGER.debug("rsNo1 = " + rsNo1);
		LOGGER.debug("rsNo2 = " + rsNo2);
		LOGGER.debug("rsNo3 = " + rsNo3);
		LOGGER.debug("rsNo4 = " + rsNo4);
		LOGGER.debug("rsNo5 = " + rsNo5);
		LOGGER.debug("rsNo6 = " + rsNo6);
		
		
		String message = "";
		boolean status = false;
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(rsCd)){
			
			EgovMap map = new EgovMap();
			//회사코드(CTMS운영) 설정
			map.put("corpCd", adminVO.getCorpCd());
			map.put("rsCd", rsCd);
			map.put("rsNo1", rsNo1);
			map.put("rsNo2", rsNo2);
			map.put("rsNo3", rsNo3);
			map.put("rsNo4", rsNo4);
			map.put("rsNo5", rsNo5);
			map.put("rsNo6", rsNo6);
			
			rs1010mVO = ech0101DAO.selectEch0101AjaxRsCdCheck2(map);
			
			if(rs1010mVO == null) {
				message = "등록된 연구계획서가 없습니다. 연구계획서를 먼저 등록하세요";
				status = false;
			}else {
				model.addAttribute("rs1010mVO", rs1010mVO);
				message = "연구계획서 정보가 설정되었습니다.";
				status = true;
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		
		
		return jsonView;
	}	
	
	// 연구차수 업데이트
	@RequestMapping("/qxsepmny/ech0101/ech0101AjaxUpdate.do")
	public View ech0101AjaxUpdate(Rs1000mVO rs1000mVO, String corpCd, String rsNo, String rsName, String vendNo, String vendName, String vmngName, String vmnghpNo, String vmngEmail, String itemCls, String itemName, String rsplDt, String repDt, String step1, String step2, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.info("/qxsepmny/ech0102/ech0101AjaxUpdate.do - 연구차수 업데이트");
		String message = "";
	
		LOGGER.debug("cordpCd= "+corpCd);
		LOGGER.debug("rsNo= "+rsNo);
		LOGGER.debug("rsName= "+rsName);
		LOGGER.debug("vendNo= "+vendNo);
		LOGGER.debug("vendName= "+vendName);
		LOGGER.debug("vmngName= "+vmngName);
		LOGGER.debug("vmnghpNo= "+vmnghpNo);
		LOGGER.debug("vmngEmail= "+vmngEmail);
		LOGGER.debug("itemCls= "+itemCls);
		LOGGER.debug("itemName= "+itemName);
		LOGGER.debug("rsplDt= "+rsplDt);
		LOGGER.debug("repDt= "+repDt);
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드, 작업자설정
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rs1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//초기값으로 설정함 
		rs1000mVO.setDataLockYn("N");
		rs1000mVO.setDelYn("N");
		//복수 지사가 참여하는 연구과제도 등록하는 연구담당자의 지사코드를 설정한다.
		rs1000mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		if(!rsplDt.isEmpty()) {
			rs1000mVO.setRsTstdt(rsplDt);
		}
		if(!repDt.isEmpty()) {
			rs1000mVO.setRsTendt(repDt);
		}

		//업데이트항목 설정 
		rs1000mVO.setRsNo(rsNo);
		rs1000mVO.setRsName(rsName);
		rs1000mVO.setVendNo(vendNo);
		rs1000mVO.setVendName(vendName);
		rs1000mVO.setVmngName(vmngName);
		rs1000mVO.setVmnghpNo(vmnghpNo);
		rs1000mVO.setVmngEmail(vmngEmail);
		rs1000mVO.setItemCls(itemCls);
		rs1000mVO.setItemName(itemName);
		
		ech0101DAO.updateEch0101RsCd(rs1000mVO);
		
		//심의결과가 승인인 경우 해당 연구과제를 진행상태로 변경한다.
		//연구과제, 참여지사, 참여자 
		//단, 예정인 경우만 변경 
		//if(rs5000mVO.getRvRs().equals("1")) {
			//ech0104DAO.updateEch0104RvRs(rs5000mVO);
			//ech0104DAO.updateEch0104BrSt(rs5000mVO);
			//ech0104DAO.updateEch0104EmpSt(rs5000mVO);
		//}
		
		
		message = "수정이 완료되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
		
	}
	
	
	
}
