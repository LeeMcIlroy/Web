package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 결석자상담VO 2020.06.25
 *
 */
public class AbsentConsultVO { 
	
	private String absentSeq			= ""; // '결석자상담 seq'
	private String attSeq				= ""; // '출결 seq'
	private String lectSeq				= ""; // '강의 seq'
	private String lectName				= ""; // '강의명'
	private String lectDivi				= ""; // '분반'
	private String memberCode			= ""; // '학번'
	private String memberName			= ""; // '학생이름'
	private String memberGrade			= ""; // '학생 등급'
	private String memberNation			= ""; // '학생 국적'
	private String absentDate			= ""; // '결석일자'
	private String firstYn				= ""; // '1차 상담 여부'
	private String firstSelorCode		= ""; // '1차 상담자 교번'
	private String firstSelorName		= ""; // '1차 상담자 이름'
	private String firstTel				= ""; // '1차 상담 상담방법-전화'
	private String firstSns				= ""; // '1차 상담 상담방법-sns'
	private String firstTeam			= ""; // '1차 상담 상담방법-국제교류팀'
	private String firstEtc				= ""; // '1차 상담 상담방법-기타'
	private String firstReason			= ""; // '1차 상담 결석사유'
	private String firstFolup			= ""; // '1차 상담 후속조치'
	private String secondYn				= ""; // '2차 상담 여부'
	private String secondSelorCode		= ""; // '2차 상담자 교번(아이디)'
	private String secondSelorName		= ""; // '2차 상담자 이름'
	private String secondTel			= ""; // '2차 상담 상담방법-전화'
	private String secondSns			= ""; // '2차 상담 상담방법-sns'
	private String secondTeam			= ""; // '2차 상담 상담방법-국제교류팀'
	private String secondEtc			= ""; // '2차 상담 상담방법-기타'
	private String secondReason			= ""; // '2차 상담 결석사유'
	private String secondFolup			= ""; // '2차 상담 후속조치'
	
	private String attRate				= ""; // 풀석율
	
	public String getAbsentSeq() {
		return absentSeq;
	}
	public void setAbsentSeq(String absentSeq) {
		this.absentSeq = absentSeq;
	}
	public String getAttSeq() {
		return attSeq;
	}
	public void setAttSeq(String attSeq) {
		this.attSeq = attSeq;
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
	public String getMemberCode() {
		return memberCode;
	}
	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberGrade() {
		return memberGrade;
	}
	public void setMemberGrade(String memberGrade) {
		this.memberGrade = memberGrade;
	}
	public String getMemberNation() {
		return memberNation;
	}
	public void setMemberNation(String memberNation) {
		this.memberNation = memberNation;
	}
	public String getAbsentDate() {
		return absentDate;
	}
	public void setAbsentDate(String absentDate) {
		this.absentDate = absentDate;
	}
	public String getFirstYn() {
		return firstYn;
	}
	public void setFirstYn(String firstYn) {
		this.firstYn = firstYn;
	}
	public String getFirstSelorCode() {
		return firstSelorCode;
	}
	public void setFirstSelorCode(String firstSelorCode) {
		this.firstSelorCode = firstSelorCode;
	}
	public String getFirstSelorName() {
		return firstSelorName;
	}
	public void setFirstSelorName(String firstSelorName) {
		this.firstSelorName = firstSelorName;
	}
	public String getFirstTel() {
		return firstTel;
	}
	public void setFirstTel(String firstTel) {
		this.firstTel = firstTel;
	}
	public String getFirstSns() {
		return firstSns;
	}
	public void setFirstSns(String firstSns) {
		this.firstSns = firstSns;
	}
	public String getFirstTeam() {
		return firstTeam;
	}
	public void setFirstTeam(String firstTeam) {
		this.firstTeam = firstTeam;
	}
	public String getFirstEtc() {
		return firstEtc;
	}
	public void setFirstEtc(String firstEtc) {
		this.firstEtc = firstEtc;
	}
	public String getFirstReason() {
		return firstReason;
	}
	public void setFirstReason(String firstReason) {
		this.firstReason = firstReason;
	}
	public String getFirstFolup() {
		return firstFolup;
	}
	public void setFirstFolup(String firstFolup) {
		this.firstFolup = firstFolup;
	}
	public String getSecondYn() {
		return secondYn;
	}
	public void setSecondYn(String secondYn) {
		this.secondYn = secondYn;
	}
	public String getSecondSelorCode() {
		return secondSelorCode;
	}
	public void setSecondSelorCode(String secondSelorCode) {
		this.secondSelorCode = secondSelorCode;
	}
	public String getSecondSelorName() {
		return secondSelorName;
	}
	public void setSecondSelorName(String secondSelorName) {
		this.secondSelorName = secondSelorName;
	}
	public String getSecondTel() {
		return secondTel;
	}
	public void setSecondTel(String secondTel) {
		this.secondTel = secondTel;
	}
	public String getSecondSns() {
		return secondSns;
	}
	public void setSecondSns(String secondSns) {
		this.secondSns = secondSns;
	}
	public String getSecondTeam() {
		return secondTeam;
	}
	public void setSecondTeam(String secondTeam) {
		this.secondTeam = secondTeam;
	}
	public String getSecondEtc() {
		return secondEtc;
	}
	public void setSecondEtc(String secondEtc) {
		this.secondEtc = secondEtc;
	}
	public String getSecondReason() {
		return secondReason;
	}
	public void setSecondReason(String secondReason) {
		this.secondReason = secondReason;
	}
	public String getSecondFolup() {
		return secondFolup;
	}
	public void setSecondFolup(String secondFolup) {
		this.secondFolup = secondFolup;
	}
	
	public String getAttRate() {
		return attRate;
	}
	public void setAttRate(String attRate) {
		this.attRate = attRate;
	}
	
	@Override
	public String toString() {
		return "AbsentConsultVO [absentSeq=" + absentSeq + ", attSeq=" + attSeq + ", lectSeq=" + lectSeq + ", lectName="
				+ lectName + ", lectDivi=" + lectDivi + ", memberCode=" + memberCode + ", memberName=" + memberName
				+ ", memberGrade=" + memberGrade + ", memberNation=" + memberNation + ", absentDate=" + absentDate
				+ ", firstYn=" + firstYn + ", firstSelorCode=" + firstSelorCode + ", firstSelorName=" + firstSelorName
				+ ", firstTel=" + firstTel + ", firstSns=" + firstSns + ", firstTeam=" + firstTeam + ", firstEtc="
				+ firstEtc + ", firstReason=" + firstReason + ", firstFolup=" + firstFolup + ", secondYn=" + secondYn
				+ ", secondSelorCode=" + secondSelorCode + ", secondSelorName=" + secondSelorName + ", secondTel="
				+ secondTel + ", secondSns=" + secondSns + ", secondTeam=" + secondTeam + ", secondEtc=" + secondEtc
				+ ", secondReason=" + secondReason + ", secondFolup=" + secondFolup + ", attRate=" + attRate + "]";
	}
}
