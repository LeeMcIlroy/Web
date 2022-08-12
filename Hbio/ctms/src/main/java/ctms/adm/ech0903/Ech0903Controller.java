package ctms.adm.ech0903;

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
import ctms.valueObject.Cs1020mVO;
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
public class Ech0903Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0903Controller.class);
	@Autowired private Ech0903DAO ech0903DAO;
	@Autowired private Ech0104DAO ech0104DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//계약관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0903List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0903/ech0903List.do";
	}
	
	//계약관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0903View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0903/ech0903View.do";
	}
	
	//계약관리 일괄등록 목록으로 이동합니다.
	private String redirectListPage(RedirectAttributes reda, String message, String gubun){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0903/ech0903RsUpload"+gubun+".do";
	}
	
	/**
	 * 계약관리 목록
	 * 
	 * @param model
	 * @return 계약관리 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/qxsepmny/ech0903/ech0903List.do")
	public String ech0903List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0903/ech0903List.do -  계약관리 목록");
		LOGGER.debug("searchVO List= " + searchVO.toString());
		//request.getSession().setAttribute("usrMenuNo", "101");
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 계약관리 목록만 표시 
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
		
		//List<EgovMap> rsCdList = ech0903DAO.selectEch0903StaffList(map);
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
		
		CmmnListVO listVO = ech0903DAO.selectEch0903List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0903/ech0903List";
		
	}

	/**
	 * 계약관리 조회
	 * 
	 * @param model
	 * @return 계약관리 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0903/ech0903View.do")
	public String ech0903View(@ModelAttribute CmmnSearchVO searchVO, Cs2000mVO cs2000mVO, String paramKeyNo, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0903/ech0903View.do -  계약관리 조회");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cs2000mVO.setCtrtNo(paramKeyNo);
			//}	
		//}
		
		cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//계약정보 조회		
		cs2000mVO =  ech0903DAO.selectEch0903View(cs2000mVO);
		
		DecimalFormat formatter = new DecimalFormat("###,###");
		//누적입금액,잔금,연구비,부가세,계약금액 숫자변환 
		cs2000mVO.setInBamt(formatter.format(Integer.parseInt(cs2000mVO.getInBamt())));
		cs2000mVO.setInTamt(formatter.format(Integer.parseInt(cs2000mVO.getInTamt())));
		cs2000mVO.setRsPay(formatter.format(Integer.parseInt(cs2000mVO.getRsPay())));
		cs2000mVO.setRsPayvt(formatter.format(Integer.parseInt(cs2000mVO.getRsPayvt())));
		cs2000mVO.setRsTpay(formatter.format(Integer.parseInt(cs2000mVO.getRsTpay())));
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("vendNo", cs2000mVO.getVendNo());
		map.put("ctrtNo", cs2000mVO.getCtrtNo());
		
		//입금정보 목록
		CmmnListVO inList = ech0903DAO.selectEch0903InList(map);
		
		//견적정보 목록
		CmmnListVO csList = ech0903DAO.selectEch0903CsList(map);
		
		//견적정보 목록
		CmmnListVO opList = ech0903DAO.selectEch0903OpList(map);		
		
		//계약정보 목록
		//CmmnListVO ctrtList = ech0903DAO.selectEch0903CtrtList(map);
				
		//연구과제 정보 목록
		//CmmnListVO rsList = ech0903DAO.selectEch0903RsList(map);		
		
		//작업권한 설정 
		//관리자 권한인지 여부 설정 isAdminType
		cs2000mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
		LOGGER.debug("setIsAdminType="+cs2000mVO.getIsAdminType());
		
		//해당 계약관리의 연구책임자 Y 연구담당자 Y 삭제가능여부 Y - 상담등록자인 경우   
		if(cs2000mVO.getEmpNo().equals(adminVO.getEmpNo())) {
			cs2000mVO.setIsRsDrt("Y");
			cs2000mVO.setIsRsStaff("Y");
			cs2000mVO.setIsDelCntr("Y");
		}else {
			cs2000mVO.setIsRsDrt("N");
			cs2000mVO.setIsRsStaff("N");
			cs2000mVO.setIsDelCntr("N");
		}
		LOGGER.debug("setIsRsDrt="+cs2000mVO.getIsRsDrt());
		LOGGER.debug("setIsRsStaff="+cs2000mVO.getIsRsStaff());
		LOGGER.debug("setIsDelCntr="+cs2000mVO.getIsDelCntr());		
		
		//첨부파일 확인 - 기능없음
		//EgovMap map1 = new EgovMap();
		//map1.put("boardSeq", cs2000mVO.getOpNo());
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
		map2.put("boardSeq", cs2000mVO.getCtrtNo());
		map2.put("boardType", "CTRT");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
		model.addAttribute("attachList", attachList);
		
		EgovMap attachMap = new EgovMap();
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		model.addAttribute("attachMap", attachMap);		
		
		model.addAttribute("cs2000mVO", cs2000mVO);
		model.addAttribute("inList", inList.getEgovList());
		model.addAttribute("csList", csList.getEgovList());
		model.addAttribute("opList", opList.getEgovList());
		//model.addAttribute("ctrtList", ctrtList.getEgovList());
		//model.addAttribute("rsList", rsList.getEgovList());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO View="+searchVO.toString());
		
		return "/adm/ech0903/ech0903View";
		
	}

	/**
	 * 계약관리 수정&등록화면
	 * 
	 * @param model
	 * @return 계약관리 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0903/ech0903Modify.do")
	public String ech0903Modify(@ModelAttribute("cs2000mVO") Cs2000mVO cs2000mVO, String opNo1, String paramKeyNo, Cs1020mVO cs1020mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0903/ech0903Modify.do -  계약관리 수정&등록화면");
		LOGGER.debug("opNo1= "+opNo1);
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정
		cs2000mVO.setCorpCd(adminVO.getCorpCd());
		
		//계약분류(공통코드) 목록
		List<EgovMap> cm1360 = cmmDAO.selectCmmCdList(cs2000mVO.getCorpCd(), "CM1360");
		model.addAttribute("cm1360", cm1360);
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(cs2000mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//초기값 설정 
		cs2000mVO.setCtrtDt(EgovStringUtil.getDateMinus());
		cs2000mVO.setCtrtStdt(EgovStringUtil.getDateMinus());
		cs2000mVO.setCtrtEndt(EgovStringUtil.getDateMinus());
		cs2000mVO.setEmpNo(adminVO.getEmpNo());
		cs2000mVO.setEmpName(adminVO.getName());
		cs2000mVO.setBranchCd(adminVO.getBranchCd());
		
		//opNo값이 있으면 견적서조회하여 초기값을 설정한다.
		//opNo값이 있고 ctrtNo 값이 없는 경우 - 견적화면에서 계약바로등록을 선택한 경우
		if(!cs2000mVO.getOpNo().isEmpty()) {
			if(cs2000mVO.getCtrtNo().isEmpty()) {
				cs1020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cs1020mVO.setOpNo(opNo1);
				cs1020mVO = ech0903DAO.selectEch0903OpView(cs1020mVO);
				cs2000mVO.setOpCd(cs1020mVO.getOpCd());
				cs2000mVO.setOpNo(cs1020mVO.getOpNo());
				cs2000mVO.setCtrtCls(cs1020mVO.getOpCls());
				cs2000mVO.setCtrtClsNm(cs1020mVO.getOpClsNm());
				
				DecimalFormat formatter = new DecimalFormat("###,###");
				//누적입금액,잔금,연구비,부가세,계약금액 숫자변환 
				cs2000mVO.setRsPay(formatter.format(Integer.parseInt(cs1020mVO.getRsPay())));
				cs2000mVO.setRsPayvt(formatter.format(Integer.parseInt(cs1020mVO.getRsPayvt())));
				cs2000mVO.setRsTpay(formatter.format(Integer.parseInt(cs1020mVO.getRsTpay())));
				
				cs2000mVO.setVendNo(cs1020mVO.getVendNo());
				cs2000mVO.setVendName(cs1020mVO.getVendName());
				
				cs2000mVO.setVmngName(cs1020mVO.getVmngName());
				cs2000mVO.setVmnghpNo(cs1020mVO.getVmnghpNo());
				cs2000mVO.setVmngEmail(cs1020mVO.getVmngEmail());
				
				cs2000mVO.setCtrtName(cs1020mVO.getOpName());
			}
		}
		//if(opNo1 != null) {
			//if(!opNo1.isEmpty()) {
				//cs1020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cs1020mVO.setOpNo(opNo1);
				//cs1020mVO = ech0903DAO.selectEch0903OpView(cs1020mVO);
				//cs2000mVO.setOpCd(cs1020mVO.getOpCd());
				//cs2000mVO.setOpNo(cs1020mVO.getOpNo());
				//cs2000mVO.setCtrtCls(cs1020mVO.getOpCls());
				//cs2000mVO.setCtrtClsNm(cs1020mVO.getOpClsNm());
				
				//DecimalFormat formatter = new DecimalFormat("###,###");
				//누적입금액,잔금,연구비,부가세,계약금액 숫자변환 
				//cs2000mVO.setRsPay(formatter.format(Integer.parseInt(cs1020mVO.getRsPay())));
				//cs2000mVO.setRsPayvt(formatter.format(Integer.parseInt(cs1020mVO.getRsPayvt())));
				//cs2000mVO.setRsTpay(formatter.format(Integer.parseInt(cs1020mVO.getRsTpay())));
				
				//cs2000mVO.setVendNo(cs1020mVO.getVendNo());
				//cs2000mVO.setVendName(cs1020mVO.getVendName());
				
				//cs2000mVO.setVmngName(cs1020mVO.getVmngName());
				//cs2000mVO.setVmnghpNo(cs1020mVO.getVmnghpNo());
				//cs2000mVO.setVmngEmail(cs1020mVO.getVmngEmail());
				
				//cs2000mVO.setCtrtName(cs1020mVO.getOpName());
			//}
		//}
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cs2000mVO.setCtrtNo(paramKeyNo);
			//}	
		//}
		
		if(!EgovStringUtil.isEmpty(cs2000mVO.getCtrtNo())){
			
			cs2000mVO = ech0903DAO.selectEch0903View(cs2000mVO);
			
			DecimalFormat formatter = new DecimalFormat("###,###");
			//누적입금액,잔금,연구비,부가세,계약금액 숫자변환 
			cs2000mVO.setInBamt(formatter.format(Integer.parseInt(cs2000mVO.getInBamt())));
			cs2000mVO.setInTamt(formatter.format(Integer.parseInt(cs2000mVO.getInTamt())));
			cs2000mVO.setRsPay(formatter.format(Integer.parseInt(cs2000mVO.getRsPay())));
			cs2000mVO.setRsPayvt(formatter.format(Integer.parseInt(cs2000mVO.getRsPayvt())));
			cs2000mVO.setRsTpay(formatter.format(Integer.parseInt(cs2000mVO.getRsTpay())));
	
			EgovMap map = new EgovMap();
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("vendNo", cs2000mVO.getVendNo());
			
			//견적서정보 목록
			//CmmnListVO opList = ech0903DAO.selectEch0903OpList(map);		
			
			//계약정보 목록
			//CmmnListVO ctrtList = ech0903DAO.selectEch0903CtrtList(map);
					
			//연구과제 정보 목록
			//CmmnListVO rsList = ech0903DAO.selectEch0903RsList(map);
			
			//model.addAttribute("opList", opList.getEgovList());
			//model.addAttribute("ctrtList", ctrtList.getEgovList());
			//model.addAttribute("rsList", rsList.getEgovList());
			
			//첨부파일 확인
			EgovMap map2 = new EgovMap();
			map2.put("boardSeq", cs2000mVO.getCtrtNo());
			map2.put("boardType", "CTRT");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);

		}
		
		model.addAttribute("cs2000mVO", cs2000mVO);
		
		return "/adm/ech0903/ech0903Modify";
	}
	
	/**
	 * 계약관리 수정&등록
	 * 
	 * @param model
	 * @return 계약관리 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0903/ech0903Update.do")
	public String ech0903Update(@ModelAttribute("cs2000mVO") Cs2000mVO cs2000mVO, String[] rsPos, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0903/ech0903Update.do -  계약관리 수정&등록");
		LOGGER.debug("+++++++++++++++++++++++++++++++++");
		//LOGGER.debug(rsPos.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		cs2000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//복수 지사가 참여하는 계약관리도 등록하는 연구담당자의 지사코드를 설정한다.
		cs2000mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(cs2000mVO.getCtrtNo())){
			
			cs2000mVO.setCtrtNo1(adminVO.getCtrtNo1());
			String csNo = ech0903DAO.insertEch0903(cs2000mVO);
			cs2000mVO.setOpNo(csNo);
			
			message = "등록이 완료되었습니다.";
		}else{
			cs2000mVO.setInBamt(Integer.toString(Integer.parseInt(cs2000mVO.getRsTpay()) - Integer.parseInt(cs2000mVO.getInTamt())));
			ech0903DAO.updateEch0903(cs2000mVO);
			
			message = "수정이 완료되었습니다.";
			
			if(delFile != null){
				for(String seq : delFile){
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "CTRT");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("CTRT");
				attachVO.setBoardNo(cs2000mVO.getCtrtNo());
				attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
				attachVO.setRegDate(EgovStringUtil.getDateMinus());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectEch0903List(reda, message);
	}
	
	/**
	 * 계약관리 삭제
	 * 
	 * @param model
	 * @return 계약관리 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0903/ech0903Delete.do")
	public String ech0903Delete(@ModelAttribute("cs2000mVO") Cs2000mVO cs2000mVO, Cs2020mVO cs2020mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0903/ech0903Delete.do -  계약관리 삭제");
		LOGGER.debug("cs2000mVO = " + cs2000mVO.toString());
		String message = "존재하지 않는 계약관리입니다.";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(cs2000mVO.getCtrtNo())){
			
			//입금정보를 확인한다
			cs2020mVO.setCorpCd(cs2000mVO.getCorpCd());
			cs2020mVO.setCtrtNo(cs2000mVO.getCtrtNo());
			int cin = ech0903DAO.selectEch0903InCnt(cs2020mVO);
			if(cin > 0) {
				message = "입금정보가 존재해서 해당 계약정보 삭제를 할 수 없습니다.";
			}else {
				int chk = ech0903DAO.deleteEch0903(cs2000mVO);
				LOGGER.debug("chk = " +chk);
				
				//첨부파일 삭제
				if(chk > 0){
					EgovMap map = new EgovMap();
					map.put("boardSeq", cs2000mVO.getCtrtNo());
					map.put("boardType", "CTRT");
					List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
					
					for(Ct7000mVO attachVO : attachList){
						cmmDAO.deleteAttachFile(attachVO.getAttachNo());
						fileUtil.deleteFile(attachVO.getRegFileName());
					}
				}
				message = "해당 계약정보 삭제가 완료되었습니다.";
			}
			
		}
		
		return redirectEch0903List(reda, message);
	}
	
	/**
	 * 계약관리 엑셀다운로드
	 * 
	 * @param model
	 * @return 계약관리 목록 엑셀다운로드
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0903/ech0903Excel.do")
	public void ech0903Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0903/ech0903Excel.do - 계약관리 엑셀 다운로드");
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
		 * println("<script>alert('엑셀다운로드권한이 허용되지 않습니다.관리자에게 문의하세요!'); location.href='/qxsepmny/ech0903/ech0903List.do';</script>"
		 * ); out.flush(); } else {
		 * 
		 * //엑셀다운로드 로직 }
		 */
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0903DAO.selectEch0903Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "계약관리 리스트", "ech0903", request, response);
		
	}
	
	// 계약정보 일괄삭제
	@RequestMapping("/qxsepmny/ech0903/ech0903AjaxCtrtDel.do")
	public View ech0903AjaxCtrtDel(String corpCd, String step1,String step2, String[] keySeq, Cs2000mVO cs2000mVO, Cs2020mVO cs2020mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0903/ech0903AjaxCtrtDel.do - 계약정보 일괄삭제");
		LOGGER.debug("keySeq="+keySeq.toString());
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("step1", step1);
		//map.put("step2", step2);
		map.put("keySeq", keySeq);
		
		//삭제대상이 있는지 확인한다. 
		int chkCnt = ech0903DAO.selectEch0903AjaxCtrtDel(map);
		LOGGER.debug("chkCnt="+chkCnt);
		
		if(chkCnt == 0) {
			message = "삭제대상이 없습니다.";
		}else {
			//계약정보 일괄삭제 - 입금정보가 있는 경우 삭제 안함 
			ech0903DAO.deleteEch0903AjaxCtrtDel(map);
			message = chkCnt+" 건 삭제되었습니다.";
			
			for(int i=0;i<keySeq.length;i++) {
				//입금정보를 확인한다
				cs2020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				cs2020mVO.setCtrtNo(keySeq[i]);
				int chkIn = ech0903DAO.selectEch0903InCnt(cs2020mVO);
				if(chkIn == 0) { //입금정보가 없는 경우만 첨부파일 삭제 
					EgovMap map2 = new EgovMap();
					map2.put("boardSeq", keySeq[i]);
					map2.put("boardType", "CTRT");
					List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
					
					for(Ct7000mVO attachVO : attachList){
						cmmDAO.deleteAttachFile(attachVO.getAttachNo());
						fileUtil.deleteFile(attachVO.getRegFileName());
					}					
				}	
			}
			
			//작업 로그 등록 
			String dspCnt = chkCnt+"건";
			admLogInsert("영업관리 > 계약정보 일괄삭제", dspCnt, "1010", request);
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
			
		}
	
		
	
	
}
