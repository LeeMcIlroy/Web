package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class Cr3240mVO {
	
	private String rownum               = ""; // 순번
	private String corpCd               = ""; // 회사코드
	private String rsNo                 = ""; // 연구과제번호
	private String rsCd                 = ""; // 연구코드
    private String rsjNo             	= ""; // 연구대상자번호
    private String rsiNo              	= ""; // 식별코드
    private String rsjName              = ""; // 연구대상자이름
    private String brDt                 = ""; // 생년월일
    private String age               	= ""; // 나이(현재)
    private String genYn               	= ""; // 성별
    private String genYnNm             	= ""; // 성별명
    private String hpNo            		= ""; // 휴대폰번호
    private String chkDt                = ""; // 실제사용일자
    private String chk1		            = ""; // 사용여부1 Y N
    private String chk2		            = ""; // 사용여부2
    private String chk3		            = ""; // 사용여부3
    private String chk4		            = ""; // 사용여부4
    private String chk5		            = ""; // 사용여부5
    private String chk1Dt               = ""; // 사용여부1 사용일시
    private String chk2Dt               = ""; // 사용여부2 사용일시
    private String chk3Dt               = ""; // 사용여부3 사용일시
    private String chk4Dt               = ""; // 사용여부4 사용일시
    private String chk5Dt               = ""; // 사용여부5 사용일시
    private String remk		            = ""; // 특이사항
    private String chkCnt             	= ""; // 사용일자 총체크수(실제사용건수)
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자
    
	public String getRsCd() {
		return rsCd;
	}
	public void setRsCd(String rsCd) {
		this.rsCd = rsCd;
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
	public String getChkDt() {
		return chkDt;
	}
	public void setChkDt(String chkDt) {
		this.chkDt = chkDt;
	}
	public String getChk1() {
		return chk1;
	}
	public void setChk1(String chk1) {
		this.chk1 = chk1;
	}
	public String getChk2() {
		return chk2;
	}
	public void setChk2(String chk2) {
		this.chk2 = chk2;
	}
	public String getChk3() {
		return chk3;
	}
	public void setChk3(String chk3) {
		this.chk3 = chk3;
	}
	public String getChk4() {
		return chk4;
	}
	public void setChk4(String chk4) {
		this.chk4 = chk4;
	}
	public String getChk5() {
		return chk5;
	}
	public void setChk5(String chk5) {
		this.chk5 = chk5;
	}
	public String getChk1Dt() {
		return chk1Dt;
	}
	public void setChk1Dt(String chk1Dt) {
		this.chk1Dt = chk1Dt;
	}
	public String getChk2Dt() {
		return chk2Dt;
	}
	public void setChk2Dt(String chk2Dt) {
		this.chk2Dt = chk2Dt;
	}
	public String getChk3Dt() {
		return chk3Dt;
	}
	public void setChk3Dt(String chk3Dt) {
		this.chk3Dt = chk3Dt;
	}
	public String getChk4Dt() {
		return chk4Dt;
	}
	public void setChk4Dt(String chk4Dt) {
		this.chk4Dt = chk4Dt;
	}
	public String getChk5Dt() {
		return chk5Dt;
	}
	public void setChk5Dt(String chk5Dt) {
		this.chk5Dt = chk5Dt;
	}
	public String getRemk() {
		return remk;
	}
	public void setRemk(String remk) {
		this.remk = remk;
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
		return "Cr3240mVO [rownum=" + rownum + ", corpCd=" + corpCd + ", rsNo=" + rsNo + ", rsCd=" + rsCd + ", rsjNo="
				+ rsjNo + ", rsiNo=" + rsiNo + ", rsjName=" + rsjName + ", brDt=" + brDt + ", age=" + age + ", genYn="
				+ genYn + ", genYnNm=" + genYnNm + ", hpNo=" + hpNo + ", chkDt=" + chkDt + ", chk1=" + chk1 + ", chk2="
				+ chk2 + ", chk3=" + chk3 + ", chk4=" + chk4 + ", chk5=" + chk5 + ", chk1Dt=" + chk1Dt + ", chk2Dt="
				+ chk2Dt + ", chk3Dt=" + chk3Dt + ", chk4Dt=" + chk4Dt + ", chk5Dt=" + chk5Dt + ", remk=" + remk
				+ ", chkCnt=" + chkCnt + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}

	
    
    
	
    
 
    
}
