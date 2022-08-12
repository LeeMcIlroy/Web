package ctms.valueObject;

import java.util.List;

public class Cr2100mVO {
    private String corpCd               = ""; // 회사코드
    private String tempNo               = ""; // CRF템플릿번호
    private String tempCd               = ""; // CRF템플릿코드
    private String tempNm               = ""; // 템플릿 명
    private String regDt                = ""; // 등록일자 
    private String tempType             = ""; // 템플릿 구분
    private String tempTypeNm           = ""; // 템플릿 구분명
    private String empNo               	= ""; // 입금담당자
	private String empName              = ""; // 입금담당자명
    private String useYn                = ""; // 사용여부
    private String stDate               = ""; // 사용시작일
    private String edDate               = ""; // 사용종료일
    private String branchCd             = ""; // 지사코드
    private String branchName           = ""; // 지사명
    private String remk           		= ""; // 비고
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자
    
    private String isAdminType            = ""; // 어드민여부
    private String isRsDrt              = ""; // 책임자
    private String isRsStaff            = ""; // 담당자
    private String isDelCntr            = ""; // 삭제가능여부
    
    private String tempNo1              = ""; // 템플릿고유번호
    private String upageCnt             = ""; // 구성쪽수 2021.6.21 추가 
    private String mkType              	= ""; // 생성구분 1 템플릿관리 2 CRF설정    
    private String srType              	= ""; // 피부자극 평가주기 1 30분후 2 24시간후
        
	public String getSrType() {
		return srType;
	}
	public void setSrType(String srType) {
		this.srType = srType;
	}
	public String getMkType() {
		return mkType;
	}
	public void setMkType(String mkType) {
		this.mkType = mkType;
	}
	public String getTempCd() {
		return tempCd;
	}
	public void setTempCd(String tempCd) {
		this.tempCd = tempCd;
	}
	public String getUpageCnt() {
		return upageCnt;
	}
	public void setUpageCnt(String upageCnt) {
		this.upageCnt = upageCnt;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getTempNo1() {
		return tempNo1;
	}
	public void setTempNo1(String tempNo1) {
		this.tempNo1 = tempNo1;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getTempNo() {
		return tempNo;
	}
	public void setTempNo(String tempNo) {
		this.tempNo = tempNo;
	}
	public String getTempNm() {
		return tempNm;
	}
	public void setTempNm(String tempNm) {
		this.tempNm = tempNm;
	}
	public String getTempType() {
		return tempType;
	}
	public void setTempType(String tempType) {
		this.tempType = tempType;
	}
	public String getTempTypeNm() {
		return tempTypeNm;
	}
	public void setTempTypeNm(String tempTypeNm) {
		this.tempTypeNm = tempTypeNm;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getStDate() {
		return stDate;
	}
	public void setStDate(String stDate) {
		this.stDate = stDate;
	}
	public String getEdDate() {
		return edDate;
	}
	public void setEdDate(String edDate) {
		this.edDate = edDate;
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
		return "Cr2100mVO [corpCd=" + corpCd + ", tempNo=" + tempNo + ", tempCd=" + tempCd + ", tempNm=" + tempNm
				+ ", regDt=" + regDt + ", tempType=" + tempType + ", tempTypeNm=" + tempTypeNm + ", empNo=" + empNo
				+ ", empName=" + empName + ", useYn=" + useYn + ", stDate=" + stDate + ", edDate=" + edDate
				+ ", branchCd=" + branchCd + ", branchName=" + branchName + ", remk=" + remk + ", dataRegdt="
				+ dataRegdt + ", dataRegnt=" + dataRegnt + ", isAdminType=" + isAdminType + ", isRsDrt=" + isRsDrt
				+ ", isRsStaff=" + isRsStaff + ", isDelCntr=" + isDelCntr + ", tempNo1=" + tempNo1 + ", upageCnt="
				+ upageCnt + ", mkType=" + mkType + ", srType=" + srType + "]";
	}
	
	
    
}