package ctms.valueObject;


 /**
 * @author Leegh
 * 
 * 관리자VO 2020.02.27
 *
 */
public class AdminVO { 
		
	private String adminId			= ""; //아이디
	private String adminPw			= ""; //비밀번호
	private String name				= ""; //이름
	private String depart			= ""; //
	private String acceIp			= ""; //접속아이피
	private String ipAllYn			= ""; //아이피허용범위
	private String useYn			= ""; //사용여부
	private String adminType		= ""; //사용자유형 
	private String dtlYn			= ""; //삭제여부
	private String entran			= "";
	private String regist			= "";
	private String student			= "";
	private String clss				= "";
	private String admstr			= "";
	private String stat				= "";
	private String curr				= "";
	private String loginDateTime	= ""; //로그인일시
	private String regId			= "";
	private String regDate			= "";
	private String updDate			= "";
	private String loginFail		= ""; //실퍠횟수
	
	private String corpCd			= ""; //회사코드
	private String branchCd			= ""; //소속지사코드
	private String empNo			= ""; //구성원번호
	private String rsNo1			= ""; //연구과제고유번호
	private String rvNo1			= ""; //IRB심의고유번호
	
	//메뉴권한
    private String rsmg       	    = ""; // 연구과제관리
    private String ecrf       	    = ""; // eCRF관리
    private String rsjt       	    = ""; // 피험자관리
    private String extr       	    = ""; // 자료추출
    private String rept       	    = ""; // 보고서
    private String send       	    = ""; // 발송관리
    private String stnd       	    = ""; // 기준정보관리
    private String oper       	    = ""; // 운영관리
    private String sale       	    = ""; // 영업관리
    private String mcrf       	    = ""; // crf작성
    private String acrf       	    = ""; // 종료확인
    
    //비밀번호 관리
    private String pwRegdt       	= ""; // 비밀번호변경일자, 변경주기관리 
    private String exauth       	= ""; // 엑셀다운로드권한 Y 허용  N 허용안함
    
    private String opNo1			= ""; // 견적고유번호
    private String ctrtNo1			= ""; // 계약고유번호
    
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
	public String getOpNo1() {
		return opNo1;
	}
	public void setOpNo1(String opNo1) {
		this.opNo1 = opNo1;
	}
	public String getCtrtNo1() {
		return ctrtNo1;
	}
	public void setCtrtNo1(String ctrtNo1) {
		this.ctrtNo1 = ctrtNo1;
	}
	public String getExauth() {
		return exauth;
	}
	public void setExauth(String exauth) {
		this.exauth = exauth;
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
	public String getRsNo1() {
		return rsNo1;
	}
	public void setRsNo1(String rsNo1) {
		this.rsNo1 = rsNo1;
	}
	public String getRvNo1() {
		return rvNo1;
	}
	public void setRvNo1(String rvNo1) {
		this.rvNo1 = rvNo1;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getBranchCd() {
		return branchCd;
	}
	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getAdminType() {
		return adminType;
	}
	public void setAdminType(String adminType) {
		this.adminType = adminType;
	}
	public String getDtlYn() {
		return dtlYn;
	}
	public void setDtlYn(String dtlYn) {
		this.dtlYn = dtlYn;
	}
	public String getEntran() {
		return entran;
	}
	public void setEntran(String entran) {
		this.entran = entran;
	}
	public String getRegist() {
		return regist;
	}
	public void setRegist(String regist) {
		this.regist = regist;
	}
	public String getStudent() {
		return student;
	}
	public void setStudent(String student) {
		this.student = student;
	}
	public String getClss() {
		return clss;
	}
	public void setClss(String clss) {
		this.clss = clss;
	}
	public String getAdmstr() {
		return admstr;
	}
	public void setAdmstr(String admstr) {
		this.admstr = admstr;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getOper() {
		return oper;
	}
	public void setOper(String oper) {
		this.oper = oper;
	}
	public String getCurr() {
		return curr;
	}
	public void setCurr(String curr) {
		this.curr = curr;
	}
	public String getLoginDateTime() {
		return loginDateTime;
	}
	public void setLoginDateTime(String loginDateTime) {
		this.loginDateTime = loginDateTime;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUpdDate() {
		return updDate;
	}
	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}
	public String getLoginFail() {
		return loginFail;
	}
	public void setLoginFail(String loginFail) {
		this.loginFail = loginFail;
	}
	@Override
	public String toString() {
		return "AdminVO [adminId=" + adminId + ", adminPw=" + adminPw + ", name=" + name + ", depart=" + depart
				+ ", acceIp=" + acceIp + ", ipAllYn=" + ipAllYn + ", useYn=" + useYn + ", adminType=" + adminType
				+ ", dtlYn=" + dtlYn + ", entran=" + entran + ", regist=" + regist + ", student=" + student + ", clss="
				+ clss + ", admstr=" + admstr + ", stat=" + stat + ", curr=" + curr + ", loginDateTime=" + loginDateTime
				+ ", regId=" + regId + ", regDate=" + regDate + ", updDate=" + updDate + ", loginFail=" + loginFail
				+ ", corpCd=" + corpCd + ", branchCd=" + branchCd + ", empNo=" + empNo + ", rsNo1=" + rsNo1 + ", rvNo1="
				+ rvNo1 + ", rsmg=" + rsmg + ", ecrf=" + ecrf + ", rsjt=" + rsjt + ", extr=" + extr + ", rept=" + rept
				+ ", send=" + send + ", stnd=" + stnd + ", oper=" + oper + ", sale=" + sale + ", mcrf=" + mcrf
				+ ", acrf=" + acrf + ", pwRegdt=" + pwRegdt + ", exauth=" + exauth + ", opNo1=" + opNo1 + ", ctrtNo1="
				+ ctrtNo1 + "]";
	}
	
	
}
