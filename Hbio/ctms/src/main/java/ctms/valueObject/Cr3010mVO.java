package ctms.valueObject;

public class Cr3010mVO {

    private String    corpCd               = ""; // 회사코드
    private String    rsNo                 = ""; // 연구과제번호
    private String    rsiNo                = ""; // 식별번호
    private String    tempNo 	           = ""; // 템플릿번호
    private String 	  quesNo			   = ""; // 질문번호
    private String 	  answCon			   = ""; // 답변내용
    private String 	  answNum			   = ""; // 답변번호
    private String    dataRegdt            = ""; // 등록수정일시
    private String    dataRegnt            = ""; // 등록수정자
    private String    quesAbb              = ""; // 질문약어
    
    
	public String getQuesAbb() {
		return quesAbb;
	}
	public void setQuesAbb(String quesAbb) {
		this.quesAbb = quesAbb;
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
	public String getTempNo() {
		return tempNo;
	}
	public void setTempNo(String tempNo) {
		this.tempNo = tempNo;
	}
	public String getQuesNo() {
		return quesNo;
	}
	public void setQuesNo(String quesNo) {
		this.quesNo = quesNo;
	}
	public String getAnswCon() {
		return answCon;
	}
	public void setAnswCon(String answCon) {
		this.answCon = answCon;
	}
	public String getAnswNum() {
		return answNum;
	}
	public void setAnswNum(String answNum) {
		this.answNum = answNum;
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
		return "Cr3010mVO [corpCd=" + corpCd + ", rsNo=" + rsNo + ", rsiNo=" + rsiNo + ", tempNo=" + tempNo
				+ ", quesNo=" + quesNo + ", answCon=" + answCon + ", answNum=" + answNum + ", dataRegdt=" + dataRegdt
				+ ", dataRegnt=" + dataRegnt + ", quesAbb=" + quesAbb + "]";
	}
	
	
	 
}
