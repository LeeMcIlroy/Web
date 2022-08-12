package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class Cr3200mVO {
	
	private String corpCd               = ""; // 회사코드
    private String rsNo                 = ""; // 연구과제번호
    private String rsName               = ""; // 연구과제번호명
    private String itemName             = ""; // 아이템명칭
    private String chkStdt              = ""; // 체크시작일자
    private String chkEndt              = ""; // 체크종료일자
    private String cont                 = ""; // 전달사항
    private String chkTrm               = ""; // 체크주기
    private String chkCnt               = ""; // 체크수
    private String dspName1             = ""; // 체크버튼명1
    private String dspName2             = ""; // 체크버튼명2
    private String dspName3             = ""; // 체크버튼명3
    private String dspName4             = ""; // 체크버튼명4
    private String dspName5             = ""; // 체크버튼명5
    private String tchkCnt              = ""; // 총체크수
    private String reYn                 = ""; // 아이템회수여부
    private String useYn                = ""; // 사용여부
    private String dataRegdt            = ""; // 등록수정일시
    private String dataRegnt            = ""; // 등록수정자

    
    public String getChkTrm() {
		return chkTrm;
	}
	public void setChkTrm(String chkTrm) {
		this.chkTrm = chkTrm;
	}
	public String getChkCnt() {
		return chkCnt;
	}
	public void setChkCnt(String chkCnt) {
		this.chkCnt = chkCnt;
	}
	public String getTchkCnt() {
		return tchkCnt;
	}
	public void setTchkCnt(String tchkCnt) {
		this.tchkCnt = tchkCnt;
	}
	public String getDataRegdt() {
		return dataRegdt;
	}
	public void setDataRegdt(String dataRegdt) {
		this.dataRegdt = dataRegdt;
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
    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }
    public String getChkStdt() {
        return chkStdt;
    }
    public void setChkStdt(String chkStdt) {
        this.chkStdt = chkStdt;
    }
    public String getChkEndt() {
        return chkEndt;
    }
    public void setChkEndt(String chkEndt) {
        this.chkEndt = chkEndt;
    }
    public String getCont() {
        return cont;
    }
    public void setCont(String cont) {
        this.cont = cont;
    }
    public String getDspName1() {
        return dspName1;
    }
    public void setDspName1(String dspName1) {
        this.dspName1 = dspName1;
    }
    public String getDspName2() {
        return dspName2;
    }
    public void setDspName2(String dspName2) {
        this.dspName2 = dspName2;
    }
    public String getDspName3() {
        return dspName3;
    }
    public void setDspName3(String dspName3) {
        this.dspName3 = dspName3;
    }
    public String getDspName4() {
        return dspName4;
    }
    public void setDspName4(String dspName4) {
        this.dspName4 = dspName4;
    }
    public String getDspName5() {
        return dspName5;
    }
    public void setDspName5(String dspName5) {
        this.dspName5 = dspName5;
    }
    public String getReYn() {
        return reYn;
    }
    public void setReYn(String reYn) {
        this.reYn = reYn;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public String getDataRegnt() {
        return dataRegnt;
    }
    public void setDataRegnt(String dataRegnt) {
        this.dataRegnt = dataRegnt;
    }
	@Override
	public String toString() {
		return "Cr3200mVO [corpCd=" + corpCd + ", rsNo=" + rsNo + ", rsName=" + rsName + ", itemName=" + itemName
				+ ", chkStdt=" + chkStdt + ", chkEndt=" + chkEndt + ", cont=" + cont + ", chkTrm=" + chkTrm
				+ ", chkCnt=" + chkCnt + ", dspName1=" + dspName1 + ", dspName2=" + dspName2 + ", dspName3=" + dspName3
				+ ", dspName4=" + dspName4 + ", dspName5=" + dspName5 + ", tchkCnt=" + tchkCnt + ", reYn=" + reYn
				+ ", useYn=" + useYn + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}
 
    
}
