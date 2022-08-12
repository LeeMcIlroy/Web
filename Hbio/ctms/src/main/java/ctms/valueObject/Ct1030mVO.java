package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class Ct1030mVO {

	// 테이블 변경 CT1010M -> CT1030M
	private String corpCd               = ""; // 회사코드
    private String empNo                = ""; // 구성원번호 - 채번
    private String empName              = ""; // 구성원이름
    private String orgNo                = ""; // 소속부서
    private String orgNm                = ""; // 소속부서명
    private String incDt                = ""; // 입사일자
    private String hpNo                 = ""; // 휴대폰번호
    private String email                = ""; // 메일주소
    private String position             = ""; // 직급
    private String empCls               = ""; // 사원구분
    private String empClsNm             = ""; // 사원구분명
    private String userId               = ""; // 아이디
    private String pwNo                 = ""; // 비밀번호
    private String branchCd             = ""; // 지사코드
    private String branchName           = ""; // 지사코드명
    private String spot                 = ""; // 직위
    private String rsCls                = ""; // 연구자구분
    private String rsClsNm              = ""; // 연구자구분명
    private String rsAuthCls            = ""; // 연구권한
    private String rsAuthClsNm          = ""; // 연구권한명
    private String rloginDt             = ""; // 최근로그인일시
    private String userSt               = ""; // 사용자상태
    private String userStNm             = ""; // 사용자상태명
    private String effStdt              = ""; // 유효시작일
    private String effEndt              = ""; // 유효종료일
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자
    
    //접속권한
    private String loginFail       	    = ""; // 로그인실패수
    private String acceIp       	    = ""; // 접속허용IP
    private String ipAllYn       	    = ""; // 접속IP권한 Y 전체허용 N ip체크
    private String adminType       	    = ""; // 1 어드민권한  2 일반사용자권한
    
    //메뉴권한
    private String rsmg       	    = ""; // 연구과제관리(메뉴)
    private String ecrf       	    = ""; // eCRF관리(메뉴)
    private String rsjt       	    = ""; // 피험자관리(메뉴)
    private String extr       	    = ""; // 자료추출(메뉴)
    private String rept       	    = ""; // 보고서(메뉴)
    private String send       	    = ""; // 발송관리(메뉴)
    private String stnd       	    = ""; // 기준정보관리(메뉴)
    private String oper       	    = ""; // 운영관리(메뉴)
    private String sale       	    = ""; // 영업관리(메뉴)
    
    //비밀번호 관리
    private String pwRegdt       	= ""; // 비밀번호변경일자, 변경주기관리
    
    //IP번호
    private String ip1       	    = ""; // ip1
    private String ip2       	    = ""; // ip2
    private String ip3       	    = ""; // ip3
    private String ip4       	    = ""; // ip4
    
    private String exauth       	= ""; // 엑셀다운로드권한
    
    private String mcrf       		= ""; // CRF작성(메뉴)
    private String acrf       		= ""; // 종료확인(메뉴)
    
    public String getMcrf() {
		return mcrf;
	}
	public void setMcrf(String mcrf) {
		this.mcrf = mcrf;
	}
	public String getAcrf() {
		return acrf;
	}
	public void setAcrf(String acrf) {
		this.acrf = acrf;
	}
	public String getSale() {
		return sale;
	}
	public void setSale(String sale) {
		this.sale = sale;
	}
	public String getExauth() {
		return exauth;
	}
	public void setExauth(String exauth) {
		this.exauth = exauth;
	}
	public String getIp1() {
		return ip1;
	}
	public void setIp1(String ip1) {
		this.ip1 = ip1;
	}
	public String getIp2() {
		return ip2;
	}
	public void setIp2(String ip2) {
		this.ip2 = ip2;
	}
	public String getIp3() {
		return ip3;
	}
	public void setIp3(String ip3) {
		this.ip3 = ip3;
	}
	public String getIp4() {
		return ip4;
	}
	public void setIp4(String ip4) {
		this.ip4 = ip4;
	}
	public String getPwRegdt() {
		return pwRegdt;
	}
	public void setPwRegdt(String pwRegdt) {
		this.pwRegdt = pwRegdt;
	}
	public String getRsmg() {
		return rsmg;
	}
	public void setRsmg(String rsmg) {
		this.rsmg = rsmg;
	}
	public String getEcrf() {
		return ecrf;
	}
	public void setEcrf(String ecrf) {
		this.ecrf = ecrf;
	}
	public String getRsjt() {
		return rsjt;
	}
	public void setRsjt(String rsjt) {
		this.rsjt = rsjt;
	}
	public String getExtr() {
		return extr;
	}
	public void setExtr(String extr) {
		this.extr = extr;
	}
	public String getRept() {
		return rept;
	}
	public void setRept(String rept) {
		this.rept = rept;
	}
	public String getSend() {
		return send;
	}
	public void setSend(String send) {
		this.send = send;
	}
	public String getStnd() {
		return stnd;
	}
	public void setStnd(String stnd) {
		this.stnd = stnd;
	}
	public String getOper() {
		return oper;
	}
	public void setOper(String oper) {
		this.oper = oper;
	}
	public String getAdminType() {
		return adminType;
	}
	public void setAdminType(String adminType) {
		this.adminType = adminType;
	}

	public String getLoginFail() {
		return loginFail;
	}

	public void setLoginFail(String loginFail) {
		this.loginFail = loginFail;
	}

	public String getAcceIp() {
		return acceIp;
	}

	public void setAcceIp(String acceIp) {
		this.acceIp = acceIp;
	}

	public String getIpAllYn() {
		return ipAllYn;
	}

	public void setIpAllYn(String ipAllYn) {
		this.ipAllYn = ipAllYn;
	}

	private String mobile1 		 = "";
	private String mobile2 		 = "";
	private String mobile3 		 = "";
	
	private String emailId 		 = "";
	private String emailAdr 	 = "";
		
		
	public String getBranchCd() {
		return branchCd;
	}

	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
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

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
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

	
	public String getHpNo() {
		if (!EgovStringUtil.isEmpty(mobile1) && !EgovStringUtil.isEmpty(mobile2) && !EgovStringUtil.isEmpty(mobile3)) {
			return mobile1 + "-" + mobile2 + "-" + mobile3;
		}else{
			return "";
		}
	}

	public void setHpNo(String hpNo) {
		if (!EgovStringUtil.isEmpty(hpNo)) {
			String[] spMobile = hpNo.split("-");

			this.mobile1 = spMobile[0];
			this.mobile2 = spMobile[1];
			this.mobile3 = spMobile[2];
		}
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

	public String getEmail() {
		if (!EgovStringUtil.isEmpty(emailId)) {
			if (!EgovStringUtil.isEmpty(emailAdr)) {
				return emailId + "@" + emailAdr;
			}
			return emailId;
		} else {
			return null;
		}
	}

	public void setEmail(String email) {
		if (!EgovStringUtil.isEmpty(email)) {
			String[] spEmail = email.split("@");

			this.emailId = spEmail[0];
			this.emailAdr = spEmail[1];
		}
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
	
	public String getSpot() {
		return spot;
	}
	public void setSpot(String spot) {
		this.spot = spot;
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
	public String getOrgNo() {
		return orgNo;
	}
	public void setOrgNo(String orgNo) {
		this.orgNo = orgNo;
	}
	public String getOrgNm() {
		return orgNm;
	}
	public void setOrgNm(String orgNm) {
		this.orgNm = orgNm;
	}
	public String getIncDt() {
		return incDt;
	}
	public void setIncDt(String incDt) {
		this.incDt = incDt;
	}
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getEmpCls() {
		return empCls;
	}

	public void setEmpCls(String empCls) {
		this.empCls = empCls;
	}

	public String getEmpClsNm() {
		return empClsNm;
	}

	public void setEmpClsNm(String empClsNm) {
		this.empClsNm = empClsNm;
	}

	public String getRsCls() {
		return rsCls;
	}

	public void setRsCls(String rsCls) {
		this.rsCls = rsCls;
	}

	public String getRsClsNm() {
		return rsClsNm;
	}

	public void setRsClsNm(String rsClsNm) {
		this.rsClsNm = rsClsNm;
	}

	public String getRsAuthCls() {
		return rsAuthCls;
	}

	public void setRsAuthCls(String rsAuthCls) {
		this.rsAuthCls = rsAuthCls;
	}

	public String getRsAuthClsNm() {
		return rsAuthClsNm;
	}

	public void setRsAuthClsNm(String rsAuthClsNm) {
		this.rsAuthClsNm = rsAuthClsNm;
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
	@Override
	public String toString() {
		return "Ct1030mVO [corpCd=" + corpCd + ", empNo=" + empNo + ", empName=" + empName + ", orgNo=" + orgNo
				+ ", orgNm=" + orgNm + ", incDt=" + incDt + ", hpNo=" + hpNo + ", email=" + email + ", position="
				+ position + ", empCls=" + empCls + ", empClsNm=" + empClsNm + ", userId=" + userId + ", pwNo=" + pwNo
				+ ", branchCd=" + branchCd + ", branchName=" + branchName + ", spot=" + spot + ", rsCls=" + rsCls
				+ ", rsClsNm=" + rsClsNm + ", rsAuthCls=" + rsAuthCls + ", rsAuthClsNm=" + rsAuthClsNm + ", rloginDt="
				+ rloginDt + ", userSt=" + userSt + ", userStNm=" + userStNm + ", effStdt=" + effStdt + ", effEndt="
				+ effEndt + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", loginFail=" + loginFail
				+ ", acceIp=" + acceIp + ", ipAllYn=" + ipAllYn + ", adminType=" + adminType + ", rsmg=" + rsmg
				+ ", ecrf=" + ecrf + ", rsjt=" + rsjt + ", extr=" + extr + ", rept=" + rept + ", send=" + send
				+ ", stnd=" + stnd + ", oper=" + oper + ", sale=" + sale + ", pwRegdt=" + pwRegdt + ", ip1=" + ip1
				+ ", ip2=" + ip2 + ", ip3=" + ip3 + ", ip4=" + ip4 + ", exauth=" + exauth + ", mcrf=" + mcrf + ", acrf="
				+ acrf + ", mobile1=" + mobile1 + ", mobile2=" + mobile2 + ", mobile3=" + mobile3 + ", emailId="
				+ emailId + ", emailAdr=" + emailAdr + "]";
	}
	


}
