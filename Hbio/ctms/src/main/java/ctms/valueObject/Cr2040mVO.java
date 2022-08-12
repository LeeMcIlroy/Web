package ctms.valueObject;

public class Cr2040mVO {
	
    private String corpCd               = ""; // 회사코드
    private String quesNo               = ""; // 질문번호
    private String answCon              = ""; // 항목내용
    private String answSort             = ""; // 항목순서
    private String delYn             	= ""; // 삭제여부 Y 삭제 N 기본값
           
    public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getCorpCd() {
        return corpCd;
    }
    public void setCorpCd(String corpCd) {
        this.corpCd = corpCd;
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
    return "Cr2040mVO [corpCd            =" + corpCd
                  + ", quesNo            =" + quesNo
                  + ", answCon           =" + answCon
                  + ", answSort          =" + answSort
                  + "]";
    }
}