package writer.valueObject;

/**
 * 상담신청&공통질문답변&재학생답변&외국인답변
 *	2017-02-08 최초생성
 *	2017-02-09 수정 (재학생과 외국인 답변 추가)
 *				추가 (상담일자, 상담시간 추가)
 *	2017-02-10 추가 (수정여부 추가)
 *	2017-06-16 추가 (신청자 대학, 신청자 학적)
 */
public class CnsltApplyVO {
	private String aplySeq = "";			// 신청SEQ
	private String aplyType = "";			// 구분(1온라인 2면대면)
	private String aplyUsrType = "";		// 신청자타입(REGI재학생 OVER외국인)
	private String aplyGrade = "";			// 신청자 학년
	private String aplyHakbun = "";			// 신청자 학번
	private String aplyDept = "";			// 신청자 학과
	private String aplyName = "";			// 신청자 이름
	private String aplyMphone = "";			// 신청자 휴대폰번호
	private String aplyCourseName = "";		// 강좌명
	private String aplyStatus = "";			// 상태(1신청완료 2상담완료 3불참)
	private String regDate = "";			// 등록일
	private String aplyAdmMemo = "";		// 관리자 메모
	private String updtId = "";				// 수정자
	private String updtName = ""; 			// 수정자명
	private String updtDate = "";			// 수정일
	private String schSeq = "";				// 상담일정SEQ
	
	private String aplyCollege = "";		// 신청자 대학
	private String aplyRegistYn = "";		// 신청자 학적
	
	/* view */
	private String aplyMphone1 = "";		// 휴대폰번호1
	private String aplyMphone2 = "";		// 휴대폰번호2
	private String aplyMphone3 = "";		// 휴대폰번호3
	public String getAplyMphone1() { return aplyMphone1; }
	public void setAplyMphone1(String aplyMphone1) { this.aplyMphone1 = aplyMphone1; }
	public String getAplyMphone2() { return aplyMphone2; }
	public void setAplyMphone2(String aplyMphone2) { this.aplyMphone2 = aplyMphone2; }
	public String getAplyMphone3() { return aplyMphone3; }
	public void setAplyMphone3(String aplyMphone3) { this.aplyMphone3 = aplyMphone3; }
	
	private String schYmd = "";				// 상담 일자
	public String getSchYmd() { return schYmd; }
	public void setSchYmd(String schYmd) { this.schYmd = schYmd; }
	private String schHm = "";				// 상담 시간
	public String getSchHm() { return schHm; }
	public void setSchHm(String schHm) { this.schHm = schHm; }
	
	private String updtYn = "";				// 수정여부
	public String getUpdtYn() { return updtYn; }
	public void setUpdtYn(String updtYn) { this.updtYn = updtYn; }

	/** 공통 질문답변 */
	private String tansSeq = "";			// 공통 답변 SEQ
	private String tans1 = "";				// 질문1_답
	private String tans2 = "";				// 질문2 답
	
	/** 재학생 답변 */
	private String regiAnsSeq = "";			// SEQ
	private String regiAns1 = "";			// 질문1_답
	private String regiAns1Txt = "";		// 질문1_답Txt
	private String regiAns2 = "";			// 질문2_답
	private String regiAns3A = "";			// 질문3_답1
	private String regiAns3B = "";			// 질문3_답2
	private String regiAns3C = "";			// 질문3_답3
	private String regiAns3D = "";			// 질문3_답4
	private String regiAns3E = "";			// 질문3_답5
	private String regiAns3F = "";			// 질문3_답6
	private String regiAns3G = "";			// 질문3_답7
	private String regiAns3H = "";			// 질문3_답8
	private String regiAns3I = "";			// 질문3_답9
	private String regiAns3Txt = "";		// 질문3_답Txt
	private String regiAns4Txt = "";		// 질문4_답Txt
	private String regiAns5Txt = "";		// 질문5_답Txt
	
