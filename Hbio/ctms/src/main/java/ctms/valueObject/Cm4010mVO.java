package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * @author 개발2
 * 
 * 공통코드(소분류)VO 2020.12.07
 *
 */
public class Cm4010mVO {

	private String commCodeNo          = ""; // 공통코드번호번호(소분류코드)
	private String commCode            = ""; // 공통코드
	private String codeName            = ""; // 코드명
	private String codeDesc            = ""; // 코드설명
	private String useYn               = ""; // 사용여부
	private String ordSeq              = ""; // 정렬순번
	private String refer1              = ""; // 참조1
	private String refer2              = ""; // 참조2
	private String commCodeclsNo       = ""; // 상위코드번호(대분류)
	private String commCodeclsName     = ""; // 상위코드명(대분류)
	private String corpCd              = ""; // 회사코드(CTMS운영)
	private String dataRegdt           = ""; // 등록수정일시
	private String dataRegnt           = ""; // 등록수정자
		
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
	public String getCommCodeNo() {
		return commCodeNo;
	}
	public void setCommCodeNo(String commCodeNo) {
		this.commCodeNo = commCodeNo;
	}
	public String getCommCode() {
		return commCode;
	}
	public void setCommCode(String commCode) {
		this.commCode = commCode;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getCodeDesc() {
		return codeDesc;
	}
	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getOrdSeq() {
		return ordSeq;
	}
	public void setOrdSeq(String ordSeq) {
		this.ordSeq = ordSeq;
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
	public String getCommCodeclsNo() {
		return commCodeclsNo;
	}
	public void setCommCodeclsNo(String commCodeclsNo) {
		this.commCodeclsNo = commCodeclsNo;
	}
	public String getCommCodeclsName() {
		return commCodeclsName;
	}
	public void setCommCodeclsName(String commCodeclsName) {
		this.commCodeclsName = commCodeclsName;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	@Override
	public String toString() {
		return "Cm4010mVO [commCodeNo=" + commCodeNo + ", commCode=" + commCode + ", codeName=" + codeName
				+ ", codeDesc=" + codeDesc + ", useYn=" + useYn + ", ordSeq=" + ordSeq + ", refer1=" + refer1
				+ ", refer2=" + refer2 + ", commCodeclsNo=" + commCodeclsNo + ", commCodeclsName=" + commCodeclsName
				+ ", corpCd=" + corpCd + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}
	
	
	
	
	
		
	
	
}
