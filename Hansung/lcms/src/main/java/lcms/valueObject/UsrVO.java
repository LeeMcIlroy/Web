package lcms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * @author Leegh
 * 
 * 사용자VO 2020.02.27
 *
 */
public class UsrVO { 
	
	private String memberSeq		= ""; // 사용자 seq
	private String memberCode		= ""; // 아이디
	private String memberPw			= ""; // 비밀번호
	private String memberType		= ""; // 강사,학생 구분
	private String name				= ""; // 이름
	private String hName			= "";
	private String eName			= "";
	private String birth			= "";
	private String post				= "";
	private String addr1			= "";
	private String addr2			= "";
	private String appDate			= "";
	private String redDate			= "";
	private String status			= "";
	private String tel1				= "";
	private String tel2				= "";
	private String tel3				= "";
	private String mobile1			= "";
	private String mobile2			= "";
	private String mobile3			= "";
	private String emailId 			= "";
	private String emailAddr 		= "";
	private String stdType			= "";
	private String stdCurr			= "";
	private String nation			= "";
	private String depart			= "";
	private String acceIp			= "";
	private String useYn			= ""; // 사용여부
	private String loginDateTime    = ""; // 최종 로그인시간
	private String step				= "";
	private String gender			= "";
	private String pic 				= "";
	private String finalEdu			= "";
	private String feSchoolname		= "";
	private String country			= "";
	private String ffDateS			= "";
	private String ffDateE			= "";
	private String trExperience		= "";
	private String trGetpath		= "";
	private String trTerm			= "";
	private String naTel			= "";
	private String naAddr			= "";
	private String emerName			= "";
	private String emerRelation		= "";
	private String telEmer			= "";
	private String emailEmer		= "";
	private String postEmer			= "";
	private String addr1Emer		= "";
	private String addr2Emer		= "";
	private String guarName			= "";
	private String guarRelation		= "";
	private String telGuar 			= "";
	private String emailGuar		= "";
	private String postGuar			= "";
	private String addr1Guar		= "";
	private String addr2Guar		= "";
	private String entryDate		= "";
	private String issueDate		= "";
	private String expiryDate		= "";
	private String rcIsDate			= "";
	private String rcCode			= "";
	private String pNumber			= "";
	private String pIsDate			= "";
	private String pValdity			= "";
	private String insCompany		= "";
	private String stockNumber		= "";
	private String insSdate			= "";
	private String insEdate			= "";
	private String bName			= "";
	private String bAccount			= "";
	private String bNumber			= "";
	private String visa1			= "";
	private String visa2			= "";
	private String regDate			= "";
	private String updDate			= "";
	private String updIp			= "";
	private String loginFail		= "";
	
	public void setMemberSeq(String memberSeq) {
		this.memberSeq = memberSeq;
	}
	
