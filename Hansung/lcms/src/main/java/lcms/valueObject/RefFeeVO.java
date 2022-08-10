package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 환불VO 2020.03.11
 *
 */
public class RefFeeVO extends EnterVO{ 
	
	private String refSeq		= "";	// 롼불Seq
	private String refDate		= "";	// 환불일자
	private String refAccount	= "";	// 환불계좌번호
	private String refType		= "";	// 환불사유
	private String refFee		= "";	// 환불금액
	private String refEtc		= "";	// 비고
	
	public String getRefSeq() {
		return refSeq;
	}
	public void setRefSeq(String refSeq) {
		this.refSeq = refSeq;
	}
	public String getRefDate() {
		return refDate;
	}
	public void setRefDate(String refDate) {
		this.refDate = refDate;
	}
	public String getRefAccount() {
		return refAccount;
	}
	public void setRefAccount(String refAccount) {
		this.refAccount = refAccount;
	}
	public String getRefType() {
		return refType;
	}
	public void setRefType(String refType) {
		this.refType = refType;
	}
	public String getRefFee() {
		return refFee;
	}
	public void setRefFee(String refFee) {
		this.refFee = refFee;
	}
	public String getRefEtc() {
		return refEtc;
	}
	public void setRefEtc(String refEtc) {
		this.refEtc = refEtc;
	}
	
	@Override
	public String toString() {
		return "RefFeeVO [refSeq=" + refSeq + ", refDate=" + refDate + ", refAccount=" + refAccount + ", refType="
				+ refType + ", refFee=" + refFee + ", refEtc=" + refEtc + "]";
	}
}
