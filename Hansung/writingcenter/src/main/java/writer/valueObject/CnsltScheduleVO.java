package writer.valueObject;

/**
 * 상담일정
 *	2017-02-02 최초생성
 *	2017-02-03 수정 (aplyYn 추가)
 */
public class CnsltScheduleVO {
	private String schSeq = "";				// SEQ
	private String schYmd = "";				// 상담일자 (yyyymmdd)
	private String schHm = "";				// 상담시간 (24HH:MI)
	private String schDy = "";				// 상담요일
	private String regId = "";				// 등록자
	private String regName = "";			// 등록자명
	private String regDate = "";			// 등록일
	
	private String schdulStartDate = "";	// 상담일자 시작일
	private String schdulEndDate = "";		// 상담일자 시작일
	public String getSchdulStartDate() { return schdulStartDate; }
	public void setSchdulStartDate(String schdulStartDate) { this.schdulStartDate = schdulStartDate; }
	public String getSchdulEndDate() { return schdulEndDate; }
	public void setSchdulEndDate(String schdulEndDate) { this.schdulEndDate = schdulEndDate; }
	
	private String aplyYn = "";			// 상담일정 상담신청여부 (Y or N)
	public String getAplyYn() { return aplyYn; }
	public void setAplyYn(String aplyYn) { this.aplyYn = aplyYn; }

	/* view */
	private String schHh = "";				// 상담시간_시
	private String schMi = "";				// 상담시간_분
	public String getSchHh() { return schHh; }
	public void setSchHh(String schHh) { this.schHh = schHh; }
	public String getSchMi() { return schMi; }
	public void setSchMi(String schMi) { this.schMi = schMi; }
	
	public String getSchSeq() {
		return schSeq;
	}
	public void setSchSeq(String schSeq) {
		this.schSeq = schSeq;
	}
	public String getSchYmd() {
		return schYmd;
	}
	public void setSchYmd(String schYmd) {
		this.schYmd = schYmd;
	}
	public String getSchHm() {
		return schHm;
	}
	public void setSchHm(String schHm) {
		this.schHm = schHm;
		String[] str = schHm.split(":");
		setSchHh(str[0]);
		setSchMi(str[1]);
	}
	public String getSchDy() {
		return schDy;
	}
	public void setSchDy(String schDy) {
		this.schDy = schDy;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "CnsltScheduleVO [\r\nschSeq=" + schSeq + "\r\n schYmd=" + schYmd + "\r\n schHm=" + schHm + "\r\n schDy=" + schDy
				+ "\r\n regId=" + regId + "\r\n regName=" + regName + "\r\n regDate=" + regDate + "\r\n]";
	}
	
}
