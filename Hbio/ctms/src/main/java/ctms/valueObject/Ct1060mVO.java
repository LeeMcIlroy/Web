package ctms.valueObject;

 /**
 * @author 개발2
 * 인증코드관리(아이디/비밀번호찾기 SMS인증코드)
 * Ct1060mVO 2021.01.19
 *
 */
public class Ct1060mVO { 
	
	private String auth1		= "";
	private String auth2			= "";
	private String auth3		= "";
	private String authCd		= "";
	private String delYn		= "";
	private String dataRegdt	= "";
	private String dataRegnt	= "";
	public String getAuth1() {
		return auth1;
	}
	public void setAuth1(String auth1) {
		this.auth1 = auth1;
	}
	public String getAuth2() {
		return auth2;
	}
	public void setAuth2(String auth2) {
		this.auth2 = auth2;
	}
	public String getAuth3() {
		return auth3;
	}
	public void setAuth3(String auth3) {
		this.auth3 = auth3;
	}
	public String getAuthCd() {
		return authCd;
	}
	public void setAuthCd(String authCd) {
		this.authCd = authCd;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getDataRegdt() {
		return dataRegdt;
	}
	public void setDataRegdt(String dataRegdt) {
		this.dataRegdt = dataRegdt;
	}
	public String getDataRegnt() {
		return dataRegnt;
	}
	public void setDataRegnt(String dataRegnt) {
		this.dataRegnt = dataRegnt;
	}

	@Override
	public String toString() {
		return "Ct1060mVO [auth1=" + auth1 + ", auth2=" + auth2 + ", auth3=" + auth3 + ", authCd=" + authCd + ", delYn="
				+ delYn + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}
	
	
	
}
