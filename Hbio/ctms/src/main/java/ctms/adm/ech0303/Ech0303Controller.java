package ctms.adm.ech0303;



import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
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

import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0303Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0303Controller.class);
	@Autowired private Ech0303DAO ech0303DAO;
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
	
	
	// ********************************(피험자관리) 20201203 관리자 피험자관리 목록화면********************************
	
	@RequestMapping("/qxsepmny/ech0303/ech0303List.do")	
	
	public String ech0303List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, String searchWord) throws Exception {
		LOGGER.debug("/qxsepmny/ech0303/ech0303List.do - 연구관리화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0303DAO.selectEch0303List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	    
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		model.addAttribute("searchWord", searchWord);

		return  "/adm/ech0303/ech0303List";
	}
	  @RequestMapping("/qxsepmny/ech0303/ech0303View.do")
	    public String admech0303View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String resrDt,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0303/ech0303View.do - 피부자극결과 조회");
	        LOGGER.debug(" = " );  //변경할것
	       
	        PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
	        List<EgovMap> result = ech0303DAO.selectEch0303View(resrDt);
	       
	        model.addAttribute("rs4000mVO",result);
	        model.addAttribute("resrDt",resrDt);
	        
	        model.addAttribute("paginationInfo", paginationInfo);
			
			model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
			model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
			model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
	        return "/adm/ech0303/ech0303View";
	    }

}
