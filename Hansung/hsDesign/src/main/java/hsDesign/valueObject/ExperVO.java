package hsDesign.valueObject;

/**
 * @author songcw
 * 진로체험신청
 * 	2017-12-06 최초생성
 *	2018-01-30 이메일 추가
 */
public class ExperVO {

	private String exaSeq 			= "";	// 진로체험신청SEQ
	private String exaAplyName 		= "";	// 신청자명
	private String exaSchName 		= "";	// 학교명
	private String exaTel 			= "";	// 연락처
	private String exaStDate 		= "";	// 신청일자_시작
	private String exaEdDate 		= "";	// 신청일자_종료
	private String regDate 			= "";	// 등록일
	private String exaEmail			= "";	// 이메일
	
	/** view */
	private String exaTel1			= "";	// 연락처1
	private String exaTel2			= "";	// 연락처2
	private String exaTel3			= "";	// 연락처3
	public String getExaTel1() { return exaTel1; }
	public void setExaTel1(String exaTel1) { this.exaTel1 = exaTel1; }
	public String getExaTel2() { return exaTel2; }
	public void setExaTel2(String exaTel2) { this.exaTel2 = exaTel2; }
	public String getExaTel3() { return exaTel3; }
	public void setExaTel3(String exaTel3) { this.exaTel3 = exaTel3; }
	
	public String getExaEmail() {
		return exaEmail;
	}
	public void setExaEmail(String exaEmail) {
		this.exaEmail = exaEmail;
	}
	public String getExaSeq() {
		return exaSeq;
	}
	public void setExaSeq(String exaSeq) {
		this.exaSeq = exaSeq;
	}
	public String getExaAplyName() {
		return exaAplyName;
	}
	public void setExaAplyName(String exaAplyName) {
		this.exaAplyName = exaAplyName;
	}
	public String getExaSchName() {
		return exaSchName;
	}
	public void setExaSchName(String exaSchName) {
		this.exaSchName = exaSchName;
	}
	public String getExaTel() {
		return exaTel;
	}
	public void setExaTel(String exaTel) {
		String[] str = exaTel.split("-");
		setExaTel1(str[0]);
		setExaTel2(str[1]);
		setExaTel3(str[2]);
		this.exaTel = exaTel;
	}
	public String getExaStDate() {
		return exaStDate;
	}
	public void setExaStDate(String exaStDate) {
		this.exaStDate = exaStDate;
	}
	public String getExaEdDate() {
		return exaEdDate;
	}
	public void setExaEdDate(String exaEdDate) {
		this.exaEdDate = exaEdDate;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "ExperVO [\nexaSeq=" + exaSeq + "\nexaAplyName=" + exaAplyName + "\nexaSchName=" + exaSchName
				+ "\nexaTel=" + exaTel + "\nexaStDate=" + exaStDate + "\nexaEdDate=" + exaEdDate + "\nregDate="
				+ regDate + "\nexaEmail=" + exaEmail + "\nexaTel1=" + exaTel1 + "\nexaTel2=" + exaTel2 + "\nexaTel3="
				+ exaTel3 + "\n]";
	}
}
