package ctms.valueObject;

import java.util.List;

public class Cr2020mVO {
    private String corpCd               = ""; // 회사코드
    private String tempNo               = ""; // 템플릿번호
    private String tempNm               = ""; // 템플릿 명
    private String tempType             = ""; // 템플릿 구분
    private String tempTypeNm			= ""; // 템플릿 구분명
    private String useYn                = ""; // 사용여부
    private String stDate               = ""; // 사용시작일
    private String edDate               = ""; // 사용종료일
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자
    
    private String regDt            	= ""; // 등록일자
    private String termType            	= ""; // 적용시기, 사전/사후    
    
    
    
    public String getTempTypeNm() {
		return tempTypeNm;
	}
	public void setTempTypeNm(String tempTypeNm) {
		this.tempTypeNm = tempTypeNm;
	}
	public String getTermType() {
		return termType;
	}
	public void setTermType(String termType) {
		this.termType = termType;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	private List<Cr2050mVO> cr2050mVOList;
    public List<Cr2050mVO> getCr2050mVOList() {
		return cr2050mVOList;
	}
	public void setCr2050mVOList(List<Cr2050mVO> cr2050mVOList) {
		this.cr2050mVOList = cr2050mVOList;
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
    public String getTempNm() {
        return tempNm;
    }
    public void setTempNm(String tempNm) {
        this.tempNm = tempNm;
    }
    public String getTempType() {
        return tempType;
    }
    public void setTempType(String tempType) {
        this.tempType = tempType;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public String getStDate() {
		return stDate;
	}
	public void setStDate(String stDate) {
		this.stDate = stDate;
	}
	public String getEdDate() {
		return edDate;
	}
	public void setEdDate(String edDate) {
		this.edDate = edDate;
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
		return "Cr2020mVO [corpCd=" + corpCd + ", tempNo=" + tempNo + ", tempNm=" + tempNm + ", tempType=" + tempType
				+ ", tempTypeNm=" + tempTypeNm + ", useYn=" + useYn + ", stDate=" + stDate + ", edDate=" + edDate
				+ ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", regDt=" + regDt + ", termType="
				+ termType + ", cr2050mVOList=" + cr2050mVOList + "]";
	}
 
}