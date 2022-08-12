package ctms.valueObject;

import java.util.List;

/**
 * @author 개발2
 * 
 * 상담관리VO 2021.04.09
 *
 */
public class Cs1000mVO {

	private String corpCd               = ""; // 회사코드
    private String csNo                 = ""; // 상담번호
    private String csDt                	= ""; // 상담일
    private String vendNo               = ""; // 고객사코드
    private String vendName             = ""; // 고객사명
    private String empNo                = ""; // 상담자
    private String empName              = ""; // 상담자명
    private String csCls                = ""; // 상담구분
    private String csClsNm              = ""; // 상담구분명
    private String csCont               = ""; // 상담내용
    private String rcsName              = ""; // 담당자명
    private String rcsTel               = ""; // 연락처
    private String rcsEmail             = ""; // 연락이메일
    private String remk                	= ""; // 비고
    private String branchCd             = ""; // 지사코드
    private String branchName           = ""; // 지사명
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자
    
    private String isAdminType            = ""; // 어드민여부
    private String isRsDrt              = ""; // 책임자
    private String isRsStaff            = ""; // 담당자
    private String isDelCntr            = ""; // 삭제가능여부
    
    public String getIsDelCntr() {
		return isDelCntr;
	}
	public void setIsDelCntr(String isDelCntr) {
		this.isDelCntr = isDelCntr;
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
	public String getIsAdminType() {
		return isAdminType;
	}
	public void setIsAdminType(String isAdminType) {
		this.isAdminType = isAdminType;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getCsNo() {
		return csNo;
	}
	public void setCsNo(String csNo) {
		this.csNo = csNo;
	}
	public String getCsDt() {
		return csDt;
	}
	public void setCsDt(String csDt) {
		this.csDt = csDt;
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
	public String getCsCls() {
		return csCls;
	}
	public void setCsCls(String csCls) {
		this.csCls = csCls;
	}
	public String getCsClsNm() {
		return csClsNm;
	}
	public void setCsClsNm(String csClsNm) {
		this.csClsNm = csClsNm;
	}
	public String getCsCont() {
		return csCont;
	}
	public void setCsCont(String csCont) {
		this.csCont = csCont;
	}
	public String getRcsName() {
		return rcsName;
	}
	public void setRcsName(String rcsName) {
		this.rcsName = rcsName;
	}
	public String getRcsTel() {
		return rcsTel;
	}
	public void setRcsTel(String rcsTel) {
		this.rcsTel = rcsTel;
	}
	public String getRcsEmail() {
		return rcsEmail;
	}
	public void setRcsEmail(String rcsEmail) {
		this.rcsEmail = rcsEmail;
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
	@Override
	public String toString() {
		return "Cs1000mVO [corpCd=" + corpCd + ", csNo=" + csNo + ", csDt=" + csDt + ", vendNo=" + vendNo
				+ ", vendName=" + vendName + ", empNo=" + empNo + ", empName=" + empName + ", csCls=" + csCls
				+ ", csClsNm=" + csClsNm + ", csCont=" + csCont + ", rcsName=" + rcsName + ", rcsTel=" + rcsTel
				+ ", rcsEmail=" + rcsEmail + ", remk=" + remk + ", branchCd=" + branchCd + ", branchName=" + branchName
				+ ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", isAdminType=" + isAdminType
				+ ", isRsDrt=" + isRsDrt + ", isRsStaff=" + isRsStaff + ", isDelCntr=" + isDelCntr + "]";
	}
	
	
	
	
}
