package lcms.valueObject;

public class AbsenceVO {
	//수업 > 결석경고
	private String absTbSeq		= "";	//게시물 SEQ
	private String absSeq		= "";	//SEQ
	private String absYear		= "";	//년도
	private String absSem		= "";	//학기
	private String absDate		= "";	//경고일자-일자
	private String absPrs		= "";	//인원수
	private String absGrade		= "";	//등급
	private String absDivi		= "";	//분반
	private String absName		= "";	//이름
	private String absAbseCnt	= "";	//총결석시간
	private String memberCode	= "";	//MEMBER_CODE
	@Override
	public String toString() {
		return "AbsenceVO [absTbSeq=" + absTbSeq + ", absSeq=" + absSeq + ", absYear=" + absYear + ", absSem=" + absSem
				+ ", absDate=" + absDate + ", absPrs=" + absPrs + ", absGrade=" + absGrade + ", absDivi=" + absDivi
				+ ", absName=" + absName + ", absAbseCnt=" + absAbseCnt + ", memberCode=" + memberCode + "]";
	}
	public String getAbsTbSeq() {
		return absTbSeq;
	}
	public void setAbsTbSeq(String absTbSeq) {
		this.absTbSeq = absTbSeq;
	}
	public String getAbsSeq() {
		return absSeq;
	}
	public void setAbsSeq(String absSeq) {
		this.absSeq = absSeq;
	}
	public String getAbsYear() {
		return absYear;
	}
	public void setAbsYear(String absYear) {
		this.absYear = absYear;
	}
	public String getAbsSem() {
		return absSem;
	}
	public void setAbsSem(String absSem) {
		this.absSem = absSem;
	}
	public String getAbsDate() {
		return absDate;
	}
	public void setAbsDate(String absDate) {
		this.absDate = absDate;
	}
	public String getAbsPrs() {
		return absPrs;
	}
	public void setAbsPrs(String absPrs) {
		this.absPrs = absPrs;
	}
	public String getAbsGrade() {
		return absGrade;
	}
	public void setAbsGrade(String absGrade) {
		this.absGrade = absGrade;
	}
	public String getAbsDivi() {
		return absDivi;
	}
	public void setAbsDivi(String absDivi) {
		this.absDivi = absDivi;
	}
	public String getAbsName() {
		return absName;
	}
	public void setAbsName(String absName) {
		this.absName = absName;
	}
	public String getAbsAbseCnt() {
		return absAbseCnt;
	}
	public void setAbsAbseCnt(String absAbseCnt) {
		this.absAbseCnt = absAbseCnt;
	}
	public String getMemberCode() {
		return memberCode;
	}
	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	
}