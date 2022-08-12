package ctms.valueObject;

public class Cr4000mVO {
	private String    corpCd               = ""; // 회사코드
	private String    rsNo	               = ""; // 연구과제번호
	private String    subNo	               = ""; // 피험자선정번호
	private String    rsjNo	               = ""; // 연구대상자번호
	private String    rsjName	           = ""; // 이름
	private String    brDt	  		       = ""; // 생년월일
	private String    age	  		       = ""; // 나이
	private String    hpNo	  		       = ""; // 핸드폰번호
	private String    pricfYn	  		   = ""; // 개인정보동의
	private String    rsicfYn	  		   = ""; // 연구참여동의
	private String    icfDt	  			   = ""; // 동의서작성일자
    private String    dataRegdt            = ""; // 등록수정일시
    private String    dataRegnt            = ""; // 등록수정자
    private String    rsCd  	           = ""; // 연구코드
    
    
	public String getRsCd() {
		return rsCd;
	}
	public void setRsCd(String rsCd) {
		this.rsCd = rsCd;
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
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getPricfYn() {
		return pricfYn;
	}
	public void setPricfYn(String pricfYn) {
		this.pricfYn = pricfYn;
	}
	public String getRsicfYn() {
		return rsicfYn;
	}
	public void setRsicfYn(String rsicfYn) {
		this.rsicfYn = rsicfYn;
	}
	public String getIcfDt() {
		return icfDt;
	}
	public void setIcfDt(String icfDt) {
		this.icfDt = icfDt;
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
		return "Cr4000mVO [corpCd=" + corpCd + ", rsNo=" + rsNo + ", subNo=" + subNo + ", rsjNo=" + rsjNo + ", rsjName="
				+ rsjName + ", brDt=" + brDt + ", age=" + age + ", hpNo=" + hpNo + ", pricfYn=" + pricfYn + ", rsicfYn="
				+ rsicfYn + ", icfDt=" + icfDt + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", rsCd="
				+ rsCd + "]";
	}
	

        
    
}
