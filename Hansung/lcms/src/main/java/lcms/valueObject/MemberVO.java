package lcms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import lcms.valueObject.cmm.CmmnSearchVO;

/**
 * @author Leegh
 * 
 *         관리자VO 2020.02.27
 *
 */
public class MemberVO extends CmmnSearchVO {

	private String memberSeq = "";
	private String memberCode = "";
	private String memberPw = "";
	private String memberType = ""; // prf 교수 , std 학생
	private String name = "";
	private String hName = "";
	private String eName = "";

	private String birthYear = "";
	private String birthMonth = "";
	private String birthDay = "";

	private String post = "";
	private String addr1 = "";
	private String addr2 = "";
	private String appDate = "";
	private String resDate = "";
	private String status = "";

	private String tel1 = "";
	private String tel2 = "";
	private String tel3 = "";

	private String mobile1 = "";
	private String mobile2 = "";
	private String mobile3 = "";

	private String emailId = "";
	private String emailAdr = "";

	private String loginDateTime = "";

	// 학생
	private String stdType = "";
	private String stdCurr = "";
	private String nation = "";
	private String depart = "";

	private String step = "";
	private String gender = "";
	private String pic = "";

	private String finalEdu = "";
	private String feSchoolname = "";
	private String feCountry = "";
	private String feDateS = "";
	private String feDateE = "";

	private String trExperience = "";
	private String trGetpath = "";
	private String trTerm = "";
	
	private String tpStep 	= ""; 	//토픽 급수
	private String tpScore	= "";	//토픽 점수
	private String tpDate 	= ""; 	//토픽 날짜

	//연락처
	private String naSns = "";
	private String naTel = "";
	private String naAddr = "";

	private String emerName = "";
	private String emerRelation = "";

	private String tel1Emer = "";
	private String tel2Emer = "";
	private String tel3Emer = "";

	private String emailEmerId = "";
	private String emailEmerAdr = "";

	private String postEmer = "";
	private String addr1Emer = "";
	private String addr2Emer = "";

	private String guarName = "";
	private String guarRelation = "";

	private String tel1Guar = "";
	private String tel2Guar = "";
	private String tel3Guar = "";

	private String emailGuarId = "";
	private String emailGuarAdr = "";

	private String postGuar = "";
	private String addr1Guar = "";
	private String addr2Guar = "";

	//비자 및 여권
	private String visa1 = "";
	private String visa2 = "";
	private String entryDate = "";
	private String issueDate = "";
	private String expiryDate = "";
	private String rcIsDate = "";
	private String rcCode = "";

	private String pNumber = "";
	private String pIsDate = "";
	private String pValidity = "";

	//보험증권 및 은행
	private String insCompany = "";
	private String stockNumber = "";
	private String insSdate = "";
	private String insEdate = "";
	private String bName = "";
	private String bAccount = "";
	private String bNumber = "";
	
	private String imgPath = "";
	private String imgName = "";
	
	public MemberVO(){}

	public MemberVO(EnterVO enterVO) {
		super();
		this.memberCode = enterVO.getEnterCode();
		this.name = enterVO.getEnterName();
		this.nation = enterVO.getEnterNation();
		this.setBirth(enterVO.getEnterBirth());
		this.stdType = enterVO.getEnterStdType();
		this.setNaTel(enterVO.getEnterTel());
		this.setEmail(enterVO.getEnterEmail());
		this.eName = enterVO.getEnterEName();
		this.gender = enterVO.getEnterGender();
		this.naTel = enterVO.getEnterTel();
	}

	public String getMemberSeq() {
		return memberSeq;
	}

	public void setMemberSeq(String memberSeq) {
		this.memberSeq = memberSeq;
	}

	public String getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getMemberType() {
		return memberType;
	}

	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getBirthYear() {
		return birthYear;
	}

	public void setBirthYear(String birthYear) {
		this.birthYear = birthYear;
	}

	public String getBirthMonth() {
		return birthMonth;
	}

	public void setBirthMonth(String birthMonth) {
		this.birthMonth = birthMonth;
	}

