package seps.valueObject.api;

public class WeatherLifeVO {
	
	//요청파라미터
	String areaCode = "";
	//VO
	String code = "";
	String baseDate = "";
	String value = "";
	
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	@Override
	public String toString() {
		return "WeatherLifeAItemVO [areaCode=" + areaCode + ", code=" + code
				+ ", baseDate=" + baseDate + ", value=" + value + "]";
	}
}
