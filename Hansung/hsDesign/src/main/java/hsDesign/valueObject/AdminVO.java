package hsDesign.valueObject;


 /**
 * @author kjhoon
 * 
 * 관리자VO 2017.06.22
 *
 */
public class AdminVO { 
	
	private String admSeq  	= ""; 						// 관리자SEQ
	private String admName 	= "";						// 관리자이름
	private String admId   	= "";						// 관리자아이디
	private String admTel  	= "";						// 관리자연락처
	private String admEmail	= "";						// 관리자이메일
	private String admUseYn = "";						// 관리자사용여부
	private String admPwd = "";							// 관리자PW
	
	public String getAdmPwd() {
		return admPwd;
	}
	public void setAdmPwd(String admPwd) {
		this.admPwd = admPwd;
	}
	public String getAdmSeq() {
		return admSeq;
	}
	public void setAdmSeq(String admSeq) {
		this.admSeq = admSeq;
	}
	public String getAdmName() {
		return admName;
	}
	public void setAdmName(String admName) {
		this.admName = admName;
	}
	public String getAdmId() {
		return admId;
	}
	public void setAdmId(String admId) {
		this.admId = admId;
	}
	public String getAdmTel() {
		return admTel;
	}
	public void setAdmTel(String admTel) {
		this.admTel = admTel;
	}
	public String getAdmEmail() {
		return admEmail;
	}
	public void setAdmEmail(String admEmail) {
		this.admEmail = admEmail;
	}
	public String getAdmUseYn() {
		return admUseYn;
	}
	public void setAdmUseYn(String admUseYn) {
		this.admUseYn = admUseYn;
	}
	@Override
	public String toString() {
		return "AdminVO [admSeq=" + admSeq + "\r\n admName=" + admName
				+ "\r\n admId=" + admId + "\r\n admTel=" + admTel + "\r\n admEmail="
				+ admEmail + "\r\n admUseYn=" + admUseYn + "\r\n admPwd=" + admPwd
				+ "]";
	}
	
	
	
}
