package egovframework.com.cmm.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.fdl.property.EgovPropertyService;

public class AuthenticInterceptorUsr extends HandlerInterceptorAdapter {

	private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticInterceptorUsr.class);
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;

	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String requestURI = request.getRequestURI(); // 요청 URI
		
		LOGGER.debug("요청URL = " + requestURI);

		if( !EgovUserDetailsHelper.isAuthenticatedUser() ){
			LOGGER.info("사용자 세션이 없는 사용자의 페이지 접근입니다. \n 접근페이지 : " + requestURI + "\n 로그인 페이지로 이동합니다."); 
		//	throw new ModelAndViewDefiningException( new ModelAndView("redirect:http://hansung.ac.kr/hansung/link_login.jsp?p_p_id=58&_58_redirect=http://writingcenter.hansung.ac.kr/") );
			throw new ModelAndViewDefiningException( new ModelAndView("redirect:https://hansung.ac.kr/hnuLogin/hansung/loginView.do?returnUrl=http://writingcenter.hansung.ac.kr/usr/lgn/login.do") );
			
		}
		
		return true;
	}

}