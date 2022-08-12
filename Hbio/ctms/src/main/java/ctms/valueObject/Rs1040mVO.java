package ctms.valueObject;

/**
 * @author 개발2
 * 
 * 참여지사(연구과제)VO 2021.01.05 
 *
 */
public class Rs1040mVO {

    private String corpCd               = ""; // 회사코드
    private String rsNo                 = ""; // 연구과제번호
    private String mtlNo                = ""; // 시험물질번호
    private String rsName               = ""; // 연구과제번호명
    private String rsCd                 = ""; // 연구코드
    private String mtlDsp               = ""; // 시험물질표시
    private String mtlName              = ""; // 시험물질명칭(NC)
    private String lotNo	            = ""; // 로트번호
    private String mtlShp	            = ""; // 성상
    private String remk			        = ""; // 비고
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자
    private String mode		            = ""; // 작업구분 i 추가 u 수정
    private String ncYn		            = ""; // NC 여부
    private String mtlName2             = ""; // 시험물질명칭 (시험물질)
    private String mrsNo  	            = ""; // 상위연구번호
    
    public String getMrsNo() {
		return mrsNo;
	}
	public void setMrsNo(String mrsNo) {
		this.mrsNo = mrsNo;
	}
	public String getMtlName2() {
		return mtlName2;
	}
	public void setMtlName2(String mtlName2) {
		this.mtlName2 = mtlName2;
	}
	public String getNcYn() {
		return ncYn;
	}
	public void setNcYn(String ncYn) {
		this.ncYn = ncYn;
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
	public String getMtlNo() {
		return mtlNo;
	}
	public void setMtlNo(String mtlNo) {
		this.mtlNo = mtlNo;
	}
	public String getRsName() {
		return rsName;
	}
	public void setRsName(String rsName) {
		this.rsName = rsName;
	}
	public String getRsCd() {
		return rsCd;
	}
	public void setRsCd(String rsCd) {
		this.rsCd = rsCd;
	}
	public String getMtlDsp() {
		return mtlDsp;
	}
	public void setMtlDsp(String mtlDsp) {
		this.mtlDsp = mtlDsp;
	}
	public String getMtlName() {
		return mtlName;
	}
	public void setMtlName(String mtlName) {
		this.mtlName = mtlName;
	}
	public String getLotNo() {
		return lotNo;
	}
	public void setLotNo(String lotNo) {
		this.lotNo = lotNo;
	}
	public String getMtlShp() {
		return mtlShp;
	}
	public void setMtlShp(String mtlShp) {
		this.mtlShp = mtlShp;
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
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	@Override
	public String toString() {
		return "Rs1040mVO [corpCd=" + corpCd + ", rsNo=" + rsNo + ", mtlNo=" + mtlNo + ", rsName=" + rsName + ", rsCd="
				+ rsCd + ", mtlDsp=" + mtlDsp + ", mtlName=" + mtlName + ", lotNo=" + lotNo + ", mtlShp=" + mtlShp
				+ ", remk=" + remk + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", mode=" + mode
				+ ", ncYn=" + ncYn + ", mtlName2=" + mtlName2 + "]";
	}
	
	
	
}
