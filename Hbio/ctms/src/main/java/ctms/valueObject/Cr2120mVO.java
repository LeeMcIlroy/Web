package ctms.valueObject;

public class Cr2120mVO {
    private String corpCd               = ""; // 회사코드
    private String rsNo                 = ""; // 연구과제번호
    private String rsName               = ""; // 연구과제번호명
    private String tempNo               = ""; // 탬플릿번호
    private String rsiNo                = ""; // 식별번호
    private String rsjNo                = ""; // 연구대상자번호
    private String rsjName              = ""; // 연구대상자명
    private String mkYn               	= ""; // 작성여부
    private String mkDt               	= ""; // 작성일자
    private String remk              	= ""; // 비고
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자
    
    private String tempType             = ""; // 템플릿구분

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

	public String getRsName() {
		return rsName;
	}

	public void setRsName(String rsName) {
		this.rsName = rsName;
	}

	public String getTempNo() {
		return tempNo;
	}

	public void setTempNo(String tempNo) {
		this.tempNo = tempNo;
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

	public String getMkYn() {
		return mkYn;
	}

	public void setMkYn(String mkYn) {
		this.mkYn = mkYn;
	}

	public String getMkDt() {
		return mkDt;
	}

	public void setMkDt(String mkDt) {
		this.mkDt = mkDt;
	}

	public String getRemk() {
		return remk;
	}

	public void setRemk(String remk) {
		this.remk = remk;
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

	public String getTempType() {
		return tempType;
	}

	public void setTempType(String tempType) {
		this.tempType = tempType;
	}

	@Override
	public String toString() {
		return "Cr2120mVO [corpCd=" + corpCd + ", rsNo=" + rsNo + ", rsName=" + rsName + ", tempNo=" + tempNo
				+ ", rsiNo=" + rsiNo + ", rsjNo=" + rsjNo + ", rsjName=" + rsjName + ", mkYn=" + mkYn + ", mkDt=" + mkDt
				+ ", remk=" + remk + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", tempType=" + tempType
				+ "]";
	}
    
	
}