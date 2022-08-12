package seps.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class HotLineVO {

	private String hotLineId = "";
	private String hotLineDept = "";
	private String hotLineName = "";
	private String hotLineTel = "";
	private String hotLineEmail = "";
	private String useYn = "";
	private String regDttm = "";
	private String regNm = "";
	private String udtDttm = "";
	private String udtNm = "";
	
	private String hotLineTel1 = "";
	private String hotLineTel2 = "";
	private String hotLineTel3 = "";
	public String getHotLineTel1() { return hotLineTel1; }
	public void setHotLineTel1(String hotLineTel1) { this.hotLineTel1 = hotLineTel1; }
	public String getHotLineTel2() { return hotLineTel2; }
	public void setHotLineTel2(String hotLineTel2) { this.hotLineTel2 = hotLineTel2; }
	public String getHotLineTel3() { return hotLineTel3; }
	public void setHotLineTel3(String hotLineTel3) { this.hotLineTel3 = hotLineTel3; }
	
	private String hotLineEmail1 = "";
	private String hotLineEmail2 = "";
	public String getHotLineEmail1() { return hotLineEmail1; }
	public void setHotLineEmail1(String hotLineEmail1) { this.hotLineEmail1 = hotLineEmail1; }
	public String getHotLineEmail2() { return hotLineEmail2; }
	public void setHotLineEmail2(String hotLineEmail2) { this.hotLineEmail2 = hotLineEmail2; }
	
	
	public String getHotLineId() {
		return hotLineId;
	}
	public void setHotLineId(String hotLineId) {
		this.hotLineId = hotLineId;
	}
	public String getHotLineDept() {
		return hotLineDept;
	}
	public void setHotLineDept(String hotLineDept) {
		this.hotLineDept = hotLineDept;
	}
	public String getHotLineName() {
		return hotLineName;
	}
	public void setHotLineName(String hotLineName) {
		this.hotLineName = hotLineName;
	}
	public String getHotLineTel() {
		return hotLineTel;
	}
	public void setHotLineTel(String hotLineTel) {
		this.hotLineTel = hotLineTel;
		if(!EgovStringUtil.isEmpty(hotLineTel)){
			setHotLineTel1(hotLineTel.split("-")[0]);
			setHotLineTel2(hotLineTel.split("-")[1]);
			setHotLineTel3(hotLineTel.split("-")[2]);
		}
	}
	public String getHotLineEmail() {
		return hotLineEmail;
	}
	public void setHotLineEmail(String hotLineEmail) {
		this.hotLineEmail = hotLineEmail;
		if(!EgovStringUtil.isEmpty(hotLineEmail)){
			setHotLineEmail1(hotLineEmail.split("@")[0]);
			setHotLineEmail2(hotLineEmail.split("@")[1]);
		}
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getUdtDttm() {
		return udtDttm;
	}
	public void setUdtDttm(String udtDttm) {
		this.udtDttm = udtDttm;
	}
	public String getUdtNm() {
		return udtNm;
	}
	public void setUdtNm(String udtNm) {
		this.udtNm = udtNm;
	}
	@Override
	public String toString() {
		return "HotLineVO [hotLineId=" + hotLineId + ", hotLineDept="
				+ hotLineDept + ", hotLineName=" + hotLineName
				+ ", hotLineTel=" + hotLineTel + ", hotLineEmail="
				+ hotLineEmail + ", useYn=" + useYn + ", regDttm=" + regDttm
				+ ", regNm=" + regNm + ", udtDttm=" + udtDttm + ", udtNm="
				+ udtNm + "]";
	}
}
