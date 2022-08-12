package ctms.usr;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.util.ComStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ctms.adm.cmm.AdmCmmController;
import ctms.valueObject.AdminVO;

@Controller
public class UsrTmpController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(UsrTmpController.class);

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
		//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/lgn/usrLoginView.do";
	}
	
	/**
	 * 관리자 코딩 화면으로 이동합니다.
	 * @param model
	 * @return 코딩 화면
	 * @throws Exception
	 */
	@RequestMapping("/tmp/ecf010101.do")
	public String ecf010101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/ecf010101.do - 사용자 참여일정");
		
		return "/usr/ecf010101";
	}

	@RequestMapping("/tmp/ecf020101.do")
	public String ecf020101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/ecf020101.do - 사용자 사용체크");
		
		return "/usr/ecf020101";
	}
	
	@RequestMapping("/tmp/ecf030101.do")
	public String ecf030101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/ecf030101.do - 사용자 설문참여목록");
		
		return "/usr/ecf030101";
	}
	
	@RequestMapping("/tmp/ecf030102.do")
	public String ecf030102(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/ecf030102.do - 사용자 설문참여입력");
		
		return "/usr/ecf030102";
	}
	
	@RequestMapping("/tmp/ecf040101.do")
	public String ecf040101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/ecf040101.do - 사용자 시험지원");
		
		return "/usr/ecf040101";
	}
	
	@RequestMapping("/tmp/ecf050101.do")
	public String ecf050101(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/ecf050101.do - 사용자 회원정보");
		
		return "/usr/ecf050101";
	}
	
	@RequestMapping("/tmp/login/loginView.do")
	public String loginView(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/login/loginView.do - 사용자 로그인");
		
		return "/usr/login/loginView";
	}
	
	@RequestMapping("/tmp/login/joinMem.do")
	public String joinMem(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/login/joinMem.do - 사용자 회원가입");
		
		return "/usr/login/joinMem";
	}
	
	@RequestMapping("/tmp/login/searchId.do")
	public String searchId(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/login/searchId.do - 사용자 아이디찾기");
		
		return "/usr/login/searchId";
	}
	
	@RequestMapping("/tmp/login/searchPw.do")
	public String searchPw(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/login/searchPw.do - 사용자 비번찾기");
		
		return "/usr/login/searchPw";
	}
	
	@RequestMapping("/tmp/login/resetPw.do")
	public String resetPw(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/tmp/login/resetPw.do - 사용자 비번재설정");
		
		return "/usr/login/resetPw";
	}
}
