package ctms.valueObject;

import java.util.List;

public class Cr2030mVO {
	
    private String corpCd               = ""; // 회사코드
    private String quesNo               = ""; // 질문번호
    private String quesNm               = ""; // 질문/답변명
    private String quesType             = ""; // 질문유형
    private String useYn                = ""; // 사용여부
    private String quesCon              = ""; // 질문내용
    private String quesAbb              = ""; // 질문약어
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자
    private String delYn             	= ""; // 삭제여부 Y 삭제 N 기본값
    
    
    
    public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}

	private List<Cr2040mVO> cr2040mVOList; // 질문 목록
    public List<Cr2040mVO> getCr2040mVOList() {
		return cr2040mVOList;
	}
	public void setCr2040mVOList(List<Cr2040mVO> cr2040mVOList) {
		this.cr2040mVOList = cr2040mVOList;
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
		return "Cr2030mVO [corpCd=" + corpCd + ", quesNo=" + quesNo + ", quesNm=" + quesNm + ", quesType=" + quesType
				+ ", useYn=" + useYn + ", quesCon=" + quesCon + ", quesAbb=" + quesAbb + ", dataRegdt=" + dataRegdt
				+ ", dataRegnt=" + dataRegnt + "]";
	}
}