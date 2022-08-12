package ctms.valueObject;

public class Rs5020mVO {
	private String    corpCd               = ""; // 회사코드
    private String    branchCd             = ""; // 지사번호
    private String    rsNo                 = ""; // 연구과제번호
    private String    rptNo                = ""; // 보고서번호
    private String    rptCls               = ""; // 보고서종류
    private String    rptClsNm             = ""; // 보고서종류명
    private String    rptDt                = ""; // 보고서등록일자
    private String    remk                 = ""; // 비고
    private String    dataRegdt            = ""; // 등록수정일시
    private String    dataRegnt            = ""; // 등록수정자
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
	public String getRsNo() {
		return rsNo;
	}
	public void setRsNo(String rsNo) {
		this.rsNo = rsNo;
	}
	public String getRptNo() {
		return rptNo;
	}
	public void setRptNo(String rptNo) {
		this.rptNo = rptNo;
	}
	public String getRptCls() {
		return rptCls;
	}
	public void setRptCls(String rptCls) {
		this.rptCls = rptCls;
	}
	public String getRptClsNm() {
		return rptClsNm;
	}
	public void setRptClsNm(String rptClsNm) {
		this.rptClsNm = rptClsNm;
	}
	public String getRptDt() {
		return rptDt;
	}
	public void setRptDt(String rptDt) {
		this.rptDt = rptDt;
	}
	public String getRemk() {
		return remk;
	}
	public void setRemk(String remk) {
		this.remk = remk;
	}
	public String getDataRegdt() {
		return dataRegdt;
	}
	public void setDataRegdt(String dataRegdt) {
		this.dataRegdt = dataRegdt;
	}
	public String getDataRegnt() {
		return dataRegnt;
	}
	public void setDataRegnt(String dataRegnt) {
		this.dataRegnt = dataRegnt;
	}
	@Override
	public String toString() {
		return "Rs5020mVO [corpCd=" + corpCd + ", branchCd=" + branchCd + ", rsNo=" + rsNo + ", rptNo=" + rptNo
				+ ", rptCls=" + rptCls + ", rptClsNm=" + rptClsNm + ", rptDt=" + rptDt + ", remk=" + remk
				+ ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}
    
    
}
