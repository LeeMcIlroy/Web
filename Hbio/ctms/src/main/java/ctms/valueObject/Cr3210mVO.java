package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class Cr3210mVO {
	
	private String rownum               = ""; // 순번
	private String corpCd               = ""; // 회사코드
	private String rsNo                 = ""; // 연구과제번호
    private String subNo                = ""; // 연구대상자선정순번
    private String rsjNo            	= ""; // 연구대상자번호
    private String rsiNo              	= ""; // 식별코드
    private String rsjName              = ""; // 연구대상자이름
    private String brDt                 = ""; // 생년월일
    private String age              	= ""; // 나이(현재)
    private String genYn                = ""; // 성별
    private String genYnNm              = ""; // 성별명
    private String hpNo             	= ""; // 휴대폰번호
    private String chkStdt            	= ""; // 체크시작일자
    private String chkEndt            	= ""; // 체크종료일자
    private String chkCnt             	= ""; // 체크수
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자
    
    private String reYn		            = ""; // 아이템회수여부
    private String stYn		            = ""; // 중지여부
    private String remk		            = ""; // 특이사항 - 중지된 경우 특이사항 기재
    
    public String getRemk() {
		return remk;
	}
	public void setRemk(String remk) {
		this.remk = remk;
	}
	public String getReYn() {
		return reYn;
	}
	public void setReYn(String reYn) {
		this.reYn = reYn;
	}
	public String getStYn() {
		return stYn;
	}
	public void setStYn(String stYn) {
		this.stYn = stYn;
	}
	public String getRownum() {
		return rownum;
	}
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getRsNo() {
		return rsNo;
	}
	public void setRsNo(String rsNo) {
		this.rsNo = rsNo;
	}
	public String getSubNo() {
		return subNo;
	}
	public void setSubNo(String subNo) {
		this.subNo = subNo;
	}
	public String getRsjNo() {
		return rsjNo;
	}
	public void setRsjNo(String rsjNo) {
		this.rsjNo = rsjNo;
	}
	public String getRsiNo() {
		return rsiNo;
	}
	public void setRsiNo(String rsiNo) {
		this.rsiNo = rsiNo;
	}
	public String getRsjName() {
		return rsjName;
	}
	public void setRsjName(String rsjName) {
		this.rsjName = rsjName;
	}
	public String getBrDt() {
		return brDt;
	}
	public void setBrDt(String brDt) {
		this.brDt = brDt;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getGenYn() {
		return genYn;
	}
	public void setGenYn(String genYn) {
		this.genYn = genYn;
	}
	public String getGenYnNm() {
		return genYnNm;
	}
	public void setGenYnNm(String genYnNm) {
		this.genYnNm = genYnNm;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getChkStdt() {
		return chkStdt;
	}
	public void setChkStdt(String chkStdt) {
		this.chkStdt = chkStdt;
	}
	public String getChkEndt() {
		return chkEndt;
	}
	public void setChkEndt(String chkEndt) {
		this.chkEndt = chkEndt;
	}
	public String getChkCnt() {
		return chkCnt;
	}
	public void setChkCnt(String chkCnt) {
		this.chkCnt = chkCnt;
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
		return "Cr3210mVO [rownum=" + rownum + ", corpCd=" + corpCd + ", rsNo=" + rsNo + ", subNo=" + subNo + ", rsjNo="
				+ rsjNo + ", rsiNo=" + rsiNo + ", rsjName=" + rsjName + ", brDt=" + brDt + ", age=" + age + ", genYn="
				+ genYn + ", genYnNm=" + genYnNm + ", hpNo=" + hpNo + ", chkStdt=" + chkStdt + ", chkEndt=" + chkEndt
				+ ", chkCnt=" + chkCnt + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", reYn=" + reYn
				+ ", stYn=" + stYn + ", remk=" + remk + "]";
	}

	
	
	
    
 
    
}
