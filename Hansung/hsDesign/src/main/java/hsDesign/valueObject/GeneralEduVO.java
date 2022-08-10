package hsDesign.valueObject;

/**
 * @author kjhoon 교양과정 2017.06.22 2017-07-05 추가
 */
public class GeneralEduVO {
	private String geSeq = "";			 	// 교양과정 SEQ
	private String geName = ""; 			// 교양과정명
	private String geType = ""; 			// 수강신청 상태
	private String geAplyBegin = "";		// 수강신청_시작일
	private String geAplyEnd = ""; 			// 수강신청_마지막일
	private String geLectureBegin = ""; 	// 수강기간_시작일
	private String geLectureEnd = ""; 		// 수강기간_마지막일
	private String geRegdate = ""; 			// 등록일
	private String geContent = ""; 			// 교양과정 내용
	private String geExpense = ""; 			// 수강료
	
	private String geClassrome = ""; 		// 강의실
	private String geTeacher = ""; 			// 교강사
	private String geClasstime = ""; 		// 수업시간
	private String geYear = ""; 			// 연도
	private String geSemester = ""; 		// 학기
	
	/*
	 * private String geLectureBeginTm = ""; // 수강신청_시작_시간 private String
	 * geLectureEndTm = ""; // 수강신청_끝_시간
	 */

	/** view */
	/*
	 * private String geLectureBeginTm1 = ""; // 수강신청_시작_시간1 private String
	 * geLectureBeginTm2 = ""; // 수강신청_시작_시간2 private String geLectureEndTm1 =
	 * ""; // 수강신청_끝_시간1 private String geLectureEndTm2 = ""; // 수강신청_끝_시간2
	 * 
	 * public String getGeLectureBeginTm1() { return geLectureBeginTm1; } public
	 * void setGeLectureBeginTm1(String geLectureBeginTm1) {
	 * this.geLectureBeginTm1 = geLectureBeginTm1; } public String
	 * getGeLectureBeginTm2() { return geLectureBeginTm2; } public void
	 * setGeLectureBeginTm2(String geLectureBeginTm2) { this.geLectureBeginTm2 =
	 * geLectureBeginTm2; } public String getGeLectureEndTm1() { return
	 * geLectureEndTm1; } public void setGeLectureEndTm1(String geLectureEndTm1)
	 * { this.geLectureEndTm1 = geLectureEndTm1; } public String
	 * getGeLectureEndTm2() { return geLectureEndTm2; } public void
	 * setGeLectureEndTm2(String geLectureEndTm2) { this.geLectureEndTm2 =
	 * geLectureEndTm2; }
	 */
	private String geAplyBeginWeek = ""; // 수강신청_시작일_요일
	private String geAplyEndWeek = ""; // 수강신청_마지막일_요일
	private String geLectureBeginWeek = ""; // 수강기간_시작일_요일
	private String geLectureEndWeek = ""; // 수강기간_마지막일_요일

	public String getGeAplyBeginWeek() {
		return geAplyBeginWeek;
	}

	public void setGeAplyBeginWeek(String geAplyBeginWeek) {
		this.geAplyBeginWeek = geAplyBeginWeek;
	}

	public String getGeAplyEndWeek() {
		return geAplyEndWeek;
	}

	public void setGeAplyEndWeek(String geAplyEndWeek) {
		this.geAplyEndWeek = geAplyEndWeek;
	}

	public String getGeLectureBeginWeek() {
		return geLectureBeginWeek;
	}

	public void setGeLectureBeginWeek(String geLectureBeginWeek) {
		this.geLectureBeginWeek = geLectureBeginWeek;
	}

	public String getGeLectureEndWeek() {
		return geLectureEndWeek;
	}

	public void setGeLectureEndWeek(String geLectureEndWeek) {
		this.geLectureEndWeek = geLectureEndWeek;
	}

	public String getGeSeq() {
		return geSeq;
	}

	public void setGeSeq(String geSeq) {
		this.geSeq = geSeq;
	}

	public String getGeName() {
		return geName;
	}

	public void setGeName(String geName) {
		this.geName = geName;
	}

	public String getGeType() {
		return geType;
	}

	public void setGeType(String geType) {
		this.geType = geType;
	}

	public String getGeAplyBegin() {
		return geAplyBegin;
	}

	public void setGeAplyBegin(String geAplyBegin) {
		this.geAplyBegin = geAplyBegin;
	}

	public String getGeAplyEnd() {
		return geAplyEnd;
	}

	public void setGeAplyEnd(String geAplyEnd) {
		this.geAplyEnd = geAplyEnd;
	}

	public String getGeLectureBegin() {
		return geLectureBegin;
	}

