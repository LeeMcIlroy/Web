package seps.valueObject.api;

public class DustVO {
	private String applcDt = "";
	private String pollutant = "";
	private String faOn = "";
	private String msrrgn = "";
	private String caistep = "";
	private String alarmCndt = "";
	private String alertstep = "";
	private String cndt1 = "";
	private String rgstDt = "";
	
	public String getApplcDt() {
		return applcDt;
	}
	public void setApplcDt(String applcDt) {
		this.applcDt = applcDt;
	}
	public String getPollutant() {
		return pollutant;
	}
	public void setPollutant(String pollutant) {
		this.pollutant = pollutant;
	}
	public String getFaOn() {
		return faOn;
	}
	public void setFaOn(String faOn) {
		this.faOn = faOn;
	}
	public String getMsrrgn() {
		return msrrgn;
	}
	public void setMsrrgn(String msrrgn) {
		this.msrrgn = msrrgn;
	}
	public String getCaistep() {
		return caistep;
	}
	public void setCaistep(String caistep) {
		this.caistep = caistep;
	}
	public String getAlertstep() {
		return alertstep;
	}
	public void setAlertstep(String alertstep) {
		this.alertstep = alertstep;
	}
	public String getAlarmCndt() {
		return alarmCndt;
	}
	public void setAlarmCndt(String alarmCndt) {
		this.alarmCndt = alarmCndt;
	}
	public String getCndt1() {
		return cndt1;
	}
	public void setCndt1(String cndt1) {
		this.cndt1 = cndt1;
	}
	public String getRgstDt() {
		return rgstDt;
	}
	public void setRgstDt(String rgstDt) {
		this.rgstDt = rgstDt;
	}
	
	@Override
	public String toString() {
		return "DustVO [applcDt=" + applcDt + ", pollutant=" + pollutant
				+ ", faOn=" + faOn + ", msrrgn=" + msrrgn + ", caistep="
				+ caistep + ", alarmCndt=" + alarmCndt + ", alertstep="
				+ alertstep + ", cndt1=" + cndt1 + ", rgstDt=" + rgstDt + "]";
	}
}
