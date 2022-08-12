package ctms.valueObject;

public class Cr3150mVO {

    private String    corpCd               = ""; // 회사코드
    private String    rsNo                 = ""; // 연구과제번호
    private String    rsiNo	               = ""; // 식별번호
    private String    pchCls               = ""; // 패치제거시간
    private String    mtlDsp	           = ""; // 물질번호
    private String    pchRst               = ""; // 피부자극정보
    private String    cls       		   = ""; // 구분
    private String    dataRegdt            = ""; // 등록수정일시
    private String    dataRegnt            = ""; // 등록수정자
    private String    mrsNo          	   = ""; // 상위연구번호
    
	public String getMrsNo() {
		return mrsNo;
	}
	public void setMrsNo(String mrsNo) {
		this.mrsNo = mrsNo;
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
	public String getRsiNo() {
		return rsiNo;
	}
	public void setRsiNo(String rsiNo) {
		this.rsiNo = rsiNo;
	}
	public String getPchCls() {
		return pchCls;
	}
	public void setPchCls(String pchCls) {
		this.pchCls = pchCls;
	}
	public String getMtlDsp() {
		return mtlDsp;
	}
	public void setMtlDsp(String mtlDsp) {
		this.mtlDsp = mtlDsp;
	}
	public String getPchRst() {
		return pchRst;
	}
	public void setPchRst(String pchRst) {
		this.pchRst = pchRst;
	}
	public String getCls() {
		return cls;
	}
	public void setCls(String cls) {
		this.cls = cls;
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
		return "Cr3150mVO [corpCd=" + corpCd + ", rsNo=" + rsNo + ", rsiNo=" + rsiNo + ", pchCls=" + pchCls
				+ ", mtlDsp=" + mtlDsp + ", pchRst=" + pchRst + ", cls=" + cls + ", dataRegdt=" + dataRegdt
				+ ", dataRegnt=" + dataRegnt + "]";
	}
	   
	 
}
