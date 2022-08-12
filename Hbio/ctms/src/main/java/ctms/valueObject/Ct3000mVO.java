package ctms.valueObject;

import java.util.List;

/**
 * @author 개발2
 * 
 * 자산관리VO 2021.04.26
 *
 */
public class Ct3000mVO {
	
	private String corpCd               = ""; // 회사코드
    private String astNo                = ""; // 자산번호
    private String astCd                = ""; // 자산코드
    private String astCls               = ""; // 자산분류
    private String astClsNm             = ""; // 자산분류명
    private String astName              = ""; // 자산명
    private String fctvName             = ""; // 제조사
    private String pchvName             = ""; // 구매처
    private String mngName              = ""; // 구매처담당자
    private String pchvTel          	= ""; // 구매처연락처
    private String pchvEmail          	= ""; // 구매처이메일
    private String empNo                = ""; // 책임자
    private String empName              = ""; // 책임자명
    private String pchAmt               = ""; // 구매가격
    private String pchAmtvt             = ""; // 구매가격부가세
    private String pchTamt              = ""; // 구매가격합계
    private String pchDt                = ""; // 구매일
    private String disDt                = ""; // 폐기일
    private String sNum                 = ""; // 시리얼번호
    private String remk                	= ""; // 비고
    private String branchCd             = ""; // 지사코드
    private String branchName           = ""; // 지사명
    private String useYn     		    = ""; // 사용여부
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자
    
    private String isAdminType            = ""; // 어드민여부
    private String isRsDrt              = ""; // 책임자
    private String isRsStaff            = ""; // 담당자
    private String isDelCntr            = ""; // 삭제가능여부
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getAstNo() {
		return astNo;
	}
	public void setAstNo(String astNo) {
		this.astNo = astNo;
	}
	public String getAstCd() {
		return astCd;
	}
	public void setAstCd(String astCd) {
		this.astCd = astCd;
	}
	public String getAstCls() {
		return astCls;
	}
	public void setAstCls(String astCls) {
		this.astCls = astCls;
	}
	public String getAstClsNm() {
		return astClsNm;
	}
	public void setAstClsNm(String astClsNm) {
		this.astClsNm = astClsNm;
	}
	public String getAstName() {
		return astName;
	}
	public void setAstName(String astName) {
		this.astName = astName;
	}
	public String getFctvName() {
		return fctvName;
	}
	public void setFctvName(String fctvName) {
		this.fctvName = fctvName;
	}
	public String getPchvName() {
		return pchvName;
	}
	public void setPchvName(String pchvName) {
		this.pchvName = pchvName;
	}
	public String getMngName() {
		return mngName;
	}
	public void setMngName(String mngName) {
		this.mngName = mngName;
	}
	public String getPchvTel() {
		return pchvTel;
	}
	public void setPchvTel(String pchvTel) {
		this.pchvTel = pchvTel;
	}
	public String getPchvEmail() {
		return pchvEmail;
	}
	public void setPchvEmail(String pchvEmail) {
		this.pchvEmail = pchvEmail;
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
	public String getPchAmt() {
		return pchAmt;
	}
	public void setPchAmt(String pchAmt) {
		this.pchAmt = pchAmt;
	}
	public String getPchAmtvt() {
		return pchAmtvt;
	}
	public void setPchAmtvt(String pchAmtvt) {
		this.pchAmtvt = pchAmtvt;
	}
	public String getPchTamt() {
		return pchTamt;
	}
	public void setPchTamt(String pchTamt) {
		this.pchTamt = pchTamt;
	}
	public String getPchDt() {
		return pchDt;
	}
	public void setPchDt(String pchDt) {
		this.pchDt = pchDt;
	}
	public String getDisDt() {
		return disDt;
	}
	public void setDisDt(String disDt) {
		this.disDt = disDt;
	}
	public String getsNum() {
		return sNum;
	}
	public void setsNum(String sNum) {
		this.sNum = sNum;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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
		return "Ct3000mVO [corpCd=" + corpCd + ", astNo=" + astNo + ", astCd=" + astCd + ", astCls=" + astCls
				+ ", astClsNm=" + astClsNm + ", astName=" + astName + ", fctvName=" + fctvName + ", pchvName="
				+ pchvName + ", mngName=" + mngName + ", pchvTel=" + pchvTel + ", pchvEmail=" + pchvEmail + ", empNo="
				+ empNo + ", empName=" + empName + ", pchAmt=" + pchAmt + ", pchAmtvt=" + pchAmtvt + ", pchTamt="
				+ pchTamt + ", pchDt=" + pchDt + ", disDt=" + disDt + ", sNum=" + sNum + ", remk=" + remk
				+ ", branchCd=" + branchCd + ", branchName=" + branchName + ", useYn=" + useYn + ", dataRegdt="
				+ dataRegdt + ", dataRegnt=" + dataRegnt + ", isAdminType=" + isAdminType + ", isRsDrt=" + isRsDrt
				+ ", isRsStaff=" + isRsStaff + ", isDelCntr=" + isDelCntr + "]";
	}
	    
		    
	
}
