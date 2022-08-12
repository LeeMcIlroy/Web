package seps.valueObject.api;

public class WeatherTemperatureVO {

	private String baseDate = "";
	private String taMin3 = "";
	private String taMax3 = "";
	private String taMin4 = "";
	private String taMax4 = "";
	private String taMin5 = "";
	private String taMax5 = "";
	private String taMin6 = "";
	private String taMax6 = "";
	private String taMin7 = "";
	private String taMax7 = "";
	public String getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}
	public String getTaMin3() {
		return taMin3;
	}
	public void setTaMin3(String taMin3) {
		this.taMin3 = taMin3;
	}
	public String getTaMax3() {
		return taMax3;
	}
	public void setTaMax3(String taMax3) {
		this.taMax3 = taMax3;
	}
	public String getTaMin4() {
		return taMin4;
	}
	public void setTaMin4(String taMin4) {
		this.taMin4 = taMin4;
	}
	public String getTaMax4() {
		return taMax4;
	}
	public void setTaMax4(String taMax4) {
		this.taMax4 = taMax4;
	}
	public String getTaMin5() {
		return taMin5;
	}
	public void setTaMin5(String taMin5) {
		this.taMin5 = taMin5;
	}
	public String getTaMax5() {
		return taMax5;
	}
	public void setTaMax5(String taMax5) {
		this.taMax5 = taMax5;
	}
	public String getTaMin6() {
		return taMin6;
	}
	public void setTaMin6(String taMin6) {
		this.taMin6 = taMin6;
	}
	public String getTaMax6() {
		return taMax6;
	}
	public void setTaMax6(String taMax6) {
		this.taMax6 = taMax6;
	}
	public String getTaMin7() {
		return taMin7;
	}
	public void setTaMin7(String taMin7) {
		this.taMin7 = taMin7;
	}
	public String getTaMax7() {
		return taMax7;
	}
	public void setTaMax7(String taMax7) {
		this.taMax7 = taMax7;
	}
	@Override
	public String toString() {
		return "WeatherTemperature [baseDate=" + baseDate + ", taMin3="
				+ taMin3 + ", taMax3=" + taMax3 + ", taMin4=" + taMin4
				+ ", taMax4=" + taMax4 + ", taMin5=" + taMin5 + ", taMax5="
				+ taMax5 + ", taMin6=" + taMin6 + ", taMax6=" + taMax6
				+ ", taMin7=" + taMin7 + ", taMax7=" + taMax7 + "]";
	}
}
