package lcms.valueObject;

import java.util.List;

/**
 * @author Leegh
 * 
 * 급별회의록VO 2020.07.09
 *
 */
public class MeetLogVO { 
	
	private String meetSeq		= ""; // "급별 회의록seq"
	private String year			= ""; // "년도"
	private String semester		= ""; // "학기"
	private String week			= ""; // "주차"
	private String grade		= ""; // "등급"
	private String thisSubject	= ""; // '금주 교과'
	private String thisStdMng	= ""; // '금주 학생 관리'
	private String thisEtc		= ""; // '금주 기타'
	private String nextSubject	= ""; // '차주 교과'
	private String nextStdMng	= ""; // '차주 학생 관리'
	private String nextEtc		= ""; // '차주 기타'
	private String notice		= ""; // '공지사항'
	private String regDate		= ""; // "등록일시"
	private String regName		= ""; // "등록자"
	private String partProf		= ""; // "참가 교사"
	private String prog			= ""; // "프로그램"
	
	private List<MeetProfVO> meetProfList;
	
	public List<MeetProfVO> getMeetProfList() {
		return meetProfList;
	}
	public void setMeetProfList(List<MeetProfVO> meetProfList) {
		this.meetProfList = meetProfList;
	}
	
	public String getMeetSeq() {
		return meetSeq;
	}
	public void setMeetSeq(String meetSeq) {
		this.meetSeq = meetSeq;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getThisSubject() {
		return thisSubject;
	}
	public void setThisSubject(String thisSubject) {
		this.thisSubject = thisSubject;
	}
	public String getThisStdMng() {
		return thisStdMng;
	}
	public void setThisStdMng(String thisStdMng) {
		this.thisStdMng = thisStdMng;
	}
	public String getThisEtc() {
		return thisEtc;
	}
	public void setThisEtc(String thisEtc) {
		this.thisEtc = thisEtc;
	}
	public String getNextSubject() {
		return nextSubject;
	}
	public void setNextSubject(String nextSubject) {
		this.nextSubject = nextSubject;
	}
	public String getNextStdMng() {
		return nextStdMng;
	}
	public void setNextStdMng(String nextStdMng) {
		this.nextStdMng = nextStdMng;
	}
	public String getNextEtc() {
		return nextEtc;
	}
	public void setNextEtc(String nextEtc) {
		this.nextEtc = nextEtc;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getPartProf() {
		return partProf;
	}
	public void setPartProf(String partProf) {
		this.partProf = partProf;
	}
	public String getProg() {
		return prog;
	}
	public void setProg(String prog) {
		this.prog = prog;
	}
	
	@Override
	public String toString() {
		return "MeetLogVO [meetSeq=" + meetSeq + ", year=" + year + ", semester=" + semester + ", week=" + week
				+ ", grade=" + grade + ", thisSubject=" + thisSubject + ", thisStdMng=" + thisStdMng + ", thisEtc="
				+ thisEtc + ", nextSubject=" + nextSubject + ", nextStdMng=" + nextStdMng + ", nextEtc=" + nextEtc
				+ ", notice=" + notice + ", regDate=" + regDate + ", regName=" + regName + ", partProf=" + partProf
				+ ", prog=" + prog + ", meetProfList=" + meetProfList + "]";
	}
	
}
