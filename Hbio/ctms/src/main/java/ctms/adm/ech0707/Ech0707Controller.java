package ctms.adm.ech0707;

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
import ctms.valueObject.Cm4000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0707Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0707Controller.class);
	@Autowired private Ech0707DAO ech0707DAO;
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
	
	
	// ********************************(기준정보관리) 20201208 관리자 공통코드분류관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0707/ech0707List.do")	
	public String ech0707List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0707/ech0707List.do - 공통코드분류관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//어드민타입 1 어드민 2 일반사용자 
		model.addAttribute("admintype", adminVO.getAdminType());
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());		
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		// CTMS 운영회사 설정
		searchVO.setCtmsCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		List<EgovMap> clsCat1 = ech0707DAO.selectEch0707ClsCat1(searchVO);
		List<EgovMap> clsCat2 = ech0707DAO.selectEch0707ClsCat2(searchVO);
		
		CmmnListVO listVO = ech0707DAO.selectEch0707List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("clsCat1", clsCat1);
		model.addAttribute("clsCat2", clsCat2);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		
		return "/adm/ech0707/ech0707List";
	}
	
	// ********************************(기준정보관리) 20201208 관리자 공통코드분류관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0707/ech0707View.do")
	public String ech0707View(@ModelAttribute CmmnSearchVO searchVO , Cm4000mVO cm4000mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0707/ech0707View.do -  공통코드분류관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//어드민타입 1 어드민 2 일반사용자 
		model.addAttribute("admintype", adminVO.getAdminType());
		
		//회사코드 설정
		cm4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		cm4000mVO =  ech0707DAO.selectEch0707View(cm4000mVO);
		
		model.addAttribute("cm4000mVO", cm4000mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		return "/adm/ech0707/ech0707View";
	}	

	// ********************************(기준정보관리) 20201208 관리자 공통코드분류관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0707/ech0707Modify.do")
	public String ech0707Modify(@ModelAttribute("cm4000mVO") Cm4000mVO cm4000mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0707/ech0707Modify.do - 관리자 공통코드분류관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	
	   //등록화면으로
		if (EgovStringUtil.isEmpty(cm4000mVO.getCorpCd())) {
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		} else {
			//수정화면으로 
				cm4000mVO = ech0707DAO.selectEch0707View(cm4000mVO);
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("cm4000mVO", cm4000mVO);			
		}
		
		return "/adm/ech0707/ech0707Modify";
	}

		// ********************************(기준정보관리) 20201208 관리자 공통코드분류관리 저장 ********************************
		@RequestMapping("/qxsepmny/ech0707/ech0707Update.do")
			public String ech0707Save(@ModelAttribute("cm4000mVO") Cm4000mVO cm4000mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0707/ech0707Save.do - 관리자 공통코드분류관리 저장");
			String message = "";
			
			//세션 호출
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
			
			// 회사코드(CTMS운영사) 설정
			cm4000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			// 등록수정자 설정
			cm4000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
						
			if(EgovStringUtil.isEmpty(cm4000mVO.getDataRegdt())){
				ech0707DAO.insertEch0707(cm4000mVO);				
				
				message = "등록이 완료되었습니다.";
			}else{
				ech0707DAO.updateEch0707(cm4000mVO);
				message = "수정이 완료되었습니다.";			
				}

			return redirectList(reda, message);

		}
		// ********************************(기준정보관리) 20201208 관리자 공통코드분류관리 삭제 ********************************
		@RequestMapping("/qxsepmny/ech0707/ech0707Delete.do")
			public String ech0707Delete(@ModelAttribute Cm4000mVO cm4000mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0707/ech0707Delete.do - 관리자 공통코드분류관리 삭제");
			String message = "";
			
			//공통코드분류관리 삭제
			if(!EgovStringUtil.isEmpty(cm4000mVO.getCd())){
			
				ech0707DAO.deleteEch0707(cm4000mVO);
				message = "공통코드분류 정보가 삭제되었습니다.";
			}
			return redirectList(reda, message);

		}

		// 공통코드분류관리 리스트로 리다이렉트
		private String redirectList(RedirectAttributes reda, String message) {
			reda.addFlashAttribute("message", message);
			return "redirect:/qxsepmny/ech0707/ech0707List.do";
		}
		
		// 공통코드분류관리 목록 엑셀 다운로드
		@SuppressWarnings("unchecked")
		@RequestMapping("/qxsepmny/ech0707/ech0707Excel.do")
		public void ech0707Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0707/ech0707Excel.do - 공통코드분류관리 목록 엑셀 다운로드");
			
			EgovMap dataMap = new EgovMap();
			
			List<EgovMap> resultList = ech0707DAO.selectEch0707Excel(searchVO);
			dataMap.put("resultList", resultList);
			
			int num = 1;
			for (EgovMap egovMap : resultList) {
				egovMap.put("number", num);
				num++;
			}
			
			AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
			
			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.getPerformanceExcel(dataMap, "공통코드분류 리스트", "ech0707", request, response);
		}
		
		// 공통코드 - 대분류와 연동하여 중분류코드 가져오기 2020.12.12 개발2
		@RequestMapping("/qxsepmny/ech0707/ech0707AjaxClsCat2.do")
		public View ech0707AjaxClsCat2(String cd, HttpServletRequest request, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0707/ech0707AjaxClsCat2.do - 공통코드 - 대분류와 연동하여 중분류코드 가져오기");
			LOGGER.debug("cd = " + cd);
				
			List<EgovMap> resultList = ech0707DAO.selectEch0707AjaxClsCat2(cd); 
			model.addAttribute("resultList", resultList);
			
			return jsonView;
		}
		

		
		

}
