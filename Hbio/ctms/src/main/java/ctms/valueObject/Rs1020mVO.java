package ctms.valueObject;

/**
 * @author 개발2
 * 
 * 참여지사(연구과제)VO 2021.01.05 
 *
 */
public class Rs1020mVO {

	private String corpCd               = ""; // 회사코드
    private String corpName             = ""; // 회사코드명
    private String rsNo                 = ""; // 연구과제번호
    private String rsCd                 = ""; // 연구과제코드
    private String rsName               = ""; // 연구과제번호명
    private String branchCd             = ""; // 지사코드
    private String branchName           = ""; // 지사코드명
    private String regDt                = ""; // 등록일자
    private String jnStdt               = ""; // 참여시작일자
    private String jnEndt               = ""; // 참여종료일자
    private String rsstCls              = ""; // 연구상태
    private String rsstClsNm            = ""; // 연구상태명
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자
    private String mode  		        = ""; // 작업구분 i 입력  u 수정
	
    public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getRsCd() {
		return rsCd;
	}
	public void setRsCd(String rsCd) {
		this.rsCd = rsCd;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getCorpName() {
		return corpName;
	}
	public void setCorpName(String corpName) {
		this.corpName = corpName;
	}
	public String getRsNo() {
		return rsNo;
	}
	public void setRsNo(String rsNo) {
		this.rsNo = rsNo;
	}
	public String getRsName() {
		return rsName;
	}
	public void setRsName(String rsName) {
		this.rsName = rsName;
	}
	public String getBranchCd() {
		return branchCd;
	}
	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getJnStdt() {
		return jnStdt;
	}
	public void setJnStdt(String jnStdt) {
		this.jnStdt = jnStdt;
	}
	public String getJnEndt() {
		return jnEndt;
	}
	public void setJnEndt(String jnEndt) {
		this.jnEndt = jnEndt;
	}
	public String getRsstCls() {
		return rsstCls;
	}
	public void setRsstCls(String rsstCls) {
		this.rsstCls = rsstCls;
	}
	public String getRsstClsNm() {
		return rsstClsNm;
	}
	public void setRsstClsNm(String rsstClsNm) {
		this.rsstClsNm = rsstClsNm;
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
		return "Rs1020mVO [corpCd=" + corpCd + ", corpName=" + corpName + ", rsNo=" + rsNo + ", rsCd=" + rsCd
				+ ", rsName=" + rsName + ", branchCd=" + branchCd + ", branchName=" + branchName + ", regDt=" + regDt
				+ ", jnStdt=" + jnStdt + ", jnEndt=" + jnEndt + ", rsstCls=" + rsstCls + ", rsstClsNm=" + rsstClsNm
				+ ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", mode=" + mode + "]";
	}
	
	
	
    
	    
    
	
	
}
