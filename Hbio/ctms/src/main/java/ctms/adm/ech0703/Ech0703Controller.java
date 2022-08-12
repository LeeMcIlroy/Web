package ctms.adm.ech0703;

import java.util.List;

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
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Ct1020mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0703Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0703Controller.class);
	@Autowired private Ech0703DAO ech0703DAO;
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
	
	
	// ********************************(기준정보관리) 20201124 관리자 지사관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0703/ech0703List.do")	
	public String ech0703List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0703/ech0703List.do - 기준정보관리 지사관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());		
		
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0703DAO.selectEch0703List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0703/ech0703List";
	}
	
	// ********************************(기준정보관리) 20201124 관리자 지사관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0703/ech0703View.do")
	public String ech0703View(@ModelAttribute CmmnSearchVO searchVO , Ct1020mVO ct1020mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0703/ech0703View.do - 기준정보관리 지사관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//어드민타입 1 어드민 2 일반사용자 
		model.addAttribute("admintype", adminVO.getAdminType());
		
		ct1020mVO =  ech0703DAO.selectEch0703View(ct1020mVO);
		
		model.addAttribute("ct1020mVO", ct1020mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
								
		return "/adm/ech0703/ech0703View";
	}	

	// ********************************(기준정보관리) 20201125 관리자 지사관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0703/ech0703Modify.do")
	public String ech0703Modify(@ModelAttribute("ct1020mVO") Ct1020mVO ct1020mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0703/ech0703Modify.do - 관리자 지사관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드(CTMS운영) 설정
		ct1020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				
		//지사구분(공통코드) 목록
		List<EgovMap> cm1020 = cmmDAO.selectCmmCdList(ct1020mVO.getCorpCd(), "CM1020");
		model.addAttribute("cm1020", cm1020);		
	
	   //등록화면으로
		if (EgovStringUtil.isEmpty(ct1020mVO.getBranchCd())) {
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(ct1020mVO.getBranchCd())){
					
			ct1020mVO = ech0703DAO.selectEch0703View(ct1020mVO);
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("ct1020mVO", ct1020mVO);
						
		}
		
		return "/adm/ech0703/ech0703Modify";
	}

	// ********************************(기준정보관리) 20201125 관리자 지사관리 저장 ********************************
	@RequestMapping("/qxsepmny/ech0703/ech0703Update.do")
	public String ech0703Save(@ModelAttribute("ct1020mVO") Ct1020mVO ct1020mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0703/ech0703Update.do - 관리자 지사관리 저장");
	String message = "";
	
	//세션 호출
	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	
	// 회사코드(CTMS운영) 설정
	ct1020mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
	//작업자 설정
	ct1020mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
	
	if(EgovStringUtil.isEmpty(ct1020mVO.getBranchCd())){
		ech0703DAO.insertEch0703(ct1020mVO);
		message = "등록이 완료되었습니다.";
	}else{
		ech0703DAO.updateEch0703(ct1020mVO);
		message = "수정이 완료되었습니다.";			
		}

	return redirectList(reda, message);

	}
	// ********************************(기준정보관리) 20201126 관리자 지사관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0703/ech0703Delete.do")
		public String ech0703Delete(@ModelAttribute Ct1020mVO ct1020mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0703/ech0703Delete.do - 관리자 지사관리 삭제");
		String message = "";
	
		// 지사정보 삭제 제한 조건 Check
		// 지사코드(BRANCH_CD)가 연구과제, 구성원정보에 사용된 경우 삭제 불가
		String branchYn = ech0703DAO.selectBranchYn(ct1020mVO.getCorpCd(), ct1020mVO.getBranchCd());
		
		if("Y".equals(branchYn)) {
			message = "지사 사용정보가 존재하여 삭제할 수 없습니다(연구과제,구성원관리 사용)";
			return redirectList(reda, message);
		}else{
			// 지사관리 삭제
			if(!EgovStringUtil.isEmpty(ct1020mVO.getBranchCd())){
				ech0703DAO.deleteEch0703(ct1020mVO);
				message = "지사정보가 삭제되었습니다.";
			}				
		}
		return redirectList(reda, message);
	}

	// 지사관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0703/ech0703List.do";
	}

	// 지사관리 조회화면 리다이렉트
	private String redirectView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0703/ech0703View.do";
	}
	
	
	// 지사관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0703/ech0703Excel.do")
	public void ech0703Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0703/ech0703Excel.do - 지사관리 목록 엑셀 다운로드");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0703DAO.selectEch0703Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "지사 리스트", "ech0703", request, response);
	}
		
		
}
