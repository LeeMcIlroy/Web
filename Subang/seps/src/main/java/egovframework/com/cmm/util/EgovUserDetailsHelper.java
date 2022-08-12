package egovframework.com.cmm.util;

import java.util.List;

import seps.valueObject.AuthVO;
import seps.valueObject.UserInfoVO;
import egovframework.com.cmm.service.EgovUserDetailsService;

/**
 * EgovUserDetails Helper 클래스
 *
 * @author sjyoon
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  sjyoon          최초 생성
 *   2011.07.01	 서준식          interface 생성후 상세 로직의 분리
 *   2015.09.01  janghh          getAuthenticatedMngrId, getAuthenticatedMngrNm 메소드 추가
 * </pre>
 */

public class EgovUserDetailsHelper {

	static EgovUserDetailsService egovUserDetailsService;

	public EgovUserDetailsService getEgovUserDetailsService() {
		return egovUserDetailsService;
	}

	public void setEgovUserDetailsService(EgovUserDetailsService egovUserDetailsService) {
		EgovUserDetailsHelper.egovUserDetailsService = egovUserDetailsService;
	}

	//관리자 VO
	public static Object getAuthenticatedAdmin() {
		return egovUserDetailsService.getAuthenticatedAdmin();
	}
	//관리자 로그인여부
	public static Boolean isAuthenticatedAdmin() {
		return egovUserDetailsService.isAuthenticatedAdmin();
	}

	//사용자 권한목록
	public static List<AuthVO> getAuthenticatedAthrList() {
		Object object = getAuthenticatedUser();
		if(object==null){
			return null;
		}
		UserInfoVO userInfoVO = (UserInfoVO) object;
		return userInfoVO.getMenuList();
	}
	
	//사용자VO
	public static Object getAuthenticatedUser() {
		return egovUserDetailsService.getAuthenticatedUser();
	}
	//사용자 로그인여부
	public static Boolean isAuthenticatedUser() {
		return egovUserDetailsService.isAuthenticatedUser();
	}
	
	//사용자:아이디
	public static String getAuthenticatedReportNo() {
		Object object = getAuthenticatedUser();
		if(object==null){
			return "";
		}
		UserInfoVO userInfoVO = (UserInfoVO) object;
		return userInfoVO.getUserInfoId();
	}
	//사용자:이름
	public static String getAuthenticatedUserNm() {
		Object object = getAuthenticatedUser();
		if(object==null){
			return "";
		}
		UserInfoVO userInfoVO = (UserInfoVO) object;
		return userInfoVO.getUserNm();
	}
	
}
