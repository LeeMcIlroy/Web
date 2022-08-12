package ctms.adm.ech0210;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
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
import org.apache.pdfbox.pdmodel.PDDocument;
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
import ctms.valueObject.Cs2000mVO;
import ctms.valueObject.Cr2100mVO;
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

import com.ubireport.eform.UbiEformData;
import com.ubireport.viewer.report.preview.UbiViewer;
import com.ubireport.common.util.StrUtil;

@Controller
public class Ech0210Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0210Controller.class);
	@Autowired private Ech0210DAO ech0210DAO;
	@Autowired private Ech0104DAO ech0104DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//CRF템플릿관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0210List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0210/ech0210List.do";
	}
	
	//CRF템플릿관리 목록화면으로 리다이렉트합니다.
	private String redirectEch0210View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0210/ech0210View.do";
	}
	
	//CRF템플릿관리 일괄등록 목록으로 이동합니다.
	private String redirectListPage(RedirectAttributes reda, String message, String gubun){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0210/ech0210RsUpload"+gubun+".do";
	}
	
	/**
	 * CRF템플릿관리 목록
	 * 
	 * @param model
	 * @return CRF템플릿관리 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/qxsepmny/ech0210/ech0210List.do")
	public String ech0210List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0210/ech0210List.do -  CRF템플릿관리 목록");
		LOGGER.debug("searchVO List= " + searchVO.toString());
		//request.getSession().setAttribute("usrMenuNo", "101");
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 CRF템플릿관리 목록만 표시 
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
		
	 	//CRF템플릿분류(공통코드) 목록
		List<EgovMap> ct3020 = cmmDAO.selectCmmCdList(searchVO.getCorpCd(), "CT3020");
		model.addAttribute("ct3020", ct3020);
	 	
		//List<EgovMap> rsCdList = ech0210DAO.selectEch0210StaffList(map);
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
		
		CmmnListVO listVO = ech0210DAO.selectEch0210List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0210/ech0210List";
		
	}

	/**
	 * CRF템플릿관리 조회
	 * 
	 * @param model
	 * @return CRF템플릿관리 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0210/ech0210View.do")
	public String ech0210View(@ModelAttribute CmmnSearchVO searchVO, Cr2100mVO cr2100mVO, String paramKeyNo, HttpServletRequest request, HttpServletResponse response,  ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0210/ech0210View.do -  CRF템플릿관리 조회");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				//cr2100mVO.setTempNo(paramKeyNo);
			//}	
		//}
		
		cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//CRF템플릿정보 조회 
		cr2100mVO =  ech0210DAO.selectEch0210View(cr2100mVO);
		
		//작업권한 설정 
		//관리자 권한인지 여부 설정 isAdminType
		cr2100mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
		LOGGER.debug("setIsAdminType="+cr2100mVO.getIsAdminType());
		
		//해당 CRF템플릿관리의 연구책임자 Y 연구담당자 Y 삭제가능여부 Y - 상담등록자인 경우   
		if(cr2100mVO.getEmpNo().equals(adminVO.getEmpNo())) {
			cr2100mVO.setIsRsDrt("Y");
			cr2100mVO.setIsRsStaff("Y");
			cr2100mVO.setIsDelCntr("Y");
		}else {
			cr2100mVO.setIsRsDrt("N");
			cr2100mVO.setIsRsStaff("N");
			cr2100mVO.setIsDelCntr("N");
		}
		LOGGER.debug("setIsRsDrt="+cr2100mVO.getIsRsDrt());
		LOGGER.debug("setIsRsStaff="+cr2100mVO.getIsRsStaff());
		LOGGER.debug("setIsDelCntr="+cr2100mVO.getIsDelCntr());		
		
		//첨부파일 확인 
		EgovMap map2 = new EgovMap();
		map2.put("boardSeq", cr2100mVO.getTempNo());
		map2.put("boardType", "UBI4\\TMPL");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
		model.addAttribute("attachList", attachList);
		
		EgovMap attachMap = new EgovMap();
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}	
		
		
		model.addAttribute("attachMap", attachMap);
		
		model.addAttribute("cr2100mVO", cr2100mVO);
		//model.addAttribute("opList", opList.getEgovList());
		//model.addAttribute("ctrtList", ctrtList.getEgovList());
		//model.addAttribute("rsList", rsList.getEgovList());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO View="+searchVO.toString());
		
		return "/adm/ech0210/ech0210View";
		
	}

	/**
	 * CRF템플릿관리 수정&등록화면
	 * 
	 * @param model
	 * @return CRF템플릿관리 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0210/ech0210Modify.do")
	public String ech0210Modify(@ModelAttribute("cr2100mVO") Cr2100mVO cr2100mVO, String paramKeyNo, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0210/ech0210Modify.do -  CRF템플릿관리 수정&등록화면");
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정
		cr2100mVO.setCorpCd(adminVO.getCorpCd());
		
		//CRF템플릿분류(공통코드) 목록
		List<EgovMap> ct3020 = cmmDAO.selectCmmCdList(cr2100mVO.getCorpCd(), "CT3020");
		model.addAttribute("ct3020", ct3020);
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(cr2100mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//초기값 설정 
		cr2100mVO.setRegDt(EgovStringUtil.getDateMinus());
		cr2100mVO.setStDate(EgovStringUtil.getDateMinus());
		cr2100mVO.setEdDate("9999-12-31");
		cr2100mVO.setEmpNo(adminVO.getEmpNo());
		cr2100mVO.setEmpName(adminVO.getName());
		cr2100mVO.setBranchCd(adminVO.getBranchCd());
		
		//if(paramKeyNo != null) {
			//if(!paramKeyNo.isEmpty()) {
				//cr2100mVO.setTempNo(paramKeyNo);
			//}	
		//}
		
		if(!EgovStringUtil.isEmpty(cr2100mVO.getTempNo())){
			
			cr2100mVO = ech0210DAO.selectEch0210View(cr2100mVO);
			
			//첨부파일 확인
			EgovMap map2 = new EgovMap();
			map2.put("boardSeq", cr2100mVO.getTempNo());
			map2.put("boardType", "UBI4\\TMPL");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map2);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);

		}
		
		model.addAttribute("cr2100mVO", cr2100mVO);
		
		return "/adm/ech0210/ech0210Modify";
	}
	
	/**
	 * CRF템플릿관리 수정&등록
	 * 
	 * @param model
	 * @return CRF템플릿관리 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0210/ech0210Update.do")
	public String ech0210Update(@ModelAttribute("cr2100mVO") Cr2100mVO cr2100mVO, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda, HttpServletResponse response) throws Exception {
		LOGGER.debug("/qxsepmny/ech0210/ech0210Update.do -  CRF템플릿관리 수정&등록");
		LOGGER.debug("+++++++++++++++++++++++++++++++++");
		//LOGGER.debug(rsPos.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		cr2100mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		cr2100mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//복수 지사가 참여하는 CRF템플릿관리도 등록하는 연구담당자의 지사코드를 설정한다.
		cr2100mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(cr2100mVO.getTempNo())){
			
			//고유번호 설정 필요함
			cr2100mVO.setTempNo1("CRF");
			LOGGER.debug("getTempNo1()= "+cr2100mVO.getTempNo1());
			//템플릿관리에서 생성 설정
			cr2100mVO.setMkType("1");
			String tempNo = ech0210DAO.insertEch0210(cr2100mVO);
			cr2100mVO.setTempNo(tempNo);
			
			message = "등록이 완료되었습니다.";
		}else{
			ech0210DAO.updateEch0210(cr2100mVO);
			
			message = "수정이 완료되었습니다.";
			
			if(delFile != null){
				for(String seq : delFile){
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());					
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		}
				
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "UBI4\\TMPL");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("UBI4\\TMPL");
				attachVO.setBoardNo(cr2100mVO.getTempNo());
				attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
				attachVO.setRegDate(EgovStringUtil.getDateMinus());
				cmmDAO.insertAttachFile(attachVO);
								
				//페이지 구성쪽수 Update 처리 Start  
				//파일이 첨부된 경우만 구성쪽수가 자동설정된다. 연구대상자특성,사용성설문,효능설문은 CRF설정관리 메뉴에서 템플릿 선택시 자동 설정됩니다.
				String appName = StrUtil.nvl(request.getContextPath(), "");
				if( "/".equals(appName) )
					appName = "";
				String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + appName;
				
				String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
				File uFile = new File(UPLOAD_HOME, attachVO.getRegFileName());
				LOGGER.debug("uFile= "+uFile);
				
				String savePath = UPLOAD_HOME;
				
				String saveFileName = "";
				String saveFullPath = "";
				String typePath = "";
				
				saveFileName = EgovStringUtil.getTimeStamp() + "." + "pdf";
				LOGGER.debug("saveFileName= "+saveFileName);
				
				saveFullPath = savePath + saveFileName;
				
				//UI에서 호출될 때 필요한 정보 - 사용안함
				String jrf = StrUtil.nvl(request.getParameter("jrf"), "ubi_sample.jrf");
				String arg = StrUtil.nvl(request.getParameter("arg"), "user#홍길동#company#유비디시전#");

				//환경에 맞게 설정해야함
				String rootUrl = appUrl;
				String serverUrl = (appUrl + "/UbiServer");
				String fileUrl = (appUrl + "/ubi4/resource");
				String resource = "fixed";
				//String jrfDir = (appPath + "/ubi4/work/");
				String dataSource = "Tutorial";

				String exportFileType = "PDF";
				//String exportPath = appPath + "/ubi4/storage/";
				String exportFileName = jrf.substring(0, jrf.lastIndexOf(".")) + ".pdf";
				//String exportFilePath = exportPath + java.io.File.separator + exportFileName;
				
				String exportFilePath = saveFullPath;
				
				UbiViewer ubi = new UbiViewer(false, false);
				
				ubi.exectype = "TYPE6";
				//ubi.fileURL = fileUrl;
				ubi.resource = resource;
				ubi.ubiServerURL = serverUrl;
				ubi.isLocalFile = true;
				ubi.dataSource = dataSource;
				//ubi.jrfFileDir = "D:/WAS_JAVA/FactCTMS_HNB/Files/upload/attach/UBI4/TMPL/";
				ubi.jrfFileDir = UPLOAD_HOME+"/UBI4/TMPL/";
				
				String regFileName = "";
				regFileName = attachVO.getRegFileName();
				int pos = regFileName.lastIndexOf( "\\" );
				regFileName = regFileName.substring( pos + 1 );
				
				ubi.jrfFileName = regFileName;
				
				LOGGER.debug("regFileName= "+regFileName);
				
				ubi.arg = arg;				
				
				ubi.setExportParams(exportFileType, exportFilePath);
				
				boolean isSuccess = ubi.loadReport();
				//out.clearBuffer();
				
				PDDocument doc = PDDocument.load(new File(savePath, saveFileName));
				int count = doc.getNumberOfPages();
				doc.close();
				
				LOGGER.debug("pdf count="+count);	
				
				//구성페이지수를 업데이트 한다. CR2100M UPAGE_CNT 
				cr2100mVO.setUpageCnt(Integer.toString(count));
				ech0210DAO.updateEch0210UpageCnt(cr2100mVO);
				
				//생성된  pdf파일을 삭제한다.
				fileUtil.deleteFile("/"+saveFileName);
				
				//페이지 구성쪽수 Update 처리 End
				
			}
		}
		
		return redirectEch0210List(reda, message);
	}
	
	/**
	 * CRF템플릿관리 삭제
	 * 
	 * @param model
	 * @return CRF템플릿관리 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0210/ech0210Delete.do")
	public String ech0210Delete(@ModelAttribute("cr2100mVO") Cr2100mVO cr2100mVO, Cs2000mVO cs2000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0210/ech0210Delete.do -  CRF템플릿관리 삭제");
		LOGGER.debug("cr2100mVO = " + cr2100mVO.toString());
		String message = "존재하지 않는 CRF템플릿관리입니다.";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(cr2100mVO.getTempNo())){
			
			//CRF템플릿사용정보를 확인한다
			//cs2000mVO.setCorpCd(cr2100mVO.getCorpCd());
			//cs2000mVO.setTempNo(cr2100mVO.getTempNo());
			//int chkCtrt = ech0210DAO.selectEch0210CtrtCnt(cs2000mVO);
			int chkTempUse = 0;
			if(chkTempUse > 0) {
				message = "사용정보가 존재해서 해당 CRF템플릿정보를 삭제를 할 수 없습니다.";
			}else {
				int chk = ech0210DAO.deleteEch0210(cr2100mVO);
				LOGGER.debug("chk = " +chk);
				
				//첨부파일 삭제
				if(chk > 0){
					EgovMap map = new EgovMap();
					map.put("boardSeq", cr2100mVO.getTempNo());
					map.put("boardType", "UBI4\\TMPL");
					List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
					
					for(Ct7000mVO attachVO : attachList){
						cmmDAO.deleteAttachFile(attachVO.getAttachNo());
						fileUtil.deleteFile(attachVO.getRegFileName());
					}
				}
				
				message = "CRF템플릿정보 삭제가 완료되었습니다.";
			}
		}
		return redirectEch0210List(reda, message);
	}
	
	/**
	 * CRF템플릿관리 엑셀다운로드
	 * 
	 * @param model
	 * @return CRF템플릿관리 목록 엑셀다운로드
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0210/ech0210Excel.do")
	public void ech0210Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0210/ech0210Excel.do - CRF템플릿관리 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		String message = "";
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0210DAO.selectEch0210Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "CRF템플릿관리 리스트", "ech0210", request, response);
		
	}

	// CRF템플릿 일괄다운로드
	@RequestMapping("/qxsepmny/ech0210/ech0210ZipDownloadCrfTemp.do")
	public void ech0210ZipDownloadCrfTemp(@ModelAttribute("searchVO") CmmnSearchVO searchVO, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.info("/qxsepmny/ech0210/ech0210ZipDownloadCrfTemp.do - CRF템플릿 일괄다운로드");
		int bufferSize = 1024*8;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar cal = Calendar.getInstance();	
		
		String outputName = sdf.format(cal.getTime()) + "_CRF템플릿일괄다운로드";
		
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setContentType("application/x-msdownload");
		setDisposition(outputName, request, response);
		
		BufferedOutputStream out = null;
		ZipOutputStream zos = null;
		
		try {
			out = new BufferedOutputStream(response.getOutputStream());
		    out.flush();
		    
		    zos = new ZipOutputStream(response.getOutputStream()); 
			zos.setLevel(8);
			BufferedInputStream bis = null;
		
			searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			
			//CRF템플릿 목록 획득 
			List<EgovMap> resultList = ech0210DAO.selectEch0210ListCrfTemp(searchVO);
			
			EgovMap paramMap = new EgovMap();
			//CRF템플릿 첨부파일 획득
			for(EgovMap result : resultList){
				String mapKey = (String) result.get("tempNo");
	        	paramMap.put("boardSeq", mapKey);
	        	paramMap.put("boardType", "UBI4\\TMPL");
	        	List<Ct7000mVO> fileList = cmmDAO.selectAttachList(paramMap);
	        		        	
	        	if(!fileList.isEmpty()) {
					for(Ct7000mVO fileMap : fileList){
						String fileName = "";
						LOGGER.info("check=");
						//if(!(String.valueOf(result.get("boardNo")) =="null") && !(String.valueOf(result.get("boardType"))=="null" )){
							//fileName += result.get("boardNo").toString()+"_"+result.get("boardType").toString()+"_"+fileMap.getOrgFileName();
						//}
						fileName += result.get("tempCd").toString()+"_"+fileMap.getOrgFileName();
						LOGGER.info("fileName="+fileName);

						String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
						/*File file = new File(UPLOAD_HOME, fileMap.get("upSaveFilePath").toString());*/
						File file = new File(UPLOAD_HOME, fileMap.getRegFileName() );
						LOGGER.info("file.getPath()="+file.getPath());
						LOGGER.info("file.toString()="+file.toString());
						
						bis = new BufferedInputStream(new FileInputStream(file));
						ZipEntry zentry = new ZipEntry(fileName);
						zentry.setTime(file.lastModified());
						zos.putNextEntry(zentry);
						byte[] buffer = new byte[bufferSize];
						int cnt = 0;
						
						while ((cnt = bis.read(buffer, 0, bufferSize)) != -1) {
							zos.write(buffer, 0, cnt);
							LOGGER.info("file write");
						}
						zos.closeEntry();
						bis.close();
					}
	        	}

			}
			zos.finish();
			zos.close();
			//bis.close();
			
		} catch (Exception ex) {
		    LOGGER.debug("IGNORED (cat): " + ex.getMessage() + " :str: "+ ex.toString());
		} finally {
		    if (out != null) {
				try {
				    out.close();
				} catch (Exception ignore) {
					LOGGER.debug("IGNORED (final): " + ignore.getMessage());
				}
		    }
		}
	}

	private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			//throw new RuntimeException("Not supported browser");
			throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename + ".zip;");

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}
	
	/**
	 * 브라우저 구분 얻기.
	 *
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
			return "Trident";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}
}
