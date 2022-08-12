package seps.valueObject;

public class SnsVO {

	private String snsId = "";
	private String snsTitle = "";
	private String snsContent = "";
	private String snsType = "";
	private String regNm = "";
	private String regDttm = "";
	
	public String getSnsId() {
		return snsId;
	}
	public void setSnsId(String snsId) {
		this.snsId = snsId;
	}
	public String getSnsTitle() {
		return snsTitle;
	}
	public void setSnsTitle(String snsTitle) {
		this.snsTitle = snsTitle;
	}
	public String getSnsContent() {
		return snsContent;
	}
	public void setSnsContent(String snsContent) {
		this.snsContent = snsContent;
	}
	public String getSnsType() {
		return snsType;
	}
	public void setSnsType(String snsType) {
		this.snsType = snsType;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	
	@Override
	public String toString() {
		return "SnsVO [snsId=" + snsId + ", snsTitle=" + snsTitle
				+ ", snsContent=" + snsContent + ", snsType=" + snsType
				+ ", regNm=" + regNm + ", regDttm=" + regDttm + "]";
	}
	
}
