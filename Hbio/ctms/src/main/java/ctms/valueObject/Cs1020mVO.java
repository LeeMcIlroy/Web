package ctms.valueObject;

import java.util.List;

/**
 * @author 개발2
 * 
 * 상담관리VO 2021.04.09
 *
 */
public class Cs1020mVO {

	private String corpCd               = ""; // 회사코드            
	private String opNo               	= ""; // 견적번호              
	private String opCd               	= ""; // 견적코드                          
	private String opDt               	= ""; // 견적일
	private String vendNo               = ""; // 거래처번호
	private String vendName             = ""; // 거래처명
	private String empNo               	= ""; // 견적담당자
	private String empName              = ""; // 견적담당자명
	private String opCls               	= ""; // 견적분야
	private String opClsNm              = ""; // 견적분야명	              
	private String opName               = ""; // 견적명	              
	private String rsInfo               = ""; // 연구대상자
	private String rsMscnt              = ""; // 연구인원
	private String rsTerm               = ""; // 연구기간				  
	private String rsPtc               	= ""; // 연구방법				  
	private String expDt               	= ""; // 유효기간				  
	private String rsPay               	= ""; // 연구비
	private String rsPayvt              = ""; // 부가세
	private String rsTpay               = ""; // 총연구비				  
	private String vmngName             = ""; // 수신담당자명				  
	private String vmngOrg              = ""; // 수신담당자부서명
	private String vmnghpNo             = ""; // 수신담당자연락처	              
	private String vmngEmail            = ""; // 수신담당자연락처
	private String remk               	= ""; // 비고
	private String branchCd             = ""; // 지사코드
	private String branchName           = ""; // 지사명
	private String dataRegdt            = ""; // 등록수정일         
	private String dataRegnt            = ""; // 등록수정자
	
	private String isAdminType            = ""; // 어드민여부
    private String isRsDrt              = ""; // 책임자
    private String isRsStaff            = ""; // 담당자
    private String isDelCntr            = ""; // 삭제가능여부
    
    private String opNo1               	= ""; // 견적번호고유번호
    
	public String getOpNo1() {
		return opNo1;
	}
	public void setOpNo1(String opNo1) {
		this.opNo1 = opNo1;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getOpNo() {
		return opNo;
	}
	public void setOpNo(String opNo) {
		this.opNo = opNo;
	}
	public String getOpCd() {
		return opCd;
	}
	public void setOpCd(String opCd) {
		this.opCd = opCd;
	}
	public String getOpDt() {
		return opDt;
	}
	public void setOpDt(String opDt) {
		this.opDt = opDt;
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
	public String getOpCls() {
		return opCls;
	}
	public void setOpCls(String opCls) {
		this.opCls = opCls;
	}
	public String getOpClsNm() {
		return opClsNm;
	}
	public void setOpClsNm(String opClsNm) {
		this.opClsNm = opClsNm;
	}
	public String getOpName() {
		return opName;
	}
	public void setOpName(String opName) {
		this.opName = opName;
	}
	public String getRsInfo() {
		return rsInfo;
	}
	public void setRsInfo(String rsInfo) {
		this.rsInfo = rsInfo;
	}
	public String getRsMscnt() {
		return rsMscnt;
	}
	public void setRsMscnt(String rsMscnt) {
		this.rsMscnt = rsMscnt;
	}
	public String getRsTerm() {
		return rsTerm;
	}
	public void setRsTerm(String rsTerm) {
		this.rsTerm = rsTerm;
	}
	public String getRsPtc() {
		return rsPtc;
	}
	public void setRsPtc(String rsPtc) {
		this.rsPtc = rsPtc;
	}
	public String getExpDt() {
		return expDt;
	}
	public void setExpDt(String expDt) {
		this.expDt = expDt;
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
	public String getVmngName() {
		return vmngName;
	}
	public void setVmngName(String vmngName) {
		this.vmngName = vmngName;
	}
	public String getVmngOrg() {
		return vmngOrg;
	}
	public void setVmngOrg(String vmngOrg) {
		this.vmngOrg = vmngOrg;
	}
	public String getVmnghpNo() {
		return vmnghpNo;
	}
	public void setVmnghpNo(String vmnghpNo) {
		this.vmnghpNo = vmnghpNo;
	}
	public String getVmngEmail() {
		return vmngEmail;
	}
	public void setVmngEmail(String vmngEmail) {
		this.vmngEmail = vmngEmail;
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
		return "Cs1020mVO [corpCd=" + corpCd + ", opNo=" + opNo + ", opCd=" + opCd + ", opDt=" + opDt + ", vendNo="
				+ vendNo + ", vendName=" + vendName + ", empNo=" + empNo + ", empName=" + empName + ", opCls=" + opCls
				+ ", opClsNm=" + opClsNm + ", opName=" + opName + ", rsInfo=" + rsInfo + ", rsMscnt=" + rsMscnt
				+ ", rsTerm=" + rsTerm + ", rsPtc=" + rsPtc + ", expDt=" + expDt + ", rsPay=" + rsPay + ", rsPayvt="
				+ rsPayvt + ", rsTpay=" + rsTpay + ", vmngName=" + vmngName + ", vmngOrg=" + vmngOrg + ", vmnghpNo="
				+ vmnghpNo + ", vmngEmail=" + vmngEmail + ", remk=" + remk + ", branchCd=" + branchCd + ", branchName="
				+ branchName + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", isAdminType=" + isAdminType
				+ ", isRsDrt=" + isRsDrt + ", isRsStaff=" + isRsStaff + ", isDelCntr=" + isDelCntr + ", opNo1=" + opNo1
				+ "]";
	}
	
}
