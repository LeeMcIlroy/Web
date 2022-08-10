package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 상담VO 2020.03.19
 *
 */
public class ConsultVO extends MemberVO { 
	
	private String consultSeq	= ""; // 상담Seq
	private String lectSeq		= ""; // 강의Seq
	private String profCode		= ""; // 강사코드
	private String consultDate	= ""; // 상담일자
	private String consultType	= ""; // 상담구분
	private String stHour		= ""; // 시작시간
	private String stMinu		= ""; // 시작분
	private String edHour		= ""; // 종료시간
	private String edMinu		= ""; // 종료분
	private String place		= ""; // 상담장소
	private String content		= ""; // 상담내용
	private String regDate		= ""; // 등록일시
	private String year			= ""; // 연도
	private String semester		= ""; // 학기
	private String regType		= ""; // 등록구분 (1:업무담당자/2:강사)
	
	public String getConsultSeq() {
		return consultSeq;
	}
	public void setConsultSeq(String consultSeq) {
		this.consultSeq = consultSeq;
	}
	public String getLectSeq() {
		return lectSeq;
	}
	public void setLectSeq(String lectSeq) {
		this.lectSeq = lectSeq;
	}
	public String getProfCode() {
		return profCode;
	}
	public void setProfCode(String profCode) {
		this.profCode = profCode;
	}
	public String getConsultDate() {
		return consultDate;
	}
	public void setConsultDate(String consultDate) {
		this.consultDate = consultDate;
	}
	public String getConsultType() {
		return consultType;
	}
	public void setConsultType(String consultType) {
		this.consultType = consultType;
	}
	public String getStHour() {
		return stHour;
	}
	public void setStHour(String stHour) {
		this.stHour = stHour;
	}
	public String getStMinu() {
		return stMinu;
	}
	public void setStMinu(String stMinu) {
		this.stMinu = stMinu;
	}
	public String getEdHour() {
		return edHour;
	}
	public void setEdHour(String edHour) {
		this.edHour = edHour;
	}
	public String getEdMinu() {
		return edMinu;
	}
	public void setEdMinu(String edMinu) {
		this.edMinu = edMinu;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
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
	public String getRegType() {
		return regType;
	}
	public void setRegType(String regType) {
		this.regType = regType;
	}
	
	@Override
	public String toString() {
		return "ConsultVO [consultSeq=" + consultSeq + ", lectSeq=" + lectSeq + ", profCode=" + profCode
				+ ", consultDate=" + consultDate + ", consultType=" + consultType + ", stHour=" + stHour + ", stMinu="
				+ stMinu + ", edHour=" + edHour + ", edMinu=" + edMinu + ", place=" + place + ", content=" + content
				+ ", regDate=" + regDate + ", year=" + year + ", semester=" + semester + ", regType=" + regType + "]";
	}
}