	/** 외국인 답변 */
	private String overAnsSeq = "";			// SEQ
	private String overAns1 = "";			// 질문1_답
	private String overAns1Txt = "";		// 질문1_답Txt
	private String overAns2A = "";			// 질문2_답1
	private String overAns2B = "";			// 질문2_답2
	private String overAns2C = "";			// 질문2_답3
	private String overAns2D = "";			// 질문2_답4
	private String overAns2E = "";			// 질문2_답5
	private String overAns2F = "";			// 질문2_답6
	private String overAns2Txt = "";		// 질문2_답Txt
	private String overAns3 = "";			// 질문3_답
	
	public String getAplySeq() {
		return aplySeq;
	}
	public void setAplySeq(String aplySeq) {
		this.aplySeq = aplySeq;
	}
	public String getAplyType() {
		return aplyType;
	}
	public void setAplyType(String aplyType) {
		this.aplyType = aplyType;
	}
	public String getAplyUsrType() {
		return aplyUsrType;
	}
	public void setAplyUsrType(String aplyUsrType) {
		this.aplyUsrType = aplyUsrType;
	}
	public String getAplyGrade() {
		return aplyGrade;
	}
	public void setAplyGrade(String aplyGrade) {
		this.aplyGrade = aplyGrade;
	}
	public String getAplyHakbun() {
		return aplyHakbun;
	}
	public void setAplyHakbun(String aplyHakbun) {
		this.aplyHakbun = aplyHakbun;
	}
	public String getAplyDept() {
		return aplyDept;
	}
	public void setAplyDept(String aplyDept) {
		this.aplyDept = aplyDept;
	}
	public String getAplyName() {
		return aplyName;
	}
	public void setAplyName(String aplyName) {
		this.aplyName = aplyName;
	}
	public String getAplyMphone() {
		return aplyMphone;
	}
	public void setAplyMphone(String aplyMphone) {
		this.aplyMphone = aplyMphone;
		String[] str = aplyMphone.split("-");
		setAplyMphone1(str[0]);
		setAplyMphone2(str[1]);
		setAplyMphone3(str[2]);
	}
	public String getAplyCourseName() {
		return aplyCourseName;
	}
	public void setAplyCourseName(String aplyCourseName) {
		this.aplyCourseName = aplyCourseName;
	}
	public String getAplyStatus() {
		return aplyStatus;
	}
	public void setAplyStatus(String aplyStatus) {
		this.aplyStatus = aplyStatus;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getAplyAdmMemo() {
		return aplyAdmMemo;
	}
	public void setAplyAdmMemo(String aplyAdmMemo) {
		this.aplyAdmMemo = aplyAdmMemo;
	}
	public String getUpdtId() {
		return updtId;
	}
	public void setUpdtId(String updtId) {
		this.updtId = updtId;
	}
	public String getUpdtName() {
		return updtName;
	}
	public void setUpdtName(String updtName) {
		this.updtName = updtName;
	}
	public String getUpdtDate() {
		return updtDate;
	}
	public void setUpdtDate(String updtDate) {
		this.updtDate = updtDate;
	}
	public String getSchSeq() {
		return schSeq;
	}
	public void setSchSeq(String schSeq) {
		this.schSeq = schSeq;
	}
	public String getTansSeq() {
		return tansSeq;
	}
	public void setTansSeq(String tansSeq) {
		this.tansSeq = tansSeq;
	}
	public String getTans1() {
		return tans1;
	}
	public void setTans1(String tans1) {
		this.tans1 = tans1;
	}
	public String getTans2() {
		return tans2;
	}
	public void setTans2(String tans2) {
		this.tans2 = tans2;
	}
	public String getRegiAnsSeq() {
		return regiAnsSeq;
	}
	public void setRegiAnsSeq(String regiAnsSeq) {
		this.regiAnsSeq = regiAnsSeq;
	}
	public String getRegiAns1() {
		return regiAns1;
	}
	public void setRegiAns1(String regiAns1) {
		this.regiAns1 = regiAns1;
	}
	public String getRegiAns1Txt() {
		return regiAns1Txt;
	}
	public void setRegiAns1Txt(String regiAns1Txt) {
		this.regiAns1Txt = regiAns1Txt;
	}
	public String getRegiAns2() {
		return regiAns2;
	}
	public void setRegiAns2(String regiAns2) {
		this.regiAns2 = regiAns2;
	}
	public String getRegiAns3A() {
		return regiAns3A;
	}
	public void setRegiAns3A(String regiAns3A) {
		this.regiAns3A = regiAns3A;
	}
	public String getRegiAns3B() {
		return regiAns3B;
	}
	public void setRegiAns3B(String regiAns3B) {
		this.regiAns3B = regiAns3B;
	}
	public String getRegiAns3C() {
		return regiAns3C;
	}
	public void setRegiAns3C(String regiAns3C) {
		this.regiAns3C = regiAns3C;
	}
	public String getRegiAns3D() {
		return regiAns3D;
	}
	public void setRegiAns3D(String regiAns3D) {
		this.regiAns3D = regiAns3D;
	}
	public String getRegiAns3E() {
		return regiAns3E;
	}
	public void setRegiAns3E(String regiAns3E) {
		this.regiAns3E = regiAns3E;
	}
	public String getRegiAns3F() {
		return regiAns3F;
	}
	public void setRegiAns3F(String regiAns3F) {
		this.regiAns3F = regiAns3F;
	}
	public String getRegiAns3G() {
		return regiAns3G;
	}
	public void setRegiAns3G(String regiAns3G) {
		this.regiAns3G = regiAns3G;
	}
	public String getRegiAns3H() {
		return regiAns3H;
	}
	public void setRegiAns3H(String regiAns3H) {
		this.regiAns3H = regiAns3H;
	}
	public String getRegiAns3I() {
		return regiAns3I;
	}
	public void setRegiAns3I(String regiAns3I) {
		this.regiAns3I = regiAns3I;
	}
	public String getRegiAns3Txt() {
		return regiAns3Txt;
	}
	public void setRegiAns3Txt(String regiAns3Txt) {
		this.regiAns3Txt = regiAns3Txt;
	}
	public String getRegiAns4Txt() {
		return regiAns4Txt;
	}
	public void setRegiAns4Txt(String regiAns4Txt) {
		this.regiAns4Txt = regiAns4Txt;
	}
	public String getRegiAns5Txt() {
		return regiAns5Txt;
	}
	public void setRegiAns5Txt(String regiAns5Txt) {
		this.regiAns5Txt = regiAns5Txt;
	}
	public String getOverAnsSeq() {
		return overAnsSeq;
	}
	public void setOverAnsSeq(String overAnsSeq) {
		this.overAnsSeq = overAnsSeq;
	}
	public String getOverAns1() {
		return overAns1;
	}
	public void setOverAns1(String overAns1) {
		this.overAns1 = overAns1;
	}
	public String getOverAns1Txt() {
		return overAns1Txt;
	}
	public void setOverAns1Txt(String overAns1Txt) {
		this.overAns1Txt = overAns1Txt;
	}
	public String getOverAns2A() {
		return overAns2A;
	}
	public void setOverAns2A(String overAns2A) {
		this.overAns2A = overAns2A;
	}
	public String getOverAns2B() {
		return overAns2B;
	}
	public void setOverAns2B(String overAns2B) {
		this.overAns2B = overAns2B;
	}
	public String getOverAns2C() {
		return overAns2C;
	}
	public void setOverAns2C(String overAns2C) {
		this.overAns2C = overAns2C;
	}
	public String getOverAns2D() {
		return overAns2D;
	}
	public void setOverAns2D(String overAns2D) {
		this.overAns2D = overAns2D;
	}
	public String getOverAns2E() {
		return overAns2E;
	}
	public void setOverAns2E(String overAns2E) {
		this.overAns2E = overAns2E;
	}
	public String getOverAns2F() {
		return overAns2F;
	}
	public void setOverAns2F(String overAns2F) {
		this.overAns2F = overAns2F;
	}
	public String getOverAns2Txt() {
		return overAns2Txt;
	}
	public void setOverAns2Txt(String overAns2Txt) {
		this.overAns2Txt = overAns2Txt;
	}
	public String getOverAns3() {
		return overAns3;
	}
	public void setOverAns3(String overAns3) {
		this.overAns3 = overAns3;
	}
	public String getAplyCollege() {
		return aplyCollege;
	}
	public void setAplyCollege(String aplyCollege) {
		this.aplyCollege = aplyCollege;
	}
	public String getAplyRegistYn() {
		return aplyRegistYn;
	}
	public void setAplyRegistYn(String aplyRegistYn) {
		this.aplyRegistYn = aplyRegistYn;
	}
	@Override
	public String toString() {
		return "CnsltApplyVO [\r\naplySeq=" + aplySeq + "\r\n aplyType=" + aplyType + "\r\n aplyUsrType=" + aplyUsrType
				+ "\r\n aplyGrade=" + aplyGrade + "\r\n aplyHakbun=" + aplyHakbun + "\r\n aplyDept=" + aplyDept + "\r\n aplyName="
				+ aplyName + "\r\n aplyMphone=" + aplyMphone + "\r\n aplyCourseName=" + aplyCourseName + "\r\n aplyStatus="
				+ aplyStatus + "\r\n regDate=" + regDate + "\r\n aplyAdmMemo=" + aplyAdmMemo + "\r\n updtId=" + updtId
				+ "\r\n updtName=" + updtName + "\r\n updtDate=" + updtDate + "\r\n schSeq=" + schSeq + "\r\n aplyCollege="
				+ aplyCollege + "\r\n aplyRegistYn=" + aplyRegistYn + "\r\n aplyMphone1=" + aplyMphone1 + "\r\n aplyMphone2="
				+ aplyMphone2 + "\r\n aplyMphone3=" + aplyMphone3 + "\r\n schYmd=" + schYmd + "\r\n schHm=" + schHm + "\r\n updtYn="
				+ updtYn + "\r\n tansSeq=" + tansSeq + "\r\n tans1=" + tans1 + "\r\n tans2=" + tans2 + "\r\n regiAnsSeq="
				+ regiAnsSeq + "\r\n regiAns1=" + regiAns1 + "\r\n regiAns1Txt=" + regiAns1Txt + "\r\n regiAns2=" + regiAns2
				+ "\r\n regiAns3A=" + regiAns3A + "\r\n regiAns3B=" + regiAns3B + "\r\n regiAns3C=" + regiAns3C + "\r\n regiAns3D="
				+ regiAns3D + "\r\n regiAns3E=" + regiAns3E + "\r\n regiAns3F=" + regiAns3F + "\r\n regiAns3G=" + regiAns3G
				+ "\r\n regiAns3H=" + regiAns3H + "\r\n regiAns3I=" + regiAns3I + "\r\n regiAns3Txt=" + regiAns3Txt
				+ "\r\n regiAns4Txt=" + regiAns4Txt + "\r\n regiAns5Txt=" + regiAns5Txt + "\r\n overAnsSeq=" + overAnsSeq
				+ "\r\n overAns1=" + overAns1 + "\r\n overAns1Txt=" + overAns1Txt + "\r\n overAns2A=" + overAns2A
				+ "\r\n overAns2B=" + overAns2B + "\r\n overAns2C=" + overAns2C + "\r\n overAns2D=" + overAns2D + "\r\n overAns2E="
				+ overAns2E + "\r\n overAns2F=" + overAns2F + "\r\n overAns2Txt=" + overAns2Txt + "\r\n overAns3=" + overAns3
				+ "\r\n]";
	}
}