	public String getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}

	public String getBirth() {
		if (!EgovStringUtil.isEmpty(birthYear) && !EgovStringUtil.isEmpty(birthMonth) && !EgovStringUtil.isEmpty(birthDay)) {
			return birthYear + "-" + birthMonth + "-" + birthDay;
		} else {
			return null;
		}
	}

	public void setBirth(String birth) {
		if (!EgovStringUtil.isEmpty(birth)) {
			String[] spBirth = birth.split("-");
			this.birthYear = spBirth[0];
			this.birthMonth = spBirth[1];
			this.birthDay = spBirth[2];
		}
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
		if(!EgovStringUtil.isEmpty(appDate)){
			return appDate;
		}else{
			return null;
		}
	}

	public void setAppDate(String appDate) {
		this.appDate = appDate;
	}

	public String getResDate() {
		if(!EgovStringUtil.isEmpty(resDate)){
			return resDate;
		}else{
			return null;
		}
	}

	public void setResDate(String resDate) {
		this.resDate = resDate;
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
		if (!EgovStringUtil.isEmpty(tel1) && !EgovStringUtil.isEmpty(tel2) && !EgovStringUtil.isEmpty(tel3)) {
			return tel1 + "-" + tel2 + "-" + tel3;
		} else {
			return "";
		}
	}

	public void setTel(String tel) {
		if (!EgovStringUtil.isEmpty(tel)) {
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
		if (!EgovStringUtil.isEmpty(mobile1) && !EgovStringUtil.isEmpty(mobile2) && !EgovStringUtil.isEmpty(mobile3)) {
			return mobile1 + "-" + mobile2 + "-" + mobile3;
		}else{
			return "";
		}
	}

	public void setMobile(String mobile) {
		if (!EgovStringUtil.isEmpty(mobile)) {
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

	public String getEmailAdr() {
		return emailAdr;
	}

	public void setEmailAdr(String emailAdr) {
		this.emailAdr = emailAdr;
	}

	public String getEmail() {
		if (!EgovStringUtil.isEmpty(emailId)) {
			if (!EgovStringUtil.isEmpty(emailAdr)) {
				return emailId + "@" + emailAdr;
			}
			return emailId;
		} else {
			return null;
		}
	}

	public void setEmail(String email) {
		if (!EgovStringUtil.isEmpty(email)) {
			String[] spEmail = email.split("@");

			this.emailId = spEmail[0];
			this.emailAdr = spEmail[1];
		}
	}

	public String getLoginDateTime() {
		return loginDateTime;
	}

	public void setLoginDateTime(String loginDateTime) {
		this.loginDateTime = loginDateTime;
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

	public String getFeCountry() {
		return feCountry;
	}

	public void setFeCountry(String feCountry) {
		this.feCountry = feCountry;
	}

	public String getFeDateS() {
		return feDateS;
	}

	public void setFeDateS(String feDateS) {
		this.feDateS = feDateS;
	}

	public String getFeDateE() {
		return feDateE;
	}

	public void setFeDateE(String feDateE) {
		this.feDateE = feDateE;
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

	public String getNaSns() {
		return naSns;
	}

	public void setNaSns(String naSns) {
		this.naSns = naSns;
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

	public String getTel1Emer() {
		return tel1Emer;
	}

	public void setTel1Emer(String tel1Emer) {
		this.tel1Emer = tel1Emer;
	}

	public String getTel2Emer() {
		return tel2Emer;
	}

	public void setTel2Emer(String tel2Emer) {
		this.tel2Emer = tel2Emer;
	}

	public String getTel3Emer() {
		return tel3Emer;
	}

	public void setTel3Emer(String tel3Emer) {
		this.tel3Emer = tel3Emer;
	}

	public String getTelEmer() {
		if (!EgovStringUtil.isEmpty(tel1Emer)) {
			return tel1Emer + "-" + tel2Emer + "-" + tel3Emer;
		} else {
			return null;
		}
	}

	public void setTelEmer(String telEmer) {
		if (!EgovStringUtil.isEmpty(telEmer)) {
			String[] spTelEmer = telEmer.split("-");

			this.tel1Emer = spTelEmer[0];
			this.tel2Emer = spTelEmer[1];
			this.tel3Emer = spTelEmer[2];
		}
	}

	public String getEmailEmerId() {
		return emailEmerId;
	}

	public void setEmailEmerId(String emailEmerId) {
		this.emailEmerId = emailEmerId;
	}

	public String getEmailEmerAdr() {
		return emailEmerAdr;
	}

	public void setEmailEmerAdr(String emailEmerAdr) {
		this.emailEmerAdr = emailEmerAdr;
	}

	public String getEmailEmer() {
		if (!EgovStringUtil.isEmpty(emailEmerId)) {
			if (!EgovStringUtil.isEmpty(emailAdr)) {
				return emailEmerId + "@" + emailEmerAdr;
			}
			return emailEmerId;
		} else {
			return null;
		}
	}

	public void setEmailEmer(String emailEmer) {
		if (!EgovStringUtil.isEmpty(emailEmer)) {
			String[] spEmailEmer = emailEmer.split("@");

			this.emailEmerId = spEmailEmer[0];
			this.emailEmerAdr = spEmailEmer[1];
		}
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

	public String getTel1Guar() {
		return tel1Guar;
	}

	public void setTel1Guar(String tel1Guar) {
		this.tel1Guar = tel1Guar;
	}

	public String getTel2Guar() {
		return tel2Guar;
	}

	public void setTel2Guar(String tel2Guar) {
		this.tel2Guar = tel2Guar;
	}

	public String getTel3Guar() {
		return tel3Guar;
	}

	public void setTel3Guar(String tel3Guar) {
		this.tel3Guar = tel3Guar;
	}

	public String getTelGuar() {
		if (!EgovStringUtil.isEmpty(tel1Guar)) {
			return tel1Guar + "-" + tel2Guar + "-" + tel3Guar;
		} else {
			return null;
		}
	}

	public void setTelGuar(String telGuar) {
		if (!EgovStringUtil.isEmpty(telGuar)) {
			String[] spTelGuar = telGuar.split("-");

			this.tel1Guar = spTelGuar[0];
			this.tel2Guar = spTelGuar[1];
			this.tel3Guar = spTelGuar[2];
		}
	}

	public String getEmailGuarId() {
		return emailGuarId;
	}

	public void setEmailGuarId(String emailGuarId) {
		this.emailGuarId = emailGuarId;
	}

	public String getEmailGuarAdr() {
		return emailGuarAdr;
	}

	public void setEmailGuarAdr(String emailGuarAdr) {
		this.emailGuarAdr = emailGuarAdr;
	}

	public String getEmailGuar() {
		if (!EgovStringUtil.isEmpty(emailGuarId)) {
			if (!EgovStringUtil.isEmpty(emailAdr)) {
				return emailGuarId + "@" + emailGuarAdr;
			}
			return emailGuarId;
		} else {
			return null;
		}
	}

	public void setEmailGuar(String emailGuar) {
		if (!EgovStringUtil.isEmpty(emailGuar)) {
			String[] spEmailGuar = emailGuar.split("@");

			this.emailGuarId = spEmailGuar[0];
			this.emailGuarAdr = spEmailGuar[1];
		}
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

	public String getpValidity() {
		return pValidity;
	}

	public void setpValidity(String pValidity) {
		this.pValidity = pValidity;
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

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getImgName() {
		return imgName;
	}

	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	public String getTpStep() {
		return tpStep;
	}

	public void setTpStep(String tpStep) {
		this.tpStep = tpStep;
	}

	public String getTpScore() {
		return tpScore;
	}

	public void setTpScore(String tpScore) {
		this.tpScore = tpScore;
	}

	public String getTpDate() {
		return tpDate;
	}

	public void setTpDate(String tpDate) {
		this.tpDate = tpDate;
	}

	@Override
	public String toString() {
		return "MemberVO [memberSeq=" + memberSeq + ", memberCode=" + memberCode + ", memberPw=" + memberPw
				+ ", memberType=" + memberType + ", name=" + name + ", hName=" + hName + ", eName=" + eName
				+ ", birthYear=" + birthYear + ", birthMonth=" + birthMonth + ", birthDay=" + birthDay + ", post="
				+ post + ", addr1=" + addr1 + ", addr2=" + addr2 + ", appDate=" + appDate + ", resDate=" + resDate
				+ ", status=" + status + ", tel1=" + tel1 + ", tel2=" + tel2 + ", tel3=" + tel3 + ", mobile1=" + mobile1
				+ ", mobile2=" + mobile2 + ", mobile3=" + mobile3 + ", emailId=" + emailId + ", emailAdr=" + emailAdr
				+ ", loginDateTime=" + loginDateTime + ", stdType=" + stdType + ", stdCurr=" + stdCurr + ", nation="
				+ nation + ", depart=" + depart + ", step=" + step + ", gender=" + gender + ", pic=" + pic
				+ ", finalEdu=" + finalEdu + ", feSchoolname=" + feSchoolname + ", feCountry=" + feCountry
				+ ", feDateS=" + feDateS + ", feDateE=" + feDateE + ", trExperience=" + trExperience + ", trGetpath="
				+ trGetpath + ", trTerm=" + trTerm + ", tpStep=" + tpStep + ", tpScore=" + tpScore + ", tpDate="
				+ tpDate + ", naSns=" + naSns + ", naTel=" + naTel + ", naAddr=" + naAddr + ", emerName=" + emerName
				+ ", emerRelation=" + emerRelation + ", tel1Emer=" + tel1Emer + ", tel2Emer=" + tel2Emer + ", tel3Emer="
				+ tel3Emer + ", emailEmerId=" + emailEmerId + ", emailEmerAdr=" + emailEmerAdr + ", postEmer="
				+ postEmer + ", addr1Emer=" + addr1Emer + ", addr2Emer=" + addr2Emer + ", guarName=" + guarName
				+ ", guarRelation=" + guarRelation + ", tel1Guar=" + tel1Guar + ", tel2Guar=" + tel2Guar + ", tel3Guar="
				+ tel3Guar + ", emailGuarId=" + emailGuarId + ", emailGuarAdr=" + emailGuarAdr + ", postGuar="
				+ postGuar + ", addr1Guar=" + addr1Guar + ", addr2Guar=" + addr2Guar + ", visa1=" + visa1 + ", visa2="
				+ visa2 + ", entryDate=" + entryDate + ", issueDate=" + issueDate + ", expiryDate=" + expiryDate
				+ ", rcIsDate=" + rcIsDate + ", rcCode=" + rcCode + ", pNumber=" + pNumber + ", pIsDate=" + pIsDate
				+ ", pValidity=" + pValidity + ", insCompany=" + insCompany + ", stockNumber=" + stockNumber
				+ ", insSdate=" + insSdate + ", insEdate=" + insEdate + ", bName=" + bName + ", bAccount=" + bAccount
				+ ", bNumber=" + bNumber + ", imgPath=" + imgPath + ", imgName=" + imgName + "]";
	}

}
