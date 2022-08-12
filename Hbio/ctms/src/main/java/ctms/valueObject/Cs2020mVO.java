package ctms.valueObject;

import java.util.List;

/**
 * @author 개발2
 * 
 * 입금관리VO 2021.04.09
 *
 */
public class Cs2020mVO {
	
	private String corpCd               = ""; // 회사코드            
	private String inNo  	            = ""; // 입금번호              
	private String ctrtNo               = ""; // 계약번호
	private String ctrtCd               = ""; // 계약코드
	private String ctrtName             = ""; // 계약명
	private String inSq               	= ""; // 입금차수
	private String inAmt               	= ""; // 입금액
	private String inTamt               = ""; // 누적입금액
	private String inBamt               = ""; // 잔금
	private String inDt               	= ""; // 입금일
	private String reciDt               = ""; // 세금계산서일
	private String vendNo               = ""; // 거래처번호
	private String vendName             = ""; // 거래처명
	private String empNo               	= ""; // 입금담당자
	private String empName              = ""; // 입금담당자명
	private String remk               	= ""; // 비고
	private String branchCd             = ""; // 지사코드
	private String branchName           = ""; // 지사명
	private String dataRegdt            = ""; // 등록수정일         
	private String dataRegnt            = ""; // 등록수정자
	
	private String isAdminType            = ""; // 어드민여부
    private String isRsDrt              = ""; // 책임자
    private String isRsStaff            = ""; // 담당자
    private String isDelCntr            = ""; // 삭제가능여부
    
    private String rsPay            	= ""; // 연구비
    private String rsPayvt            	= ""; // 부가세
    private String rsTpay            	= ""; // 합계
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getInNo() {
		return inNo;
	}
	public void setInNo(String inNo) {
		this.inNo = inNo;
	}
	public String getCtrtNo() {
		return ctrtNo;
	}
	public void setCtrtNo(String ctrtNo) {
		this.ctrtNo = ctrtNo;
	}
	public String getCtrtCd() {
		return ctrtCd;
	}
	public void setCtrtCd(String ctrtCd) {
		this.ctrtCd = ctrtCd;
	}
	public String getCtrtName() {
		return ctrtName;
	}
	public void setCtrtName(String ctrtName) {
		this.ctrtName = ctrtName;
	}
	public String getInSq() {
		return inSq;
	}
	public void setInSq(String inSq) {
		this.inSq = inSq;
	}
	public String getInAmt() {
		return inAmt;
	}
	public void setInAmt(String inAmt) {
		this.inAmt = inAmt;
	}
	public String getInTamt() {
		return inTamt;
	}
	public void setInTamt(String inTamt) {
		this.inTamt = inTamt;
	}
	public String getInBamt() {
		return inBamt;
	}
	public void setInBamt(String inBamt) {
		this.inBamt = inBamt;
	}
	public String getInDt() {
		return inDt;
	}
	public void setInDt(String inDt) {
		this.inDt = inDt;
	}
	public String getReciDt() {
		return reciDt;
	}
	public void setReciDt(String reciDt) {
		this.reciDt = reciDt;
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
	public String getRsPay() {
		return rsPay;
	}
	public void setRsPay(String rsPay) {
		this.rsPay = rsPay;
	}
	public String getRsPayvt() {
		return rsPayvt;
	}
	public void setRsPayvt(String rsPayvt) {
		this.rsPayvt = rsPayvt;
	}
	public String getRsTpay() {
		return rsTpay;
	}
	public void setRsTpay(String rsTpay) {
		this.rsTpay = rsTpay;
	}
	@Override
	public String toString() {
		return "Cs2020mVO [corpCd=" + corpCd + ", inNo=" + inNo + ", ctrtNo=" + ctrtNo + ", ctrtCd=" + ctrtCd
				+ ", ctrtName=" + ctrtName + ", inSq=" + inSq + ", inAmt=" + inAmt + ", inTamt=" + inTamt + ", inBamt="
				+ inBamt + ", inDt=" + inDt + ", reciDt=" + reciDt + ", vendNo=" + vendNo + ", vendName=" + vendName
				+ ", empNo=" + empNo + ", empName=" + empName + ", remk=" + remk + ", branchCd=" + branchCd
				+ ", branchName=" + branchName + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt
				+ ", isAdminType=" + isAdminType + ", isRsDrt=" + isRsDrt + ", isRsStaff=" + isRsStaff + ", isDelCntr="
				+ isDelCntr + ", rsPay=" + rsPay + ", rsPayvt=" + rsPayvt + ", rsTpay=" + rsTpay + "]";
	}
    
        	
	
	
}
