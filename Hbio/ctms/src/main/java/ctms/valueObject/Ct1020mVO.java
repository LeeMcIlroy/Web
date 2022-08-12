package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class Ct1020mVO {

	private String corpCd               = ""; // 회사코드
    private String branchCd             = ""; // 지사코드
    private String branchCls            = ""; // 지사구분
    private String branchClsNm          = ""; // 지사구분명
    private String branchName           = ""; // 지사명칭
    private String branchSm             = ""; // 지사약칭
    private String bregRsno             = ""; // 사업자번호
    private String corpNo               = ""; // 법인번호
    private String excutNm              = ""; // 대표자성명
    private String bsln                 = ""; // 업태
    private String bscl                 = ""; // 업종(종목)
    private String postNo               = ""; // 우편번호
    private String addrMain             = ""; // 기본주소
    private String addrGita             = ""; // 기타주소
    private String telno                = ""; // 전화번호
    private String faxno                = ""; // 팩스번호
    private String mngName              = ""; // 담당자명
    private String mngOrg               = ""; // 담당자부서명
    private String mnghpNo              = ""; // 담당자휴대폰
    private String mngEmail             = ""; // 담당자이메일
    private String remk                 = ""; // 비고
    private String useYn                = ""; // 사용여부
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자
    
	private String tel1			= ""; // 전화번호1
	private String tel2			= ""; // 전화번호2
	private String tel3			= ""; // 전화번호3
	
	private String fax1			= ""; // 전화번호1
	private String fax2			= ""; // 전화번호2
	private String fax3			= ""; // 전화번호3
	
	private String post 		= ""; // 우편번호
	private String addr1 		= ""; // 주소1
	private String addr2 		= ""; // 주소2
	
	
	
	
	
	public String getCorpCd() {
		return corpCd;
	}

	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}

	public String getBranchCd() {
		return branchCd;
	}

	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
	}

	public String getBranchCls() {
		return branchCls;
	}

	public void setBranchCls(String branchCls) {
		this.branchCls = branchCls;
	}

	public String getBranchClsNm() {
		return branchClsNm;
	}

	public void setBranchClsNm(String branchClsNm) {
		this.branchClsNm = branchClsNm;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getBranchSm() {
		return branchSm;
	}

	public void setBranchSm(String branchSm) {
		this.branchSm = branchSm;
	}

	public String getBregRsno() {
		return bregRsno;
	}

	public void setBregRsno(String bregRsno) {
		this.bregRsno = bregRsno;
	}

	public String getCorpNo() {
		return corpNo;
	}

	public void setCorpNo(String corpNo) {
		this.corpNo = corpNo;
	}

	public String getExcutNm() {
		return excutNm;
	}

	public void setExcutNm(String excutNm) {
		this.excutNm = excutNm;
	}

	public String getBsln() {
		return bsln;
	}

	public void setBsln(String bsln) {
		this.bsln = bsln;
	}

	public String getBscl() {
		return bscl;
	}

	public void setBscl(String bscl) {
		this.bscl = bscl;
	}

	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getAddrMain() {
		return addrMain;
	}

	public void setAddrMain(String addrMain) {
		this.addrMain = addrMain;
	}

	public String getAddrGita() {
		return addrGita;
	}

	public void setAddrGita(String addrGita) {
		this.addrGita = addrGita;
	}

	public String getMngName() {
		return mngName;
	}

	public void setMngName(String mngName) {
		this.mngName = mngName;
	}

	public String getMngOrg() {
		return mngOrg;
	}

	public void setMngOrg(String mngOrg) {
		this.mngOrg = mngOrg;
	}

	public String getMnghpNo() {
		return mnghpNo;
	}

	public void setMnghpNo(String mnghpNo) {
		this.mnghpNo = mnghpNo;
	}

	public String getMngEmail() {
		return mngEmail;
	}

	public void setMngEmail(String mngEmail) {
		this.mngEmail = mngEmail;
	}

	public String getRemk() {
		return remk;
	}

	public void setRemk(String remk) {
		this.remk = remk;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
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

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}

	public String getFax1() {
		return fax1;
	}

	public void setFax1(String fax1) {
		this.fax1 = fax1;
	}

	public String getFax2() {
		return fax2;
	}

	public void setFax2(String fax2) {
		this.fax2 = fax2;
	}

	public String getFax3() {
		return fax3;
	}

	public void setFax3(String fax3) {
		this.fax3 = fax3;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getTelno() {
		if (!EgovStringUtil.isEmpty(tel1) && !EgovStringUtil.isEmpty(tel2) && !EgovStringUtil.isEmpty(tel3)) {
			return tel1 + "-" + tel2 + "-" + tel3;
		}else{
			return "";
		}
	}

	public void setTelno(String telno) {
		if (!EgovStringUtil.isEmpty(telno)) {
			String[] spTel = telno.split("-");

			this.tel1 = spTel[0];
			this.tel2 = spTel[1];
			this.tel3 = spTel[2];
		}
	}

	public String getFaxno() {
		if (!EgovStringUtil.isEmpty(fax1) && !EgovStringUtil.isEmpty(fax2) && !EgovStringUtil.isEmpty(fax3)) {
			return fax1 + "-" + fax2 + "-" + fax3;
		}else{
			return "";
		}
	}

	public void setFaxno(String faxno) {
		if (!EgovStringUtil.isEmpty(faxno)) {
			String[] spFax = faxno.split("-");

			this.fax1 = spFax[0];
			this.fax2 = spFax[1];
			this.fax3 = spFax[2];
		}
	}

	@Override
	public String toString() {
		return "Ct1020mVO [corpCd=" + corpCd + ", branchCd=" + branchCd + ", branchCls=" + branchCls + ", branchClsNm="
				+ branchClsNm + ", branchName=" + branchName + ", branchSm=" + branchSm + ", bregRsno=" + bregRsno
				+ ", corpNo=" + corpNo + ", excutNm=" + excutNm + ", bsln=" + bsln + ", bscl=" + bscl + ", postNo="
				+ postNo + ", addrMain=" + addrMain + ", addrGita=" + addrGita + ", telno=" + telno + ", faxno=" + faxno
				+ ", mngName=" + mngName + ", mngOrg=" + mngOrg + ", mnghpNo=" + mnghpNo + ", mngEmail=" + mngEmail
				+ ", remk=" + remk + ", useYn=" + useYn + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt
				+ ", tel1=" + tel1 + ", tel2=" + tel2 + ", tel3=" + tel3 + ", fax1=" + fax1 + ", fax2=" + fax2
				+ ", fax3=" + fax3 + ", post=" + post + ", addr1=" + addr1 + ", addr2=" + addr2 + "]";
	}
	
	
	
	
}
