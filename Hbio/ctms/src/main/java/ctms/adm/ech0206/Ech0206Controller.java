package ctms.adm.ech0206;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
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
import ctms.valueObject.AdminVO;
import ctms.valueObject.Cr3240mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Rs5020mVO;
import ctms.valueObject.Cr4000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0206Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0206Controller.class);
	@Autowired private Ech0206DAO ech0206DAO;
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
	
	
	// ********************************(기준정보관리) 20201128 관리자 연구동의서관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0206/ech0206List.do")	
	public String ech0206List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0206/ech0206List.do - 기준정보관리 연구동의서관리 목록화면");
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
		CmmnListVO listVO = ech0206DAO.selectEch0206List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0206/ech0206List";
	}
	
	// ********************************(기준정보관리) 20201128 관리자 연구동의서관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0206/ech0206View.do")
	public String ech0206View(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0206/ech0206View.do - 기준정보관리 연구동의서관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		rs1000mVO =  ech0206DAO.selectEch0206View(rs1000mVO);
		
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
			
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		CmmnListVO listVO = ech0206DAO.selectEch0206IcfList(searchVO);
		
		//동의서 첨부파일 확인시작 - 마스터 list에서 mapKey를 만들어야 한다
		//mapKey 영문자는 소문자로 만들어짐 
		EgovMap paramMap = new EgovMap();        
        EgovMap resultMap = new EgovMap();

        for(EgovMap map1 : listVO.getEgovList()){
        	String mapKey = (String) map1.get("corpCd")+map1.get("rsNo")+map1.get("subNo");
        	paramMap.put("boardSeq", mapKey);
           	paramMap.put("boardType", "ICF");
           	List<Ct7000mVO> attachList = cmmDAO.selectAttachList(paramMap);
            resultMap.put(mapKey, attachList);
        }
        model.addAttribute("mtList", resultMap);
		//동의서 첨부파일 확인 끝       
		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0206/ech0206View";
	}	

	// ********************************(기준정보관리) 20201128 관리자 연구동의서관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0206/ech0206Modify.do")
	public String ech0206Modify(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0206/ech0206Modify.do - 관리자 연구동의서관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		// 회사코드 설정 
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	 	
	 	
	
	   //등록화면으로
//	if (EgovStringUtil.isEmpty(rs1000mVO.getEmpNo())) {
//				
			//지사명  목록 
			//List<EgovMap> branch = ech0206DAO.selectBranchList(rs1000mVO);
			//model.addAttribute("branch", branch);
			
			//연구자구분(공통코드) 목록 
			//List<EgovMap> cm1240 = ech0206DAO.selectCmmCdList(rs1000mVO.getCorpCd(), "CM1240");
			//model.addAttribute("cm1240", cm1240);
			
			//model.addAttribute("adminVO", adminVO);
			//model.addAttribute("NotiPageGubun","NotiRegist");
		//}
		//수정화면으로 
		//if(!EgovStringUtil.isEmpty(rs1000mVO.getEmpNo())){
					
			//rs1000mVO = ech0206DAO.selectEch0206View(rs1000mVO);
			
						
			//model.addAttribute("NotiPageGubun","NotiUpdate");
			//model.addAttribute("rs1000mVO", rs1000mVO);
			
		//}
		
		return "/adm/ech0206/ech0206Modify";
	}

	// ********************************(기준정보관리) 20201128 관리자 연구동의서관리 저장 ********************************
	@RequestMapping("/qxsepmny/ech0206/ech0206Update.do")
	public String ech0206Save(@ModelAttribute("rs1000mVO") Cr4000mVO cr4000mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0206/ech0206Save.do - 관리자 연구동의서관리 저장");
	String message = "";
	
	//세션 호출
	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	
	// 회사코드(CTMS운영) 설정
	cr4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	
	//if(EgovStringUtil.isEmpty(rs1000mVO.getEmpNo())){
	    
		//작성자 안에 세션 name 입력
		//noticeVO.setNoti_writer(adminVO.getName());
					
		//ech0206DAO.insertEch0206(rs1000mVO);
		
		//message = "등록이 완료되었습니다.";
	//}else{
		//ech0206DAO.updateEch0206(rs1000mVO);

		//message = "수정이 완료되었습니다.";			
		//}

	return redirectList(reda, message);

	}

	// ********************************(기준정보관리) 20201128 관리자 연구동의서관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0206/ech0206Delete.do")
	public String ech0206Delete(@ModelAttribute Rs1000mVO rs1000mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0206/ech0206Delete.do - 관리자 연구동의서관리 삭제");
	String message = "";
	
	//연구동의서관리 삭제
	//if(!EgovStringUtil.isEmpty(rs1000mVO.getEmpNo())){
	
		//ech0206DAO.deleteEch0206(rs1000mVO);
	
		//message = "사용자정보가 삭제되었습니다.";
	//}
	return redirectList(reda, message);

	}

	// 연구동의서관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0206/ech0206List.do";
	}

	// 연구동의서관리 리스트로 리다이렉트
	private String redirectIcfmgPop(RedirectAttributes reda, String message, Cr4000mVO cr4000mVO) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("act", "Y");
		reda.addFlashAttribute("cr4000mVO", cr4000mVO);
		return "redirect:/qxsepmny/ech0206/ech0206IcfmgPop.do";
	}

	
	// 연구동의서관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0206/ech0206Excel.do")
	public void ech0206Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0206/ech0206Excel.do - 연구동의서관리 목록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0206DAO.selectEch0206Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "연구동의서 리스트", "ech0206", request, response);
	}
		
	// 동의서 첨부 팝업
	@RequestMapping("/qxsepmny/ech0206/ech0206IcfmgPop.do")
	public String ech0206IcfmgPop(String corpCd, String rsNo, String subNo, @ModelAttribute("cr4000mVO") Cr4000mVO cr4000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0206/ech0206IcfmgPop.do - 연구대상자별 동의서 첨부팝업");
		//세션 호출
	 	//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		cr4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//연구대상자  사용내역 정보 설정
		LOGGER.debug("cr4000mVO="+cr4000mVO.toString());
		
		cr4000mVO.setRsNo(cr4000mVO.getRsNo());
		cr4000mVO.setSubNo(cr4000mVO.getSubNo());
		int chkcnt = ech0206DAO.selectEch0206ChkIcfCnt(cr4000mVO);
		if(chkcnt == 0) {
			LOGGER.debug("없다="+chkcnt);
			cr4000mVO = ech0206DAO.selectEch0206ViewInfo(cr4000mVO);
		}else {
			//첨부파일 가져와야 함 
			LOGGER.debug("있다="+chkcnt);
			cr4000mVO = ech0206DAO.selectEch0206IcfView(cr4000mVO);
		}
		
		//첨부파일 확인 시작
	 	EgovMap mapSelect = new EgovMap();
	 	//CT7000M CORP_CD 추가 필요 함, 스토리지도 회사별 구분필요함 
		mapSelect.put("boardNo",cr4000mVO.getCorpCd()+cr4000mVO.getRsNo()+cr4000mVO.getSubNo());
		
		List<Rs5020mVO> rs5020mVO = ech0206DAO.selectEch0206selectbox(mapSelect);
		
		EgovMap attachMapSelect = new EgovMap();
		
		for(Rs5020mVO attach : rs5020mVO){
			attachMapSelect.put(attach.getRptCls(), attach);
		}
		
		model.addAttribute("rs5020mVO", attachMapSelect);
		
		//첨부파일 테이블 확인 
		EgovMap map = new EgovMap();
		
		map.put("boardSeq", cr4000mVO.getCorpCd()+cr4000mVO.getRsNo()+cr4000mVO.getSubNo());
		map.put("boardType", "ICF");

		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);

		EgovMap attachMap = new EgovMap();
		
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		
		model.addAttribute("attachMap", attachMap);
		//-- 첨부파일 확인 끝
		
		LOGGER.debug("cr4000mVO="+cr4000mVO.toString());
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("cr4000mVO", cr4000mVO);				

		return "/adm/ech0206/ech0206IcfmgPop";
		
	}
	
	//동의서 첨부 등록
	@RequestMapping("/qxsepmny/ech0206/ech0206IcfUpdate.do" )
	public String ech0206IcfUpdate(@ModelAttribute("cr4000mVO") Cr4000mVO cr4000mVO, String[] delFile , String[]rptName, String[] rptNo, @RequestParam(required = false)String ct2010, BindingResult result, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/ech0206/ech0206IcfUpdate.do -  동의서첨부 등록");
		LOGGER.debug("cr4000mVO first  = " + cr4000mVO.toString());
		String message = "";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "ICF");
	
		String setprIcf = cr4000mVO.getPricfYn();
		String setrsIcf = cr4000mVO.getRsicfYn();
		
		LOGGER.debug("cr4000mVO1 = " + cr4000mVO.toString());
		
		if(delFile != null){
			for(String seq : delFile){
				LOGGER.debug("seq = " + seq);
				Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
				//rs, pr check -> "N"
				
				LOGGER.debug("delAttach = " + delAttach);
				if(delAttach.getFileKey().equals("rsIcf")) {
					setrsIcf = "N";
				}else {
					setprIcf = "N";
				}
				cmmDAO.deleteAttachFile(delAttach.getAttachNo());
				LOGGER.debug("getAttachNo = " + delAttach.getAttachNo());
				fileUtil.deleteFile(delAttach.getRegFileName());
			}
		}
		
		/*
		 * if(rptNo != null){ for(String rptSeq : rptNo){
		 * 
		 * Rs5020mVO delData = ech0206DAO.selectReportOne(rptSeq);
		 * ech0206DAO.deleteReportTable(rptSeq); } }
		 */		
		
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("ICF");//폴더명
				attachVO.setBoardNo(cr4000mVO.getCorpCd()+cr4000mVO.getRsNo()+cr4000mVO.getSubNo()); //회사코드+연구과제번호+피험자선정순번 
				attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
				if(fileInfoVO.getFileKey().equals("prIcf")) {
					setprIcf = "Y";
				}else {
					setrsIcf = "Y";
				}
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		//동의서 등록여부를 확인한다. 
		cr4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		int chkcnt = ech0206DAO.selectEch0206ChkIcfCnt(cr4000mVO);
		
		cr4000mVO.setRsicfYn(setrsIcf);
		cr4000mVO.setPricfYn(setprIcf);
		
		LOGGER.debug("cr4000mVO 2 = " + cr4000mVO.toString());
		
		if(chkcnt == 0){
			//작성자 안에 세션 name 입력 //noticeVO.setNoti_writer(adminVO.getName());
			ech0206DAO.insertEch0206(cr4000mVO);
			message = "등록이 완료되었습니다.";
		
		}else{ 
			ech0206DAO.updateEch0206(cr4000mVO);
			message = "수정이 완료되었습니다."; 
		}
		
		cr4000mVO.setRsNo(cr4000mVO.getRsNo());
		cr4000mVO.setSubNo(cr4000mVO.getSubNo());
		LOGGER.debug("cr4000mVO 3 = " + cr4000mVO.toString());
		
		model.addAttribute("cr4000mVO", cr4000mVO);
		
		return redirectIcfmgPop(reda, message, cr4000mVO);
	}
}
