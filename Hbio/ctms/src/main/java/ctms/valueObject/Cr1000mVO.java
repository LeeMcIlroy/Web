package ctms.valueObject;

public class Cr1000mVO {
    private String corpCd               = ""; // 회사코드
    private String rsNo                 = ""; // 연구과제번호
    private String rsName               = ""; // 연구과제번호명
    private String tempNo               = ""; // 탬플릿번호
    private String svSeq                = ""; // 설문차수
    private String svCnt                = ""; // 설문횟수
    private String title                = ""; // 설문명
    private String content              = ""; // 조사내용
    private String svStdt               = ""; // 설문시작일자
    private String svEndt               = ""; // 설문종료일자
    private String mtCls                = ""; // 방문여부
    private String mtClsNm              = ""; // 방문여부명
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자
    
    private String tempType             = ""; // 템플릿구분
    
	public String getTempType() {
		return tempType;
	}
	public void setTempType(String tempType) {
		this.tempType = tempType;
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
	public String getSvSeq() {
		return svSeq;
	}
	public void setSvSeq(String svSeq) {
		this.svSeq = svSeq;
	}
	public String getSvCnt() {
		return svCnt;
	}
	public void setSvCnt(String svCnt) {
		this.svCnt = svCnt;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSvStdt() {
		return svStdt;
	}
	public void setSvStdt(String svStdt) {
		this.svStdt = svStdt;
	}
	public String getSvEndt() {
		return svEndt;
	}
	public void setSvEndt(String svEndt) {
		this.svEndt = svEndt;
	}
	public String getMtCls() {
		return mtCls;
	}
	public void setMtCls(String mtCls) {
		this.mtCls = mtCls;
	}
	public String getMtClsNm() {
		return mtClsNm;
	}
	public void setMtClsNm(String mtClsNm) {
		this.mtClsNm = mtClsNm;
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
		return "Cr1000mVO [corpCd=" + corpCd + ", rsNo=" + rsNo + ", rsName=" + rsName + ", tempNo=" + tempNo
				+ ", svSeq=" + svSeq + ", svCnt=" + svCnt + ", title=" + title + ", content=" + content + ", svStdt="
				+ svStdt + ", svEndt=" + svEndt + ", mtCls=" + mtCls + ", mtClsNm=" + mtClsNm + ", dataRegdt="
				+ dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}
}