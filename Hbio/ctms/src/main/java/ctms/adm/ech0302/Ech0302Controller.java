package ctms.adm.ech0302;

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
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.web.PaginationController;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0302Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0302Controller.class);
	@Autowired private Ech0302DAO ech0302DAO;
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
	
	@RequestMapping("/qxsepmny/ech0302/ech0302List.do")	
	
	public String ech0302List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0302/ech0302List.do - 연구관리화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0302DAO.selectEch0302List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	    

		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
	
		return  "/adm/ech0302/ech0302List";
	}
	
	  @RequestMapping("/qxsepmny/ech0302/ech0302View.do")
	    public String admech0302View(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String rsStdt,HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
	        LOGGER.debug("/qxsepmny/ech0207/ech0207View.do - 피부자극결과 조회");
	        LOGGER.debug(" = " );  //변경할것
	       
	       PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
	       List<EgovMap> result = ech0302DAO.selectEch0302View(rsStdt);
	       
	        model.addAttribute("rs1000mVO",result);
	        model.addAttribute("rsStdt",rsStdt);
	        
	        model.addAttribute("paginationInfo", paginationInfo);
			
			model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
			model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
			model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
	        return "/adm/ech0302/ech0302View";
	    }
	   
}
