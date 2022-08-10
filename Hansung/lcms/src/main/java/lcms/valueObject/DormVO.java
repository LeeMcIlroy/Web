package lcms.valueObject;

/**
 * @author wlsaud92@celldio
 * 
 *         (행정)기숙사VO 2020.03.06
 *
 */
public class DormVO  extends MemberVO{

	private String dormSeq = ""; // 테이블 시퀀스
	private String memCode = ""; // 맴버 코드(학번 이면서 아이디)
	private String resiStartdate = ""; // 거주기간 시작
	private String resiEnddate = ""; // 거주기간 끝
	private String dormFirst = ""; // 기숙사 1지망
	private String dormSecond = ""; // 기숙사 2지망
	private String renewGubun = ""; // 신청 구분 신입사,재입사
	private String dormNow = ""; // 현재 기숙사
	private String perroomNow = ""; // 현재 인실
	private String roomNum = ""; // 방번호
	private String payment = ""; // 수납금액
	private String payDate = ""; // 수납날짜
	private String remarks = ""; // 비고
	private String joinyn = ""; // 입사여부 YN
	private String registDate = ""; // 접수 일자
	private String joinDate = ""; // 입사 일자
	private String joinMinDate = ""; // 최초 입사 일자
	private String resignDate = ""; // 퇴사 일자
	private String semYear = ""; // 신청 한 년도
	private String semEster = ""; // 신청학기 구분  봄/여름/가을/겨울
	private String vacationInc = ""; // 방학구분 YN
	private String dormRecepNum = ""; // 기숙사 접수번호

	public String getDormSeq() {
		return dormSeq;
	}
	public void setDormSeq(String dormSeq) {
		this.dormSeq = dormSeq;
	}
	public String getMemCode() {
		return memCode;
	}
	public void setMemCode(String memCode) {
		this.memCode = memCode;
	}
	public String getResiStartdate() {
		return resiStartdate;
	}
	public void setResiStartdate(String resiStartdate) {
		this.resiStartdate = resiStartdate;
	}
	public String getResiEnddate() {
		return resiEnddate;
	}
	public void setResiEnddate(String resiEnddate) {
		this.resiEnddate = resiEnddate;
	}
	public String getDormFirst() {
		return dormFirst;
	}
	public void setDormFirst(String dormFirst) {
		this.dormFirst = dormFirst;
	}
	public String getDormSecond() {
		return dormSecond;
	}
	public void setDormSecond(String dormSecond) {
		this.dormSecond = dormSecond;
	}
	public String getRenewGubun() {
		return renewGubun;
	}
	public void setRenewGubun(String renewGubun) {
		this.renewGubun = renewGubun;
	}
	public String getDormNow() {
		return dormNow;
	}
	public void setDormNow(String dormNow) {
		this.dormNow = dormNow;
	}
	public String getPerroomNow() {
		return perroomNow;
	}
	public void setPerroomNow(String perroomNow) {
		this.perroomNow = perroomNow;
	}
	public String getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getPayDate() {
		return payDate;
	}
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getJoinyn() {
		return joinyn;
	}
	public void setJoinyn(String joinyn) {
		this.joinyn = joinyn;
	}
	public String getRegistDate() {
		return registDate;
	}
	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getResignDate() {
		return resignDate;
	}
	public void setResignDate(String resignDate) {
		this.resignDate = resignDate;
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
	public String getVacationInc() {
		return vacationInc;
	}
	public void setVacationInc(String vacationInc) {
		this.vacationInc = vacationInc;
	}
	public String getDormRecepNum() {
		return dormRecepNum;
	}
	public void setDormRecepNum(String dormRecepNum) {
		this.dormRecepNum = dormRecepNum;
	}
	public String getJoinMinDate() {
		return joinMinDate;
	}
	public void setJoinMinDate(String joinMinDate) {
		this.joinMinDate = joinMinDate;
	}
	
	}
