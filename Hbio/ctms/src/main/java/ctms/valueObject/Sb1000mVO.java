package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * @author 개발2
 * 
 * 연구대상자VO 2020.12.03
 *
 */
public class Sb1000mVO {

    private String    corpCd               = ""; // 회사코드
    private String    rsjNo                = ""; // 연구대상자번호
    private String    rsjName              = ""; // 이름
    private String    regDt                = ""; // 등록일자
    private String    brDt                 = ""; // 생년월일
    private String    jregNo               = ""; // 주민등록번호
    private String    acctNo               = ""; // 통장번호
    private String    bankName             = ""; // 은행명칭
    private String    acctName             = ""; // 예금주
    private String    acctCp               = ""; // 통장사본
    private String    postNo               = ""; // 우편번호
    private String    addrMain             = ""; // 기본주소
    private String    addrGita             = ""; // 기타주소
    private String    rsjStCls             = ""; // 연구순응도상태
    private String    rsjStClsNm           = ""; // 연구순응도상태명
    private String    genYn                = ""; // 성별
    private String    genName              = ""; // 성별명    
    private String    hpNo                 = ""; // 휴대폰번호
    private String    email                = ""; // 메일주소
    private String    position             = ""; // 직급
    private String    userId               = ""; // 아이디
    private String    pwNo                 = ""; // 비밀번호
    private String    branchCd             = ""; // 지사코드
    private String    branchName           = ""; // 지사코드명
    private String    spot                 = ""; // 직위
    private String    rloginDt             = ""; // 최근로그인일시
    private String    userSt               = ""; // 사용자상태
    private String    userStNm             = ""; // 사용자상태명
    private String    remk                 = ""; // 비고
    private String    effStdt              = ""; // 유효시작일
    private String    effEndt              = ""; // 유효종료일
    private String    loginFail            = ""; // 로그인실패횟수
    private String    cfmDt 	           = ""; // 관리자확인일자
    private String    cfmYn 	           = ""; // 관리자확인여부 Y 확인 N 미확인
    private String    useRuleYn 	       = ""; // 이용약관동의
    private String    privRuleYn 	       = ""; // 개인정보처리동의
    private String    dataRegdt            = ""; // 등록수정일
    private String    dataRegnt            = ""; // 등록수정자    
    
    private String mobile1 				= "";
	private String mobile2 				= "";
	private String mobile3 				= "";
	
	private String emailId 				= "";
	private String emailAdr 			= "";
	
	private String regNo1 				= "";
	private String regNo2 				= "";
	
	//생년웡일
	private String brDtY 				= "";
	private String brDtM 				= "";
	private String brDtD 				= "";
	
	private String authCd				= ""; // 아이디/비번 찾기 인증코드
	
	private String regLv				= "";
	
	private String hplogin				= ""; //핸드폰로그인 여부 Y 핸드폰로그인 N 아이디비번 로그인
	private String ctrlogin				= ""; //임상시험센터로그인 여부 Y 로그인 N 아님
	
