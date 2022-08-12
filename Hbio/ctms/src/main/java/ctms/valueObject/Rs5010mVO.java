package ctms.valueObject;

public class Rs5010mVO {
	
	private String corpCd       = ""; // 회사코드
	private String branchCd     = ""; // 지사코드
	private int    rptNo        = 0;  // 보고서번호
	private String rsField      = ""; // 임상분류
	private String rsFieldNm      = ""; // 임상분류명
	private String rptCls       = ""; // 보고서종류
	private String rptClsNm     = ""; // 보고서종류명
	private String rptfrName    = ""; // 보고서양식명
	private String dataRegDt  	= ""; // 등록수정자
	private String dataRegNt    = ""; // 등록자
	
	
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getBranchCd() {
		return branchCd;
	}
	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
	}
	public int getRptNo() {
		return rptNo;
	}
	public void setRptNo(int rptNo) {
		this.rptNo = rptNo;
	}
	public String getRsField() {
		return rsField;
	}
	public void setRsField(String rsField) {
		this.rsField = rsField;
	}
	public String getRptCls() {
		return rptCls;
	}
	public void setRptCls(String rptCls) {
		this.rptCls = rptCls;
	}
	public String getRptfrName() {
		return rptfrName;
	}
	public void setRptfrName(String rptfrName) {
		this.rptfrName = rptfrName;
	}
	public String getDataRegDt() {
		return dataRegDt;
	}
	public void setDataRegDt(String dataRegDt) {
		this.dataRegDt = dataRegDt;
	}
	public String getDataRegNt() {
		return dataRegNt;
	}
	public void setDataRegNt(String dataRegNt) {
		this.dataRegNt = dataRegNt;
	}
	
	public String getRptClsNm() {
		return rptClsNm;
	}
	public void setRptClsNm(String rptClsNm) {
		this.rptClsNm = rptClsNm;
	}
	
	public String getRsFieldNm() {
		return rsFieldNm;
	}
	public void setRsFieldNm(String rsFieldNm) {
		this.rsFieldNm = rsFieldNm;
	}
	@Override
	public String toString() {
		return "Rs5010mVO [corpCd=" + corpCd + ", branchCd=" + branchCd + ", rptNo=" + rptNo + ", rsField=" + rsField
				+ ", rsFieldNm=" + rsFieldNm + ", rptCls=" + rptCls + ", rptClsNm=" + rptClsNm + ", rptfrName="
				+ rptfrName + ", dataRegDt=" + dataRegDt + ", dataRegNt=" + dataRegNt + "]";
	}
	
	
	
	
		
}
