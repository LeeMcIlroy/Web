package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * @author 개발2
 * 
 * SMS발송내역VO 2020.12.04
 *
 */
public class Rm2000mVO {

	private String corpCd               = ""; // 회사코드
    private String recsNo               = ""; // SMS접수번호
    private String recsDt               = ""; // SMS접수일자
    private String branchCd             = ""; // 지사코드
    private String branchName           = ""; // 지사코드명
    private String rsNo                 = ""; // 연구과제번호
    private String rsName               = ""; // 연구과제번호명
    private String tstaCls              = ""; // 전송상태
    private String tstaClsNm            = ""; // 전송상태명
    private String tsenCls              = ""; // 전송결과
    private String tsenClsNm            = ""; // 전송결과명
    private String sendNo               = ""; // 발신번호
    private String sendName             = ""; // 발신자명
    private String receNo               = ""; // 수신번호
    private String receName             = ""; // 수신자명
    private String smsCls    	        = ""; // SMS구분 1 단문 2 장문
    private String smsClsName           = ""; // 단문, 장문
    private String title                = ""; // 제목
    private String cont                 = ""; // 내용
    private String remk                 = ""; // 비고
    private String sendmCls             = ""; // 발송구분 1 즉시발송 2 예약발송
    private String sendmClsNm           = ""; // 발송구분 1 즉시발송 2 예약발송
    private String resrDt               = ""; // 예약일자
    private String resrHr               = ""; // 예약시간
    private String resrMm               = ""; // 예약분
    private String accpDt               = ""; // 접수일시
    private String sendDt               = ""; // 발송일시
    private String retnDt               = ""; // 전송결과수신일시
    private String filenames            = ""; // 전송파일명리스트
    private String rsjNo	            = ""; // 연구대상자번호
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자
    
	public String getRsjNo() {
		return rsjNo;
	}
	public void setRsjNo(String rsjNo) {
		this.rsjNo = rsjNo;
	}
	public String getSendmClsNm() {
		return sendmClsNm;
	}
	public void setSendmClsNm(String sendmClsNm) {
		this.sendmClsNm = sendmClsNm;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getRecsNo() {
		return recsNo;
	}
	public void setRecsNo(String recsNo) {
		this.recsNo = recsNo;
	}
	public String getRecsDt() {
		return recsDt;
	}
	public void setRecsDt(String recsDt) {
		this.recsDt = recsDt;
	}
	public String getBranchCd() {
		return branchCd;
	}
	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
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
	public String getSendNo() {
		return sendNo;
	}
	public void setSendNo(String sendNo) {
		this.sendNo = sendNo;
	}
	public String getSendName() {
		return sendName;
	}
	public void setSendName(String sendName) {
		this.sendName = sendName;
	}
	public String getReceNo() {
		return receNo;
	}
	public void setReceNo(String receNo) {
		this.receNo = receNo;
	}
	public String getReceName() {
		return receName;
	}
	public void setReceName(String receName) {
		this.receName = receName;
	}
	public String getSmsCls() {
		return smsCls;
	}
	public void setSmsCls(String smsCls) {
		this.smsCls = smsCls;
	}
	public String getSmsClsName() {
		return smsClsName;
	}
	public void setSmsClsName(String smsClsName) {
		this.smsClsName = smsClsName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public String getRemk() {
		return remk;
	}
	public void setRemk(String remk) {
		this.remk = remk;
	}
	public String getSendmCls() {
		return sendmCls;
	}
	public void setSendmCls(String sendmCls) {
		this.sendmCls = sendmCls;
	}
	public String getResrDt() {
		return resrDt;
	}
	public void setResrDt(String resrDt) {
		this.resrDt = resrDt;
	}
	public String getResrHr() {
		return resrHr;
	}
	public void setResrHr(String resrHr) {
		this.resrHr = resrHr;
	}
	public String getResrMm() {
		return resrMm;
	}
	public void setResrMm(String resrMm) {
		this.resrMm = resrMm;
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
	public String getFilenames() {
		return filenames;
	}
	public void setFilenames(String filenames) {
		this.filenames = filenames;
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
		return "Rm2000mVO [corpCd=" + corpCd + ", recsNo=" + recsNo + ", recsDt=" + recsDt + ", branchCd=" + branchCd
				+ ", branchName=" + branchName + ", rsNo=" + rsNo + ", rsName=" + rsName + ", tstaCls=" + tstaCls
				+ ", tstaClsNm=" + tstaClsNm + ", tsenCls=" + tsenCls + ", tsenClsNm=" + tsenClsNm + ", sendNo="
				+ sendNo + ", sendName=" + sendName + ", receNo=" + receNo + ", receName=" + receName + ", smsCls="
				+ smsCls + ", smsClsName=" + smsClsName + ", title=" + title + ", cont=" + cont + ", remk=" + remk
				+ ", sendmCls=" + sendmCls + ", sendmClsNm=" + sendmClsNm + ", resrDt=" + resrDt + ", resrHr=" + resrHr
				+ ", resrMm=" + resrMm + ", accpDt=" + accpDt + ", sendDt=" + sendDt + ", retnDt=" + retnDt
				+ ", filenames=" + filenames + ", rsjNo=" + rsjNo + ", dataRegdt=" + dataRegdt + ", dataRegnt="
				+ dataRegnt + "]";
	}
	
	
    
    
	
	
}
