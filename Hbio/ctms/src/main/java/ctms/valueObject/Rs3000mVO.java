package ctms.valueObject;

/**
 * @author 개발2
 * 
 * 시험제품VO 2021.04.13
 *
 */

public class Rs3000mVO {

	private String corpCd               = ""; // 회사코드
    private String corpName             = ""; // 회사코드명
    private String itemNo	            = ""; // 시험제품번호
    private String rsNo                 = ""; // 연구과제번호
    private String rsCd                 = ""; // 연구과제코드
    private String rsName               = ""; // 연구과제번호명
    private String itemName             = ""; // 제품명
    private String itemCls             	= ""; // 제품구분
    private String itemClsNm            = ""; // 제품구분명
    private String empNo            	= ""; // 제품담당자
    private String empName            	= ""; // 담당자명
    private String vendNo             	= ""; // 거래처번호
    private String vendName             = ""; // 거래처명
    private String inhDt             	= ""; // 입고일
    private String outDt             	= ""; // 출고일
    private String sendDt             	= ""; // 발송일
    private String reDt             	= ""; // 수거일
    private String reYn             	= ""; // 수거여부 Y 수거 N 미수거
    private String dispoDt             	= ""; // 폐기일
    private String remk             	= ""; // 비고
    private String branchCd             = ""; // 지사코드
    private String branchName           = ""; // 지사명
    private String dataRegdt            = ""; // 등록수정일자
    private String dataRegnt            = ""; // 등록수정자
    
    private String isAdminType          = ""; // 어드민여부
    private String isRsDrt              = ""; // 책임자
    private String isRsStaff            = ""; // 담당자
    private String isDelCntr            = ""; // 삭제가능여부
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
	public String getItemNo() {
		return itemNo;
	}
	public void setItemNo(String itemNo) {
		this.itemNo = itemNo;
	}
	public String getRsNo() {
		return rsNo;
	}
	public void setRsNo(String rsNo) {
		this.rsNo = rsNo;
	}
	public String getRsCd() {
		return rsCd;
	}
	public void setRsCd(String rsCd) {
		this.rsCd = rsCd;
	}
	public String getRsName() {
		return rsName;
	}
	public void setRsName(String rsName) {
		this.rsName = rsName;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemCls() {
		return itemCls;
	}
	public void setItemCls(String itemCls) {
		this.itemCls = itemCls;
	}
	public String getItemClsNm() {
		return itemClsNm;
	}
	public void setItemClsNm(String itemClsNm) {
		this.itemClsNm = itemClsNm;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getVendNo() {
		return vendNo;
	}
	public void setVendNo(String vendNo) {
		this.vendNo = vendNo;
	}
	public String getVendName() {
		return vendName;
	}
	public void setVendName(String vendName) {
		this.vendName = vendName;
	}
	public String getInhDt() {
		return inhDt;
	}
	public void setInhDt(String inhDt) {
		this.inhDt = inhDt;
	}
	public String getOutDt() {
		return outDt;
	}
	public void setOutDt(String outDt) {
		this.outDt = outDt;
	}
	public String getSendDt() {
		return sendDt;
	}
	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
	}
	public String getReDt() {
		return reDt;
	}
	public void setReDt(String reDt) {
		this.reDt = reDt;
	}
	public String getReYn() {
		return reYn;
	}
	public void setReYn(String reYn) {
		this.reYn = reYn;
	}
	public String getDispoDt() {
		return dispoDt;
	}
	public void setDispoDt(String dispoDt) {
		this.dispoDt = dispoDt;
	}
	public String getRemk() {
		return remk;
	}
	public void setRemk(String remk) {
		this.remk = remk;
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
	public String getIsAdminType() {
		return isAdminType;
	}
	public void setIsAdminType(String isAdminType) {
		this.isAdminType = isAdminType;
	}
	public String getIsRsDrt() {
		return isRsDrt;
	}
	public void setIsRsDrt(String isRsDrt) {
		this.isRsDrt = isRsDrt;
	}
	public String getIsRsStaff() {
		return isRsStaff;
	}
	public void setIsRsStaff(String isRsStaff) {
		this.isRsStaff = isRsStaff;
	}
	public String getIsDelCntr() {
		return isDelCntr;
	}
	public void setIsDelCntr(String isDelCntr) {
		this.isDelCntr = isDelCntr;
	}
	@Override
	public String toString() {
		return "Rs3000mVO [corpCd=" + corpCd + ", corpName=" + corpName + ", itemNo=" + itemNo + ", rsNo=" + rsNo
				+ ", rsCd=" + rsCd + ", rsName=" + rsName + ", itemName=" + itemName + ", itemCls=" + itemCls
				+ ", itemClsNm=" + itemClsNm + ", empNo=" + empNo + ", empName=" + empName + ", vendNo=" + vendNo
				+ ", vendName=" + vendName + ", inhDt=" + inhDt + ", outDt=" + outDt + ", sendDt=" + sendDt + ", reDt="
				+ reDt + ", reYn=" + reYn + ", dispoDt=" + dispoDt + ", remk=" + remk + ", branchCd=" + branchCd
				+ ", branchName=" + branchName + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt
				+ ", isAdminType=" + isAdminType + ", isRsDrt=" + isRsDrt + ", isRsStaff=" + isRsStaff + ", isDelCntr="
				+ isDelCntr + "]";
	}
	
   

    
	
	
		
}