	public String getMemberSeq() {
		return memberSeq;
	}
	
	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	
	public String getMemberCode() {
		return memberCode;
	}
	
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	
	public String getMemberPw() {
		return memberPw;
	}
	
	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	
	public String getMemberType() {
		return memberType;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	public String getUseYn() {
		return useYn;
	}
	
	public void setLoginDateTime(String loginDateTime) {
		this.loginDateTime = loginDateTime;
	}
	
	public String getLoginDateTime() {
		return loginDateTime;
	}

	public String gethName() {
		return hName;
	}

	public void sethName(String hName) {
		this.hName = hName;
	}

	public String geteName() {
		return eName;
	}

	public void seteName(String eName) {
		this.eName = eName;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
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

	public String getAppDate() {
		return appDate;
	}

	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}

	public String getRedDate() {
		return redDate;
	}

	public void setRedDate(String redDate) {
		this.redDate = redDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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
	public String getTel() {
		if(!EgovStringUtil.isEmpty(tel1) && !EgovStringUtil.isEmpty(tel2) && !EgovStringUtil.isEmpty(tel3)){
			return tel1+"-"+tel2+"-"+tel3;	
		}else{
			return "";
		}
	}
	
	public void setTel(String tel) {
		if(!EgovStringUtil.isEmpty(tel)){
			String[] spTel = tel.split("-");
			
			this.tel1 = spTel[0];
			this.tel2 = spTel[1];
			this.tel3 = spTel[2];
		}
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
	
	public String getMobile() {
		if(!EgovStringUtil.isEmpty(mobile1) && !EgovStringUtil.isEmpty(mobile2) && !EgovStringUtil.isEmpty(mobile3)){
			return mobile1+"-"+mobile2+"-"+mobile3;
		}else{
			return "";
		}
	}
	public void setMobile(String mobile) {
		if(!EgovStringUtil.isEmpty(mobile)){
			String[] spMobile = mobile.split("-");
			
			this.mobile1 = spMobile[0];
			this.mobile2 = spMobile[1];
			this.mobile3 = spMobile[2];
		}
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getEmail() {
		if(!EgovStringUtil.isEmpty(emailId) && !EgovStringUtil.isEmpty(emailAddr)){
			return emailId + "@" + emailAddr;
		}else{
			return "";
		}
	}
	public void setEmail(String email) {
		if(!EgovStringUtil.isEmpty(email)){
			String[] spEmail = email.split("@");
	
			this.emailId = spEmail[0];
			this.emailAddr = spEmail[1];
		}
	}
	public String getStdType() {
		return stdType;
	}

	public void setStdType(String stdType) {
		this.stdType = stdType;
	}

	public String getStdCurr() {
		return stdCurr;
	}

	public void setStdCurr(String stdCurr) {
		this.stdCurr = stdCurr;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getDepart() {
		return depart;
	}

	public void setDepart(String depart) {
		this.depart = depart;
	}

	public String getAcceIp() {
		return acceIp;
	}

	public void setAcceIp(String acceIp) {
		this.acceIp = acceIp;
	}

	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getFinalEdu() {
		return finalEdu;
	}

	public void setFinalEdu(String finalEdu) {
		this.finalEdu = finalEdu;
	}

	public String getFeSchoolname() {
		return feSchoolname;
	}

	public void setFeSchoolname(String feSchoolname) {
		this.feSchoolname = feSchoolname;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getFfDateS() {
		return ffDateS;
	}

	public void setFfDateS(String ffDateS) {
		this.ffDateS = ffDateS;
	}

	public String getFfDateE() {
		return ffDateE;
	}

	public void setFfDateE(String ffDateE) {
		this.ffDateE = ffDateE;
	}

	public String getTrExperience() {
		return trExperience;
	}

	public void setTrExperience(String trExperience) {
		this.trExperience = trExperience;
	}

	public String getTrGetpath() {
		return trGetpath;
	}

	public void setTrGetpath(String trGetpath) {
		this.trGetpath = trGetpath;
	}

	public String getTrTerm() {
		return trTerm;
	}

	public void setTrTerm(String trTerm) {
		this.trTerm = trTerm;
	}

	public String getNaTel() {
		return naTel;
	}

	public void setNaTel(String naTel) {
		this.naTel = naTel;
	}

	public String getNaAddr() {
		return naAddr;
	}

	public void setNaAddr(String naAddr) {
		this.naAddr = naAddr;
	}

	public String getEmerName() {
		return emerName;
	}

	public void setEmerName(String emerName) {
		this.emerName = emerName;
	}

	public String getEmerRelation() {
		return emerRelation;
	}

	public void setEmerRelation(String emerRelation) {
		this.emerRelation = emerRelation;
	}

	public String getTelEmer() {
		return telEmer;
	}

	public void setTelEmer(String telEmer) {
		this.telEmer = telEmer;
	}

	public String getEmailEmer() {
		return emailEmer;
	}

	public void setEmailEmer(String emailEmer) {
		this.emailEmer = emailEmer;
	}

	public String getPostEmer() {
		return postEmer;
	}

	public void setPostEmer(String postEmer) {
		this.postEmer = postEmer;
	}

	public String getAddr1Emer() {
		return addr1Emer;
	}

	public void setAddr1Emer(String addr1Emer) {
		this.addr1Emer = addr1Emer;
	}
	public String getAddr2Emer() {
		return addr2Emer;
	}
	public void setAddr2Emer(String addr2Emer) {
		this.addr2Emer = addr2Emer;
	}
	public String getGuarName() {
		return guarName;
	}
	public void setGuarName(String guarName) {
		this.guarName = guarName;
	}
	public String getGuarRelation() {
		return guarRelation;
	}
	public void setGuarRelation(String guarRelation) {
		this.guarRelation = guarRelation;
	}
	public String getTelGuar() {
		return telGuar;
	}
	public void setTelGuar(String telGuar) {
		this.telGuar = telGuar;
	}
	public String getEmailGuar() {
		return emailGuar;
	}
	public void setEmailGuar(String emailGuar) {
		this.emailGuar = emailGuar;
	}
	public String getPostGuar() {
		return postGuar;
	}
	public void setPostGuar(String postGuar) {
		this.postGuar = postGuar;
	}
	public String getAddr1Guar() {
		return addr1Guar;
	}
	public void setAddr1Guar(String addr1Guar) {
		this.addr1Guar = addr1Guar;
	}
	public String getAddr2Guar() {
		return addr2Guar;
	}
	public void setAddr2Guar(String addr2Guar) {
		this.addr2Guar = addr2Guar;
	}
	public String getEntryDate() {
		return entryDate;
	}
	public void setEntryDate(String entryDate) {
		this.entryDate = entryDate;
	}
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getExpiryDate() {
		return expiryDate;
	}
	public void setExpiryDate(String expiryDate) {
		this.expiryDate = expiryDate;
	}
	public String getRcIsDate() {
		return rcIsDate;
	}
	public void setRcIsDate(String rcIsDate) {
		this.rcIsDate = rcIsDate;
	}
	public String getRcCode() {
		return rcCode;
	}
	public void setRcCode(String rcCode) {
		this.rcCode = rcCode;
	}
	public String getpNumber() {
		return pNumber;
	}
	public void setpNumber(String pNumber) {
		this.pNumber = pNumber;
	}
	public String getpIsDate() {
		return pIsDate;
	}
	public void setpIsDate(String pIsDate) {
		this.pIsDate = pIsDate;
	}
	public String getpValdity() {
		return pValdity;
	}
	public void setpValdity(String pValdity) {
		this.pValdity = pValdity;
	}
	public String getInsCompany() {
		return insCompany;
	}
	public void setInsCompany(String insCompany) {
		this.insCompany = insCompany;
	}
	public String getStockNumber() {
		return stockNumber;
	}
	public void setStockNumber(String stockNumber) {
		this.stockNumber = stockNumber;
	}
	public String getInsSdate() {
		return insSdate;
	}
	public void setInsSdate(String insSdate) {
		this.insSdate = insSdate;
	}
	public String getInsEdate() {
		return insEdate;
	}
	public void setInsEdate(String insEdate) {
		this.insEdate = insEdate;
	}
	public String getbName() {
		return bName;
	}
	public void setbName(String bName) {
		this.bName = bName;
	}
	public String getbAccount() {
		return bAccount;
	}
	public void setbAccount(String bAccount) {
		this.bAccount = bAccount;
	}
	public String getbNumber() {
		return bNumber;
	}
	public void setbNumber(String bNumber) {
		this.bNumber = bNumber;
	}
	public String getVisa1() {
		return visa1;
	}
	public void setVisa1(String visa1) {
		this.visa1 = visa1;
	}
	public String getVisa2() {
		return visa2;
	}
	public void setVisa2(String visa2) {
		this.visa2 = visa2;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getUpdDate() {
		return updDate;
	}
	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}
	public String getUpdIp() {
		return updIp;
	}
	public void setUpdIp(String updIp) {
		this.updIp = updIp;
	}
	public String getLoginFail() {
		return loginFail;
	}

	public void setLoginFail(String loginFail) {
		this.loginFail = loginFail;
	}

	@Override
	public String toString() {
		return "UsrVO [memberSeq=" + memberSeq + ", memberCode=" + memberCode + ", memberPw=" + memberPw
				+ ", memberType=" + memberType + ", name=" + name + ", hName=" + hName + ", eName=" + eName + ", birth="
				+ birth + ", post=" + post + ", addr1=" + addr1 + ", addr2=" + addr2 + ", appDate=" + appDate
				+ ", redDate=" + redDate + ", status=" + status + ", tel1=" + tel1 + ", tel2=" + tel2 + ", tel3=" + tel3
				+ ", mobile1=" + mobile1 + ", mobile2=" + mobile2 + ", mobile3=" + mobile3 + ", emailId=" + emailId
				+ ", emailAddr=" + emailAddr + ", stdType=" + stdType + ", stdCurr=" + stdCurr + ", nation=" + nation
				+ ", depart=" + depart + ", acceIp=" + acceIp + ", useYn=" + useYn + ", loginDateTime=" + loginDateTime
				+ ", step=" + step + ", gender=" + gender + ", pic=" + pic + ", finalEdu=" + finalEdu
				+ ", feSchoolname=" + feSchoolname + ", country=" + country + ", ffDateS=" + ffDateS + ", ffDateE="
				+ ffDateE + ", trExperience=" + trExperience + ", trGetpath=" + trGetpath + ", trTerm=" + trTerm
				+ ", naTel=" + naTel + ", naAddr=" + naAddr + ", emerName=" + emerName + ", emerRelation="
				+ emerRelation + ", telEmer=" + telEmer + ", emailEmer=" + emailEmer + ", postEmer=" + postEmer
				+ ", addr1Emer=" + addr1Emer + ", addr2Emer=" + addr2Emer + ", guarName=" + guarName + ", guarRelation="
				+ guarRelation + ", telGuar=" + telGuar + ", emailGuar=" + emailGuar + ", postGuar=" + postGuar
				+ ", addr1Guar=" + addr1Guar + ", addr2Guar=" + addr2Guar + ", entryDate=" + entryDate + ", issueDate="
				+ issueDate + ", expiryDate=" + expiryDate + ", rcIsDate=" + rcIsDate + ", rcCode=" + rcCode
				+ ", pNumber=" + pNumber + ", pIsDate=" + pIsDate + ", pValdity=" + pValdity + ", insCompany="
				+ insCompany + ", stockNumber=" + stockNumber + ", insSdate=" + insSdate + ", insEdate=" + insEdate
				+ ", bName=" + bName + ", bAccount=" + bAccount + ", bNumber=" + bNumber + ", visa1=" + visa1
				+ ", visa2=" + visa2 + ", regDate=" + regDate + ", updDate=" + updDate + ", updIp=" + updIp
				+ ", loginFail=" + loginFail + "]";
	}
	
}
