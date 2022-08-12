package ctms.valueObject;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class Cr2050mVO {
	
    private String corpCd               = ""; // 회사코드
    private String tempNo               = ""; // 템플릿번호
    private String quesNo               = ""; // 질문번호
    private String quesNm               = ""; // 질문/답변명
    private String quesType             = ""; // 질문유형
    private String useYn                = ""; // 사용여부
    private String quesCon              = ""; // 질문내용
    private String quesAbb              = ""; // 질문약어
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자
    
    
    private List<Cr2060mVO> cr2060mVOList; // 질문 목록
    
    public Cr2050mVO(){}
    public Cr2050mVO(EgovMap map){
    	this.corpCd = (String) map.get("corpCd");
    	this.tempNo = (String) map.get("tempNo");
    	this.quesNo = (String) map.get("quesNo");
    	this.quesNm = (String) map.get("quesNm");
    	this.quesType = (String) map.get("quesType");
    	this.useYn = (String) map.get("useYn");
    	this.quesCon = (String) map.get("quesCon");
    	this.quesAbb = (String) map.get("quesAbb");
    }
    
    public List<Cr2060mVO> getCr2060mVOList() {
		return cr2060mVOList;
	}
	public void setCr2060mVOList(List<Cr2060mVO> cr2060mVOList) {
		this.cr2060mVOList = cr2060mVOList;
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
    public String getQuesNm() {
        return quesNm;
    }
    public void setQuesNm(String quesNm) {
        this.quesNm = quesNm;
    }
    public String getQuesType() {
        return quesType;
    }
    public void setQuesType(String quesType) {
        this.quesType = quesType;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public String getQuesCon() {
        return quesCon;
    }
    public void setQuesCon(String quesCon) {
        this.quesCon = quesCon;
    }
    public String getQuesAbb() {
        return quesAbb;
    }
    public void setQuesAbb(String quesAbb) {
        this.quesAbb = quesAbb;
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
		return "Cr2050mVO [corpCd=" + corpCd + ", tempNo=" + tempNo + ", quesNo=" + quesNo + ", quesNm=" + quesNm
				+ ", quesType=" + quesType + ", useYn=" + useYn + ", quesCon=" + quesCon + ", quesAbb=" + quesAbb
				+ ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}
}