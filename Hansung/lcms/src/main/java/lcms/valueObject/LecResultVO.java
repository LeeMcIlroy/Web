package lcms.valueObject;

import component.file.FileInfoVO;

/**
 * @author Leegh
 * 
 * 관리자VO 2019.06.20
 *
 */
public class LecResultVO { 
	
	private String gradeSeq 		= ""; 						// 성적 SEQ
	private String lectCdoe			= "";						// 강의 SEQ
	private String memberCode   	= "";						// 학생코드
	private String gradeName		= "";						// 학생명
	private String semYear			= "";						// 기준년도
	private String semester			= "";						// 기준학기
	private String gradeLec			= "";						// 평가자
	private String gradeDate		= "";						// 성적 등록일
	private String gradeGubun		= "";						// 시험구분
	private String gradeExprSpeak	= "";						// 표현능력 말하기
	private String gradeExprWrite	= "";						// 표현능력 쓰기
	private String gradeCompListen	= "";						// 이해능력 듣기	
	private String gradeCompRead	= "";						// 이해능력 읽기
	
	public LecResultVO(){}
	
	public void setGradeSeq(String gradeSeq) {
		this.gradeSeq = gradeSeq;
	}
	
	public String getGradeSeq() {
		return gradeSeq;
	}
	
	public void setLectCdoe(String lectCdoe) {
		this.lectCdoe = lectCdoe;
	}
	
	public String getLectCdoe() {
		return lectCdoe;
	}
	
	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	
	public String getMemberCode() {
		return memberCode;
	}
	
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	
	public String getGradeName() {
		return gradeName;
	}
	
	public void setSemYear(String semYear) {
		this.semYear = semYear;
	}
	
	public String getSemYear() {
		return semYear;
	}
	
	public void setSemester(String semester) {
		this.semester = semester;
	}
	
	public String getSemester() {
		return semester;
	}
	
	public void setGradeLec(String gradeLec) {
		this.gradeLec = gradeLec;
	}
	
	public String getGradeLec() {
		return gradeLec;
	}
	
	public void setGradeDate(String gradeDate) {
		this.gradeDate = gradeDate;
	}
	
	public String getGradeDate() {
		return gradeDate;
	}
	
	public void setGradeGubun(String gradeGubun) {
		this.gradeGubun = gradeGubun;
	}
	
	public String getGradeGubun() {
		return gradeGubun;
	}
	
	public void setGradeExprSpeak(String gradeExprSpeak) {
		this.gradeExprSpeak = gradeExprSpeak;
	}
	
	public String getGradeExprSpeak() {
		return gradeExprSpeak;
	}
	
	public void setGradeExprWrite(String gradeExprWrite) {
		this.gradeExprWrite = gradeExprWrite;
	}
	
	public String getGradeExprWrite() {
		return gradeExprWrite;
	}
	
	public void setGradeCompListen(String gradeCompListen) {
		this.gradeCompListen = gradeCompListen;
	}
	
	public String getGradeCompListen() {
		return gradeCompListen;
	}
	
	public void setGradeCompRead(String gradeCompRead) {
		this.gradeCompRead = gradeCompRead;
	}
	
	public String getGradeCompRead() {
		return gradeCompRead;
	}

}
