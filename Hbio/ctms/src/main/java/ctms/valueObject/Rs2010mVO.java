package ctms.valueObject;

/**
 * @author 
 * 
 * 연구과제참여VO 2020.12.07 - 연구계획서 - 피험자 
 *
 */

public class Rs2010mVO {

	private String corpCd               = ""; // 회사코드
    private String corpName             = ""; // 회사코드명
    private String rsNo                 = ""; // 연구과제번호
    private String rsName               = ""; // 연구과제번호명
    private String subNo                = ""; // 피험자선정번호
    private String rsiNo1               = ""; // 식별번호1
    private String rsiNo2               = ""; // 식별번호2
    private String rsiNo3               = ""; // 식별번호3
    private String rsiNo                = ""; // 식별번호
    private String rsjNo                = ""; // 연구대상자번호
    private String rsjName              = ""; // 연구대상자번호명
    private String appstaCls            = ""; // 참여상태
    private String appstaClsNm          = ""; // 참여상태명
    private String appStdt              = ""; // 참여시작일자
    private String appEndt              = ""; // 참여종료일자
    private String etc                  = ""; // 특이사항
    private String appYn                = ""; // 지원여부
    private String poolYn               = ""; // 풀선별
    private String firstSt              = ""; // 1차선정
    private String cfmYn                = ""; // 확정여부
    private String dataRegdt            = ""; // 등록수정일자
    private String dataRegnt            = ""; // 등록수정자
    
    private String firstStNo            = ""; // 스크리닝번호
    private String rsCd  		        = ""; // 연구코드
    private String brDt  		        = ""; // 생년얼일
    private String genYnNm  		    = ""; // 성별
    private String age  		        = ""; // 나이 
    private String hpNo  		        = ""; // 휴대폰번호
    private String genYn  		        = ""; // 성별 1 남 2 여    
    
    private String doutYn  		        = ""; // 중도탈락여부 Y 중도탈락 appstaCls 40 N 임상시험진행
    private String doutCont  		    = ""; // 중도탈락사유 
    private String doutDt  		    	= ""; // 중도탈락일자
    private String doutCls  		    = ""; // 중도탈락여부 코드 CT3030
        
	public String getDoutCls() {
		return doutCls;
	}
	public void setDoutCls(String doutCls) {
		this.doutCls = doutCls;
	}
	public String getDoutYn() {
		return doutYn;
	}
	public void setDoutYn(String doutYn) {
		this.doutYn = doutYn;
	}
	public String getDoutCont() {
		return doutCont;
	}
	public void setDoutCont(String doutCont) {
		this.doutCont = doutCont;
	}
	public String getDoutDt() {
		return doutDt;
	}
	public void setDoutDt(String doutDt) {
		this.doutDt = doutDt;
	}
	public String getGenYn() {
		return genYn;
	}
	public void setGenYn(String genYn) {
		this.genYn = genYn;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getCorpName() {
		return corpName;
	}
	public void setCorpName(String corpName) {
		this.corpName = corpName;
	}
	public String getRsNo() {
		return rsNo;
	}
	public void setRsNo(String rsNo) {
		this.rsNo = rsNo;
	}
	public String getRsName() {
		return rsName;
	}
	public void setRsName(String rsName) {
		this.rsName = rsName;
	}
	public String getSubNo() {
		return subNo;
	}
	public void setSubNo(String subNo) {
		this.subNo = subNo;
	}
	public String getRsiNo1() {
		return rsiNo1;
	}
	public void setRsiNo1(String rsiNo1) {
		this.rsiNo1 = rsiNo1;
	}
	public String getRsiNo2() {
		return rsiNo2;
	}
	public void setRsiNo2(String rsiNo2) {
		this.rsiNo2 = rsiNo2;
	}
	public String getRsiNo3() {
		return rsiNo3;
	}
	public void setRsiNo3(String rsiNo3) {
		this.rsiNo3 = rsiNo3;
	}
	public String getRsiNo() {
		return rsiNo;
	}
	public void setRsiNo(String rsiNo) {
		this.rsiNo = rsiNo;
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
	public String getAppstaCls() {
		return appstaCls;
	}
	public void setAppstaCls(String appstaCls) {
		this.appstaCls = appstaCls;
	}
	public String getAppstaClsNm() {
		return appstaClsNm;
	}
	public void setAppstaClsNm(String appstaClsNm) {
		this.appstaClsNm = appstaClsNm;
	}
	public String getAppStdt() {
		return appStdt;
	}
	public void setAppStdt(String appStdt) {
		this.appStdt = appStdt;
	}
	public String getAppEndt() {
		return appEndt;
	}
	public void setAppEndt(String appEndt) {
		this.appEndt = appEndt;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getAppYn() {
		return appYn;
	}
	public void setAppYn(String appYn) {
		this.appYn = appYn;
	}
	public String getPoolYn() {
		return poolYn;
	}
	public void setPoolYn(String poolYn) {
		this.poolYn = poolYn;
	}
	public String getFirstSt() {
		return firstSt;
	}
	public void setFirstSt(String firstSt) {
		this.firstSt = firstSt;
	}
	public String getCfmYn() {
		return cfmYn;
	}
	public void setCfmYn(String cfmYn) {
		this.cfmYn = cfmYn;
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
	public String getFirstStNo() {
		return firstStNo;
	}
	public void setFirstStNo(String firstStNo) {
		this.firstStNo = firstStNo;
	}
	public String getRsCd() {
		return rsCd;
	}
	public void setRsCd(String rsCd) {
		this.rsCd = rsCd;
	}
	public String getBrDt() {
		return brDt;
	}
	public void setBrDt(String brDt) {
		this.brDt = brDt;
	}
	public String getGenYnNm() {
		return genYnNm;
	}
	public void setGenYnNm(String genYnNm) {
		this.genYnNm = genYnNm;
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
	@Override
	public String toString() {
		return "Rs2010mVO [corpCd=" + corpCd + ", corpName=" + corpName + ", rsNo=" + rsNo + ", rsName=" + rsName
				+ ", subNo=" + subNo + ", rsiNo1=" + rsiNo1 + ", rsiNo2=" + rsiNo2 + ", rsiNo3=" + rsiNo3 + ", rsiNo="
				+ rsiNo + ", rsjNo=" + rsjNo + ", rsjName=" + rsjName + ", appstaCls=" + appstaCls + ", appstaClsNm="
				+ appstaClsNm + ", appStdt=" + appStdt + ", appEndt=" + appEndt + ", etc=" + etc + ", appYn=" + appYn
				+ ", poolYn=" + poolYn + ", firstSt=" + firstSt + ", cfmYn=" + cfmYn + ", dataRegdt=" + dataRegdt
				+ ", dataRegnt=" + dataRegnt + ", firstStNo=" + firstStNo + ", rsCd=" + rsCd + ", brDt=" + brDt
				+ ", genYnNm=" + genYnNm + ", age=" + age + ", hpNo=" + hpNo + ", genYn=" + genYn + ", doutYn=" + doutYn
				+ ", doutCont=" + doutCont + ", doutDt=" + doutDt + ", doutCls=" + doutCls + "]";
	}
	
	
	
    
    		
}