	public String getCtrlogin() {
		return ctrlogin;
	}
	public void setCtrlogin(String ctrlogin) {
		this.ctrlogin = ctrlogin;
	}
	public String getHplogin() {
		return hplogin;
	}
	public void setHplogin(String hplogin) {
		this.hplogin = hplogin;
	}
	public String getRegLv() {
		return regLv;
	}
	public void setRegLv(String regLv) {
		this.regLv = regLv;
	}
	public String getAuthCd() {
		return authCd;
	}
	public void setAuthCd(String authCd) {
		this.authCd = authCd;
	}
	public String getUseRuleYn() {
		return useRuleYn;
	}
	public void setUseRuleYn(String useRuleYn) {
		this.useRuleYn = useRuleYn;
	}
	public String getPrivRuleYn() {
		return privRuleYn;
	}
	public void setPrivRuleYn(String privRuleYn) {
		this.privRuleYn = privRuleYn;
	}
	public String getLoginFail() {
		return loginFail;
	}
	public void setLoginFail(String loginFail) {
		this.loginFail = loginFail;
	}
	public String getCfmDt() {
		return cfmDt;
	}
	public void setCfmDt(String cfmDt) {
		this.cfmDt = cfmDt;
	}
	public String getCfmYn() {
		return cfmYn;
	}
	public void setCfmYn(String cfmYn) {
		this.cfmYn = cfmYn;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getRsjNo() {
		return rsjNo;
	}
	public void setRsjNo(String rsjNo) {
		this.rsjNo = rsjNo;
	}
	public String getRsjName() {
		return rsjName;
	}
	public void setRsjName(String rsjName) {
		this.rsjName = rsjName;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getBrDt() {
		return brDt;
	}
	public void setBrDt(String brDt) {
		this.brDt = brDt;
	}
	public String getJregNo() {
		return jregNo;
	}
	public void setJregNo(String jregNo) {
		this.jregNo = jregNo;
	}
	public String getAcctNo() {
		return acctNo;
	}
	public void setAcctNo(String acctNo) {
		this.acctNo = acctNo;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAcctName() {
		return acctName;
	}
	public void setAcctName(String acctName) {
		this.acctName = acctName;
	}
	public String getAcctCp() {
		return acctCp;
	}
	public void setAcctCp(String acctCp) {
		this.acctCp = acctCp;
	}
	public String getPostNo() {
		return postNo;
	}
	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}
	public String getAddrMain() {
		return addrMain;
	}
	public void setAddrMain(String addrMain) {
		this.addrMain = addrMain;
	}
	public String getAddrGita() {
		return addrGita;
	}
	public void setAddrGita(String addrGita) {
		this.addrGita = addrGita;
	}
	public String getRsjStCls() {
		return rsjStCls;
	}
	public void setRsjStCls(String rsjStCls) {
		this.rsjStCls = rsjStCls;
	}
	public String getRsjStClsNm() {
		return rsjStClsNm;
	}
	public void setRsjStClsNm(String rsjStClsNm) {
		this.rsjStClsNm = rsjStClsNm;
	}
	public String getGenYn() {
		return genYn;
	}
	public void setGenYn(String genYn) {
		this.genYn = genYn;
	}
	public String getGenName() {
		return genName;
	}
	public void setGenName(String genName) {
		this.genName = genName;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPwNo() {
		return pwNo;
	}
	public void setPwNo(String pwNo) {
		this.pwNo = pwNo;
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
	public String getSpot() {
		return spot;
	}
	public void setSpot(String spot) {
		this.spot = spot;
	}
	public String getRloginDt() {
		return rloginDt;
	}
	public void setRloginDt(String rloginDt) {
		this.rloginDt = rloginDt;
	}
	public String getUserSt() {
		return userSt;
	}
	public void setUserSt(String userSt) {
		this.userSt = userSt;
	}
	public String getUserStNm() {
		return userStNm;
	}
	public void setUserStNm(String userStNm) {
		this.userStNm = userStNm;
	}
	public String getRemk() {
		return remk;
	}
	public void setRemk(String remk) {
		this.remk = remk;
	}
	public String getEffStdt() {
		return effStdt;
	}
	public void setEffStdt(String effStdt) {
		this.effStdt = effStdt;
	}
	public String getEffEndt() {
		return effEndt;
	}
	public void setEffEndt(String effEndt) {
		this.effEndt = effEndt;
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
	public String getMobile1() {
		return mobile1;
	}
	public void setMobile1(String mobile1) {
		this.mobile1 = mobile1;
	}
	public String getMobile2() {
		return mobile2;
	}
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}
	public String getMobile3() {
		return mobile3;
	}
	public void setMobile3(String mobile3) {
		this.mobile3 = mobile3;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getEmailAdr() {
		return emailAdr;
	}
	public void setEmailAdr(String emailAdr) {
		this.emailAdr = emailAdr;
	}
	public String getRegNo1() {
		return regNo1;
	}
	public void setRegNo1(String regNo1) {
		this.regNo1 = regNo1;
	}
	public String getRegNo2() {
		return regNo2;
	}
	public void setRegNo2(String regNo2) {
		this.regNo2 = regNo2;
	}
	public String getBrDtY() {
		return brDtY;
	}
	public void setBrDtY(String brDtY) {
		this.brDtY = brDtY;
	}
	public String getBrDtM() {
		return brDtM;
	}
	public void setBrDtM(String brDtM) {
		this.brDtM = brDtM;
	}
	public String getBrDtD() {
		return brDtD;
	}
	public void setBrDtD(String brDtD) {
		this.brDtD = brDtD;
	}
	@Override
	public String toString() {
		return "Sb1000mVO [corpCd=" + corpCd + ", rsjNo=" + rsjNo + ", rsjName=" + rsjName + ", regDt=" + regDt
				+ ", brDt=" + brDt + ", jregNo=" + jregNo + ", acctNo=" + acctNo + ", bankName=" + bankName
				+ ", acctName=" + acctName + ", acctCp=" + acctCp + ", postNo=" + postNo + ", addrMain=" + addrMain
				+ ", addrGita=" + addrGita + ", rsjStCls=" + rsjStCls + ", rsjStClsNm=" + rsjStClsNm + ", genYn="
				+ genYn + ", genName=" + genName + ", hpNo=" + hpNo + ", email=" + email + ", position=" + position
				+ ", userId=" + userId + ", pwNo=" + pwNo + ", branchCd=" + branchCd + ", branchName=" + branchName
				+ ", spot=" + spot + ", rloginDt=" + rloginDt + ", userSt=" + userSt + ", userStNm=" + userStNm
				+ ", remk=" + remk + ", effStdt=" + effStdt + ", effEndt=" + effEndt + ", loginFail=" + loginFail
				+ ", cfmDt=" + cfmDt + ", cfmYn=" + cfmYn + ", useRuleYn=" + useRuleYn + ", privRuleYn=" + privRuleYn
				+ ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", mobile1=" + mobile1 + ", mobile2="
				+ mobile2 + ", mobile3=" + mobile3 + ", emailId=" + emailId + ", emailAdr=" + emailAdr + ", regNo1="
				+ regNo1 + ", regNo2=" + regNo2 + ", brDtY=" + brDtY + ", brDtM=" + brDtM + ", brDtD=" + brDtD
				+ ", authCd=" + authCd + ", regLv=" + regLv + ", hplogin=" + hplogin + ", ctrlogin=" + ctrlogin + "]";
	}

	
	
		
		
	
}
