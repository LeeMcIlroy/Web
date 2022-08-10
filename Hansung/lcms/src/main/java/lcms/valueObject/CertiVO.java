package lcms.valueObject;

import java.util.List;

public class CertiVO extends MemberVO {

	private String certiSeq		= ""; // 증명서Seq
	private String certiNum		= ""; // 증명서번호
	private String lectSeq		= ""; // 
	private String certiDate	= ""; // 접수일자
	private String certiType	= ""; // 증명서구분
	private String regDate		= ""; // 등록일
	private String printNum		= ""; // 부수
	private String semYear		= ""; // 년도
	private String semester		= ""; // 학기
	private String certiEtc		= ""; // 발급사유
	private String semCurr		= ""; // 교육과정
	private String semProg		= ""; // 프로그램
	private String lectNm		= ""; // 반명
	List<CertiVO> certiList;
	
	public List<CertiVO> getCertiList() {
		return certiList;
	}
	public String getLectNm() {
		return lectNm;
	}
	public void setLectNm(String lectNm) {
		this.lectNm = lectNm;
	}
	public void setCertiList(List<CertiVO> certiList) {
		this.certiList = certiList;
	}
	
	public String getCertiSeq() {
		return certiSeq;
	}
	public void setCertiSeq(String certiSeq) {
		this.certiSeq = certiSeq;
	}
	public String getCertiNum() {
		return certiNum;
	}
	public void setCertiNum(String certiNum) {
		this.certiNum = certiNum;
	}
	public String getLectSeq() {
		return lectSeq;
	}
	public void setLectSeq(String lectSeq) {
		this.lectSeq = lectSeq;
	}
	public String getCertiDate() {
		return certiDate;
	}
	public void setCertiDate(String certiDate) {
		this.certiDate = certiDate;
	}
	public String getCertiType() {
		return certiType;
	}
	public void setCertiType(String certiType) {
		this.certiType = certiType;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getPrintNum() {
		return printNum;
	}
	public void setPrintNum(String printNum) {
		this.printNum = printNum;
	}
	public String getSemYear() {
		return semYear;
	}
	public void setSemYear(String semYear) {
		this.semYear = semYear;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public String getCertiEtc() {
		return certiEtc;
	}
	public void setCertiEtc(String certiEtc) {
		this.certiEtc = certiEtc;
	}
	public String getSemCurr() {
		return semCurr;
	}
	public void setSemCurr(String semCurr) {
		this.semCurr = semCurr;
	}
	public String getSemProg() {
		return semProg;
	}
	public void setSemProg(String semProg) {
		this.semProg = semProg;
	}
	@Override
	public String toString() {
		return "CertiVO [certiSeq=" + certiSeq + ", certiNum=" + certiNum + ", lectSeq=" + lectSeq + ", certiDate="
				+ certiDate + ", certiType=" + certiType + ", regDate=" + regDate + ", printNum=" + printNum
				+ ", semYear=" + semYear + ", semester=" + semester + ", certiEtc=" + certiEtc + ", semCurr=" + semCurr
				+ ", semProg=" + semProg + ", lectNm=" + lectNm + ", certiList=" + certiList + "]";
	}
	

}
