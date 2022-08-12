package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class Ct1040mVO {

	// CT1040M 로그인접속정보
	private String corpCd               = ""; // 회사코드
    private String userId               = ""; // 사용자아이디
    private String empNo                = ""; // 구성원번호
    private String empName              = ""; // 구성원이름
    private String loginType            = ""; // 로그인타입 CM1230 사용
    private String loginTypeNm          = ""; // 로그인타입명 
    private String acceIp               = ""; // 접속아이피
    private String acceDt               = ""; // 접속일자(일자 시분초)
    private String branchCd             = ""; // 지사코드 
    private String branchNm             = ""; // 지사명
    
	public String getLoginTypeNm() {
		return loginTypeNm;
	}
	public void setLoginTypeNm(String loginTypeNm) {
		this.loginTypeNm = loginTypeNm;
	}
	public String getBranchCd() {
		return branchCd;
	}
	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
	}
	public String getBranchNm() {
		return branchNm;
	}
	public void setBranchNm(String branchNm) {
		this.branchNm = branchNm;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	public String getLoginType() {
		return loginType;
	}
	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}
	public String getAcceIp() {
		return acceIp;
	}
	public void setAcceIp(String acceIp) {
		this.acceIp = acceIp;
	}
	public String getAcceDt() {
		return acceDt;
	}
	public void setAcceDt(String acceDt) {
		this.acceDt = acceDt;
	}
	@Override
	public String toString() {
		return "Ct1040mVO [corpCd=" + corpCd + ", userId=" + userId + ", empNo=" + empNo + ", empName=" + empName
				+ ", loginType=" + loginType + ", loginTypeNm=" + loginTypeNm + ", acceIp=" + acceIp + ", acceDt="
				+ acceDt + ", branchCd=" + branchCd + ", branchNm=" + branchNm + "]";
	}
	
	
	
}
