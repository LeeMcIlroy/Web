package ctms.valueObject;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class Cr2060mVO {
	
    private String corpCd               = ""; // 회사코드
    private String tempNo               = ""; // 템플릿번호
    private String quesNo               = ""; // 질문번호
    private String answCon              = ""; // 항목내용
    private String answSort             = ""; // 항목순서
    
    public Cr2060mVO(){}
    public Cr2060mVO(EgovMap map){
    	this.corpCd = (String) map.get("corpCd");
    	this.tempNo = (String) map.get("tempNo");
    	this.quesNo = (String) map.get("quesNo");
    	this.answCon = (String) map.get("answCon");
    	this.answSort = (String) map.get("answSort");
    }
 
    public String getCorpCd() {
        return corpCd;
    }
    public void setCorpCd(String corpCd) {
        this.corpCd = corpCd;
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
    public String getAnswSort() {
        return answSort;
    }
    public void setAnswSort(String answSort) {
        this.answSort = answSort;
    }
 
    @Override
	public String toString() {
		return "Cr2060mVO [corpCd=" + corpCd + ", tempNo=" + tempNo + ", quesNo=" + quesNo + ", answCon=" + answCon
				+ ", answSort=" + answSort + "]";
	}
}