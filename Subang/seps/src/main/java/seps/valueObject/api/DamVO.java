package seps.valueObject.api;

public class DamVO {

	private String dmobscd = "";
	private String baseDate = "";
	private String baseTime = "";
	private String swl = "";
	private String inf = "";
	private String sfw = "";
	private String ecpc = "";
	private String tototf = "";
	private String regDttm = "";
	
	public String getDmobscd() {
		return dmobscd;
	}
	public void setDmobscd(String dmobscd) {
		this.dmobscd = dmobscd;
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
	public String getSwl() {
		return swl;
	}
	public void setSwl(String swl) {
		this.swl = swl;
	}
	public String getInf() {
		return inf;
	}
	public void setInf(String inf) {
		this.inf = inf;
	}
	public String getSfw() {
		return sfw;
	}
	public void setSfw(String sfw) {
		this.sfw = sfw;
	}
	public String getEcpc() {
		return ecpc;
	}
	public void setEcpc(String ecpc) {
		this.ecpc = ecpc;
	}
	public String getTototf() {
		return tototf;
	}
	public void setTototf(String tototf) {
		this.tototf = tototf;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	@Override
	public String toString() {
		return "DamVO [dmobscd=" + dmobscd + ", baseDate=" + baseDate
				+ ", baseTime=" + baseTime + ", swl=" + swl + ", inf=" + inf
				+ ", sfw=" + sfw + ", ecpc=" + ecpc + ", tototf=" + tototf
				+ ", regDttm=" + regDttm + "]";
	}
}