	public void setGeLectureBegin(String geLectureBegin) {
		this.geLectureBegin = geLectureBegin;
	}

	public String getGeLectureEnd() {
		return geLectureEnd;
	}

	public void setGeLectureEnd(String geLectureEnd) {
		this.geLectureEnd = geLectureEnd;
	}

	public String getGeRegdate() {
		return geRegdate;
	}

	public void setGeRegdate(String geRegdate) {
		this.geRegdate = geRegdate;
	}

	public String getGeContent() {
		return geContent;
	}

	public void setGeContent(String geContent) {
		this.geContent = geContent;
	}

	public String getGeExpense() {
		return geExpense;
	}

	public void setGeExpense(String geExpense) {
		this.geExpense = geExpense;
	}


	public String getGeClassrome() {
		return geClassrome;
	}

	public void setGeClassrome(String geClassrome) {
		this.geClassrome = geClassrome;
	}

	public String getGeTeacher() {
		return geTeacher;
	}

	public void setGeTeacher(String geTeacher) {
		this.geTeacher = geTeacher;
	}

	public String getGeClasstime() {
		return geClasstime;
	}

	public void setGeClasstime(String geClasstime) {
		this.geClasstime = geClasstime;
	}

	public String getGeYear() {
		return geYear;
	}

	public void setGeYear(String geYear) {
		this.geYear = geYear;
	}

	public String getGeSemester() {
		return geSemester;
	}

	public void setGeSemester(String geSemester) {
		this.geSemester = geSemester;
	}

	/*
	 * public String getGeLectureBeginTm() { return geLectureBeginTm; } public
	 * void setGeLectureBeginTm(String geLectureBeginTm) { String[] str =
	 * geLectureBeginTm.split(":"); setGeLectureBeginTm1(str[0]);
	 * setGeLectureBeginTm2(str[1]); this.geLectureBeginTm = geLectureBeginTm; }
	 * public String getGeLectureEndTm() { return geLectureEndTm; } public void
	 * setGeLectureEndTm(String geLectureEndTm) { String[] str =
	 * geLectureEndTm.split(":"); setGeLectureEndTm1(str[0]);
	 * setGeLectureEndTm2(str[1]); this.geLectureEndTm = geLectureEndTm; }
	 */
	/*
	 * @Override public String toString() { return "GeneralEduVO [\ngeSeq=" +
	 * geSeq + "\ngeName=" + geName + "\ngeType=" + geType + "\ngeAplyBegin=" +
	 * geAplyBegin + "\ngeAplyEnd=" + geAplyEnd + "\ngeLectureBegin=" +
	 * geLectureBegin + "\ngeLectureEnd=" + geLectureEnd + "\ngeRegdate=" +
	 * geRegdate + "\ngeContent=" + geContent + "\ngeExpense=" + geExpense +
	 * "\ngeLectureBeginTm=" + geLectureBeginTm + "\ngeLectureEndTm=" +
	 * geLectureEndTm + "\ngeLectureBeginTm1=" + geLectureBeginTm1 +
	 * "\ngeLectureBeginTm2=" + geLectureBeginTm2 + "\ngeLectureEndTm1=" +
	 * geLectureEndTm1 + "\ngeLectureEndTm2=" + geLectureEndTm2 +
	 * "\ngeAplyBeginWeek=" + geAplyBeginWeek + "\ngeAplyEndWeek=" +
	 * geAplyEndWeek + "\ngeLectureBeginWeek=" + geLectureBeginWeek +
	 * "\ngeLectureEndWeek=" + geLectureEndWeek + "\n]"; }
	 */
	@Override
	public String toString() {
		return "GeneralEduVO [geSeq=" + geSeq + "\r\n geName=" + geName + "\r\n geType=" + geType + "\r\n geAplyBegin="
				+ geAplyBegin + "\r\n geAplyEnd=" + geAplyEnd + "\r\n geLectureBegin=" + geLectureBegin
				+ "\r\n geLectureEnd=" + geLectureEnd + "\r\n geRegdate=" + geRegdate + "\r\n geContent=" + geContent
				+ "\r\n geExpense=" + geExpense + "\r\n geAplyBeginWeek=" + geAplyBeginWeek + "\r\n geAplyEndWeek="
				+ geAplyEndWeek + "\r\n geLectureBeginWeek=" + geLectureBeginWeek + "\r\n geLectureEndWeek="
				+ geLectureEndWeek + "\r\n geClassrome=" + geClassrome + "\r\n geTeacher=" + geTeacher
				+ "\r\n geClasstime=" + geClasstime + "\r\n geYear=" + geYear + "\r\n geSemester=" + geSemester 
				+ "]";
	}

}
