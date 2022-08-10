package lcms.valueObject;

import java.util.List;

/**
 * @author Leegh
 * 
 * 성적VO 2020.03.16
 *
 */
public class GradeVO extends MemberVO { 
	
	private String gradeSeq = "";
	private String lectCode = "";
	private String gradeName = "";
	private String semYear = "";
	private String semEster = "";
	private String gradeLec = "";
	private String gradeDate = "";
	private String gradeGubun = "";
	private String gradeExprSpeak = "";
	private String gradeExprWrite = "";
	private String gradeCompListen = "";
	private String gradeCompRead = "";
	
	private List<GradeVO> gradeList;
	
	public List<GradeVO> getGradeList() {
		return gradeList;
	}
	public void setGradeList(List<GradeVO> gradeList) {
		this.gradeList = gradeList;
	}
	
	public String getGradeSeq() {
		return gradeSeq;
	}
	public void setGradeSeq(String gradeSeq) {
		this.gradeSeq = gradeSeq;
	}
	public String getLectCode() {
		return lectCode;
	}
	public void setLectCode(String lectCode) {
		this.lectCode = lectCode;
	}
	public String getGradeName() {
		return gradeName;
	}
	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
	public String getSemYear() {
		return semYear;
	}
	public void setSemYear(String semYear) {
		this.semYear = semYear;
	}
	public String getSemEster() {
		return semEster;
	}
	public void setSemEster(String semEster) {
		this.semEster = semEster;
	}
	public String getGradeLec() {
		return gradeLec;
	}
	public void setGradeLec(String gradeLec) {
		this.gradeLec = gradeLec;
	}
	public String getGradeDate() {
		return gradeDate;
	}
	public void setGradeDate(String gradeDate) {
		this.gradeDate = gradeDate;
	}
	public String getGradeGubun() {
		return gradeGubun;
	}
	public void setGradeGubun(String gradeGubun) {
		this.gradeGubun = gradeGubun;
	}
	public String getGradeExprSpeak() {
		return gradeExprSpeak;
	}
	public void setGradeExprSpeak(String gradeExprSpeak) {
		this.gradeExprSpeak = gradeExprSpeak;
	}
	public String getGradeExprWrite() {
		return gradeExprWrite;
	}
	public void setGradeExprWrite(String gradeExprWrite) {
		this.gradeExprWrite = gradeExprWrite;
	}
	public String getGradeCompListen() {
		return gradeCompListen;
	}
	public void setGradeCompListen(String gradeCompListen) {
		this.gradeCompListen = gradeCompListen;
	}
	public String getGradeCompRead() {
		return gradeCompRead;
	}
	public void setGradeCompRead(String gradeCompRead) {
		this.gradeCompRead = gradeCompRead;
	}
	
	@Override
	public String toString() {
		return "GradeVO [gradeSeq=" + gradeSeq + ", lectCode=" + lectCode + ", gradeName=" + gradeName + ", semYear="
				+ semYear + ", semEster=" + semEster + ", gradeLec=" + gradeLec + ", gradeDate=" + gradeDate
				+ ", gradeGubun=" + gradeGubun + ", gradeExprSpeak=" + gradeExprSpeak + ", gradeExprWrite="
				+ gradeExprWrite + ", gradeCompListen=" + gradeCompListen + ", gradeCompRead=" + gradeCompRead + "]";
	}
}
