package ctms.adm.ech0401;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
import component.file.CmmnFileMngUtil;
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
import ctms.adm.ech0205.Ech0205DAO;
import ctms.adm.ech0101.Ech0101DAO;
import ctms.adm.ech0105.Ech0105DAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Cr3010mVO;
import ctms.valueObject.Cr3100mVO;
import ctms.valueObject.Cr3150mVO;
import ctms.valueObject.Cr3160mVO;
import ctms.valueObject.Cr3170mVO;
import ctms.valueObject.Cr3180mVO;
import ctms.valueObject.Cr3190mVO;
import ctms.valueObject.Cr3280mVO;
import ctms.valueObject.Cr3290mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0401Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0401Controller.class);
	@Autowired private Ech0401DAO ech0401DAO;
	@Autowired private Ech0205DAO ech0205DAO;
	@Autowired private Ech0101DAO ech0101DAO;
	@Autowired private Ech0105DAO ech0105DAO;
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
	@RequestMapping("/qxsepmny/ech0401/ech0401List.do")	
	public String ech0401List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401List.do - 시험결과추출 목록화면");
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
		CmmnListVO listVO = ech0401DAO.selectEch0401List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0401/ech0401List";
	}
	
	// ********************************(자료추출) 20201230 관리자 시험결과추출 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401ViewIcf.do")
	public String ech0401ViewIcf(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ViewIcf.do - 시험결과추출(동의서) 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");

		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);

		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		
		EgovMap map2 = new EgovMap();
		map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map2.put("rsCd", rs1000mVO.getRsCd());
		map2.put("mrsNo", rs1000mVO.getRsNo());
		rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
		
		if(rs1010mVO != null) {
			searchVO.setRsNo(rs1010mVO.getRsNo());
			//동의서목록 
			CmmnListVO listVO = ech0401DAO.selectEch0401ResList(searchVO);
			
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
	        model.addAttribute("resultList", listVO.getEgovList());
			//동의서 첨부파일 확인 끝 	
		}
		      		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0401/ech0401ViewIcf";
	}	

	// ********************************(자료추출) 20201230 관리자 시험결과추출 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401ViewCrf.do")
	public String ech0401ViewCrf(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ViewCrf.do - 시험결과추출(eCRF통계) 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
		
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		
		EgovMap map2 = new EgovMap();
		map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map2.put("rsCd", rs1000mVO.getRsCd());
		map2.put("mrsNo", rs1000mVO.getRsNo());
		rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
		
		searchVO.setRsNo(rs1010mVO.getRsNo());
		
		//eCRF통계로 변경해야 함 
		CmmnListVO listVO = ech0401DAO.selectEch0401ResList(searchVO);
		
		//피부특성 첨부파일 확인시작 - 마스터 list에서 mapKey를 만들어야 한다
		//mapKey 영문자는 소문자로 만들어짐 
		EgovMap paramMap1 = new EgovMap();        
        EgovMap resultMap = new EgovMap();

        for(EgovMap map1 : listVO.getEgovList()){
        	String mapKey = (String) map1.get("corpCd")+map1.get("rsNo")+map1.get("rsiNo");
        	LOGGER.debug("mapKey="+(String) map1.get("mapKey"));
        	paramMap1.put("boardSeq", mapKey);
        	
           	paramMap1.put("boardType", "SVY");
           	paramMap1.put("fileKey", "survey");
           	List<Ct7000mVO> attachList = cmmDAO.selectAttachListFileKey(paramMap1);
            resultMap.put(mapKey, attachList);
            LOGGER.debug("resultMap = " + resultMap.toString());
        }
        model.addAttribute("mtList", resultMap);
		//피부특성 첨부파일 확인 끝 
		
		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0401/ech0401ViewCrf";
	}

	// ********************************(자료추출) 20201230 관리자 시험결과추출 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401ViewSkinProp.do")
	public String ech0401ViewSkinProp(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ViewSkinProp.do - 시험결과추출(연구대상자특성) 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
		
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		
		EgovMap map2 = new EgovMap();
		map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map2.put("rsCd", rs1000mVO.getRsCd());
		map2.put("mrsNo", rs1000mVO.getRsNo());
		rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
		
		searchVO.setRsNo(rs1010mVO.getRsNo());
		
		//피부특성으로 변경해야 함 
		CmmnListVO listVO = ech0401DAO.selectEch0401ResList(searchVO);
		
		//피부특성 첨부파일 확인시작 - 마스터 list에서 mapKey를 만들어야 한다
		//mapKey 영문자는 소문자로 만들어짐 
		EgovMap paramMap1 = new EgovMap();        
        EgovMap resultMap = new EgovMap();

        for(EgovMap map1 : listVO.getEgovList()){
        	String mapKey = (String) map1.get("corpCd")+map1.get("rsNo")+map1.get("rsiNo");
        	LOGGER.debug("mapKey="+(String) map1.get("mapKey"));
        	paramMap1.put("boardSeq", mapKey);
        	
           	paramMap1.put("boardType", "SVY");
           	paramMap1.put("fileKey", "survey_1");
           	List<Ct7000mVO> attachList = cmmDAO.selectAttachListFileKey(paramMap1);
            resultMap.put(mapKey, attachList);
            LOGGER.debug("resultMap = " + resultMap.toString());
        }
        model.addAttribute("mtList", resultMap);
		//피부특성 첨부파일 확인 끝 
        
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0401/ech0401ViewSkinProp";
	}

	// ********************************(자료추출) 20201230 관리자 시험결과추출 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401ViewSkinStim.do")
	public String ech0401ViewSkinStim(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ViewSkinStim.do - 시험결과추출(피부자극) 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
		
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		
		//피부자극 결과 
		CmmnListVO listVO = ech0401DAO.selectEch0401VlList(searchVO);
		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0401/ech0401ViewSkinStim";
	}	

	// ********************************(자료추출) 20201230 관리자 시험결과추출 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401ViewItemUse.do")
	public String ech0401ViewItemUse(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ViewItemUse.do - 시험결과추출(제품사용) 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
				
		//연구대상자 제품사용목록 조회
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		
		CmmnListVO listVO = ech0205DAO.selectEch0205ChkList(searchVO);
		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0401/ech0401ViewItemUse";
	}	
	
	// ********************************(자료추출) 20201230 관리자 시험결과추출 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401ViewReport.do")
	public String ech0401ViewReport(@ModelAttribute CmmnSearchVO searchVO , Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ViewReport.do - 시험결과추출(결과보고서) 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
		
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		searchVO.setRsNo(rs1000mVO.getRsNo());
		
		//결과보고서로 변경해야 함 
		//CmmnListVO listVO = ech0401DAO.selectEch0401RptList(searchVO);
		//연구차수 목록
		CmmnListVO listVO = ech0401DAO.selectEch0401RsSeqList(searchVO);
		
		model.addAttribute("rs1000mVO", rs1000mVO);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("pageIndex", searchVO.getPageIndex());
										
		return "/adm/ech0401/ech0401ViewReport";
	}	
	
	// ********************************(자료추출) 20201128 관리자 시험결과추출 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401Modify.do")
	public String ech0401Modify(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401Modify.do - 관리자 시험결과추출 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		// 회사코드 설정 
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	 	
	 	
	
	   //등록화면으로
//	if (EgovStringUtil.isEmpty(rs1000mVO.getEmpNo())) {
//				
			//지사명  목록 
			//List<EgovMap> branch = ech0401DAO.selectBranchList(rs1000mVO);
			//model.addAttribute("branch", branch);
			
			//연구자구분(공통코드) 목록 
			//List<EgovMap> cm1240 = ech0401DAO.selectCmmCdList(rs1000mVO.getCorpCd(), "CM1240");
			//model.addAttribute("cm1240", cm1240);
			
			//model.addAttribute("adminVO", adminVO);
			//model.addAttribute("NotiPageGubun","NotiRegist");
		//}
		//수정화면으로 
		//if(!EgovStringUtil.isEmpty(rs1000mVO.getEmpNo())){
					
			//rs1000mVO = ech0401DAO.selectEch0401View(rs1000mVO);
			
						
			//model.addAttribute("NotiPageGubun","NotiUpdate");
			//model.addAttribute("rs1000mVO", rs1000mVO);
			
		//}
		
		return "/adm/ech0401/ech0401Modify";
	}

	// ********************************(자료추출) 20201128 관리자 시험결과추출 저장 ********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401Update.do")
	public String ech0401Save(@ModelAttribute("rs1000mVO") Rs1000mVO rs1000mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0401/ech0401Save.do - 관리자 연구동의서관리 저장");
	String message = "";
	
	//세션 호출
	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	
	// 회사코드(CTMS운영) 설정
	//rs1000mVO.setCorpCd("HNBSRC");
	
	//if(EgovStringUtil.isEmpty(rs1000mVO.getEmpNo())){
	    
		//작성자 안에 세션 name 입력
		//noticeVO.setNoti_writer(adminVO.getName());
					
		//ech0401DAO.insertEch0401(rs1000mVO);
		
		//message = "등록이 완료되었습니다.";
	//}else{
		//ech0401DAO.updateEch0401(rs1000mVO);

		//message = "수정이 완료되었습니다.";			
		//}

	return redirectList(reda, message);

	}

	// ********************************(자료추출) 20201128 관리자 시험결과추출 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0401/ech0401Delete.do")
	public String ech0401Delete(@ModelAttribute Rs1000mVO rs1000mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0401/ech0401Delete.do - 관리자 시험결과추출 삭제");
	String message = "";
	
	//연구동의서관리 삭제
	//if(!EgovStringUtil.isEmpty(rs1000mVO.getEmpNo())){
	
		//ech0401DAO.deleteEch0401(rs1000mVO);
	
		//message = "사용자정보가 삭제되었습니다.";
	//}
	return redirectList(reda, message);

	}

	// 시험결과추출 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0401/ech0401List.do";
	}

	// 시험결과추출 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0401/ech0401Excel.do")
	public void ech0401Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401Excel.do - 시험결과추출 목록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0401DAO.selectEch0401Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "시험결과추출 리스트", "ech0401", request, response);
	}
	
	// 피부자극결과 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0401/ech0401ExcelSkinStim.do")
	public void ech0401ExcelSkinStim(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ExcelSkinStim.do - 피부자극결과 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0401DAO.selectEch0401ExcelSkinStim(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "시험결과추출 리스트", "ech0401", request, response);
	}

	// 연구대상자의 피부자극결과 일괄 생성  Ajax
	@RequestMapping("/qxsepmny/ech0401/ech0401AjaxRsiCodeBat.do")
	public View ech0401AjaxRsiCodeBat(String corpCd, String rsNo, String step1, String step2, Rs1010mVO rs1010mVO, Rs1000mVO rs1000mVO, Cr3150mVO cr3150mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401AjaxRsiCodeBat.do - 연구대상자의 피부자극결과 일괄 생성  Ajax");
		String message = "";
		boolean status = false;
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", rsNo);
		
		//대상 연구의 피부자극결과 획득
		List<Cr3100mVO> resultList = ech0401DAO.selectEch0401RsiCodeBat(map);
		int chkMtlDsp = 0;
		int chkMtlDsp2 = 0;
		int setClsCnt = 0;
		String setCls = "";
		
		if(resultList.size() != 0){
			
			//기존 생성된 피부자극결과를 삭제 한다. 
			int delchk = ech0401DAO.deleteEch0401Rst(map);
			LOGGER.debug("delchk="+delchk);
			
			for(Cr3100mVO cr3100mVO : resultList){
				
				//동일식별번호 - 물질번호가 5개를 넘으면 cls = '2', 음성대조군 물질은 먼저 등록 
				String chkRsiNo = cr3100mVO.getBrsjNo();
				
				if(!chkRsiNo.equals(cr3150mVO.getRsiNo())) {
					cr3150mVO.setRsiNo(chkRsiNo);					
					setCls = "1";
					chkMtlDsp = 0;
					chkMtlDsp2 = 0;
					setClsCnt = 0;
					LOGGER.debug("not="+chkRsiNo);
					LOGGER.debug("not="+cr3150mVO.getRsiNo());
					
				}else {
					if(chkMtlDsp > 4) {
						chkMtlDsp = 0;
						//다시 읽어서 N.C 물질을 먼저 입력 한다. 
						//대상 연구의 피부자극결과 획득
						map.put("rsiNo", cr3100mVO.getBrsjNo());
						List<Cr3100mVO> resultList2 = ech0401DAO.selectEch0401RsiCodeBat2(map);
						for(Cr3100mVO cr3100mVO2 : resultList2){
							if(setClsCnt > 9) {
								LOGGER.debug("setClsCnt 9="+setClsCnt);
								setCls = "3";	
							}else if(setClsCnt > 4) {
								LOGGER.debug("setClsCnt 4="+setClsCnt);
								setCls = "2";	
							} 
							
							cr3150mVO.setCorpCd(cr3100mVO2.getCorpCd());
							cr3150mVO.setRsNo(cr3100mVO2.getRsNo());
							cr3150mVO.setRsiNo(cr3100mVO2.getBrsjNo());
							cr3150mVO.setMtlDsp(cr3100mVO2.getMtlDsp());
							cr3150mVO.setCls(setCls);
							cr3150mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
							//setClsCnt = setClsCnt + 1;
							//chkMtlDsp = chkMtlDsp + 1;
							//리포트용 데이터 생성 m30
							cr3150mVO.setPchCls("M30");
							cr3150mVO.setPchRst(cr3100mVO2.getM30Vl1());
							cr3150mVO.setMrsNo(rsNo);
							ech0401DAO.insertEch0401AjaxSaveRst(cr3150mVO);
							
							//리포트용 데이터 생성 h24
							cr3150mVO.setPchCls("H24");
							cr3150mVO.setPchRst(cr3100mVO2.getH24Vl1());
							cr3150mVO.setMrsNo(rsNo);
							ech0401DAO.insertEch0401AjaxSaveRst(cr3150mVO);
							setClsCnt = setClsCnt + 1;
							chkMtlDsp = chkMtlDsp + 1;
						}	
						//chkMtlDsp = 0;
						if(setClsCnt > 9) {
							setCls = "3";	
						}else if(setClsCnt > 4) {
							setCls = "2";	
						} 
						//setCls = "2";
						LOGGER.debug("change 2="+chkMtlDsp);
					}else {
						if(chkMtlDsp2 < 4) {setCls = "1"; }
					}

				}
				
				chkMtlDsp = chkMtlDsp + 1;
				chkMtlDsp2 = chkMtlDsp2 + 1;
				setClsCnt = setClsCnt + 1;
				LOGGER.debug("chkMtlDsp 2="+chkMtlDsp);
				
				cr3150mVO.setCorpCd(cr3100mVO.getCorpCd());
				cr3150mVO.setRsNo(cr3100mVO.getRsNo());
				cr3150mVO.setRsiNo(cr3100mVO.getBrsjNo());
				cr3150mVO.setMtlDsp(cr3100mVO.getMtlDsp());
				cr3150mVO.setCls(setCls);
				cr3150mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				
				//리포트용 데이터 생성 m30
				cr3150mVO.setPchCls("M30");
				cr3150mVO.setPchRst(cr3100mVO.getM30Vl1());
				cr3150mVO.setMrsNo(rsNo);
				ech0401DAO.insertEch0401AjaxSaveRst(cr3150mVO);
				
				//리포트용 데이터 생성 h24
				cr3150mVO.setPchCls("H24");
				cr3150mVO.setPchRst(cr3100mVO.getH24Vl1());
				cr3150mVO.setMrsNo(rsNo);
				ech0401DAO.insertEch0401AjaxSaveRst(cr3150mVO);
				
			}
			message = "피부자극결과 일괄등록이 완료되었습니다. 피부자극 결과보고서 추출이 가능합니다";
			status = true;
		}else{
			message = "피부자극결과를 생성할 정보가 없습니다.";
			status = false;
		}
				
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		return jsonView;
	}

	// 연구대상자의 특성결과 일괄 생성  Ajax
	@RequestMapping("/qxsepmny/ech0401/ech0401AjaxSkinPropBat.do")
	public View ech0401AjaxSkinPropBat(String corpCd, String rsNo, String step1, String step2, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, Cr3160mVO cr3160mVO, Cr3170mVO cr3170mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401AjaxSkinPropBat.do - 연구대상자의 특성결과 일괄 생성  Ajax");
		String message = "";
		boolean status = false;
		
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rs1000mVO.setRsNo(rsNo);
		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
		String rsNo7 = rs1000mVO.getRsNo7();
		LOGGER.debug("rsNo7="+rsNo7);		
		
		EgovMap map2 = new EgovMap();
		map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map2.put("rsCd", rs1000mVO.getRsCd());
		map2.put("mrsNo", rs1000mVO.getRsNo());
		rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("rsNo", rsNo);
		map.put("rsNo", rs1010mVO.getRsNo());
		
		//연구대상자의 특성결과 획득
		List<Cr3010mVO> resultList = ech0401DAO.selectEch0401SkinPropBat(map);	
		LOGGER.debug("resultList="+resultList.toString());
		
		int chkMtlDsp = 0;
		int chkMtlDsp2 = 0;
		
		if(resultList.size() != 0){
			
			//기존 생성된 특성결과를 삭제 한다. 
			EgovMap map3 = new EgovMap();
			map3.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map3.put("rsNo", rsNo);
			int delchk = ech0401DAO.deleteEch0401SkinProp(map3);
			int delchk2 = ech0401DAO.deleteEch0401SkinPropTl(map3);
			LOGGER.debug("delchk="+delchk);
			
			//연구차수 연구대상자특성을 삭제한다.
			int delchk3 = ech0401DAO.deleteEch0401SkinPropRsSeq(map3);
			
			//특성표제를 생성한다. 
			List<Cr3010mVO> resultList2 = ech0401DAO.selectEch0401SkinPropBatTl(map);
			for(Cr3010mVO cr3010mVO2 : resultList2){
				chkMtlDsp2 = chkMtlDsp2 + 1;
				LOGGER.debug("chkMtlDsp2="+chkMtlDsp2);
				switch (chkMtlDsp2) {
	            	case 1: cr3170mVO.setVar1(cr3010mVO2.getQuesAbb());
	                		break;
	            	case 2: cr3170mVO.setVar2(cr3010mVO2.getQuesAbb());
            				break;
	            	case 3: cr3170mVO.setVar3(cr3010mVO2.getQuesAbb());
            				break;
	            	case 4: cr3170mVO.setVar4(cr3010mVO2.getQuesAbb());
            				break;
	            	case 5: cr3170mVO.setVar5(cr3010mVO2.getQuesAbb());
            				break;
	            	case 6: cr3170mVO.setVar6(cr3010mVO2.getQuesAbb());
            				break;
	            	case 7: cr3170mVO.setVar7(cr3010mVO2.getQuesAbb());
            				break;
	            	case 8: cr3170mVO.setVar8(cr3010mVO2.getQuesAbb());
            				break;
	            	case 9: cr3170mVO.setVar9(cr3010mVO2.getQuesAbb());
            				break;
	            	case 10: cr3170mVO.setVar10(cr3010mVO2.getQuesAbb());
            				break;
	            	case 11: cr3170mVO.setVar11(cr3010mVO2.getQuesAbb());
    						break;
	            	case 12: cr3170mVO.setVar12(cr3010mVO2.getQuesAbb());
							break;
	            	case 13: cr3170mVO.setVar13(cr3010mVO2.getQuesAbb());
	            			break;
	            	case 14: cr3170mVO.setVar14(cr3010mVO2.getQuesAbb());
							break;
	            	case 15: cr3170mVO.setVar15(cr3010mVO2.getQuesAbb());
							break;		
            	}
				
			}
			ech0401DAO.insertEch0401AjaxSaveSkinPropTl(cr3170mVO);
			
			for(Cr3010mVO cr3010mVO : resultList){
				
				String chkRsiNo = cr3010mVO.getRsiNo();
				
				if(!chkRsiNo.equals(cr3160mVO.getRsiNo())) {
					
					if(chkMtlDsp != 0) {
						cr3160mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
						cr3160mVO.setRsNo(rsNo);
						LOGGER.debug("3=");
						cr3160mVO.setRsNo7(rsNo7);
						ech0401DAO.insertEch0401AjaxSaveSkinProp(cr3160mVO);
					}	
					cr3160mVO.setRsiNo(chkRsiNo);
					chkMtlDsp = 0;
					chkMtlDsp = chkMtlDsp + 1;
					LOGGER.debug("chkMtlDsp="+chkMtlDsp);
					switch (chkMtlDsp) {
		            	case 1: cr3160mVO.setVar1(cr3010mVO.getAnswNum());
		                		break;
		            	case 2: cr3160mVO.setVar2(cr3010mVO.getAnswNum());
                				break;
		            	case 3: cr3160mVO.setVar3(cr3010mVO.getAnswNum());
                				break;
		            	case 4: cr3160mVO.setVar4(cr3010mVO.getAnswNum());
                				break;
		            	case 5: cr3160mVO.setVar5(cr3010mVO.getAnswNum());
                				break;
		            	case 6: cr3160mVO.setVar6(cr3010mVO.getAnswNum());
                				break;
		            	case 7: cr3160mVO.setVar7(cr3010mVO.getAnswNum());
                				break;
		            	case 8: cr3160mVO.setVar8(cr3010mVO.getAnswNum());
                				break;
		            	case 9: cr3160mVO.setVar9(cr3010mVO.getAnswNum());
                				break;
		            	case 10: cr3160mVO.setVar10(cr3010mVO.getAnswNum());
                				break;
		            	case 11: cr3160mVO.setVar11(cr3010mVO.getAnswNum());
        						break;
		            	case 12: cr3160mVO.setVar12(cr3010mVO.getAnswNum());
        						break;
		            	case 13: cr3160mVO.setVar13(cr3010mVO.getAnswNum());
        						break;
		            	case 14: cr3160mVO.setVar14(cr3010mVO.getAnswNum());
        						break;
		            	case 15: cr3160mVO.setVar15(cr3010mVO.getAnswNum());
        						break;
                	}
					
				}else {
						//index에 따라 컬럼에 매칭한다
						//map.put("rsiNo", cr3010mVO.getRsiNo());
						cr3160mVO.setRsiNo(cr3010mVO.getRsiNo());
						chkMtlDsp = chkMtlDsp + 1;
						LOGGER.debug("chkMtlDsp="+chkMtlDsp);
						switch (chkMtlDsp) {
			            	case 1: cr3160mVO.setVar1(cr3010mVO.getAnswNum());
			                		break;
			            	case 2: cr3160mVO.setVar2(cr3010mVO.getAnswNum());
	                				break;
			            	case 3: cr3160mVO.setVar3(cr3010mVO.getAnswNum());
	                				break;
			            	case 4: cr3160mVO.setVar4(cr3010mVO.getAnswNum());
	                				break;
			            	case 5: cr3160mVO.setVar5(cr3010mVO.getAnswNum());
	                				break;
			            	case 6: cr3160mVO.setVar6(cr3010mVO.getAnswNum());
	                				break;
			            	case 7: cr3160mVO.setVar7(cr3010mVO.getAnswNum());
	                				break;
			            	case 8: cr3160mVO.setVar8(cr3010mVO.getAnswNum());
	                				break;
			            	case 9: cr3160mVO.setVar9(cr3010mVO.getAnswNum());
	                				break;
			            	case 10: cr3160mVO.setVar10(cr3010mVO.getAnswNum());
	                				break;
			            	case 11: cr3160mVO.setVar11(cr3010mVO.getAnswNum());
            						break;
			            	case 12: cr3160mVO.setVar12(cr3010mVO.getAnswNum());
            						break;
			            	case 13: cr3160mVO.setVar13(cr3010mVO.getAnswNum());
            						break;
			            	case 14: cr3160mVO.setVar14(cr3010mVO.getAnswNum());
            						break;
			            	case 15: cr3160mVO.setVar15(cr3010mVO.getAnswNum());
            						break;
	                	}
				}
			}
			if(chkMtlDsp != 0) {
				cr3160mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				cr3160mVO.setRsNo(rsNo);
				cr3160mVO.setRsNo7(rsNo7);
				LOGGER.debug("3=");
				ech0401DAO.insertEch0401AjaxSaveSkinProp(cr3160mVO);
			}
			message = "연구대상자 특성결과 일괄등록이 완료되었습니다. 특성결과보고서 추출이 가능합니다";
			status = true;
			
		}else{
			message = "연구대상자 특성결과를 생성할 정보가 없습니다.";
			status = false;
		}
		
		//생성된 연구대상자 특성을 읽는다 CR3160M
		//연구차수별로 연구대상자 특성을 등록한다 CR3162M MRS_NO = RS_NO
		map2.put("rsNo", rs1000mVO.getRsNo());
		map2.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		ech0401DAO.insertEch0401AjaxSaveSkinPropRsSeq(map2);
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		return jsonView;
	}

	// 연구대상자의 ICF 일괄다운로드
	@RequestMapping("/qxsepmny/ech0401/ech0401ZipDownloadIcf.do")
	public void ech0401ZipDownloadIcf(@ModelAttribute("searchVO") CmmnSearchVO searchVO, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.info("/qxsepmny/ech0401/ech0401ZipDownloadIcf.do - 연구대상자의 ICF 일괄다운로드");
		int bufferSize = 1024*8;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Calendar cal = Calendar.getInstance();	
		
		String outputName = sdf.format(cal.getTime()) + "_ICF일괄다운로드";
		
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
		
			rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
			
			EgovMap map2 = new EgovMap();
			map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map2.put("rsCd", rs1000mVO.getRsCd());
			map2.put("mrsNo", rs1000mVO.getRsNo());
			rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
			
			searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			//searchVO.setRsNo(rs1000mVO.getRsNo());
			searchVO.setRsNo(rs1010mVO.getRsNo());
			
			//연구대상자 목록 획득 
			List<EgovMap> resultList = ech0401DAO.selectEch0401ListIcf(searchVO);
			
			EgovMap paramMap = new EgovMap();
			//연구대상자의 첨부파일(ICF) 획득
			for(EgovMap result : resultList){
				String mapKey = (String) result.get("corpCd")+result.get("rsNo")+result.get("subNo");
	        	paramMap.put("boardSeq", mapKey);
	        	paramMap.put("boardType", "ICF");
	        	List<Ct7000mVO> fileList = cmmDAO.selectAttachList(paramMap);
	        		        	
	        	if(!fileList.isEmpty()) {
					for(Ct7000mVO fileMap : fileList){
						String fileName = "";
						LOGGER.info("check=");
						//if(!(String.valueOf(result.get("boardNo")) =="null") && !(String.valueOf(result.get("boardType"))=="null" )){
							//fileName += result.get("boardNo").toString()+"_"+result.get("boardType").toString()+"_"+fileMap.getOrgFileName();
						//}
						fileName += result.get("rsiNo").toString()+"_"+result.get("rsNo").toString()+"_"+fileMap.getOrgFileName();
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
	
	// 연구대상자특성 데이터 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0401/ech0401ExcelSkinProp.do")
	public void ech0401ExcelSkinProp(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ExcelSkinProp.do - 연구대상자특성 데이터 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0401DAO.selectEch0401ExcelSkinProp(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "연구대상자특성 리스트", "ech0401SkinProp", request, response);
	}

	// 연구대상자의  사용성설문 결과 일괄 생성  Ajax termType 사전 1 사후 2 -> 사전 사후 구분없이 일괄생성으로 변경 2021.08.16
	@RequestMapping("/qxsepmny/ech0401/ech0401AjaxCrfSvyBat1.do")
	public View ech0401AjaxCrfSvyBat1(String corpCd, String rsNo, String step1, String step2, String termType, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, Cr3180mVO cr3180mVO, Cr3190mVO cr3190mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401AjaxCrfSvyBat1.do - 연구대상자의   사용성설문 결과 일괄 생성  Ajax");
		String message = "";
		boolean status = false;
		
		LOGGER.debug("termType="+termType);
		
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rs1000mVO.setRsNo(rsNo);
		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
		String rsNo7 = rs1000mVO.getRsNo7();
		LOGGER.debug("rsNo7="+rsNo7);		
		
		EgovMap map2 = new EgovMap();
		map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map2.put("rsCd", rs1000mVO.getRsCd());
		map2.put("mrsNo", rs1000mVO.getRsNo());
		rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("rsNo", rsNo);
		map.put("rsNo", rs1010mVO.getRsNo());
		
		//연구대상자의 사용성설문 목록 획득
		map.put("termType", termType);
		
		List<Cr3010mVO> resultList3 = ech0401DAO.selectEch0401CrfSvyBat11(map);
		if(resultList3.size() == 0){
			message = "연구대상자 사용성설문결과를 생성할 정보가 없습니다.";
		}
		
		for(Cr3010mVO cr3010mVO3 : resultList3){
			LOGGER.debug("resultList3="+resultList3.toString());
		
			//연구대상자의 사용성설문 목록 획득(템플릿번호)
			map.put("tempNo", cr3010mVO3.getTempNo());
			List<Cr3010mVO> resultList = ech0401DAO.selectEch0401CrfSvyBat1(map);	
			LOGGER.debug("resultList="+resultList.toString());
			
			int chkMtlDsp = 0;
			int chkMtlDsp2 = 0;
			
			if(resultList.size() != 0){
				
				//기존 생성된 특성결과를 삭제 한다. 
				EgovMap map3 = new EgovMap();
				map3.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				map3.put("rsNo", rsNo);
				map3.put("termType", termType);
				map3.put("tempNo", cr3010mVO3.getTempNo());
				int delchk = ech0401DAO.deleteEch0401CrfSvy1(map3);
				int delchk2 = ech0401DAO.deleteEch0401CrfSvyTl1(map3);
				LOGGER.debug("delchk="+delchk);
				
				//특성표제를 생성한다. 
				List<Cr3010mVO> resultList2 = ech0401DAO.selectEch0401CrfSvyBatTl1(map);
				for(Cr3010mVO cr3010mVO2 : resultList2){
					chkMtlDsp2 = chkMtlDsp2 + 1;
					LOGGER.debug("chkMtlDsp2="+chkMtlDsp2);
					switch (chkMtlDsp2) {
		            	case 1: cr3190mVO.setVar1(cr3010mVO2.getQuesAbb());
		                		break;
		            	case 2: cr3190mVO.setVar2(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 3: cr3190mVO.setVar3(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 4: cr3190mVO.setVar4(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 5: cr3190mVO.setVar5(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 6: cr3190mVO.setVar6(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 7: cr3190mVO.setVar7(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 8: cr3190mVO.setVar8(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 9: cr3190mVO.setVar9(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 10: cr3190mVO.setVar10(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 11: cr3190mVO.setVar10(cr3010mVO2.getQuesAbb());
        						break;		
		            	case 12: cr3190mVO.setVar10(cr3010mVO2.getQuesAbb());
								break;
		            	case 13: cr3190mVO.setVar10(cr3010mVO2.getQuesAbb());
								break;
		            	case 14: cr3190mVO.setVar10(cr3010mVO2.getQuesAbb());
								break;
		            	case 15: cr3190mVO.setVar10(cr3010mVO2.getQuesAbb());
								break;
					}
					
				}
				cr3190mVO.setTermType(termType);
				cr3190mVO.setTempNo(cr3010mVO3.getTempNo());
				ech0401DAO.insertEch0401AjaxSaveCrfSvyTl1(cr3190mVO);
				//cr3190mVO clear
				cr3190mVO.setVar1("");
				cr3190mVO.setVar2("");
				cr3190mVO.setVar3("");
				cr3190mVO.setVar4("");
				cr3190mVO.setVar5("");
				cr3190mVO.setVar6("");
				cr3190mVO.setVar7("");
				cr3190mVO.setVar8("");
				cr3190mVO.setVar9("");
				cr3190mVO.setVar10("");
				cr3190mVO.setVar11("");
				cr3190mVO.setVar12("");
				cr3190mVO.setVar13("");
				cr3190mVO.setVar14("");
				cr3190mVO.setVar15("");
				
				for(Cr3010mVO cr3010mVO : resultList){
					
					String chkRsiNo = cr3010mVO.getRsiNo();
					
					if(!chkRsiNo.equals(cr3180mVO.getRsiNo())) {
						
						if(chkMtlDsp != 0) {
							cr3180mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							cr3180mVO.setRsNo(rsNo);
							LOGGER.debug("3=");
							cr3180mVO.setRsNo7(rsNo7);
							cr3180mVO.setTermType(termType);
							cr3180mVO.setTempNo(cr3010mVO.getTempNo());
							ech0401DAO.insertEch0401AjaxSaveCrfSvy1(cr3180mVO);
							//cr3180mVO clear
							cr3180mVO.setVar1("");
							cr3180mVO.setVar2("");
							cr3180mVO.setVar3("");
							cr3180mVO.setVar4("");
							cr3180mVO.setVar5("");
							cr3180mVO.setVar6("");
							cr3180mVO.setVar7("");
							cr3180mVO.setVar8("");
							cr3180mVO.setVar9("");
							cr3180mVO.setVar10("");
							cr3180mVO.setVar11("");
							cr3180mVO.setVar12("");
							cr3180mVO.setVar13("");
							cr3180mVO.setVar14("");
							cr3180mVO.setVar15("");
						}	
						cr3180mVO.setRsiNo(chkRsiNo);
						chkMtlDsp = 0;
						chkMtlDsp = chkMtlDsp + 1;
						LOGGER.debug("chkMtlDsp="+chkMtlDsp);
						switch (chkMtlDsp) {
			            	case 1: cr3180mVO.setVar1(cr3010mVO.getAnswNum());
			                		break;
			            	case 2: cr3180mVO.setVar2(cr3010mVO.getAnswNum());
	                				break;
			            	case 3: cr3180mVO.setVar3(cr3010mVO.getAnswNum());
	                				break;
			            	case 4: cr3180mVO.setVar4(cr3010mVO.getAnswNum());
	                				break;
			            	case 5: cr3180mVO.setVar5(cr3010mVO.getAnswNum());
	                				break;
			            	case 6: cr3180mVO.setVar6(cr3010mVO.getAnswNum());
	                				break;
			            	case 7: cr3180mVO.setVar7(cr3010mVO.getAnswNum());
	                				break;
			            	case 8: cr3180mVO.setVar8(cr3010mVO.getAnswNum());
	                				break;
			            	case 9: cr3180mVO.setVar9(cr3010mVO.getAnswNum());
	                				break;
			            	case 10: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
	                				break;
			            	case 11: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
			            			break;
			            	case 12: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
			            	case 13: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
			            	case 14: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
			            	case 15: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
	                	}
						
					}else {
							//index에 따라 컬럼에 매칭한다
							//map.put("rsiNo", cr3010mVO.getRsiNo());
							cr3180mVO.setRsiNo(cr3010mVO.getRsiNo());
							chkMtlDsp = chkMtlDsp + 1;
							LOGGER.debug("chkMtlDsp="+chkMtlDsp);
							switch (chkMtlDsp) {
				            	case 1: cr3180mVO.setVar1(cr3010mVO.getAnswNum());
				                		break;
				            	case 2: cr3180mVO.setVar2(cr3010mVO.getAnswNum());
		                				break;
				            	case 3: cr3180mVO.setVar3(cr3010mVO.getAnswNum());
		                				break;
				            	case 4: cr3180mVO.setVar4(cr3010mVO.getAnswNum());
		                				break;
				            	case 5: cr3180mVO.setVar5(cr3010mVO.getAnswNum());
		                				break;
				            	case 6: cr3180mVO.setVar6(cr3010mVO.getAnswNum());
		                				break;
				            	case 7: cr3180mVO.setVar7(cr3010mVO.getAnswNum());
		                				break;
				            	case 8: cr3180mVO.setVar8(cr3010mVO.getAnswNum());
		                				break;
				            	case 9: cr3180mVO.setVar9(cr3010mVO.getAnswNum());
		                				break;
				            	case 10: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
		                				break;
				            	case 11: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
				            	case 12: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
				            	case 13: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
				            	case 14: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
				            	case 15: cr3180mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
		                	}
					}
				}
				if(chkMtlDsp != 0) {
					cr3180mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
					cr3180mVO.setRsNo(rsNo);
					cr3180mVO.setRsNo7(rsNo7);
					LOGGER.debug("3=");
					cr3180mVO.setTermType(termType);
					cr3180mVO.setTempNo(cr3010mVO3.getTempNo());
					ech0401DAO.insertEch0401AjaxSaveCrfSvy1(cr3180mVO);
					//cr3180mVO clear
					cr3180mVO.setVar1("");
					cr3180mVO.setVar2("");
					cr3180mVO.setVar3("");
					cr3180mVO.setVar4("");
					cr3180mVO.setVar5("");
					cr3180mVO.setVar6("");
					cr3180mVO.setVar7("");
					cr3180mVO.setVar8("");
					cr3180mVO.setVar9("");
					cr3180mVO.setVar10("");
					cr3180mVO.setVar11("");
					cr3180mVO.setVar12("");
					cr3180mVO.setVar13("");
					cr3180mVO.setVar14("");
					cr3180mVO.setVar15("");
				}
				message = "연구대상자 사용성설문 일괄등록이 완료되었습니다. 사용성설문결과 추출이 가능합니다";
				status = true;
				
			}else{
				message = "연구대상자 사용성설문결과를 생성할 정보가 없습니다.";
				status = false;
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		return jsonView;
	}

	// 연구대상자 사용성설문  데이터 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0401/ech0401ExcelCrfSvy1.do")
	public void ech0401ExcelCrfSvy1(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ExcelCrfSvy1.do - 연구대상자 사용성설문  데이터 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0401DAO.selectEch0401ExcelCrfSvy1(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "연구대상자 사용성설문 데이터 리스트", "ech0401CrfSvy1", request, response);
	}
	
	// 연구대상자의  효능설문 결과 일괄 생성  Ajax termType 사전 1 사후 2 -> 사전 사후 구분없이 일괄생성으로 변경 2021.08.16
	@RequestMapping("/qxsepmny/ech0401/ech0401AjaxCrfSvyBat2.do")
	public View ech0401AjaxCrfSvyBat2(String corpCd, String rsNo, String step1, String step2, String termType, Rs1000mVO rs1000mVO, Rs1010mVO rs1010mVO, Cr3280mVO cr3280mVO, Cr3290mVO cr3290mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401AjaxCrfSvyBat2.do - 연구대상자의  효능설문 결과 일괄 생성  Ajax");
		String message = "";
		boolean status = false;
		
		LOGGER.debug("termType="+termType);
		
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rs1000mVO.setRsNo(rsNo);
		rs1000mVO =  ech0401DAO.selectEch0401View(rs1000mVO);
		String rsNo7 = rs1000mVO.getRsNo7();
		LOGGER.debug("rsNo7="+rsNo7);		
		
		EgovMap map2 = new EgovMap();
		map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map2.put("rsCd", rs1000mVO.getRsCd());
		map2.put("mrsNo", rs1000mVO.getRsNo());
		rs1010mVO = ech0101DAO.selectEch0101RsCdCheck3(map2);
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//map.put("rsNo", rsNo);
		map.put("rsNo", rs1010mVO.getRsNo());
		
		//연구대상자의 효능설문 목록 획득(템플릿번호)
		map.put("termType", termType);
		
		
		List<Cr3010mVO> resultList3 = ech0401DAO.selectEch0401CrfSvyBat21(map);
		if(resultList3.size() == 0){
			message = "연구대상자 효능설문결과를 생성할 정보가 없습니다.";
		}
		
		for(Cr3010mVO cr3010mVO3 : resultList3){
			LOGGER.debug("resultList3="+resultList3.toString());
			
			//연구대상자의 효능설문 목록 획득(템플릿번호)
			map.put("tempNo", cr3010mVO3.getTempNo());
			List<Cr3010mVO> resultList = ech0401DAO.selectEch0401CrfSvyBat2(map);	
			LOGGER.debug("resultList="+resultList.toString());
			
			int chkMtlDsp = 0;
			int chkMtlDsp2 = 0;
			
			if(resultList.size() != 0){
				
				//기존 생성된 특성결과를 삭제 한다. 
				EgovMap map3 = new EgovMap();
				map3.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				map3.put("rsNo", rsNo);
				map3.put("termType", termType);
				map3.put("tempNo", cr3010mVO3.getTempNo());
				int delchk = ech0401DAO.deleteEch0401CrfSvy2(map3);
				int delchk2 = ech0401DAO.deleteEch0401CrfSvyTl2(map3);
				LOGGER.debug("delchk="+delchk);
				
				//특성표제를 생성한다. 
				List<Cr3010mVO> resultList2 = ech0401DAO.selectEch0401CrfSvyBatTl2(map);
				for(Cr3010mVO cr3010mVO2 : resultList2){
					chkMtlDsp2 = chkMtlDsp2 + 1;
					LOGGER.debug("chkMtlDsp2="+chkMtlDsp2);
					switch (chkMtlDsp2) {
		            	case 1: cr3290mVO.setVar1(cr3010mVO2.getQuesAbb());
		                		break;
		            	case 2: cr3290mVO.setVar2(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 3: cr3290mVO.setVar3(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 4: cr3290mVO.setVar4(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 5: cr3290mVO.setVar5(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 6: cr3290mVO.setVar6(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 7: cr3290mVO.setVar7(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 8: cr3290mVO.setVar8(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 9: cr3290mVO.setVar9(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 10: cr3290mVO.setVar10(cr3010mVO2.getQuesAbb());
	            				break;
		            	case 11: cr3290mVO.setVar10(cr3010mVO2.getQuesAbb());
        						break;
		            	case 12: cr3290mVO.setVar10(cr3010mVO2.getQuesAbb());
        						break;
		            	case 13: cr3290mVO.setVar10(cr3010mVO2.getQuesAbb());
        						break;
		            	case 14: cr3290mVO.setVar10(cr3010mVO2.getQuesAbb());
        						break;
		            	case 15: cr3290mVO.setVar10(cr3010mVO2.getQuesAbb());
        						break;
	            				
	            	}
					
				}
				cr3290mVO.setTermType(termType);
				cr3290mVO.setTempNo(cr3010mVO3.getTempNo());
				ech0401DAO.insertEch0401AjaxSaveCrfSvyTl2(cr3290mVO);
				//cr3290mVO clear
				cr3290mVO.setVar1("");
				cr3290mVO.setVar2("");
				cr3290mVO.setVar3("");
				cr3290mVO.setVar4("");
				cr3290mVO.setVar5("");
				cr3290mVO.setVar6("");
				cr3290mVO.setVar7("");
				cr3290mVO.setVar8("");
				cr3290mVO.setVar9("");
				cr3290mVO.setVar10("");
				cr3290mVO.setVar11("");
				cr3290mVO.setVar12("");
				cr3290mVO.setVar13("");
				cr3290mVO.setVar14("");
				cr3290mVO.setVar15("");
				
				for(Cr3010mVO cr3010mVO : resultList){
					
					String chkRsiNo = cr3010mVO.getRsiNo();
					
					if(!chkRsiNo.equals(cr3280mVO.getRsiNo())) {
						
						if(chkMtlDsp != 0) {
							cr3280mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							cr3280mVO.setRsNo(rsNo);
							LOGGER.debug("3=");
							cr3280mVO.setRsNo7(rsNo7);
							cr3280mVO.setTermType(termType);
							cr3280mVO.setTempNo(cr3010mVO.getTempNo());
							ech0401DAO.insertEch0401AjaxSaveCrfSvy2(cr3280mVO);
							//cr3280mVO clear
							cr3280mVO.setVar1("");
							cr3280mVO.setVar2("");
							cr3280mVO.setVar3("");
							cr3280mVO.setVar4("");
							cr3280mVO.setVar5("");
							cr3280mVO.setVar6("");
							cr3280mVO.setVar7("");
							cr3280mVO.setVar8("");
							cr3280mVO.setVar9("");
							cr3280mVO.setVar10("");
							cr3280mVO.setVar11("");
							cr3280mVO.setVar12("");
							cr3280mVO.setVar13("");
							cr3280mVO.setVar14("");
							cr3280mVO.setVar15("");
						}	
						cr3280mVO.setRsiNo(chkRsiNo);
						chkMtlDsp = 0;
						chkMtlDsp = chkMtlDsp + 1;
						LOGGER.debug("chkMtlDsp="+chkMtlDsp);
						switch (chkMtlDsp) {
			            	case 1: cr3280mVO.setVar1(cr3010mVO.getAnswNum());
			                		break;
			            	case 2: cr3280mVO.setVar2(cr3010mVO.getAnswNum());
	                				break;
			            	case 3: cr3280mVO.setVar3(cr3010mVO.getAnswNum());
	                				break;
			            	case 4: cr3280mVO.setVar4(cr3010mVO.getAnswNum());
	                				break;
			            	case 5: cr3280mVO.setVar5(cr3010mVO.getAnswNum());
	                				break;
			            	case 6: cr3280mVO.setVar6(cr3010mVO.getAnswNum());
	                				break;
			            	case 7: cr3280mVO.setVar7(cr3010mVO.getAnswNum());
	                				break;
			            	case 8: cr3280mVO.setVar8(cr3010mVO.getAnswNum());
	                				break;
			            	case 9: cr3280mVO.setVar9(cr3010mVO.getAnswNum());
	                				break;
			            	case 10: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
	                				break;
			            	case 11: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
			            	case 12: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
			            	case 13: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
			            	case 14: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
			            	case 15: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
            						break;
	                	}
						
					}else {
							//index에 따라 컬럼에 매칭한다
							//map.put("rsiNo", cr3010mVO.getRsiNo());
							cr3280mVO.setRsiNo(cr3010mVO.getRsiNo());
							chkMtlDsp = chkMtlDsp + 1;
							LOGGER.debug("chkMtlDsp="+chkMtlDsp);
							switch (chkMtlDsp) {
				            	case 1: cr3280mVO.setVar1(cr3010mVO.getAnswNum());
				                		break;
				            	case 2: cr3280mVO.setVar2(cr3010mVO.getAnswNum());
		                				break;
				            	case 3: cr3280mVO.setVar3(cr3010mVO.getAnswNum());
		                				break;
				            	case 4: cr3280mVO.setVar4(cr3010mVO.getAnswNum());
		                				break;
				            	case 5: cr3280mVO.setVar5(cr3010mVO.getAnswNum());
		                				break;
				            	case 6: cr3280mVO.setVar6(cr3010mVO.getAnswNum());
		                				break;
				            	case 7: cr3280mVO.setVar7(cr3010mVO.getAnswNum());
		                				break;
				            	case 8: cr3280mVO.setVar8(cr3010mVO.getAnswNum());
		                				break;
				            	case 9: cr3280mVO.setVar9(cr3010mVO.getAnswNum());
		                				break;
				            	case 10: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
		                				break;
				            	case 11: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
				            	case 12: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
				            	case 13: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
				            	case 14: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
				            	case 15: cr3280mVO.setVar10(cr3010mVO.getAnswNum());
                						break;
		                	}
					}
				}
				if(chkMtlDsp != 0) {
					cr3280mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
					cr3280mVO.setRsNo(rsNo);
					cr3280mVO.setRsNo7(rsNo7);
					LOGGER.debug("3=");
					cr3280mVO.setTermType(termType);
					cr3280mVO.setTempNo(cr3010mVO3.getTempNo());
					ech0401DAO.insertEch0401AjaxSaveCrfSvy2(cr3280mVO);
					//cr3280mVO clear
					cr3280mVO.setVar1("");
					cr3280mVO.setVar2("");
					cr3280mVO.setVar3("");
					cr3280mVO.setVar4("");
					cr3280mVO.setVar5("");
					cr3280mVO.setVar6("");
					cr3280mVO.setVar7("");
					cr3280mVO.setVar8("");
					cr3280mVO.setVar9("");
					cr3280mVO.setVar10("");
					cr3280mVO.setVar11("");
					cr3280mVO.setVar12("");
					cr3280mVO.setVar13("");
					cr3280mVO.setVar14("");
					cr3280mVO.setVar15("");
				}
				message = "연구대상자 효능설문 통계 일괄등록이 완료되었습니다. 효능설문결과 추출이 가능합니다";
				status = true;
				
			}else{
				message = "연구대상자 효능설문결과를 생성할 정보가 없습니다.";
				status = false;
			}
		
		}		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		return jsonView;
	}
	
	
	// 연구대상자 사용성설문  데이터 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0401/ech0401ExcelCrfSvy2.do")
	public void ech0401ExcelCrfSvy2(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0401/ech0401ExcelCrfSvy2.do - 연구대상자 사용성설문  데이터 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0401DAO.selectEch0401ExcelCrfSvy2(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "연구대상자 효능설문 데이터 리스트", "ech0401CrfSvy2", request, response);
	}

}
