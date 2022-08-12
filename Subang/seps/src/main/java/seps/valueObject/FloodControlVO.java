package seps.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class FloodControlVO {
	
	private String floodControlId = "";
	private String floodLevel = "";
	private String issueDate = "";
	private String issueTime = "";
	private String hitCnt = "";
	private String regDttm = "";
	private String regNm = "";
	private String udtDttm = "";
	private String udtNm = "";
	
	private String issueTime1 = "";
	private String issueTime2 = "";
	public String getIssueTime1() { return issueTime1; }
	public void setIssueTime1(String issueTime1) { this.issueTime1 = issueTime1; }
	public String getIssueTime2() { return issueTime2; }
	public void setIssueTime2(String issueTime2) { this.issueTime2 = issueTime2; }
	
	private String situationType = "";
	
	public String getSituationType() {
		return situationType;
	}
	public void setSituationType(String situationType) {
		this.situationType = situationType;
	}
	public String getHitCnt() {
		return hitCnt;
	}
	public void setHitCnt(String hitCnt) {
		this.hitCnt = hitCnt;
	}
	public String getFloodControlId() {
		return floodControlId;
	}
	public void setFloodControlId(String floodControlId) {
		this.floodControlId = floodControlId;
	}
	public String getFloodLevel() {
		return floodLevel;
	}
	public void setFloodLevel(String floodLevel) {
		this.floodLevel = floodLevel;
	}
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getIssueTime() {
		return issueTime;
	}
	public void setIssueTime(String issueTime) {
		this.issueTime = issueTime;
		if(!EgovStringUtil.isEmpty(issueTime)){
			setIssueTime1(issueTime.split(":")[0]);
			setIssueTime2(issueTime.split(":")[1]);
		}
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
		return "FloodControlVO [floodControlId=" + floodControlId
				+ ", floodLevel=" + floodLevel + ", issueDate=" + issueDate
				+ ", issueTime=" + issueTime + ", hitCnt=" + hitCnt
				+ ", regDttm=" + regDttm + ", regNm=" + regNm + ", udtDttm="
				+ udtDttm + ", udtNm=" + udtNm + ", issueTime1=" + issueTime1
				+ ", issueTime2=" + issueTime2 + ", situationType="
				+ situationType + "]";
	}
}
