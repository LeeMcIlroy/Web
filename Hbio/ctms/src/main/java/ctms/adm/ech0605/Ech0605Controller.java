package ctms.adm.ech0605;

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
import ctms.valueObject.Rm1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0605Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0605Controller.class);
	@Autowired private Ech0605DAO ech0605DAO;
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
	
	
	// ********************************(발송관리) 20201124 관리자 이메일메시지(예문)관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0605/ech0605List.do")	
	public String ech0605List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0605/ech0605List.do - 발송관리 이메일메시지(예문)관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0605DAO.selectEch0605List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0605/ech0605List";
	}
	
	// ********************************(발송관리) 20201124 관리자 이메일메시지(예문)관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0605/ech0605View.do")
	public String ech0605View(@ModelAttribute CmmnSearchVO searchVO , Rm1010mVO rm1010mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0605/ech0605View.do - 발송관리 이메일메시지(예문)관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		rm1010mVO =  ech0605DAO.selectEch0605View(rm1010mVO);
		
		model.addAttribute("rm1010mVO", rm1010mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		EgovMap map = new EgovMap();
		map.put("getEmailtNo", rm1010mVO.getEmailtNo());
						
		return "/adm/ech0605/ech0605View";
	}	

	// ********************************(발송관리) 20201125 관리자 이메일메시지(예문)관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0605/ech0605Modify.do")
	public String ech0605Modify(@ModelAttribute("rm1010mVO") Rm1010mVO rm1010mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0605/ech0605Modify.do - 관리자 이메일메시지(예문)관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
	
		// 회사코드(CTMS운영) 설정
		rm1010mVO.setCorpCd("HNBSRC");
		
	   //등록화면으로
		if (EgovStringUtil.isEmpty(rm1010mVO.getEmailtNo())) {
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rm1010mVO.getEmailtNo())){
					
			rm1010mVO = ech0605DAO.selectEch0605View(rm1010mVO);
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("rm1010mVO", rm1010mVO);			
		}
		
		return "/adm/ech0605/ech0605Modify";
	}

	// ********************************(발송관리) 20201125 관리자 이메일메시지(예문)관리 저장 ********************************
	@RequestMapping("/qxsepmny/ech0605/ech0605Update.do")
		public String ech0605Save(@ModelAttribute("rm1010mVO") Rm1010mVO rm1010mVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0605/ech0605Update.do - 관리자 이메일메시지(예문)관리 저장");
		LOGGER.debug("searchVO = " + rm1010mVO.toString());
		String message = "";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드(CTMS운영) 설정
		rm1010mVO.setCorpCd("HNBSRC");
		
		if(EgovStringUtil.isEmpty(rm1010mVO.getEmailtNo())){
		    
			//작성자 안에 세션 name 입력
			//noticeVO.setNoti_writer(adminVO.getName());				
			
			ech0605DAO.insertEch0605(rm1010mVO);				
			
			message = "등록이 완료되었습니다.";
		}else{
			ech0605DAO.updateEch0605(rm1010mVO);
			
			message = "수정이 완료되었습니다.";			
			}

		return redirectList(reda, message);

	}
	
	// ********************************(발송관리) 20201126 관리자 이메일메시지(예문)관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0605/ech0605Delete.do")
		public String ech0605Delete(@ModelAttribute Rm1010mVO rm1010mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0605/ech0605Delete.do - 관리자 이메일메시지(예문)관리 삭제");
		String message = "";
		
		//이메일메시지(예문)관리 삭제
		if(!EgovStringUtil.isEmpty(rm1010mVO.getEmailtNo())){
		
			ech0605DAO.deleteEch0605(rm1010mVO);
			message = "이메일메시지 정보가 삭제되었습니다.";
		}
		return redirectList(reda, message);

	}

	// 이메일메시지(예문)관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0605/ech0605List.do";
	}
	
	// 이메일메시지(예문)관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0605/ech0605Excel.do")
	public void ech0605Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0605/ech0605Excel.do - 이메일메시지(예문)관리 목록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0605DAO.selectEch0605Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "이메일메시지 리스트", "ech0605", request, response); 
	}
		
		

}
