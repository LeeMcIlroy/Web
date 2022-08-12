package ctms.adm.ech0106;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import component.file.FileInfoVO;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.adm.ech0104.Ech0104DAO;
import ctms.cmm.CmmDAO;
import ctms.cmm.CtmsCmmMethods;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs3000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class Ech0106Controller extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0106Controller.class);
	@Autowired private Ech0106DAO ech0106DAO;
	@Autowired private Ech0104DAO ech0104DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		
	//시험제품 목록화면으로 리다이렉트합니다.
	private String redirectEch0106List(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0106/ech0106List.do";
	}
	
	//시험제품 목록화면으로 리다이렉트합니다.
	private String redirectEch0106View(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0106/ech0106View.do";
	}
	
	//시험제품 일괄등록 목록으로 이동합니다.
	private String redirectListPage(RedirectAttributes reda, String message, String gubun){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0106/ech0106ItemUpload"+gubun+".do";
	}
	
	/**
	 * 시험제품 목록
	 * 
	 * @param model
	 * @return 시험제품 목록화면
	 * @throws Exception
	 */	
	
	@RequestMapping("/qxsepmny/ech0106/ech0106List.do")
	public String ech0106List(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0106/ech0106List.do -  시험제품 목록");
		LOGGER.debug("searchVO List= " + searchVO.toString());
		//request.getSession().setAttribute("usrMenuNo", "101");
		
		//검색항목 설정 시작
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 시험제품 목록만 표시 
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
		
		//List<EgovMap> rsCdList = ech0106DAO.selectEch0106StaffList(map);
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
		
		CmmnListVO listVO = ech0106DAO.selectEch0106List(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0106/ech0106List";
		
	}

	/**
	 * 시험제품 조회
	 * 
	 * @param model
	 * @return 시험제품 조회화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0106/ech0106View.do")
	public String ech0106View(@ModelAttribute CmmnSearchVO searchVO, Rs3000mVO rs3000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0106/ech0106View.do -  시험제품 조회");
		LOGGER.debug("rs3000mVO="+rs3000mVO.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		//시험제품정보 조회 
		rs3000mVO =  ech0106DAO.selectEch0106View(rs3000mVO);
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("vendNo", rs3000mVO.getVendNo());
		
		//상담정보 목록
		CmmnListVO csList = ech0106DAO.selectEch0106CsList(map);
		
		//견적정보 목록
		CmmnListVO opList = ech0106DAO.selectEch0106OpList(map);		
		
		//계약정보 목록
		//CmmnListVO ctrtList = ech0106DAO.selectEch0106CtrtList(map);
				
		//연구과제 정보 목록
		//CmmnListVO rsList = ech0106DAO.selectEch0106RsList(map);		
		
		//작업권한 설정 
		//관리자 권한인지 여부 설정 isAdminType
		rs3000mVO.setIsAdminType(adminVO.getAdminType()); // 1 어드민권한  2 일반사용자
		LOGGER.debug("setIsAdminType="+rs3000mVO.getIsAdminType());
		
		//해당 시험제품의 연구책임자 Y 연구담당자 Y 삭제가능여부 Y - 상담등록자인 경우   
		if(rs3000mVO.getEmpNo().equals(adminVO.getEmpNo())) {
			rs3000mVO.setIsRsDrt("Y");
			rs3000mVO.setIsRsStaff("Y");
			rs3000mVO.setIsDelCntr("Y");
		}else {
			rs3000mVO.setIsRsDrt("N");
			rs3000mVO.setIsRsStaff("N");
			rs3000mVO.setIsDelCntr("N");
		}
		LOGGER.debug("setIsRsDrt="+rs3000mVO.getIsRsDrt());
		LOGGER.debug("setIsRsStaff="+rs3000mVO.getIsRsStaff());
		LOGGER.debug("setIsDelCntr="+rs3000mVO.getIsDelCntr());		
		
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
		
		model.addAttribute("rs3000mVO", rs3000mVO);
		model.addAttribute("csList", csList.getEgovList());
		model.addAttribute("opList", opList.getEgovList());
		//model.addAttribute("ctrtList", ctrtList.getEgovList());
		//model.addAttribute("rsList", rsList.getEgovList());
		
		//검색조건 유지 설정
		model.addAttribute("searchVO", searchVO);
		LOGGER.debug("searchVO View="+searchVO.toString());
		
		return "/adm/ech0106/ech0106View";
		
	}

	/**
	 * 시험제품 수정&등록화면
	 * 
	 * @param model
	 * @return 시험제품 수정&등록화면
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0106/ech0106Modify.do")
	public String ech0106Modify(@ModelAttribute("rs3000mVO") Rs3000mVO rs3000mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0106/ech0106Modify.do -  시험제품 수정&등록화면");
		LOGGER.debug("rs3000mVO="+rs3000mVO.toString());
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정
		rs3000mVO.setCorpCd(adminVO.getCorpCd());
		
		//입금분류(공통코드) 목록
		//List<EgovMap> cm1360 = cmmDAO.selectCmmCdList(rs3000mVO.getCorpCd(), "CM1360");
		//model.addAttribute("cm1360", cm1360);
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(rs3000mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//제품구분(공통코드) 목록
		List<EgovMap> ct2040 = cmmDAO.selectCmmCdList(rs3000mVO.getCorpCd(), "CT2040");
		model.addAttribute("ct2040", ct2040);
		
		//입고일을 오늘일자 설정 
		rs3000mVO.setInhDt(EgovStringUtil.getDateMinus());
		
		if(!EgovStringUtil.isEmpty(rs3000mVO.getItemNo())){
			
			rs3000mVO = ech0106DAO.selectEch0106View(rs3000mVO);
	
			EgovMap map = new EgovMap();
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("vendNo", rs3000mVO.getVendNo());
			
			//견적서정보 목록
			//CmmnListVO opList = ech0106DAO.selectEch0106OpList(map);		
			
			//계약정보 목록
			//CmmnListVO ctrtList = ech0106DAO.selectEch0106CtrtList(map);
					
			//연구과제 정보 목록
			//CmmnListVO rsList = ech0106DAO.selectEch0106RsList(map);
			
			//model.addAttribute("opList", opList.getEgovList());
			//model.addAttribute("ctrtList", ctrtList.getEgovList());
			//model.addAttribute("rsList", rsList.getEgovList());

		}
		
		model.addAttribute("rs3000mVO", rs3000mVO);
		
		return "/adm/ech0106/ech0106Modify";
	}
	
	/**
	 * 시험제품 수정&등록
	 * 
	 * @param model
	 * @return 시험제품 수정&등록
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0106/ech0106Update.do")
	public String ech0106Update(@ModelAttribute("rs3000mVO") Rs3000mVO rs3000mVO, String[] rsPos, String[] delFile, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0106/ech0106Update.do -  시험제품 수정&등록");
		LOGGER.debug("+++++++++++++++++++++++++++++++++");
		//LOGGER.debug(rsPos.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		rs3000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rs3000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//복수 지사가 참여하는 시험제품도 등록하는 연구담당자의 지사코드를 설정한다.
		rs3000mVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(rs3000mVO.getItemNo())){
			
			String inNo = ech0106DAO.insertEch0106(rs3000mVO);
			
			message = "등록이 완료되었습니다.";
		}else{
			ech0106DAO.updateEch0106(rs3000mVO);
			
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
				attachVO.setBoardNo(rs3000mVO.getItemNo());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectEch0106List(reda, message);
	}
	
	/**
	 * 시험제품 삭제
	 * 
	 * @param model
	 * @return 시험제품 삭제
	 * @throws Exception
	 */	
	@RequestMapping("/qxsepmny/ech0106/ech0106Delete.do")
	public String ech0106Delete(@ModelAttribute("rs3000mVO") Rs3000mVO rs3000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0106/ech0106Delete.do -  시험제품 삭제");
		LOGGER.debug("rs3000mVO = " + rs3000mVO.toString());
		String message = "존재하지 않는 시험제품입니다.";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		if(!EgovStringUtil.isEmpty(rs3000mVO.getItemNo())){
			
			ech0106DAO.deleteEch0106(rs3000mVO);
			
			message = "해당 시험제품정보 삭제가 완료되었습니다.";
		}
		
		return redirectEch0106List(reda, message);
	}
	
	/**
	 * 시험제품 엑셀다운로드
	 * 
	 * @param model
	 * @return 시험제품 목록 엑셀다운로드
	 * @throws Exception
	 */	
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0106/ech0106Excel.do")
	public void ech0106Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0106/ech0106Excel.do - 시험제품 엑셀 다운로드");
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
		 * println("<script>alert('엑셀다운로드권한이 허용되지 않습니다.관리자에게 문의하세요!'); location.href='/qxsepmny/ech0106/ech0106List.do';</script>"
		 * ); out.flush(); } else {
		 * 
		 * //엑셀다운로드 로직 }
		 */
		
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0106DAO.selectEch0106Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "시험제품 리스트", "ech0106", request, response);
		
	}
	
	
	// 연구과제 일괄등록 - 엑셀파일 업로드 
	@RequestMapping("/qxsepmny/ech0106/ech0106ItemUpload.do")
	public String ech0106ItemUpload(@ModelAttribute CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/ech0106/ech0106ItemUpload.do -  시험제품 일괄등록");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		// 엑셀 데이터 삭제
		session.removeAttribute("insertMemList");
		session.removeAttribute("excelDupMemList");

		return "/adm/ech0106/ech0106ItemUpload";
		
	}
	
	// 연구과제 일괄등록 - 엑셀파일 파싱 
	@RequestMapping("/qxsepmny/ech0106/ech0106UploadMemData.do")
	public String ech0106UploadMemData(MultipartHttpServletRequest multiRequest, Rs1000mVO rs1000mVO, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/ech0106/ech0106UploadMemData.do -  시험제품 일괄등록 엑셀파일 파싱");
		
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
				List<EgovMap> excelMemList = excelUtil.getExcelUploadData(filePath, "item");
				
				// 업로드된 파일 삭제
				//fileUtil.deleteFile(filePath);
				
				// 중복 목록 저장용도
				List<EgovMap> excelDupMemList = new ArrayList<EgovMap>();
				
				// 중복 제거한  목록 저장용도
				List<Rs3000mVO> insertMemList = new ArrayList<>();
				
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
							//RsUploadVO rsUploadVO = new RsUploadVO();
							Rs3000mVO rsUploadVO = new Rs3000mVO();
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

							//연구과제정보 확인 
							EgovMap map2 = new EgovMap();
							map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							map2.put("rsNo1", EgovWebUtil.removeTag(memMap.get("rsNo1").toString()));
							map2.put("rsNo2", EgovWebUtil.removeTag(memMap.get("rsNo2").toString()));
							map2.put("rsNo3", EgovWebUtil.removeTag(memMap.get("rsNo3").toString()));
							map2.put("rsNo4", EgovWebUtil.removeTag(memMap.get("rsNo4").toString()));
							map2.put("rsNo5", EgovWebUtil.removeTag(memMap.get("rsNo5").toString()));
							map2.put("rsNo6", EgovWebUtil.removeTag(memMap.get("rsNo6").toString()));
							map2.put("rsNo7", EgovWebUtil.removeTag(memMap.get("rsNo7").toString()));

							rs1000mVO = ech0106DAO.selectEch0106AjaxRsCdCheck2(map2);
							rsUploadVO.setRsNo(rs1000mVO.getRsNo());
							rsUploadVO.setVendNo(rs1000mVO.getVendNo());
							rsUploadVO.setRsCd(rs1000mVO.getRsCd());
							
							rsUploadVO.setInhDt(EgovWebUtil.removeTag(memMap.get("inhDt").toString()));
							rsUploadVO.setOutDt(EgovWebUtil.removeTag(memMap.get("outDt").toString()));
							rsUploadVO.setSendDt(EgovWebUtil.removeTag(memMap.get("sendDt").toString()));
							rsUploadVO.setReDt(EgovWebUtil.removeTag(memMap.get("reDt").toString()));
							rsUploadVO.setReYn(EgovWebUtil.removeTag(memMap.get("reYn").toString()));
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
							//Map<String, String> errors = MemberValidator.validate(rsUploadVO);
							//if(errors.size()!=0) {
								//message = "데이터 형식에 오류가 있어 업로드 등록에 실패하였습니다.";
								//reda.addFlashAttribute("errors", errors);
								//return redirectListPage(reda, message, "");
							//}
							
							// 중복검사
							EgovMap map = new EgovMap();
							
							map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							map.put("rsNo", rsUploadVO.getRsNo());
							map.put("itemName", rsUploadVO.getItemName());
							List<EgovMap> list = ech0106DAO.selectEch0106DupItemList(map);
							
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

		return redirectListPage(reda, message, gubun);
		
	}
	

	// 시험제품 일괄등록 - Data 검증 화면
	@RequestMapping("/qxsepmny/ech0106/ech0106ItemUpload2.do")
	public String ech0106ItemUpload2(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxsepmny/ech0106/ech0106ItemUpload2.do - {} 시험제품 일괄등록 > Data 검증 화면");
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
				
		return "/adm/ech0106/ech0106ItemUpload";
	}
		
	//시험제품 일괄등록 - 시험제품 일괄 등록 처리 	
	@RequestMapping("/qxsepmny/ech0106/ech0106SaveItemData.do")
	public String ech0106SaveItemData(HttpServletRequest request, ModelMap model, Rs3000mVO rs3000mVO, Rs1000mVO rs1000mVO, HttpSession session, RedirectAttributes reda, String memType) throws Exception {
		LOGGER.info("/qxsepmny/ech0106/ech0106SaveItemData.do - 시험제품 일괄 등록 처리");
	
		// CSRF 토큰 검사
		if(!CtmsCmmMethods.isCsrfToken(request, reda)){
		  return CtmsCmmMethods.redirectLoginView;
		}
		
		List<Rs3000mVO> insertMemList = (List<Rs3000mVO>) session.getAttribute("insertMemList");
		
		// 유효성 검사 통과 등록 작업.
		EgovMap map = new EgovMap();
		for(Rs3000mVO rsUploadVO : insertMemList) {
			//연구과제정보 확인 
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("rsNo", rsUploadVO.getRsNo());

			rs1000mVO = ech0106DAO.selectEch0106AjaxRsCdCheck(map);
			
			if(!(rs1000mVO == null)) {
				rsUploadVO.setRsNo(rs1000mVO.getRsNo());
				rsUploadVO.setRsCd(rs1000mVO.getRsCd());
				rsUploadVO.setVendNo(rs1000mVO.getVendNo());
				rsUploadVO.setEmpNo(rs1000mVO.getRsDrt());
				rsUploadVO.setBranchCd(rs1000mVO.getBranchCd());
				
			}else { //연구코드가 없는 경우 
				rsUploadVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				rsUploadVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
				rsUploadVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
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
			
			ech0106DAO.insertEch0106(rsUploadVO);
			
		}
		
		//작업 로그 등록 
		String dspCnt = insertMemList.size()+"건";
		admLogInsert("연구관리 > 시험제품 일괄등록", dspCnt, "1010", request);
		
		String message = "등록 완료되었습니다.";
		
		return redirectListPage(reda, message, "");
	}	

	// 시험제품 일괄삭제
	@RequestMapping("/qxsepmny/ech0106/ech0106AjaxItemDel.do")
	public View ech0106AjaxItemDel(String corpCd, String step1,String step2, String[] itemSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0106/ech0106AjaxItemDel.do - 시험제품 일괄삭제");
		LOGGER.debug("itemSeq="+itemSeq.toString());
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("step1", step1);
		//map.put("step2", step2);
		//시험제품 번호 
		map.put("itemSeq", itemSeq);
		
		//시험제품 일괄삭제
		ech0106DAO.deleteEch0106AjaxItemDel(map);
		
		message = "삭제되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	
}
