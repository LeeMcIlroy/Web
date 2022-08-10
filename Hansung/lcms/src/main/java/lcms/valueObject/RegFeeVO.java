package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 등록금VO 2020.03.10
 *
 */
public class RegFeeVO extends EnterVO{ 
	
	private String regSeq		= "";	// 등록금 고지 seq
	private String memberCode	= "";	// 학번
	private String regFee		= "";	// 등록금
	private String enterFee		= "";	// 입학금
	private String regDate		= "";	// 고지일자
	private String regSeDate	= "";	// 고지서발송일자
	private String regStYear	= "";	// 납부시작년도
	private String regStSeme	= "";	// 납부시작학기
	private String regRgSeme	= "";	// 대상학기
	private String payDate		= "";	// 납부일자
	private String payFee		= "";	// 납부금액
	private String insuFee		= "";	// 보험료
	private String regStDate	= "";	// 납부기간시작
	private String regEdDate	= "";	// 납부기간종료
	private String addYn		= "";	// 추가납부 여부
	
	public String getRegSeq() {
		return regSeq;
	}
	public void setRegSeq(String regSeq) {
		this.regSeq = regSeq;
	}
	public String getMemberCode() {
		return memberCode;
	}
	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	public String getRegFee() {
		return regFee;
	}
	public void setRegFee(String regFee) {
		this.regFee = regFee;
	}
	public String getEnterFee() {
		return enterFee;
	}
	public void setEnterFee(String enterFee) {
		this.enterFee = enterFee;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegSeDate() {
		return regSeDate;
	}
	public void setRegSeDate(String regSeDate) {
		this.regSeDate = regSeDate;
	}
	public String getRegStYear() {
		return regStYear;
	}
	public void setRegStYear(String regStYear) {
		this.regStYear = regStYear;
	}
	public String getRegStSeme() {
		return regStSeme;
	}
	public void setRegStSeme(String regStSeme) {
		this.regStSeme = regStSeme;
	}
	public String getRegRgSeme() {
		return regRgSeme;
	}
	public void setRegRgSeme(String regRgSeme) {
		this.regRgSeme = regRgSeme;
	}
	public String getPayDate() {
		return payDate;
	}
	public void setPayDate(String payDate) {
		this.payDate = payDate;
	}
	public String getPayFee() {
		return payFee;
	}
	public void setPayFee(String payFee) {
		this.payFee = payFee;
	}
	public String getInsuFee() {
		return insuFee;
	}
	public void setInsuFee(String insuFee) {
		this.insuFee = insuFee;
	}
	public String getRegStDate() {
		return regStDate;
	}
	public void setRegStDate(String regStDate) {
		this.regStDate = regStDate;
	}
	public String getRegEdDate() {
		return regEdDate;
	}
	public void setRegEdDate(String regEdDate) {
		this.regEdDate = regEdDate;
	}
	public String getAddYn() {
		return addYn;
	}
	public void setAddYn(String addYn) {
		this.addYn = addYn;
	}
	
	@Override
	public String toString() {
		return "RegFeeVO [regSeq=" + regSeq + ", memberCode=" + memberCode + ", regFee=" + regFee + ", enterFee="
				+ enterFee + ", regDate=" + regDate + ", regSeDate=" + regSeDate + ", regStYear=" + regStYear
				+ ", regStSeme=" + regStSeme + ", regRgSeme=" + regRgSeme + ", payDate=" + payDate + ", payFee="
				+ payFee + ", insuFee=" + insuFee + ", regStDate=" + regStDate + ", regEdDate=" + regEdDate + ", addYn="
				+ addYn + "]";
	}
}
