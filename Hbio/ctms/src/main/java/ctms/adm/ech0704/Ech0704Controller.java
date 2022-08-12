package ctms.adm.ech0704;

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
import ctms.valueObject.Ct2000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0704Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0704Controller.class);
	@Autowired private Ech0704DAO ech0704DAO;
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
	// ********************************(기준정보관리) 20201124 관리자 고객사관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0704/ech0704List.do")	
	public String ech0704List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0704/ech0704List.do - 기준정보관리 고객사관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//어드민타입 1 어드민 2 일반사용자 
		model.addAttribute("admintype", adminVO.getAdminType());

		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());	
		//회사코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0704DAO.selectEch0704List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/ech0704/ech0704List";
	}
	
	// ********************************(기준정보관리) 20201124 관리자 고객사관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0704/ech0704View.do")
	public String ech0704View(@ModelAttribute CmmnSearchVO searchVO , Ct2000mVO ct2000mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0704/ech0704View.do - 기준정보관리 고객사관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//어드민타입 1 어드민 2 일반사용자 
		model.addAttribute("admintype", adminVO.getAdminType());
		
		ct2000mVO = ech0704DAO.selectEch0704View(ct2000mVO);
		
		// 사업자번호를 3-2-5 형식으로 나눈다.
		if (!EgovStringUtil.isEmpty(ct2000mVO.getBregRsno())) {
			String bregRsno = ct2000mVO.getBregRsno();
			ct2000mVO.setRegno1(bregRsno.substring(0, 3)); // 사업자번호1 3자리
			ct2000mVO.setRegno2(bregRsno.substring(3, 5)); // 사업자번호2 2자리
			ct2000mVO.setRegno3(bregRsno.substring(bregRsno.length()-5, bregRsno.length())); // 사업자번호3 5자리
		}
		
		// 법인사업자번호를 6-7 형식으로 나눈다.
		if (!EgovStringUtil.isEmpty(ct2000mVO.getCorpNo())) {
			String cregno = ct2000mVO.getCorpNo();	
		
			ct2000mVO.setCregno1(cregno.substring(0, 6)); // 법인사업자번호1 6자리
			ct2000mVO.setCregno2(cregno.substring(cregno.length()-7, cregno.length())); // 법인사업자번호2 7자리
		}
				
		model.addAttribute("ct2000mVO", ct2000mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		//EgovMap map = new EgovMap();
		//map.put("clientNo", ct2000mVO.getVendNo());
						
		return "/adm/ech0704/ech0704View";
	}	

	// ********************************(기준정보관리) 20201125 관리자 고객사관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0704/ech0704Modify.do")
	public String ech0704Modify(@ModelAttribute("ct2000mVO") Ct2000mVO ct2000mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0704/ech0704Modify.do - 관리자 고객사관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드(CTMS운영) 설정
		ct2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(ct2000mVO.getCorpCd());
		model.addAttribute("branch", branch);		
		
		// 고객사구분(공통코드) 목록 CM1010
		List<EgovMap> cm1010 = cmmDAO.selectCmmCdList(ct2000mVO.getCorpCd(), "CM1010");
		model.addAttribute("cm1010", cm1010);
	
	   // 등록화면으로
		if (EgovStringUtil.isEmpty(ct2000mVO.getVendNo())) {
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		// 수정화면으로 
		if(!EgovStringUtil.isEmpty(ct2000mVO.getVendNo())){
			
			ct2000mVO = ech0704DAO.selectEch0704View(ct2000mVO);
			
			// 이메일 설정 이메일 변화 id @ adr -> Mng_email
			if (!EgovStringUtil.isEmpty(ct2000mVO.getMngEmail())) {
				String email = ct2000mVO.getMngEmail();	
				
				String[] spEmail = email.split("@");

				ct2000mVO.setEmailId(spEmail[0]);
				ct2000mVO.setEmailAdr(spEmail[1]);
			}
			
			// 사업자번호를 3-2-5 형식으로 나눈다.
			if (!EgovStringUtil.isEmpty(ct2000mVO.getBregRsno())) {
				String bregRsno = ct2000mVO.getBregRsno();	
			
				ct2000mVO.setRegno1(bregRsno.substring(0, 3)); // 사업자번호1 3자리
				ct2000mVO.setRegno2(bregRsno.substring(3, 5)); // 사업자번호2 2자리
				ct2000mVO.setRegno3(bregRsno.substring(bregRsno.length()-5, bregRsno.length())); // 사업자번호3 5자리
			}
			
			// 사업자번호를 6-7 형식으로 나눈다.
			if (!EgovStringUtil.isEmpty(ct2000mVO.getCorpNo())){
				String cregno = ct2000mVO.getCorpNo();	
			
				ct2000mVO.setCregno1(cregno.substring(0, 6)); // 법인사업자번호1 6자리
				ct2000mVO.setCregno2(cregno.substring(cregno.length()-7, cregno.length())); // 법인사업자번호2 7자리
			}
			
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("ct2000mVO", ct2000mVO);
		}
		
		return "/adm/ech0704/ech0704Modify";
	}

		// ********************************(기준정보관리) 20201125 관리자 고객사관리 저장 ********************************
		@RequestMapping("/qxsepmny/ech0704/ech0704Update.do")
		public String ech0704Save(@ModelAttribute("ct2000mVO") Ct2000mVO ct2000mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0704/ech0704Save.do - 관리자 고객사관리 저장");
		String message = "";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드(CTMS운영) 설정 
		ct2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		//작업자 설정
		ct2000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());

		if (!EgovStringUtil.isEmpty(ct2000mVO.getEmailId())) {
			String email = ct2000mVO.getEmailId() + "@" + ct2000mVO.getEmailAdr();
			ct2000mVO.setMngEmail(email);					
		}
		
		// 사업자등록번호 3-2-5 -> 10자리로			
		if (!EgovStringUtil.isEmpty(ct2000mVO.getRegno1())) {
			ct2000mVO.setBregRsno(ct2000mVO.getRegno1()+ct2000mVO.getRegno2()+ct2000mVO.getRegno3());
		}
		
		// 법인등록번호 6-7 -> 13자리로			
		if (!EgovStringUtil.isEmpty(ct2000mVO.getCregno1())) {
			ct2000mVO.setCorpNo(ct2000mVO.getCregno1()+ct2000mVO.getCregno2());
		}
		
		if(EgovStringUtil.isEmpty(ct2000mVO.getVendNo())){
			ech0704DAO.insertEch0704(ct2000mVO);
			message = "등록이 완료되었습니다.";
		}else{
			ech0704DAO.updateEch0704(ct2000mVO);
			message = "수정이 완료되었습니다.";			
		}

		return redirectList(reda, message);

	}
	// ********************************(기준정보관리) 20201126 관리자 고객사관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0704/ech0704Delete.do")
		public String ech0704Delete(@ModelAttribute Ct2000mVO ct2000mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0704/ech0704Delete.do - 관리자 고객사관리 삭제");
		String message = "";
		
		// 고객사정보 삭제 제한 조건 Check
		// 고객사코드(VEND_NO)가 연구과제에 사용된 경우 삭제 불가
		String vendYn = ech0704DAO.selectVendYn(ct2000mVO.getCorpCd(), ct2000mVO.getVendNo());
	
		if("Y".equals(vendYn)) {
			message = "고객사정보가 존재하여 삭제할 수 없습니다(연구과제)";
			return redirectList(reda, message);
		}
		
		//고객사정보 삭제
		if(!EgovStringUtil.isEmpty(ct2000mVO.getVendNo())){
			ech0704DAO.deleteEch0704(ct2000mVO);
			message = "고객사정보가 삭제되었습니다.";
		}
		return redirectList(reda, message);
	}

	// 고객사관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0704/ech0704List.do";
	}
	
	// 고객사관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0704/ech0704Excel.do")
	public void ech0704Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0704/ech0704Excel.do - 고객사관리 목록 엑셀 다운로드");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0704DAO.selectEch0704Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
					
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "고객사 리스트", "ech0704", request, response);
	}

}
