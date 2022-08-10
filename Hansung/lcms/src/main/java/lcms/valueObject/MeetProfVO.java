package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 급별회의록 교사VO 2020.07.13
 *
 */
public class MeetProfVO { 
	
	private String mprofSeq		= ""; // '급별회의록 교사 seq'
	private String meetSeq		= ""; // '급별 회의록seq'
	private String lectSeq		= ""; // '강의 seq'
	private String dweek		= ""; // '요일'
	private String classNum		= ""; // '교시'
	private String monProfCode	= ""; // '교번(월)'
	private String tueProfCode	= ""; // '교번(화)'
	private String wedProfCode	= ""; // '교번(수)'
	private String thuProfCode	= ""; // '교번(목)'
	private String friProfCode	= ""; // '교번(금)'
	
	public String getMprofSeq() {
		return mprofSeq;
	}
	public void setMprofSeq(String mprofSeq) {
		this.mprofSeq = mprofSeq;
	}
	public String getMeetSeq() {
		return meetSeq;
	}
	public void setMeetSeq(String meetSeq) {
		this.meetSeq = meetSeq;
	}
	public String getLectSeq() {
		return lectSeq;
	}
	public void setLectSeq(String lectSeq) {
		this.lectSeq = lectSeq;
	}
	public String getDweek() {
		return dweek;
	}
	public void setDweek(String dweek) {
		this.dweek = dweek;
	}
	public String getClassNum() {
		return classNum;
	}
	public void setClassNum(String classNum) {
		this.classNum = classNum;
	}
	public String getMonProfCode() {
		return monProfCode;
	}
	public void setMonProfCode(String monProfCode) {
		this.monProfCode = monProfCode;
	}
	public String getTueProfCode() {
		return tueProfCode;
	}
	public void setTueProfCode(String tueProfCode) {
		this.tueProfCode = tueProfCode;
	}
	public String getWedProfCode() {
		return wedProfCode;
	}
	public void setWedProfCode(String wedProfCode) {
		this.wedProfCode = wedProfCode;
	}
	public String getThuProfCode() {
		return thuProfCode;
	}
	public void setThuProfCode(String thuProfCode) {
		this.thuProfCode = thuProfCode;
	}
	public String getFriProfCode() {
		return friProfCode;
	}
	public void setFriProfCode(String friProfCode) {
		this.friProfCode = friProfCode;
	}
	
	@Override
	public String toString() {
		return "MeetProfVO [mprofSeq=" + mprofSeq + ", meetSeq=" + meetSeq + ", lectSeq=" + lectSeq + ", dweek=" + dweek
				+ ", classNum=" + classNum + ", monProfCode=" + monProfCode + ", tueProfCode=" + tueProfCode
				+ ", wedProfCode=" + wedProfCode + ", thuProfCode=" + thuProfCode + ", friProfCode=" + friProfCode
				+ "]";
	}
	
}
