package ctms.valueObject;

import java.util.List;

/**
 * @author 개발2
 * 
 * 상담관리VO 2021.04.09
 *
 */
public class Cs2000mVO {
	
	private String corpCd               = ""; // 회사코드            
	private String ctrtNo               = ""; // 계약번호              
	private String ctrtCd               = ""; // 계약코드                          
	private String ctrtDt               = ""; // 계약일
	private String ctrtCls              = ""; // 계약분야
	private String ctrtClsNm            = ""; // 계약분야명	
	private String vendNo               = ""; // 거래처번호
	private String vendName             = ""; // 거래처명
	private String empNo               	= ""; // 계약담당자
	private String empName              = ""; // 계약담당자명
	private String ctrtStdt             = ""; // 계약시작일
	private String ctrtEndt             = ""; // 계약종료일
	private String opNo             	= ""; // 견적번호
	private String opCd             	= ""; // 견적코드
	private String rsPay               	= ""; // 연구비
	private String rsPayvt              = ""; // 부가세
	private String rsTpay               = ""; // 총연구비				  
	private String inCond               = ""; // 수금조건
	private String esDt               	= ""; // 이메일발송일자
	private String psDt               	= ""; // 우편발송일자
	private String rtYn               	= ""; // 회신상태
	private String ctrtCont             = ""; // 계약내용
	private String vmngName             = ""; // 수신담당자명				  
	private String vmngOrg              = ""; // 수신담당자부서명
	private String vmnghpNo             = ""; // 수신담당자연락처	              
	private String vmngEmail            = ""; // 수신담당자연락처
	private String ctrtName             = ""; // 계약명	
	private String remk               	= ""; // 비고
	private String branchCd             = ""; // 지사코드
	private String branchName           = ""; // 지사명
	private String dataRegdt            = ""; // 등록수정일         
	private String dataRegnt            = ""; // 등록수정자
	
	private String inTamt               = ""; // 누적입금액
	private String inBamt               = ""; // 잔금
	
	private String opName               = ""; // 견적명
	private String opDt               	= ""; // 견적일
	private String opRsPay              = ""; // 견적연구비
	private String opRsPayvt            = ""; // 견적부가세
	private String opRsTpay             = ""; // 견적합계
	
	private String isAdminType            = ""; // 어드민여부
    private String isRsDrt              = ""; // 책임자
    private String isRsStaff            = ""; // 담당자
    private String isDelCntr            = ""; // 삭제가능여부
    
    private String ctrtNo1              = ""; // 계약고유번호
    private String inSq              	= ""; // 입금차수
    
    

	public String getInSq() {
		return inSq;
	}

	public void setInSq(String inSq) {
		this.inSq = inSq;
	}

	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
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

	public String getCtrtDt() {
		return ctrtDt;
	}

	public void setCtrtDt(String ctrtDt) {
		this.ctrtDt = ctrtDt;
	}

	public String getCtrtCls() {
		return ctrtCls;
	}

	public void setCtrtCls(String ctrtCls) {
		this.ctrtCls = ctrtCls;
	}

	public String getCtrtClsNm() {
		return ctrtClsNm;
	}

	public void setCtrtClsNm(String ctrtClsNm) {
		this.ctrtClsNm = ctrtClsNm;
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

	public String getCtrtStdt() {
		return ctrtStdt;
	}

	public void setCtrtStdt(String ctrtStdt) {
		this.ctrtStdt = ctrtStdt;
	}

	public String getCtrtEndt() {
		return ctrtEndt;
	}

	public void setCtrtEndt(String ctrtEndt) {
		this.ctrtEndt = ctrtEndt;
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

	public String getInCond() {
		return inCond;
	}

	public void setInCond(String inCond) {
		this.inCond = inCond;
	}

	public String getEsDt() {
		return esDt;
	}

	public void setEsDt(String esDt) {
		this.esDt = esDt;
	}

	public String getPsDt() {
		return psDt;
	}

	public void setPsDt(String psDt) {
		this.psDt = psDt;
	}

	public String getRtYn() {
		return rtYn;
	}

	public void setRtYn(String rtYn) {
		this.rtYn = rtYn;
	}

	public String getCtrtCont() {
		return ctrtCont;
	}

	public void setCtrtCont(String ctrtCont) {
		this.ctrtCont = ctrtCont;
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

	public String getCtrtName() {
		return ctrtName;
	}

	public void setCtrtName(String ctrtName) {
		this.ctrtName = ctrtName;
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

	public String getOpName() {
		return opName;
	}

	public void setOpName(String opName) {
		this.opName = opName;
	}

	public String getOpDt() {
		return opDt;
	}

	public void setOpDt(String opDt) {
		this.opDt = opDt;
	}

	public String getOpRsPay() {
		return opRsPay;
	}

	public void setOpRsPay(String opRsPay) {
		this.opRsPay = opRsPay;
	}

	public String getOpRsPayvt() {
		return opRsPayvt;
	}

	public void setOpRsPayvt(String opRsPayvt) {
		this.opRsPayvt = opRsPayvt;
	}

	public String getOpRsTpay() {
		return opRsTpay;
	}

	public void setOpRsTpay(String opRsTpay) {
		this.opRsTpay = opRsTpay;
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

	public String getCtrtNo1() {
		return ctrtNo1;
	}

	public void setCtrtNo1(String ctrtNo1) {
		this.ctrtNo1 = ctrtNo1;
	}

	@Override
	public String toString() {
		return "Cs2000mVO [corpCd=" + corpCd + ", ctrtNo=" + ctrtNo + ", ctrtCd=" + ctrtCd + ", ctrtDt=" + ctrtDt
				+ ", ctrtCls=" + ctrtCls + ", ctrtClsNm=" + ctrtClsNm + ", vendNo=" + vendNo + ", vendName=" + vendName
				+ ", empNo=" + empNo + ", empName=" + empName + ", ctrtStdt=" + ctrtStdt + ", ctrtEndt=" + ctrtEndt
				+ ", opNo=" + opNo + ", opCd=" + opCd + ", rsPay=" + rsPay + ", rsPayvt=" + rsPayvt + ", rsTpay="
				+ rsTpay + ", inCond=" + inCond + ", esDt=" + esDt + ", psDt=" + psDt + ", rtYn=" + rtYn + ", ctrtCont="
				+ ctrtCont + ", vmngName=" + vmngName + ", vmngOrg=" + vmngOrg + ", vmnghpNo=" + vmnghpNo
				+ ", vmngEmail=" + vmngEmail + ", ctrtName=" + ctrtName + ", remk=" + remk + ", branchCd=" + branchCd
				+ ", branchName=" + branchName + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", inTamt="
				+ inTamt + ", inBamt=" + inBamt + ", opName=" + opName + ", opDt=" + opDt + ", opRsPay=" + opRsPay
				+ ", opRsPayvt=" + opRsPayvt + ", opRsTpay=" + opRsTpay + ", isAdminType=" + isAdminType + ", isRsDrt="
				+ isRsDrt + ", isRsStaff=" + isRsStaff + ", isDelCntr=" + isDelCntr + ", ctrtNo1=" + ctrtNo1 + ", inSq="
				+ inSq + "]";
	}

	
	
    	
	
	
}
