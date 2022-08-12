package egovframework.com.cmm.service;

public interface EgovUserDetailsService {

	/**
	 * 인증된 사용자객체를 VO형식으로 가져온다.
	 * @return Object - 사용자 ValueObject
	 */
	public Object getAuthenticatedAdmin();
	public Object getAuthenticatedUser();
	
	/**
	 * 인증된 사용자 여부를 체크한다.
	 * @return Boolean - 인증된 사용자 여부(TRUE / FALSE)	
	 */
	public Boolean isAuthenticatedAdmin(); 
	public Boolean isAuthenticatedUser();

}
