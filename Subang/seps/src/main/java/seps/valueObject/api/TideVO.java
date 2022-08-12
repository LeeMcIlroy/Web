package seps.valueObject.api;

public class TideVO {

	private String obscode = "";
	private String baseDate = "";
	private String baseTime = "";
	private String realValue = "";
	private String prvValue= "";
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
	public String getRealValue() {
		return realValue;
	}
	public void setRealValue(String realValue) {
		this.realValue = realValue;
	}
	public String getPrvValue() {
		return prvValue;
	}
	public void setPrvValue(String prvValue) {
		this.prvValue = prvValue;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	@Override
	public String toString() {
		return "TideVO [obscode=" + obscode + ", baseDate=" + baseDate
				+ ", baseTime=" + baseTime + ", realValue=" + realValue
				+ ", prvValue=" + prvValue + ", regDttm=" + regDttm + "]";
	}
}
