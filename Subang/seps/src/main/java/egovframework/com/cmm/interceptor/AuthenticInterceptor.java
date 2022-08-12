package egovframework.com.cmm.interceptor;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import seps.cmmn.SepsCommonCode;
import seps.valueObject.AuthVO;
import seps.valueObject.UserInfoVO;

public class AuthenticInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AuthenticInterceptor.class);

	private static final String USR_REGEXP = "/usr/.*\\.do\\Z";
	private static final String ADM_REGEXP = "/adm/.*\\.do\\Z";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String requestURI = request.getRequestURI(); // 요청 URI
		
		LOGGER.debug("요청URL = " + requestURI);
		//로그인여부 검사
		if( !EgovUserDetailsHelper.isAuthenticatedUser() ){
			LOGGER.info("세션이 없는 사용자의 관리자 페이지 접근입니다. \n 접근페이지 : " + requestURI + "\n 로그인 페이지로 이동합니다.");
			throw new ModelAndViewDefiningException( new ModelAndView("redirect:/loginView.do") );
		}
		
		boolean isPermit = true;
		
		//권한URL 검사
		Pattern p = Pattern.compile(USR_REGEXP); //사용자검사
		if( p.matcher(requestURI).matches() ){
			List<AuthVO> menuList = EgovUserDetailsHelper.getAuthenticatedAthrList();
			for (AuthVO menuVO : menuList) {
				Pattern p2 = Pattern.compile(".*\\"+menuVO.getUrl());
				Matcher m2 = p2.matcher(requestURI);
				boolean a2 = m2.matches();
				LOGGER.debug(menuVO.getUrl() + " = " + a2);
				if(a2){
					isPermit = true;
					break;
				}
			}
		}
		
		Pattern p2 = Pattern.compile(ADM_REGEXP); //관리자검사
		if( p2.matcher(requestURI).matches() ){
			UserInfoVO sessionVO = (UserInfoVO) EgovUserDetailsHelper.getAuthenticatedUser();
			if("Y".equals(sessionVO.getAdminYn())){
				return true;
			}
		}
		
		if(!isPermit){
			LOGGER.info("해당 메뉴에 대한 권한이 없는 사용자의 접근입니다. \n 접근페이지 : " + requestURI + "\n 로그인 페이지로 이동합니다.");
			throw new ModelAndViewDefiningException( new ModelAndView("redirect:/loginView.do") );
		}
		
		if(request.getSession().getAttribute("KAKAO_API_KEY") == null){
			request.getSession().setAttribute("KAKAO_API_KEY", SepsCommonCode.KAKAO_API_KEY);
		}
	
		return true;
	}
	
	
}
