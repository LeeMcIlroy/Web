package egovframework.com.cmm.interceptor;

import java.util.List;
import java.util.regex.Pattern;
 
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import WiseAccess.SSO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import writer.valueObject.MenuAthrVO;

/**
 * 인증여부 체크 인터셉터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *  </pre>
 */


public class AuthenticInterceptorAdm extends HandlerInterceptorAdapter {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticInterceptorAdm.class);
	
	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String requestURI = request.getRequestURI(); // 요청 URI
		
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
									throw new ModelAndViewDefiningException( new ModelAndView("redirect:/xabdmxgr/lgn/admLogin.do") );
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
		}
*/
		//로그인여부 검사
		if( !EgovUserDetailsHelper.isAuthenticatedAdmin() ){
			LOGGER.info("관리자 세션이 없는 사용자의 관리자 페이지 접근입니다. \n 접근페이지 : " + requestURI + "\n 로그인 페이지로 이동합니다.");
			throw new ModelAndViewDefiningException( new ModelAndView("redirect:/xabdmxgr/lgn/admLoginView.do") );
		}
		
		// 권한여부 검사
		boolean isPermit = false;
		List<MenuAthrVO> athrList = EgovUserDetailsHelper.getAuthenticatedAthrList();
		if(athrList != null && athrList.size() > 0){
			for(MenuAthrVO vo : athrList){
				LOGGER.debug("vo.getAthrUrl = "+vo.getAthrUrl());
				Pattern p = Pattern.compile(vo.getAthrUrl());
				if( p.matcher(requestURI).matches() ){
					isPermit = true;
				}
			}
		}
		
		if(!isPermit){
			LOGGER.info("메뉴권한이 없는 사용자가 페이지를 접근하였습니다.\n 접근페이지 : " + requestURI + "\n 상담 페이지로 이동합니다.");
			throw new ModelAndViewDefiningException( new ModelAndView("redirect:/xabdmxgr/cnslt/list/admCnsltList.do") );
		}
		
		return true;
	}

}