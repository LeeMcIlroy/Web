package writer.adm.lgn;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import WiseAccess.SSO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.AdminVO;

@Controller
public class AdmLgnController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmLgnController.class);
	
	@Autowired private AdmLgnDAO admLgnDAO;
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/xabdmxgr/lgn/admLoginView.do";
	}

	//로그인사용자의 첫페이지로 리다이렉트합니다.
	private String redirectIndexPage(){
		return "redirect:/xabdmxgr/lec/admLecClassList.do";
	}
	
	// sso 쿠키 id 확인
	private String getAdmLoginCookieId(HttpServletRequest request){
		// 로그인 쿠키 확인
		SSO sso = new SSO();
		Cookie[] aCookies = request.getCookies();
		if (aCookies != null) {
			for (int i = 0;i < aCookies.length;i++) {
				LOGGER.debug("aCookies["+i+"].getName() = "+aCookies[i].getName());
				LOGGER.debug("aCookies["+i+"].getValue() = "+aCookies[i].getValue());
				if(aCookies[i].getName().equals("ssotoken")){
					if(aCookies[i].getValue() != "") {
						int nResult = sso.verifyToken(aCookies[i].getValue());
						if(nResult >= 0){
							if(!EgovStringUtil.isEmpty(sso.getValueUserID())){
								LOGGER.debug("로그인 쿠키가 있습니다.("+sso.getValueUserID()+")");
								return sso.getValueUserID();
							}
						}
					}
				}
			}
		}
		return "";
	}
	
	/**
	 * 로그인 화면으로 이동합니다.
	 * 이미 로그인 되어 있는 경우 첫페이지로 이동합니다.
	 * @param model
	 * @return 로그인화면
	 * @throws Exception
	 */
	@RequestMapping("/xabdmxgr/lgn/admLoginView.do")
	public String admLoginView(HttpServletRequest request) throws Exception {
		if(!EgovStringUtil.isEmpty(getAdmLoginCookieId(request))){
			return "redirect:/xabdmxgr/lgn/admLogin.do";
		}
		if( EgovUserDetailsHelper.isAuthenticatedAdmin()){
			return redirectIndexPage();
		}

		//return "/adm/lgn/admLoginView";
		return "/adm/lgn/admLoginView2";
	}
	
	/**
	 * 로그인을 시도합니다.
	 * @param loginVO 아이디, 비밀번호 입력값이 담긴 VO
	 * @return 로그인성공시 첫화면으로, 실패시 로그인화면으로 돌아감
	 */
/*
	@RequestMapping("/xabdmxgr/lgn/admLogin.do")
	public String login(HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/lgn/admLogin.do - 관리자 로그인");
		
		String ssoId = getAdmLoginCookieId(request);
		
		if(EgovStringUtil.isEmpty(ssoId)){
			return redirectLoginView(reda, "로그인 정보가 올바르지 않습니다.");
		}

		LOGGER.debug("로그인됨"+ssoId);
		
		AdminVO adminVO = new AdminVO();
		
		// sso 정보 불러오기 (WRITER_USER1)
		AdminVO ssoVO = admLgnDAO.actionSsoLogin(ssoId);
		if(ssoVO == null){
			LOGGER.debug("교수, 강사, 연구원이 아닙니다.");
			request.setAttribute("type", "ADM");
			return "/cmm/ssoLogout";
		}
		
		// TB_HSWC_MEMBER 권한 및 기타사항 불러오기(사고와표현 관련)
		AdminVO resultVO = admLgnDAO.actionLogin(ssoId);
		
		if(resultVO == null){
			request.setAttribute("type", "ADM");
			return "/cmm/ssoLogout";
		}
		
		// vo값 셋팅
		adminVO.setMemCode(ssoVO.getProfCode());						// 사번
		adminVO.setMemName(ssoVO.getProfName());						// 이름
		if(resultVO != null){
			adminVO.setMemSeq(resultVO.getMemSeq());					// 회원번호
			adminVO.setMemEmail(resultVO.getMemEmail());				// 이메일
			adminVO.setMemMphone(resultVO.getMemMphone());				// 휴대폰
			adminVO.setMemLevel(resultVO.getMemLevel());				// 회원레벨
			adminVO.setMemUpdtYn(resultVO.getMemUpdtYn());				// 첨삭가능여부
			adminVO.setMemMemo(resultVO.getMemMemo());					// 메모
			adminVO.setRegId(resultVO.getRegId());						// 등록자
			adminVO.setRegDate(resultVO.getRegDate());					// 등록일
			adminVO.setAthrList(resultVO.getAthrList());				// 권한목록
		}
		
		request.getSession().setAttribute("adminSession", adminVO);
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("로그인 - "+ssoId, ip);
		
		return redirectIndexPage();
	}
*/

	// SSO 미연동 로그인
	@RequestMapping("/xabdmxgr/lgn/admLogin.do")
	public String login(String memCode, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/lgn/admLogin.do - 관리자 로그인");
		LOGGER.debug("memCode = "+memCode);
		AdminVO adminVO = admLgnDAO.actionLogin(memCode);
		
		if (adminVO == null) {
			return redirectLoginView(reda, "로그인 정보가 올바르지 않습니다.");
		}
		
		request.getSession().setAttribute("adminSession", adminVO);
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("로그인 - "+memCode, ip);
		
		return redirectIndexPage();
	}

	/**
	 * 로그아웃 
	 * session 에 loginVO 를 지웁니다.
	 * @return 로그인화면
	 */
	@RequestMapping("/xabdmxgr/lgn/admLogout.do")
	public String logout(HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/lgn/admLogout.do - 관리자 > 로그아웃");
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		LOGGER.debug("clientIp = "+ip);

		if(EgovUserDetailsHelper.isAuthenticatedAdmin()){
			admCmmLogDAO.insertLogOne("로그아웃", ip);
			request.getSession().removeAttribute("adminSession");
		}
		Cookie[] cookies = request.getCookies();
		if(cookies != null && cookies.length >0){
			for(int i = 0; i<cookies.length; i++){
				if(cookies[i].getName().equals("ssotoken")){
					Cookie cookie = new Cookie("ssotoken", null);
					cookie.setMaxAge(0); 
					cookie.setDomain( ".hansung.ac.kr");
					cookie.setPath( "/" );
					response.addCookie(cookie);
				}
			}
		}
		return "redirect:/xabdmxgr/lgn/admLoginView.do";
	}
}
