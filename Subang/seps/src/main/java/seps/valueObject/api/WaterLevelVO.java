package seps.valueObject.api;

public class WaterLevelVO {

	private String wlobscd = "";
	private String baseDate = "";
	private String baseTime = "";
	private String wl = "";
	private String fw = "";
	private String regDttm = "";
	
	public String getWlobscd() {
		return wlobscd;
	}
	public void setWlobscd(String wlobscd) {
		this.wlobscd = wlobscd;
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
	public String getWl() {
		return wl;
	}
	public void setWl(String wl) {
		this.wl = wl;
	}
	public String getFw() {
		return fw;
	}
	public void setFw(String fw) {
		this.fw = fw;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	@Override
	public String toString() {
		return "WaterLevel [wlobscd=" + wlobscd + ", baseDate=" + baseDate
				+ ", baseTime=" + baseTime + ", wl=" + wl + ", fw=" + fw
				+ ", regDttm=" + regDttm + "]";
	}
}
