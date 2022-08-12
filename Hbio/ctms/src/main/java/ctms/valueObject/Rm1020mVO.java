package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * @author 개발2
 * 
 * 이메일재발송관리VO 2021.01.30
 *
 */
public class Rm1020mVO {
	
	private String    corpCd               = ""; // 회사코드
    private String    recmNo               = ""; // 메일접수번호
    private String    recmDt               = ""; // 메일접수일자
    private String    orecmNo              = ""; // 원본메일접수번호
    private String    tstaCls              = ""; // 전송상태
    private String    tstaClsNm            = ""; // 전송상태명
    private String    tsenCls              = ""; // 전송결과
    private String    tsenClsNm            = ""; // 전송결과명
    private String    accpDt               = ""; // 접수일시
    private String    sendDt               = ""; // 발송일시
    private String    retnDt               = ""; // 전송결과수신일시
    private String    dataRegdt            = ""; // 등록수정일
    private String    dataRegnt            = ""; // 등록수정자
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getRecmNo() {
		return recmNo;
	}
	public void setRecmNo(String recmNo) {
		this.recmNo = recmNo;
	}
	public String getRecmDt() {
		return recmDt;
	}
	public void setRecmDt(String recmDt) {
		this.recmDt = recmDt;
	}
	public String getOrecmNo() {
		return orecmNo;
	}
	public void setOrecmNo(String orecmNo) {
		this.orecmNo = orecmNo;
	}
	public String getTstaCls() {
		return tstaCls;
	}
	public void setTstaCls(String tstaCls) {
		this.tstaCls = tstaCls;
	}
	public String getTstaClsNm() {
		return tstaClsNm;
	}
	public void setTstaClsNm(String tstaClsNm) {
		this.tstaClsNm = tstaClsNm;
	}
	public String getTsenCls() {
		return tsenCls;
	}
	public void setTsenCls(String tsenCls) {
		this.tsenCls = tsenCls;
	}
	public String getTsenClsNm() {
		return tsenClsNm;
	}
	public void setTsenClsNm(String tsenClsNm) {
		this.tsenClsNm = tsenClsNm;
	}
	public String getAccpDt() {
		return accpDt;
	}
	public void setAccpDt(String accpDt) {
		this.accpDt = accpDt;
	}
	public String getSendDt() {
		return sendDt;
	}
	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
	}
	public String getRetnDt() {
		return retnDt;
	}
	public void setRetnDt(String retnDt) {
		this.retnDt = retnDt;
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
		return "Rm1020mVO [corpCd=" + corpCd + ", recmNo=" + recmNo + ", recmDt=" + recmDt + ", orecmNo=" + orecmNo
				+ ", tstaCls=" + tstaCls + ", tstaClsNm=" + tstaClsNm + ", tsenCls=" + tsenCls + ", tsenClsNm="
				+ tsenClsNm + ", accpDt=" + accpDt + ", sendDt=" + sendDt + ", retnDt=" + retnDt + ", dataRegdt="
				+ dataRegdt + ", dataRegnt=" + dataRegnt + "]";
	}

    
  
    
	
	
	
	
	
	
	
}
