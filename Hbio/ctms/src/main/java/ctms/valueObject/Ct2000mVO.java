package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class Ct2000mVO {
	
	private String corpCd               = ""; // 회사코드
    private String vendNo               = ""; // 거래처번호
    private String vendCls              = ""; // 거래처구분
    private String vendClsNm            = ""; // 거래처구분명
    private String vendName             = ""; // 거래처명칭
    private String vendSm               = ""; // 거래처약칭
    private String bregRsno             = ""; // 사업자번호
    private String corpNo               = ""; // 법인번호
    private String excutName            = ""; // 대표자성명
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
    private String branchCd             = ""; // 지사코드
    private String branchName           = ""; // 지사명칭
    private String useYn                = ""; // 사용여부
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정
			
	private String tel1					= ""; // 전화번호1
	private String tel2					= ""; // 전화번호2
	private String tel3					= ""; // 전화번호3
	
	private String fax1					= ""; // 전화번호1
	private String fax2					= ""; // 전화번호2
	private String fax3					= ""; // 전화번호3
	
	private String post 				= ""; // 우편번호
	private String addr1 				= ""; // 주소1
	private String addr2 				= ""; // 주소2
	
	private String mobile1 		= "";
	private String mobile2 		= "";
	private String mobile3 		= "";
	
	private String emailId 		= "";
	private String emailAdr 	= "";
	
	private String regno1 		= "";
	private String regno2 		= "";
	private String regno3 		= "";
	
	private String cregno1 		= "";
	private String cregno2 		= "";
	
	
	public String getCregno1() {
		return cregno1;
	}
	public void setCregno1(String cregno1) {
		this.cregno1 = cregno1;
	}
	public String getCregno2() {
		return cregno2;
	}
	public void setCregno2(String cregno2) {
		this.cregno2 = cregno2;
	}
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
	}
	public String getVendNo() {
		return vendNo;
	}
	public void setVendNo(String vendNo) {
		this.vendNo = vendNo;
	}
	public String getVendCls() {
		return vendCls;
	}
	public void setVendCls(String vendCls) {
		this.vendCls = vendCls;
	}
	public String getVendClsNm() {
		return vendClsNm;
	}
	public void setVendClsNm(String vendClsNm) {
		this.vendClsNm = vendClsNm;
	}
	public String getVendName() {
		return vendName;
	}
	public void setVendName(String vendName) {
		this.vendName = vendName;
	}
	public String getVendSm() {
		return vendSm;
	}
	public void setVendSm(String vendSm) {
		this.vendSm = vendSm;
	}
	
	public String getCorpNo() {
		return corpNo;
	}
	public void setCorpNo(String corpNo) {
		this.corpNo = corpNo;
	}
	public String getExcutName() {
		return excutName;
	}
	public void setExcutName(String excutName) {
		this.excutName = excutName;
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
	public String getRemk() {
		return remk;
	}
	public void setRemk(String remk) {
		this.remk = remk;
	}
	public String getBranchCd() {
		return branchCd;
	}
	public void setBranchCd(String branchCd) {
		this.branchCd = branchCd;
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
	public String getMobile1() {
		return mobile1;
	}
	public void setMobile1(String mobile1) {
		this.mobile1 = mobile1;
	}
	public String getMobile2() {
		return mobile2;
	}
	public void setMobile2(String mobile2) {
		this.mobile2 = mobile2;
	}
	public String getMobile3() {
		return mobile3;
	}
	public void setMobile3(String mobile3) {
		this.mobile3 = mobile3;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getEmailAdr() {
		return emailAdr;
	}
	public void setEmailAdr(String emailAdr) {
		this.emailAdr = emailAdr;
	}
	public String getRegno1() {
		return regno1;
	}
	public void setRegno1(String regno1) {
		this.regno1 = regno1;
	}
	public String getRegno2() {
		return regno2;
	}
	public void setRegno2(String regno2) {
		this.regno2 = regno2;
	}
	public String getRegno3() {
		return regno3;
	}
	public void setRegno3(String regno3) {
		this.regno3 = regno3;
	}
	
	
	
	
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getMngEmail() {
		if (!EgovStringUtil.isEmpty(emailId)) {
			if (!EgovStringUtil.isEmpty(emailAdr)) {
				return emailId + "@" + emailAdr;
			}
			return emailId;
		} else {
			return null;
		}
	}
	public void setMngEmail(String mngEmail) {
		if (!EgovStringUtil.isEmpty(mngEmail)) {
			String[] spEmail = mngEmail.split("@");

			this.emailId = spEmail[0];
			this.emailAdr = spEmail[1];
		}
	}
	
	
	public String getBregRsno() {
		//if (!EgovStringUtil.isEmpty(regno1) && !EgovStringUtil.isEmpty(regno2) && !EgovStringUtil.isEmpty(regno3)) {
			//return regno1 + "-" + regno2 + "-" + regno3;
		//}else{
			//return "";
		//}
		return bregRsno;
	}
	public void setBregRsno(String bregRsno) {
		//if (!EgovStringUtil.isEmpty(bregRsno)) {
			//String[] spRegno = bregRsno.split("-");

			//this.regno1 = spRegno[0];
			//this.regno2 = spRegno[1];
			//this.regno3 = spRegno[2];
		//}
		this.bregRsno = bregRsno;

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
	
	public String getMnghpNo() {
		if (!EgovStringUtil.isEmpty(mobile1) && !EgovStringUtil.isEmpty(mobile2) && !EgovStringUtil.isEmpty(mobile3)) {
			return mobile1 + "-" + mobile2 + "-" + mobile3;
		}else{
			return "";
		}
	}
	public void setMnghpNo(String mngHphone) {
		if (!EgovStringUtil.isEmpty(mngHphone)) {
			String[] spMobile = mngHphone.split("-");

			this.mobile1 = spMobile[0];
			this.mobile2 = spMobile[1];
			this.mobile3 = spMobile[2];
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
		return "Ct2000mVO [corpCd=" + corpCd + ", vendNo=" + vendNo + ", vendCls=" + vendCls + ", vendClsNm="
				+ vendClsNm + ", vendName=" + vendName + ", vendSm=" + vendSm + ", bregRsno=" + bregRsno + ", corpNo="
				+ corpNo + ", excutName=" + excutName + ", bsln=" + bsln + ", bscl=" + bscl + ", postNo=" + postNo
				+ ", addrMain=" + addrMain + ", addrGita=" + addrGita + ", telno=" + telno + ", faxno=" + faxno
				+ ", mngName=" + mngName + ", mngOrg=" + mngOrg + ", mnghpNo=" + mnghpNo + ", mngEmail=" + mngEmail
				+ ", remk=" + remk + ", branchCd=" + branchCd + ", branchName=" + branchName + ", useYn=" + useYn
				+ ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + ", tel1=" + tel1 + ", tel2=" + tel2
				+ ", tel3=" + tel3 + ", fax1=" + fax1 + ", fax2=" + fax2 + ", fax3=" + fax3 + ", post=" + post
				+ ", addr1=" + addr1 + ", addr2=" + addr2 + ", mobile1=" + mobile1 + ", mobile2=" + mobile2
				+ ", mobile3=" + mobile3 + ", emailId=" + emailId + ", emailAdr=" + emailAdr + ", regno1=" + regno1
				+ ", regno2=" + regno2 + ", regno3=" + regno3 + ", cregno1=" + cregno1 + ", cregno2=" + cregno2 + "]";
	}
	
	
	
	

	
	
}
