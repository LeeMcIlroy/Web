package egovframework.com.cmm.util;

import hsDesign.valueObject.AdminVO;
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
	/*
	// 관리자 권한목록
	public static List<MenuAthrVO> getAuthenticatedAthrList() {
		Object object = getAuthenticatedAdmin();
		if(object==null){
			return null;
		}
		AdminVO adminVO = (AdminVO) object;
		return adminVO.getAthrList();
	}
	*/
	
	//관리자:아이디
	public static String getAuthenticatedAdminId() {
		Object object = getAuthenticatedAdmin();
		if(object==null){
			return "";
		}
		AdminVO adminVO = (AdminVO) object;
		return adminVO.getAdmId();
	}
	/*
	//관리자:이름
	public static String getAuthenticatedMngrNm() {
		Object object = getAuthenticatedAdmin();
		if(object==null){
			return "";
		}
		AdminVO adminVO = (AdminVO) object;
		return adminVO.getMemName();
	}
	 */
	//사용자VO
	public static Object getAuthenticatedUser() {
		return egovUserDetailsService.getAuthenticatedUser();
	}
	//사용자 로그인여부
	public static Boolean isAuthenticatedUser() {
		return egovUserDetailsService.isAuthenticatedUser();
	}
	/*
	//사용자:아이디
	public static String getAuthenticatedReportNo() {
		Object object = getAuthenticatedUser();
		if(object==null){
			return "";
		}
		UsrMemberVO usrMemberVO = (UsrMemberVO) object;
		return usrMemberVO.getReportNo();
	}
	//사용자:이름
	public static String getAuthenticatedUserNm() {
		Object object = getAuthenticatedUser();
		if(object==null){
			return "";
		}
		UsrMemberVO usrMemberVO = (UsrMemberVO) object;
		return usrMemberVO.getReportName();
	}
	*/
}
