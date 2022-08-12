package ctms.adm.ech1005;

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
import ctms.valueObject.Rm2000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech1005Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech1005Controller.class);
	@Autowired private Ech1005DAO ech1005DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
			
	
	//로그인화면으로 리다이렉트합니다.
	//private String redirectLoginView(RedirectAttributes reda, String message){
	//	reda.addFlashAttribute("message", message);
	//	return "redirect:/qxsepmny/lgn/admLoginView.do";
	//}
		
	// 구성원 찾기
	@RequestMapping("/qxsepmny/ech1005/ech1005AjaxSearchStaff.do")
	public View ech1005AjaxSearchStaff(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech1005/ech1005AjaxSearchStaff.do - 구성원찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		List<EgovMap> resultList = ech1005DAO.selectEch1005StaffList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 고객사 찾기
	@RequestMapping("/qxsepmny/ech1005/ech1005AjaxSearchVendor.do")
	public View ech1005AjaxSearchVendor(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech1005/ech1005AjaxSearchVendor.do - 고객사찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		List<EgovMap> resultList = ech1005DAO.selectEch1005VendorList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}

	// 견적 찾기
	@RequestMapping("/qxsepmny/ech1005/ech1005AjaxSearchOp.do")
	public View ech1005AjaxSearchOp(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech1005/ech1005AjaxSearchOp.do - 견적찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		List<EgovMap> resultList = ech1005DAO.selectEch1005OpList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 계약 찾기
	@RequestMapping("/qxsepmny/ech1005/ech1005AjaxSearchCtrt.do")
	public View ech1005AjaxSearchCtrt(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech1005/ech1005AjaxSearchCtrt.do - 계약찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		List<EgovMap> resultList = ech1005DAO.selectEch1005CtrtList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 연구코드 찾기
	@RequestMapping("/qxsepmny/ech1005/ech1005AjaxSearchRs.do")
	public View ech1005AjaxSearchRs(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech1005/ech1005AjaxSearchRs.do - 연구코드찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		List<EgovMap> resultList = ech1005DAO.selectEch1005RsList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	
}
