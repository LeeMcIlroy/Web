package ctms.valueObject;


 /**
 * @author Leegh
 * 
 * 관리자VO 2019.06.20
 *
 */
public class UserInfoVO { 
	
	private String userInfoSeq 	= ""; 						// 사용자_고유번호
	private String userId 		= "";						// 사용자_아이디
	private String userPw   	= "";						// 사용자_비밀번호
	private String name  		= "";						// 이름
	private String tel			= "";						// 연락처
	private String email		= "";						// 이메일
	private String useYn 		= "";						// 사용여부
	private String regDttm		= "";						// 등록일시
	
	public String getUserInfoSeq() {
		return userInfoSeq;
	}
	public void setUserInfoSeq(String userInfoSeq) {
		this.userInfoSeq = userInfoSeq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	
	@Override
	public String toString() {
		return "UserInfoVO [\nuserInfoSeq=" + userInfoSeq + "\nuserId=" + userId + "\nuserPw=" + userPw + "\nname="
				+ name + "\ntel=" + tel + "\nemail=" + email + "\nuseYn=" + useYn + "\nregDttm=" + regDttm + "\n]";
	}
}
