package seps.valueObject.api;

public class TideTphVO {

	private String obscode = "";
	private String baseDate = "";
	private String baseTime = "";
	private String hlCode = "";
	private String tphLevel = "";
	private String regDttm = "";
	
	public String getObscode() {
		return obscode;
	}
	public void setObscode(String obscode) {
		this.obscode = obscode;
	}
	public String getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}
	public String getBaseTime() {
		return baseTime;
	}
	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
	}
	public String getHlCode() {
		return hlCode;
	}
	public void setHlCode(String hlCode) {
		this.hlCode = hlCode;
	}
	public String getTphLevel() {
		return tphLevel;
	}
	public void setTphLevel(String tphLevel) {
		this.tphLevel = tphLevel;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	@Override
	public String toString() {
		return "TideTphVO [obscode=" + obscode + ", baseDate=" + baseDate
				+ ", baseTime=" + baseTime + ", hlCode=" + hlCode
				+ ", tphLevel=" + tphLevel + ", regDttm=" + regDttm + "]";
	}
}
