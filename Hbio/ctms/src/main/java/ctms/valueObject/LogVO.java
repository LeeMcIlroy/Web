package ctms.valueObject;


 /**
 * @author Leegh
 * 
 * 로그VO 2020.02.27
 *
 */
public class LogVO { 
	
	private String logSeq		= "";
	private String regId		= "";
	private String memberCode	= "";
	private String name			= "";
	private String eName		= "";
	private String logCont		= "";
	private String acceIp		= "";
	private String regDate		= "";
	
	public LogVO(){};
	public LogVO(String regId, String memberCode, String logCont, String acceIp){
		this.regId = regId;
		this.memberCode = memberCode;
		this.logCont = logCont;
		this.acceIp = acceIp;
	}
	
	public String getLogSeq() {
		return logSeq;
	}
	public void setLogSeq(String logSeq) {
		this.logSeq = logSeq;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getMemberCode() {
		return memberCode;
	}
	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String geteName() {
		return eName;
	}
	public void seteName(String eName) {
		this.eName = eName;
	}
	public String getLogCont() {
		return logCont;
	}
	public void setLogCont(String logCont) {
		this.logCont = logCont;
	}
	public String getAcceIp() {
		return acceIp;
	}
	public void setAcceIp(String acceIp) {
		this.acceIp = acceIp;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	@Override
	public String toString() {
		return "LogVO [logSeq=" + logSeq + ", regId=" + regId + ", memberCode=" + memberCode + ", name=" + name
				+ ", eName=" + eName + ", logCont=" + logCont + ", acceIp=" + acceIp + ", regDate=" + regDate + "]";
	}
	
}
