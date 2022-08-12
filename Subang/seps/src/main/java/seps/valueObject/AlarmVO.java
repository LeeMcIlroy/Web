package seps.valueObject;

public class AlarmVO {

	private String alarmId = "";
	private String alarmType = "";
	private String alarmContent = "";
	private String placeCode = "";
	private String baseDate = "";
	private String baseTime = "";
	private String regDttm = "";
	
	public AlarmVO(String type, String stx, String placeCode, String baseDate, String baseTime) {
		this.alarmType = type;
		this.alarmContent = stx;
		this.placeCode = placeCode;
		this.baseDate = baseDate;
		this.baseTime = baseTime;
	}
	
	public String getPlaceCode() {
		return placeCode;
	}
	public void setPlaceCode(String placeCode) {
		this.placeCode = placeCode;
	}
	public String getAlarmId() {
		return alarmId;
	}
	public void setAlarmId(String alarmId) {
		this.alarmId = alarmId;
	}
	public String getAlarmType() {
		return alarmType;
	}
	public void setAlarmType(String alarmType) {
		this.alarmType = alarmType;
	}
	public String getAlarmContent() {
		return alarmContent;
	}
	public void setAlarmContent(String alarmContent) {
		this.alarmContent = alarmContent;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
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

	@Override
	public String toString() {
		return "AlarmVO [alarmId=" + alarmId + ", alarmType=" + alarmType
				+ ", alarmContent=" + alarmContent + ", placeCode=" + placeCode
				+ ", baseDate=" + baseDate + ", baseTime=" + baseTime
				+ ", regDttm=" + regDttm + "]";
	}

}
