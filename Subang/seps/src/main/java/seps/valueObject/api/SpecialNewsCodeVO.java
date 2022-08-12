package seps.valueObject.api;

public class SpecialNewsCodeVO {
	private String stnId = "";
	private String tmFc = "";
	private String tmSeq = "";
	private String areaCode = "";
	private String areaName = "";
	private String warnVar = "";
	private String warnStress = "";
	private String command = "";
	private String startTime = "";
	private String endTime = "";
	private String allEndTime = "";
	private String cancel = "";
	
	private String regDttm = "";
	public String getRegDttm() { return regDttm; }
	public void setRegDttm(String regDttm) { this.regDttm = regDttm; }
	
	public String getStnId() {
		return stnId;
	}
	public void setStnId(String stnId) {
		this.stnId = stnId;
	}
	public String getTmFc() {
		return tmFc;
	}
	public void setTmFc(String tmFc) {
		this.tmFc = tmFc;
	}
	public String getTmSeq() {
		return tmSeq;
	}
	public void setTmSeq(String tmSeq) {
		this.tmSeq = tmSeq;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getWarnVar() {
		return warnVar;
	}
	public void setWarnVar(String warnVar) {
		this.warnVar = warnVar;
	}
	public String getWarnStress() {
		return warnStress;
	}
	public void setWarnStress(String warnStress) {
		this.warnStress = warnStress;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getAllEndTime() {
		return allEndTime;
	}
	public void setAllEndTime(String allEndTime) {
		this.allEndTime = allEndTime;
	}
	public String getCancel() {
		return cancel;
	}
	public void setCancel(String cancel) {
		this.cancel = cancel;
	}
	@Override
	public String toString() {
		return "SpecialNewsCodeVO [\nstnId=" + stnId + "\ntmFc=" + tmFc + "\ntmSeq=" + tmSeq + "\nareaCode=" + areaCode
				+ "\nareaName=" + areaName + "\nwarnVar=" + warnVar + "\nwarnStress=" + warnStress + "\ncommand="
				+ command + "\nstartTime=" + startTime + "\nendTime=" + endTime + "\nallEndTime=" + allEndTime
				+ "\ncancel=" + cancel + "\n]";
	}
}
