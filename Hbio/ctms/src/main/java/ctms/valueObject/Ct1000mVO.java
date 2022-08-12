package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class Ct1000mVO {
	
	private String corpCd               = ""; // 회사코드
    private String corpName             = ""; // 회사명칭
    private String corpEm               = ""; // 영문명칭
    private String baseDt               = ""; // 설립일자
    private String bregRsno             = ""; // 사업자번호
    private String corpNo               = ""; // 법인번호
    private String excutName            = ""; // 대표자성명
    private String bsln                 = ""; // 업태
    private String bscl                 = ""; // 종목(업종)
    private String postNo               = ""; // 우편번호
    private String addrMain             = ""; // 기본주소
    private String addrGita             = ""; // 기타주소
    private String telno                = ""; // 전화번호
    private String faxno                = ""; // 팩스번호
    private String email                = ""; // 대표메일
    private String homepage             = ""; // 홈페이지
    private String useRule              = ""; // 이용약관
    private String privRule             = ""; // 개인정보처리방침
    private String cntrTelno            = ""; // 고객센터전화번호
    private String mngName              = ""; // 담당자명
    private String mngOrg               = ""; // 담당자부서명
    private String mnghpNo              = ""; // 담당자휴대폰
    private String mngEmail             = ""; // 담당자이메일
    private String privmngName          = ""; // 개인정보담당자
    private String useYn                = ""; // 사용여부
    private String useYnNm              = ""; // 사용명칭
    private String rsNo1                = ""; // 연구고유번호(3)
    private String rvNo1                = ""; // IRBM심의고유번호(7)
    private String dataRegdt            = ""; // 등록수정일
    private String dataRegnt            = ""; // 등록수정자

	private String regno1 				= ""; // 사업자등록번호1 
	private String regno2 				= ""; // 사업자등록번호2
	private String regno3 				= ""; // 사업자등록번호3
	
	private String tel1					= ""; // 전화번호1
	private String tel2					= ""; // 전화번호2
	private String tel3					= ""; // 전화번호3

	private String ctel1				= ""; // 고객센터전화번호1
	private String ctel2				= ""; // 고객센터전화번호2
	private String ctel3				= ""; // 고객센터전화번호3

	private String emailId 				= ""; // 이메일아이디
	private String emailAdr 			= ""; // 이메일주소

	private String opNo1                = ""; // 견적고유번호
	private String ctrtNo1              = ""; // 계약고유번호
	
	public String getOpNo1() {
		return opNo1;
	}
	public void setOpNo1(String opNo1) {
		this.opNo1 = opNo1;
	}
	public String getCtrtNo1() {
		return ctrtNo1;
	}
	public void setCtrtNo1(String ctrtNo1) {
		this.ctrtNo1 = ctrtNo1;
	}
	public String getUseYnNm() {
		return useYnNm;
	}
	public void setUseYnNm(String useYnNm) {
		this.useYnNm = useYnNm;
	}
	public String getRvNo1() {
		return rvNo1;
	}
	public void setRvNo1(String rvNo1) {
		this.rvNo1 = rvNo1;
	}
	public String getRsNo1() {
		return rsNo1;
	}
	public void setRsNo1(String rsNo1) {
		this.rsNo1 = rsNo1;
	}
	public String getCorpEm() {
		return corpEm;
	}
	public void setCorpEm(String corpEm) {
		this.corpEm = corpEm;
	}
	public String getBaseDt() {
		return baseDt;
	}
	public void setBaseDt(String baseDt) {
		this.baseDt = baseDt;
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
	public String getFaxno() {
		return faxno;
	}
	public void setFaxno(String faxno) {
		this.faxno = faxno;
	}	
	public String getPrivRule() {
		return privRule;
	}
	public void setPrivRule(String privRule) {
		this.privRule = privRule;
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
	public String getPrivmngName() {
		return privmngName;
	}
	public void setPrivmngName(String privmngName) {
		this.privmngName = privmngName;
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
	public String getCorpCd() {
		return corpCd;
	}
	public void setCorpCd(String corpCd) {
		this.corpCd = corpCd;
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
	public String getCtel1() {
		return ctel1;
	}
	public void setCtel1(String ctel1) {
		this.ctel1 = ctel1;
	}
	public String getCtel2() {
		return ctel2;
	}
	public void setCtel2(String ctel2) {
		this.ctel2 = ctel2;
	}
	public String getCtel3() {
		return ctel3;
	}
	public void setCtel3(String ctel3) {
		this.ctel3 = ctel3;
	}
	public String getCorpNo() {
		return corpNo;
	}
	public void setCorpNo(String corpNo) {
		this.corpNo = corpNo;
	}
	public String getCorpName() {
		return corpName;
	}
	public void setCorpName(String corpName) {
		this.corpName = corpName;
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
	public String getExcutName() {
		return excutName;
	}
	public void setExcutName(String excutName) {
		this.excutName = excutName;
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
	public String getMngName() {
		return mngName;
	}
	public void setMngName(String mngName) {
		this.mngName = mngName;
	}
	public String getMngEmail() {
		return mngEmail;
	}
	public void setMngEmail(String mngEmail) {
		this.mngEmail = mngEmail;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getCntrTelno() {
		if (!EgovStringUtil.isEmpty(ctel1) && !EgovStringUtil.isEmpty(ctel2) && !EgovStringUtil.isEmpty(ctel3)) {
			return ctel1 + "-" + ctel2 + "-" + ctel3;
		}else{
			return "";
		}
	}
	public void setCntrTelno(String cntrTelno) {
		if (!EgovStringUtil.isEmpty(cntrTelno)) {
			String[] spTel = cntrTelno.split("-");

			this.ctel1 = spTel[0];
			this.ctel2 = spTel[1];
			this.ctel3 = spTel[2];
		}

	}
	public String getEmail() {
		return email;
		//if (!EgovStringUtil.isEmpty(emailId)) {
		//	if (!EgovStringUtil.isEmpty(emailAdr)) {
		//		return emailId + "@" + emailAdr;
		//	}
		//	return emailId;
		//} else {
		//	return null;
		//}
	}
	public void setEmail(String email) {
		this.email = email;
		//if (!EgovStringUtil.isEmpty(email)) {
		//	String[] spEmail = email.split("@");

			//this.emailId = spEmail[0];
			//this.emailAdr = spEmail[1];
		//}

	}
	public String getUseRule() {
		return useRule;
	}
	public void setUseRule(String useRule) {
		this.useRule = useRule;
	}	
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	@Override
	public String toString() {
		return "Ct1000mVO [corpCd=" + corpCd + ", corpName=" + corpName + ", corpEm=" + corpEm + ", baseDt=" + baseDt
				+ ", bregRsno=" + bregRsno + ", corpNo=" + corpNo + ", excutName=" + excutName + ", bsln=" + bsln
				+ ", bscl=" + bscl + ", postNo=" + postNo + ", addrMain=" + addrMain + ", addrGita=" + addrGita
				+ ", telno=" + telno + ", faxno=" + faxno + ", email=" + email + ", homepage=" + homepage + ", useRule="
				+ useRule + ", privRule=" + privRule + ", cntrTelno=" + cntrTelno + ", mngName=" + mngName + ", mngOrg="
				+ mngOrg + ", mnghpNo=" + mnghpNo + ", mngEmail=" + mngEmail + ", privmngName=" + privmngName
				+ ", useYn=" + useYn + ", useYnNm=" + useYnNm + ", rsNo1=" + rsNo1 + ", rvNo1=" + rvNo1 + ", dataRegdt="
				+ dataRegdt + ", dataRegnt=" + dataRegnt + ", regno1=" + regno1 + ", regno2=" + regno2 + ", regno3="
				+ regno3 + ", tel1=" + tel1 + ", tel2=" + tel2 + ", tel3=" + tel3 + ", ctel1=" + ctel1 + ", ctel2="
				+ ctel2 + ", ctel3=" + ctel3 + ", emailId=" + emailId + ", emailAdr=" + emailAdr + ", opNo1=" + opNo1
				+ ", ctrtNo1=" + ctrtNo1 + "]";
	}
	
		
	
}
