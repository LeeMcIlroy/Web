package lcms.valueObject;

public class PrfSub4VO extends MemberVO{
	
	private String prfPSeq 				= "";	//seq
	private String prfPIssueNum 		= "";	//발급번호
	private String prfPCerti 			= "";	//증명서
	private String prfPCauseIssue 		= "";	//발급사유
	private String prfPDateIssue 		= "";	//발급일시
	private String prfPIncidental 		= "";	//부수
	@Override
	public String toString() {
		return "PrfSub4VO [prfPSeq=" + prfPSeq + ", prfPIssueNum=" + prfPIssueNum + ", prfPCerti=" + prfPCerti
				+ ", prfPCauseIssue=" + prfPCauseIssue + ", prfPDateIssue=" + prfPDateIssue + ", prfPIncidental="
				+ prfPIncidental + "]";
	}
	public String getPrfPSeq() {
		return prfPSeq;
	}
	public void setPrfPSeq(String prfPSeq) {
		this.prfPSeq = prfPSeq;
	}
	public String getPrfPIssueNum() {
		return prfPIssueNum;
	}
	public void setPrfPIssueNum(String prfPIssueNum) {
		this.prfPIssueNum = prfPIssueNum;
	}
	public String getPrfPCerti() {
		return prfPCerti;
	}
	public void setPrfPCerti(String prfPCerti) {
		this.prfPCerti = prfPCerti;
	}
	public String getPrfPCauseIssue() {
		return prfPCauseIssue;
	}
	public void setPrfPCauseIssue(String prfPCauseIssue) {
		this.prfPCauseIssue = prfPCauseIssue;
	}
	public String getPrfPDateIssue() {
		return prfPDateIssue;
	}
	public void setPrfPDateIssue(String prfPDateIssue) {
		this.prfPDateIssue = prfPDateIssue;
	}
	public String getPrfPIncidental() {
		return prfPIncidental;
	}
	public void setPrfPIncidental(String prfPIncidental) {
		this.prfPIncidental = prfPIncidental;
	}
	
}
