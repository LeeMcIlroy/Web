package egovframework.com.cmm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthenticInterceptorAdmCooki extends HandlerInterceptorAdapter {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticInterceptorAdmCooki.class);
		
	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String requestURI = request.getRequestURI();
		
		LOGGER.debug("요청URL = " + requestURI);
/*		
		// sso 로그인 여부 확인
		boolean flag = false;
		SSO sso = new SSO();
		Cookie[] aCookies = request.getCookies();
		if (aCookies != null) {
			for (int i = 0;i < aCookies.length;i++) {
				if(aCookies[i].getName().equals("ssotoken")){
					if(aCookies[i].getValue() != "") {
						int nResult = sso.verifyToken(aCookies[i].getValue());
						if(nResult >= 0){
							flag = true;
							if(sso.getValueUserID()==null || sso.getValueUserID().equals("")){
								LOGGER.debug("로그인 쿠키가 없습니다.");
							}else{
								if( !EgovUserDetailsHelper.isAuthenticatedAdmin() ){
									LOGGER.debug("로그인 쿠키가 존재합니다.");
									throw new ModelAndViewDefiningException( new ModelAndView("redirect:/qxerpynm/lgn/admLogin.do") );
								}
							}
						}
					}
				}
			}
		}

		// 세션 존재시 삭제
		if(!flag){
			if( EgovUserDetailsHelper.isAuthenticatedAdmin() ){
				request.getSession().removeAttribute("adminSessionctms");
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
		}
*/		
/*		
		// (1)
		if( EgovUserDetailsHelper.isAuthenticatedUser() ){
			return true;
		}
	
		// (2)
		Cookie[] cookies = request.getCookies();
		if( cookies == null ) return true; 

		// (3)
		String cookieId = ""; //쿠키값 가져옴
		String cookiePw = ""; //쿠키값 가져옴
		for (int i = 0; i < cookies.length; i++) {
			if( cookies[i].getName().equals("cookieId")){
				cookieId = cookies[i].getValue();
			}else if( cookies[i].getName().equals("cookiePw")){
				cookiePw = cookies[i].getValue();
			}
		}
		
		if( EgovStringUtil.isEmpty(cookieId) || EgovStringUtil.isEmpty(cookiePw) ){
			return true;
		}
			
		// (4)
		UsrMemberVO usrMemberVO = DAO.actionUserLogin(cookieId, cookiePw);
		if( usrMemberVO==null ){
			//로그인 실패시 쿠키값 제거
			for (int i = 0; i < cookies.length; i++) {
				cookies[i].setMaxAge(0);
				cookies[i].setPath("/");
				response.addCookie(cookies[i]);
			}
			return true;
		}
		//로그인 성공시 세션 저장
		request.getSession().setAttribute("usrSession", usrMemberVO);
*/
		return true;
	}

}