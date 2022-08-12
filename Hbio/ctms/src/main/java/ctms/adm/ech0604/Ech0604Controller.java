package ctms.adm.ech0604;

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
import ctms.valueObject.Rm2010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0604Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0604Controller.class);
	@Autowired private Ech0604DAO ech0604DAO;
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
	
	
	// ********************************(발송관리) 20201124 관리자 SMS메시지(예문)관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0604/ech0604List.do")	
	public String ech0604List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0604/ech0604List.do - 발송관리 SMS메시지(예문)관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0604DAO.selectEch0604List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0604/ech0604List";
	}
	
	// ********************************(발송관리) 20201124 관리자 SMS메시지(예문)관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0604/ech0604View.do")
	public String ech0604View(@ModelAttribute CmmnSearchVO searchVO , Rm2010mVO rm2010mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0604/ech0604View.do - 발송관리 SMS메시지(예문)관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		rm2010mVO =  ech0604DAO.selectEch0604View(rm2010mVO);
		
		model.addAttribute("rm2010mVO", rm2010mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		EgovMap map = new EgovMap();
		map.put("getSmstNo", rm2010mVO.getSmstNo());
						
		return "/adm/ech0604/ech0604View";
	}	

	// ********************************(발송관리) 20201125 관리자 SMS메시지(예문)관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0604/ech0604Modify.do")
	public String ech0604Modify(@ModelAttribute("rm2010mVO") Rm2010mVO rm2010mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0604/ech0604Modify.do - 관리자 SMS메시지(예문)관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	
		// 회사코드(CTMS운영) 설정
		rm2010mVO.setCorpCd("HNBSRC");
		
	   //등록화면으로
		if (EgovStringUtil.isEmpty(rm2010mVO.getSmstNo())) {
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rm2010mVO.getSmstNo())){
					
			rm2010mVO = ech0604DAO.selectEch0604View(rm2010mVO);
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("rm2010mVO", rm2010mVO);			
		}
		
		return "/adm/ech0604/ech0604Modify";
	}

	// ********************************(발송관리) 20201125 관리자 SMS메시지(예문)관리 저장 ********************************
	@RequestMapping("/qxsepmny/ech0604/ech0604Update.do")
		public String ech0604Save(@ModelAttribute("rm2010mVO") Rm2010mVO rm2010mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0604/ech0604Update.do - 관리자 SMS메시지(예문)관리 저장");
		LOGGER.debug("searchVO = " + rm2010mVO.toString());
		String message = "";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드(CTMS운영) 설정
		rm2010mVO.setCorpCd("HNBSRC");
		
		if(EgovStringUtil.isEmpty(rm2010mVO.getSmstNo())){
		    
			//작성자 안에 세션 name 입력
			//noticeVO.setNoti_writer(adminVO.getName());				
			
			ech0604DAO.insertEch0604(rm2010mVO);				
			
			message = "등록이 완료되었습니다.";
		}else{
			ech0604DAO.updateEch0604(rm2010mVO);
			
			message = "수정이 완료되었습니다.";			
			}

		return redirectList(reda, message);

	}
	// ********************************(발송관리) 20201126 관리자 SMS메시지(예문)관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0604/ech0604Delete.do")
		public String ech0604Delete(@ModelAttribute Rm2010mVO rm2010mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0604/ech0604Delete.do - 관리자 SMS메시지(예문)관리 삭제");
		String message = "";
		
		//SMS메시지(예문)관리 삭제
		if(!EgovStringUtil.isEmpty(rm2010mVO.getSmstNo())){
		
			ech0604DAO.deleteEch0604(rm2010mVO);
			message = "SMS메시지 정보가 삭제되었습니다.";
		}
		return redirectList(reda, message);

	}
	
	

	// SMS메시지(예문)관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0604/ech0604List.do";
	}
	
	// SMS메시지(예문)관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0604/ech0604Excel.do")
	public void ech0604Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0604/ech0604Excel.do - SMS메시지(예문)관리 목록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0604DAO.selectEch0604Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		//AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		//dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "SMS메시지 리스트", "ech0604", request, response); // smssplList
	}
		
		

}
