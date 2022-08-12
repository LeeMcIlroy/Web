package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * @author 개발2
 * 
 * 이메일발송관리VO 2020.12.05
 *
 */
public class Rm1000mVO {
	
	private String    corpCd               = ""; // 회사코드
    private String    recmNo               = ""; // 메일접수번호
    private String    recmDt               = ""; // 메일접수일자
    private String    branchCd             = ""; // 지사코드
    private String    branchName           = ""; // 지사명칭
    private String    rsNo                 = ""; // 연구과제번호
    private String    rsName               = ""; // 연구과제번호명
    private String    tstaCls              = ""; // 전송상태
    private String    tstaClsNm            = ""; // 전송상태명
    private String    tsenCls              = ""; // 전송결과
    private String    tsenClsNm            = ""; // 전송결과명
    private String    sendNo               = ""; // 발신번호
    private String    sendName             = ""; // 발신자명
    private String    receNo               = ""; // 수신번호
    private String    receName             = ""; // 수신자명
    private String    sendEmail            = ""; // 발신이메일
    private String    receEmail            = ""; // 수신이메일
    private String    sendsCls             = ""; // 발송설정
    private String    sendsClsNm           = ""; // 발송설정명
    private String    sendmCls             = ""; // 발송구분
    private String    sendmClsNm           = ""; // 발송구분명
    private String    title                = ""; // 제목
    private String    cont                 = ""; // 내용
    private String    remk                 = ""; // 비고
    private String    resrDt               = ""; // 예약일자
    private String    resrHr               = ""; // 예약시간
    private String    resrMm               = ""; // 예약분
    private String    accpDt               = ""; // 접수일시
    private String    sendDt               = ""; // 발송일시
    private String    retnDt               = ""; // 전송결과수신일시
    private String    fileNames            = ""; // 전송파일명리스트
    private String    otFileNames          = ""; // 추가전송파일명리스트
    private String    emails               = ""; // 수신이메일리스트
    private String    smscont              = ""; // SMS내용
    private String    dataRegdt            = ""; // 등록수정일
    private String    dataRegnt            = ""; // 등록수정자
    private String    fileNames1            = ""; // 전송보고서1
    private String    fileNames2            = ""; // 전송보고서2
    
    private String    rsCd		            = ""; // 연구코드
    
	public String getRsCd() {
		return rsCd;
	}
	public void setRsCd(String rsCd) {
		this.rsCd = rsCd;
	}
	public String getFileNames1() {
		return fileNames1;
	}
	public void setFileNames1(String fileNames1) {
		this.fileNames1 = fileNames1;
	}
	public String getFileNames2() {
		return fileNames2;
	}
	public void setFileNames2(String fileNames2) {
		this.fileNames2 = fileNames2;
	}
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
	public String getSendEmail() {
		return sendEmail;
	}
	public void setSendEmail(String sendEmail) {
		this.sendEmail = sendEmail;
	}
	public String getReceEmail() {
		return receEmail;
	}
	public void setReceEmail(String receEmail) {
		this.receEmail = receEmail;
	}
	public String getSendsCls() {
		return sendsCls;
	}
	public void setSendsCls(String sendsCls) {
		this.sendsCls = sendsCls;
	}
	public String getSendsClsNm() {
		return sendsClsNm;
	}
	public void setSendsClsNm(String sendsClsNm) {
		this.sendsClsNm = sendsClsNm;
	}
	public String getSendmCls() {
		return sendmCls;
	}
	public void setSendmCls(String sendmCls) {
		this.sendmCls = sendmCls;
	}
	public String getSendmClsNm() {
		return sendmClsNm;
	}
	public void setSendmClsNm(String sendmClsNm) {
		this.sendmClsNm = sendmClsNm;
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
	public String getFileNames() {
		return fileNames;
	}
	public void setFileNames(String fileNames) {
		this.fileNames = fileNames;
	}
	public String getOtFileNames() {
		return otFileNames;
	}
	public void setOtFileNames(String otFileNames) {
		this.otFileNames = otFileNames;
	}
	public String getEmails() {
		return emails;
	}
	public void setEmails(String emails) {
		this.emails = emails;
	}
	public String getSmscont() {
		return smscont;
	}
	public void setSmscont(String smscont) {
		this.smscont = smscont;
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
		return "Rm1000mVO [corpCd=" + corpCd + ", recmNo=" + recmNo + ", recmDt=" + recmDt + ", branchCd=" + branchCd
				+ ", branchName=" + branchName + ", rsNo=" + rsNo + ", rsName=" + rsName + ", tstaCls=" + tstaCls
				+ ", tstaClsNm=" + tstaClsNm + ", tsenCls=" + tsenCls + ", tsenClsNm=" + tsenClsNm + ", sendNo="
				+ sendNo + ", sendName=" + sendName + ", receNo=" + receNo + ", receName=" + receName + ", sendEmail="
				+ sendEmail + ", receEmail=" + receEmail + ", sendsCls=" + sendsCls + ", sendsClsNm=" + sendsClsNm
				+ ", sendmCls=" + sendmCls + ", sendmClsNm=" + sendmClsNm + ", title=" + title + ", cont=" + cont
				+ ", remk=" + remk + ", resrDt=" + resrDt + ", resrHr=" + resrHr + ", resrMm=" + resrMm + ", accpDt="
				+ accpDt + ", sendDt=" + sendDt + ", retnDt=" + retnDt + ", fileNames=" + fileNames + ", otFileNames="
				+ otFileNames + ", emails=" + emails + ", smscont=" + smscont + ", dataRegdt=" + dataRegdt
				+ ", dataRegnt=" + dataRegnt + ", fileNames1=" + fileNames1 + ", fileNames2=" + fileNames2 + ", rsCd="
				+ rsCd + "]";
	}

	
	
	
}
