package ctms.adm.ech0708;

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
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Cm4010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0708Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0708Controller.class);
	@Autowired private Ech0708DAO ech0708DAO;
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
	
	
	// ********************************(기준정보관리) 20201208 관리자 공통코드관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0708/ech0708List.do")	
	public String ech0708List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0708/ech0708List.do - 공통코드관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0708DAO.selectEch0708List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0708/ech0708List";
	}
	
	// ********************************(기준정보관리) 20201208 관리자 공통코드관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0708/ech0708View.do")
	public String ech0708View(@ModelAttribute CmmnSearchVO searchVO , Cm4010mVO cm4010mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0708/ech0708View.do - 공통코드관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		cm4010mVO =  ech0708DAO.selectEch0708One(cm4010mVO.getCommCodeNo());
		
		model.addAttribute("result", cm4010mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		EgovMap map = new EgovMap();
		map.put("commCodeNo", cm4010mVO.getCommCodeNo());
						
		return "/adm/ech0708/ech0708View";
	}	

	// ********************************(기준정보관리) 20201208 관리자 공통코드관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0708/ech0708Modify.do")
	public String ech0708Modify(@ModelAttribute("cm4010mVO") Cm4010mVO cm4010mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0708/ech0708Modify.do - 관리자 공통코드관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
	
	   //등록화면으로
		if (EgovStringUtil.isEmpty(cm4010mVO.getCommCodeNo())) {
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(cm4010mVO.getCommCodeNo())){
					
			cm4010mVO = ech0708DAO.selectEch0708One(cm4010mVO.getCommCodeNo());
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("cm4010mVO", cm4010mVO);			
		}
		
		return "/adm/ech0708/ech0708Modify";
	}

		// ********************************(기준정보관리) 20201208 관리자 공통코드관리 저장 ********************************
		@RequestMapping("/qxsepmny/ech0708/ech0708Save.do")
			public String ech0708Save(@ModelAttribute("cm4010mVO") Cm4010mVO cm4010mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0708/ech0708Save.do - 관리자 공통코드관리 저장");
			String message = "";
			
			//세션 호출
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
			
			// 회사코드(CTMS운영사) 설정
			cm4010mVO.setCorpCd("HSRC");
			
			if(EgovStringUtil.isEmpty(cm4010mVO.getCommCodeNo())){
			    
				//작성자 안에 세션 name 입력
				//noticeVO.setNoti_writer(adminVO.getName());
				
				ech0708DAO.insertEch0708(cm4010mVO);				
				
				message = "등록이 완료되었습니다.";
			}else{
				ech0708DAO.updateEch0708(cm4010mVO);
				message = "수정이 완료되었습니다.";			
				}

			return redirectList(reda, message);

		}
		// ********************************(기준정보관리) 20201208 관리자 공통코드관리 삭제 ********************************
		@RequestMapping("/qxsepmny/ech0708/ech0708Delete.do")
			public String ech0708Delete(@ModelAttribute Cm4010mVO cm4010mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0708/ech0708Delete.do - 관리자 공통코드관리 삭제");
			String message = "";
			
			//공통코드관리 삭제
			if(!EgovStringUtil.isEmpty(cm4010mVO.getCommCodeNo())){
			
				ech0708DAO.deleteEch0708(cm4010mVO);
				message = "공통코드 정보가 삭제되었습니다.";
			}
			return redirectList(reda, message);

		}
		
		

		// 공통코드관리 리스트로 리다이렉트
		private String redirectList(RedirectAttributes reda, String message) {
			reda.addFlashAttribute("message", message);
			return "redirect:/qxsepmny/ech0708/ech0708List.do";
		}
		
		// 공통코드관리 목록 엑셀 다운로드
		@SuppressWarnings("unchecked")
		@RequestMapping("/qxsepmny/ech0708/ech0708Excel.do")
		public void ech0708Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0708/ech0708Excel.do - 공통코드관리 목록 엑셀 다운로드");
			LOGGER.debug("searchVO = " + searchVO.toString());
			EgovMap dataMap = new EgovMap();
			
			List<EgovMap> resultList = ech0708DAO.selectEch0708Excel(searchVO);
			dataMap.put("resultList", resultList);
			
			int num = 1;
			for (EgovMap egovMap : resultList) {
				egovMap.put("number", num);
				num++;
			}
			
			//AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			//dataMap.put("printUser", sessionVO.getName());
			
			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.getPerformanceExcel(dataMap, "공통코드 리스트", "codeList", request, response);
		}
		
		

}
