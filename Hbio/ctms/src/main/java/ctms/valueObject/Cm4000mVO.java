package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * @author 개발2
 * 
 * 공통코드(분류)VO 2020.12.07
 *
 */
public class Cm4000mVO {
    private String    corpCd               = ""; // 회사코드
    private String    cdCls                = ""; // 코드분류
    private String    cd                   = ""; // 공통코드
    private String    cdName               = ""; // 코드명칭
    private String    cdDesc               = ""; // 코드설명
    private String    refer1               = ""; // 참조1
    private String    refer2               = ""; // 참조2
    private String    dspSeq               = ""; // 표시순서
    private String    useYn                = ""; // 사용여부
    private String    clsCat               = ""; // 분류카테고리 1 대분류 2 중분류 3 소분류
    private String    dataRegdt            = ""; // 등록수정일시
    private String    dataRegnt            = ""; // 등록수정자
    
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getCdCls() {
		return cdCls;
	}
	public void setCdCls(String cdCls) {
		this.cdCls = cdCls;
	}
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getCdName() {
		return cdName;
	}
	public void setCdName(String cdName) {
		this.cdName = cdName;
	}
	public String getCdDesc() {
		return cdDesc;
	}
	public void setCdDesc(String cdDesc) {
		this.cdDesc = cdDesc;
	}
	public String getRefer1() {
		return refer1;
	}
	public void setRefer1(String refer1) {
		this.refer1 = refer1;
	}
	public String getRefer2() {
		return refer2;
	}
	public void setRefer2(String refer2) {
		this.refer2 = refer2;
	}
	public String getDspSeq() {
		return dspSeq;
	}
	public void setDspSeq(String dspSeq) {
		this.dspSeq = dspSeq;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getClsCat() {
		return clsCat;
	}
	public void setClsCat(String clsCat) {
		this.clsCat = clsCat;
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
		return "Cm4000mVO [corpCd=" + corpCd + ", cdCls=" + cdCls + ", cd=" + cd + ", cdName=" + cdName + ", cdDesc="
				+ cdDesc + ", refer1=" + refer1 + ", refer2=" + refer2 + ", dspSeq=" + dspSeq + ", useYn=" + useYn
				+ ", clsCat=" + clsCat + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}
	
	
	
 
  
     
}


