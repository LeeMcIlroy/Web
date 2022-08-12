package ctms.valueObject;

 /**
 * @author 개발2
 * 개인정보처리 로그
 * Ct1050mVO 2021.01.12
 *
 */
public class Ct1050mVO { 
	
	private String corpCd		= "";
	private String mbCd			= "";
	private String mbName		= "";
	private String logCont		= "";
	private String acceIp		= "";
	private String branchCd		= "";
	private String branchNm		= "";
	private String dataRegdt	= "";
	private String empName		= "";
	private String dataRegnt	= "";
	private String logCls		= "";
	
	public Ct1050mVO(){};
	
	public Ct1050mVO(String dataRegnt, String mbCd, String mbName, String logCont, String acceIp, String corpCd, String branchCd){
		this.dataRegnt = dataRegnt;
		this.mbCd = mbCd;
		this.mbName = mbName;
		this.logCont = logCont;
		this.acceIp = acceIp;
		this.corpCd = corpCd;
		this.branchCd = branchCd;
	}
	
	public String getLogCls() {
		return logCls;
	}

	public void setLogCls(String logCls) {
		this.logCls = logCls;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
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
	public String getMbCd() {
		return mbCd;
	}
	public void setMbCd(String mbCd) {
		this.mbCd = mbCd;
	}
	public String getMbName() {
		return mbName;
	}
	public void setMbName(String mbName) {
		this.mbName = mbName;
	}
	public String getLogCont() {
		return logCont;
	}
	public void setLogCont(String logCont) {
		this.logCont = logCont;
	}
	public String getAcceIp() {
		return acceIp;
	}
	public void setAcceIp(String acceIp) {
		this.acceIp = acceIp;
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
		return "Ct1050mVO [corpCd=" + corpCd + ", mbCd=" + mbCd + ", mbName=" + mbName + ", logCont=" + logCont
				+ ", acceIp=" + acceIp + ", branchCd=" + branchCd + ", branchNm=" + branchNm + ", dataRegdt="
				+ dataRegdt + ", empName=" + empName + ", dataRegnt=" + dataRegnt + ", logCls=" + logCls + "]";
	}

	
	
	
}
