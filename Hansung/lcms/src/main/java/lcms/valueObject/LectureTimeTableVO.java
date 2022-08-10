package lcms.valueObject;

import java.util.List;

public class LectureTimeTableVO extends LectureVO{
	
//	시간추가
	private String lectCode				= "";	// = lectSeq 과목 넘버
	private String lectTbseq			= "";   // 시퀀스
	private String lectTea				= "";   // 강사 코드번호
	private String lectWeek				= "";   // 요일
	private String lectSclass			= "";   // 교시 시작
	private String lectEclass			= "";   // 교시 끝
	private String lectGrammar			= "";   // 과목의 과정이름
	private String lectStdRegiCnt		= "";   // 학생 개인 신청과목수
	
	private List<LectureTimeTableVO> timeTableList;
	
	public List<LectureTimeTableVO> getTimeTableList() {
		return timeTableList;
	}
	public void setTimeTableList(List<LectureTimeTableVO> timeTableList) {
		this.timeTableList = timeTableList;
	}
	
	
	public String getLectCode() {
		return lectCode;
	}
	public void setLectCode(String lectCode) {
		this.lectCode = lectCode;
	}
	public String getLectTbseq() {
		return lectTbseq;
	}
	public void setLectTbseq(String lectTbseq) {
		this.lectTbseq = lectTbseq;
	}
	public String getLectTea() {
		return lectTea;
	}
	public void setLectTea(String lectTea) {
		this.lectTea = lectTea;
	}
	public String getLectWeek() {
		return lectWeek;
	}
	public void setLectWeek(String lectWeek) {
		this.lectWeek = lectWeek;
	}
	public String getLectSclass() {
		return lectSclass;
	}
	public void setLectSclass(String lectSclass) {
		this.lectSclass = lectSclass;
	}
	public String getLectEclass() {
		return lectEclass;
	}
	public void setLectEclass(String lectEclass) {
		this.lectEclass = lectEclass;
	}
	public String getLectGrammar() {
		return lectGrammar;
	}
	public void setLectGrammar(String lectGrammar) {
		this.lectGrammar = lectGrammar;
	}

	public String getLectStdRegiCnt() {
		return lectStdRegiCnt;
	}
	public void setLectStdRegiCnt(String lectStdRegiCnt) {
		this.lectStdRegiCnt = lectStdRegiCnt;
	}
	@Override
	public String toString() {
		return "LectureTimeTableVO [lectCode=" + lectCode + ", lectTbseq=" + lectTbseq + ", lectTea=" + lectTea
				+ ", lectWeek=" + lectWeek + ", lectSclass=" + lectSclass + ", lectEclass=" + lectEclass
				+ ", lectGrammar=" + lectGrammar + "]";
	}
	
}