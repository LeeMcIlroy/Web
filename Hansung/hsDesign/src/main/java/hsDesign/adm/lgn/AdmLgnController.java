package hsDesign.adm.lgn;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.AdminVO;

@Controller
public class AdmLgnController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmLgnController.class);
	@Autowired private AdmLgnDAO admLgnDAO;

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/lgn/admLoginView.do";
	}

	//로그인사용자의 첫페이지로 리다이렉트합니다.
	private String redirectIndexPage(){
		return "redirect:/qxerpynm/majorBoard/interior/admMajorInteriorList.do";
	
	}
	
	/**
	 * 로그인 화면으로 이동합니다.
	 * 이미 로그인 되어 있는 경우 첫페이지로 이동합니다.
	 * @param model
	 * @return 로그인화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/lgn/admLoginView.do")
	public String admLoginView(HttpServletRequest request) throws Exception {
		if( EgovUserDetailsHelper.isAuthenticatedAdmin() ){
			return redirectIndexPage();
		}
		return "/adm/lgn/admLoginView";
	}
	
	/**
	 * 로그인을 시도합니다.
	 * @param loginVO 아이디, 비밀번호 입력값이 담긴 VO
	 * @return 로그인성공시 첫화면으로, 실패시 로그인화면으로 돌아감
	 */
	@RequestMapping("/qxerpynm/lgn/admLogin.do")
	public String login(AdminVO adminVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/lgn/admLogin.do - 관리자 로그인");
		LOGGER.debug("adminVO = "+adminVO);
		
		// 암호화
		/*
		String encryptPw = EgovFileScrty.encryptPassword(adminVO.getAdmPw(), adminVO.getAdmId());
		adminVO.setAdmPw(encryptPw);
		*/
		
		String encryptPw = EgovFileScrty.encryptPassword(adminVO.getAdmPwd(), adminVO.getAdmId());
		adminVO.setAdmPwd(encryptPw);
		
		AdminVO resultVO = admLgnDAO.selectAdmLgnOne(adminVO);
		String message="";
		/*if(resultVO == null){
			return redirectLoginView(reda, "로그인 정보가 올바르지 않습니다.");
		}
		*/
		request.getSession().setAttribute("adminSession", resultVO);
		
		// 로그등록
		//admLogInsert(null, "로그인", resultVO.getAdmId(), request);
		
		return redirectIndexPage();
	}

	/**
	 * 로그아웃 
	 * session 에 loginVO 를 지웁니다.
	 * @return 로그인화면
	 */
	@RequestMapping("/qxerpynm/lgn/admLogout.do")
	public String logout(HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/lgn/admLogout.do - 관리자 > 로그아웃");

		if(EgovUserDetailsHelper.isAuthenticatedAdmin()){
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSession");
			
			// 로그등록
			admLogInsert(null, "로그아웃", adminVO.getAdmId(), request);
			
			request.getSession().removeAttribute("adminSession");
			
		}
		
		

		return "redirect:/qxerpynm/lgn/admLoginView.do";
	}
}
