package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 관리자VO 2020.02.27
 *
 */
public class AdminVO { 
	
	private String adminId			= "";
	private String adminPw			= "";
	private String name				= "";
	private String depart			= "";
	private String acceIp			= "";
	private String ipAllYn			= "";
	private String useYn			= "";
	private String adminType		= "";
	private String dtlYn			= "";
	private String entran			= "";
	private String regist			= "";
	private String student			= "";
	private String clss				= "";
	private String admstr			= "";
	private String stat				= "";
	private String oper				= "";
	private String curr				= "";
	private String loginDateTime	= "";
	private String regId			= "";
	private String regDate			= "";
	private String updDate			= "";
	private String loginFail		= "";
	
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
				+ clss + ", admstr=" + admstr + ", stat=" + stat + ", oper=" + oper + ", curr=" + curr
				+ ", loginDateTime=" + loginDateTime + ", regId=" + regId + ", regDate=" + regDate + ", updDate="
				+ updDate + ", loginFail=" + loginFail + "]";
	}
}
