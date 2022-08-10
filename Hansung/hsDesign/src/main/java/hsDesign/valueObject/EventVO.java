package hsDesign.valueObject;

/**
 * @author leegh
 *  행사참가신청
 * 	2018-11-16 최초생성
 */
public class EventVO {

	private String eveSeq 			= "";	// 행사참가신청SEQ
	private String eveNum			= "";	// 행사 회차수
	private String eveEvname		= "";	// 행사명
	private String eveName 			= "";	// 신청자명
	private String eveTel 			= "";	// 연락처
	private String eveEmail			= "";	// 이메일
	private String eveQues1			= "";	// 설문 문항 답변1
	private String eveQues2			= "";	// 문항 답변2
	private String eveQues3			= "";	// 문항 답변3
	private String eveQues4			= "";	// 문항 답변4
	private String eveQues5			= "";	// 문항 답변5
	private String eveDepoName		= "";	// 입금자명
	private String eveDepoDate		= "";	// 입금일
	private String eveRefundBank	= "";	// 환불은행
	private String eveRefundAcnm	= "";	// 환불계좌
	private String eveDepoYn		= "";	// 입금여부
	private String eveRefundYn		= "";	// 환불여부
	private String eveCancelYn		= "";	// 취소여부
	private String eveCancelDate	= "";	// 취소일
	private String eveRegDate		= "";	// 신청일
	
	/** view */
	private String eveTel1			= "";	// 연락처1
	private String eveTel2			= "";	// 연락처2
	private String eveTel3			= "";	// 연락처3
	public String getEveTel1() { return eveTel1; }
	public void setEveTel1(String eveTel1) { this.eveTel1 = eveTel1; }
	public String getEveTel2() { return eveTel2; }
	public void setEveTel2(String eveTel2) { this.eveTel2 = eveTel2; }
	public String getEveTel3() { return eveTel3; }
	public void setEveTel3(String eveTel3) { this.eveTel3 = eveTel3; }
	
	public String getEveEmail() {
		return eveEmail;
	}
	public void setEveEmail(String eveEmail) {
		this.eveEmail = eveEmail;
	}
	public String getEveSeq() {
		return eveSeq;
	}
	public void setEveSeq(String eveSeq) {
		this.eveSeq = eveSeq;
	}
	public String getEveNum() {
		return eveNum;
	}
	public void setEveNum(String eveNum) {
		this.eveNum = eveNum;
	}
	public String getEveName() {
		return eveName;
	}
	public void setEveName(String eveName) {
		this.eveName = eveName;
	}
	public String getEveTel() {
		return eveTel;
	}
	public String getEveQues1() {
		return eveQues1;
	}
	public void setEveQues1(String eveQues1) {
		this.eveQues1 = eveQues1;
	}
	public String getEveQues2() {
		return eveQues2;
	}
	public void setEveQues2(String eveQues2) {
		this.eveQues2 = eveQues2;
	}
	public String getEveQues3() {
		return eveQues3;
	}
	public void setEveQues3(String eveQues3) {
		this.eveQues3 = eveQues3;
	}
	public String getEveQues4() {
		return eveQues4;
	}
	public void setEveQues4(String eveQues4) {
		this.eveQues4 = eveQues4;
	}
	public String getEveQues5() {
		return eveQues5;
	}
	public void setEveQues5(String eveQues5) {
		this.eveQues5 = eveQues5;
	}
	public String getEveRegDate() {
		return eveRegDate;
	}
	public void setEveRegDate(String eveRegDate) {
		this.eveRegDate = eveRegDate;
	}
	public String getEveDepoYn() {
		return eveDepoYn;
	}
	public void setEveDepoYn(String eveDepoYn) {
		this.eveDepoYn = eveDepoYn;
	}
	public String getEveDepoDate() {
		return eveDepoDate;
	}
	public void setEveDepoDate(String eveDepoDate) {
		this.eveDepoDate = eveDepoDate;
	}
	public String getEveEvname() {
		return eveEvname;
	}
	public void setEveEvname(String eveEvname) {
		this.eveEvname = eveEvname;
	}
	public String getEveDepoName() {
		return eveDepoName;
	}
	public void setEveDepoName(String eveDepoName) {
		this.eveDepoName = eveDepoName;
	}
	public String getEveRefundBank() {
		return eveRefundBank;
	}
	public void setEveRefundBank(String eveRefundBank) {
		this.eveRefundBank = eveRefundBank;
	}
	public String getEveRefundAcnm() {
		return eveRefundAcnm;
	}
	public void setEveRefundAcnm(String eveRefundAcnm) {
		this.eveRefundAcnm = eveRefundAcnm;
	}
	public String getEveRefundYn() {
		return eveRefundYn;
	}
	public void setEveRefundYn(String eveRefundYn) {
		this.eveRefundYn = eveRefundYn;
	}
	public String getEveCancelDate() {
		return eveCancelDate;
	}
	public void setEveCancelDate(String eveCancelDate) {
		this.eveCancelDate = eveCancelDate;
	}
	public String getEveCancelYn() {
		return eveCancelYn;
	}
	public void setEveCancelYn(String eveCancelYn) {
		this.eveCancelYn = eveCancelYn;
	}
	public void setEveTel(String eveTel) {
		String[] str = eveTel.split("-");
		setEveTel1(str[0]);
		setEveTel2(str[1]);
		setEveTel3(str[2]);
		this.eveTel = eveTel;
	}
	
	@Override
	public String toString() {
		return "ExperVO [\neveSeq=" + eveSeq + "\neveEvname=" + eveEvname + "\neveName=" + eveName + "\neveNum" + eveNum
				+ "\neveQues1=" + eveQues1 + "\neveQues2=" + eveQues2 + "\neveQues3=" + eveQues3 + "\neveQues4=" + eveQues4 + "\neveQues5=" + eveQues5
				+ "\neveTel=" + eveTel + "\neveEmail=" + eveEmail + "\neveRegDate=" + eveRegDate  
				+ "\neveDepoName=" + eveDepoName + "\neveDepoYn=" + eveDepoYn + "\neveDepoDate=" + eveDepoDate
				+ "\neveRefundBank=" + eveRefundBank + "\neveRefundAcnm=" + eveRefundAcnm + "\neveRefundYn=" + eveRefundYn + "\neveCancelYn=" + eveCancelYn
				 + "\neveCancelDate=" + eveCancelDate + "\neveTel1=" + eveTel1 + "\neveTel2=" + eveTel2 + "\neveTel3=" + eveTel3 + "\n]";
	}
}
