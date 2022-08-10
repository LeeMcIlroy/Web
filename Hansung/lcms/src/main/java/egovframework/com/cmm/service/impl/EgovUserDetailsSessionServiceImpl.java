package egovframework.com.cmm.service.impl;

import egovframework.com.cmm.service.EgovUserDetailsService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * 
 * @author 공통서비스 개발팀 서준식
 * @since 2011. 6. 25.
 * @version 1.0
 * @see
 *
 * <pre>
 * 개정이력(Modification Information) 
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011. 8. 12.    서준식        최초생성
 *  
 *  </pre>
 */

public class EgovUserDetailsSessionServiceImpl extends EgovAbstractServiceImpl implements EgovUserDetailsService {

	public Object getAuthenticatedAdmin() {
		return getSession("adminSessionLcms");
	}
	public Object getAuthenticatedUser() {
		return getSession("usrSession");
	}

	// 인증된 유저인지 확인한다.
	@Override
	public Boolean isAuthenticatedAdmin() {
		if( getSession("adminSessionLcms") == null ){
			return false;
		}
		return true;
	}
	@Override
	public Boolean isAuthenticatedUser() {
		if( getSession("usrSession") == null ){
			return false;
		}
		return true;
	}
	
	private Object getSession(String sessionName){
		if( RequestContextHolder.getRequestAttributes() == null ){
			return null;
		}
		return RequestContextHolder.getRequestAttributes().getAttribute(sessionName, RequestAttributes.SCOPE_SESSION);
	}

}
