package seps.valueObject;

public class AlarmBoardVO {

	private String placeCode = "";
	private String alarmYn = "";
	private String alarmId = "";
	private String udtDttm = "";
	
	public String getPlaceCode() {
		return placeCode;
	}
	public void setPlaceCode(String placeCode) {
		this.placeCode = placeCode;
	}
	public String getAlarmYn() {
		return alarmYn;
	}
	public void setAlarmYn(String alarmYn) {
		this.alarmYn = alarmYn;
	}
	public String getAlarmId() {
		return alarmId;
	}
	public void setAlarmId(String alarmId) {
		this.alarmId = alarmId;
	}
	public String getUdtDttm() {
		return udtDttm;
	}
	public void setUdtDttm(String udtDttm) {
		this.udtDttm = udtDttm;
	}
	
	@Override
	public String toString() {
		return "AlarmBoard [placeCode=" + placeCode + ", alarmYn=" + alarmYn
				+ ", alarmId=" + alarmId + ", udtDttm=" + udtDttm + "]";
	}
}
