package lcms.valueObject;

public class LectureVO {
	
//	교육과정 > 강의개설
	private String lectSeq				= "";  //  
	private String lectName				= "";  // '과목명/교과목>>'
	private String lectDivi				= "";  // '분반'    
	private String lectClaTea			= "";  // '담임교사'  
	private String lectClassroom		= "";  // '강의실   
	private String lectSdate			= "";  // '강의시작일'
	private String lectEdate			= "";  // '강의 종료일'
	private String lectState			= "";  // 'Y/N',
	private String lectYear				= "";  // '년도',   
	private String lectSem				= "";  // '학기',  
	private String lectProg				= "";  // '프로그램>>' 
	private String lectCurr				= "";  // '교육과정>>'
	private String lectPer				= "";  // '정원'       
	private String gradeYn				= "";
	private String admisYn				= "";
	private String lectTeaCon			= "";  // 강사
	private String lectClaTeaNm			= "";  // '담임교사이름'  
	private String lectGrade			= "";  // 강의등급

	@Override
	public String toString() {
		return "LectureVO [lectSeq=" + lectSeq + ", lectName=" + lectName + ", lectDivi=" + lectDivi + ", lectClaTea="
				+ lectClaTea + ", lectClassroom=" + lectClassroom + ", lectSdate=" + lectSdate + ", lectEdate="
				+ lectEdate + ", lectState=" + lectState + ", lectYear=" + lectYear + ", lectSem=" + lectSem
				+ ", lectProg=" + lectProg + ", lectCurr=" + lectCurr + ", lectPer=" + lectPer + ", gradeYn=" + gradeYn
				+ ", admisYn=" + admisYn + ", lectTeaCon=" + lectTeaCon + ", lectClaTeaNm=" + lectClaTeaNm
				+ ", lectGrade=" + lectGrade + "]";
	}
	
	public String getLectSeq() {
		return lectSeq;
	}
	public void setLectSeq(String lectSeq) {
		this.lectSeq = lectSeq;
	}
	public String getLectName() {
		return lectName;
	}
	public void setLectName(String lectName) {
		this.lectName = lectName;
	}
	public String getLectDivi() {
		return lectDivi;
	}
	public void setLectDivi(String lectDivi) {
		this.lectDivi = lectDivi;
	}
	public String getLectClaTea() {
		return lectClaTea;
	}
	public void setLectClaTea(String lectClaTea) {
		this.lectClaTea = lectClaTea;
	}
	public String getLectClassroom() {
		return lectClassroom;
	}
	public void setLectClassroom(String lectClassroom) {
		this.lectClassroom = lectClassroom;
	}
	public String getLectSdate() {
		return lectSdate;
	}
	public void setLectSdate(String lectSdate) {
		this.lectSdate = lectSdate;
	}
	public String getLectEdate() {
		return lectEdate;
	}
	public void setLectEdate(String lectEdate) {
		this.lectEdate = lectEdate;
	}
	public String getLectState() {
		return lectState;
	}
	public void setLectState(String lectState) {
		this.lectState = lectState;
	}
	public String getLectYear() {
		return lectYear;
	}
	public void setLectYear(String lectYear) {
		this.lectYear = lectYear;
	}
	public String getLectSem() {
		return lectSem;
	}
	public void setLectSem(String lectSem) {
		this.lectSem = lectSem;
	}
	public String getLectProg() {
		return lectProg;
	}
	public void setLectProg(String lectProg) {
		this.lectProg = lectProg;
	}
	public String getLectCurr() {
		return lectCurr;
	}
	public void setLectCurr(String lectCurr) {
		this.lectCurr = lectCurr;
	}
	public String getLectPer() {
		return lectPer;
	}
	public void setLectPer(String lectPer) {
		this.lectPer = lectPer;
	}
	public String getGradeYn() {
		return gradeYn;
	}
	public void setGradeYn(String gradeYn) {
		this.gradeYn = gradeYn;
	}
	public String getAdmisYn() {
		return admisYn;
	}
	public void setAdmisYn(String admisYn) {
		this.admisYn = admisYn;
	}
	public String getLectTeaCon() {
		return lectTeaCon;
	}
	public void setLectTeaCon(String lectTeaCon) {
		this.lectTeaCon = lectTeaCon;
	}
	public String getLectClaTeaNm() {
		return lectClaTeaNm;
	}
	public void setLectClaTeaNm(String lectClaTeaNm) {
		this.lectClaTeaNm = lectClaTeaNm;
	}
	public String getLectGrade() {
		return lectGrade;
	}
	public void setLectGrade(String lectGrade) {
		this.lectGrade = lectGrade;
	}
}