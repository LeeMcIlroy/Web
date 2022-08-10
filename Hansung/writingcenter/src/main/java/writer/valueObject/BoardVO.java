package writer.valueObject;

/**
 * @author kjhoon
 * @ 공통게시판 
 * 2017-02-02 생성
 */
public class BoardVO {
	private String brdSeq="";						//SEQ
	private String brdType="";						//구분
	private String brdTitle="";						//제목
	private String brdContent="";					//내용
	private String brdNoticeYn="";					//공지여부
	private String regId="";						//작성자
	private String regName="";						//작성자명
	private String regDate="";						//작성일
	private String brdHitcount="";					//조회수
	private String useYn="";						//게시여부
	
	/** 
	 * 제 15회 한성인 글쓰기대회 
	 */
	private String topicYn="";						//주제글여부
	private String openYear="";						//개최년도
	private String appNum="";						//모집인원
	private String appSDate="";						//신청시작일
	private String appSHour="";						//신청시작시간
	private String appSMinu="";						//신청시작분
	private String appEDate="";						//신청종료일
	private String appEHour="";						//신청종료시간
	private String appEMinu="";						//신청종료분
	private String subject1="";						//주제1
	private String subject2="";						//주제2
	private String subject3="";						//주제3
	
	/* 
	 * 첨부파일*/
	private String upSeq="";										//SEQ
	private String upOriginFileName="";								//원본파일명
	private String upSaveFileName="";								//저장파일명
	private String upSaveFilePath="";								//저장경로
	
	private String fileDeleteChk = "";		// 삭제파일 선택
	public String getFileDeleteChk() {
		return fileDeleteChk;
	}
	public void setFileDeleteChk(String fileDeleteChk) {
		this.fileDeleteChk = fileDeleteChk;
	}
	
	public String getUpSeq() {
		return upSeq;
	}
	public void setUpSeq(String upSeq) {
		this.upSeq = upSeq;
	}
	public String getUpOriginFileName() {
		return upOriginFileName;
	}
	public void setUpOriginFileName(String upOriginFileName) {
		this.upOriginFileName = upOriginFileName;
	}
	public String getUpSaveFileName() {
		return upSaveFileName;
	}
	public void setUpSaveFileName(String upSaveFileName) {
		this.upSaveFileName = upSaveFileName;
	}
	public String getUpSaveFilePath() {
		return upSaveFilePath;
	}
	public void setUpSaveFilePath(String upSaveFilePath) {
		this.upSaveFilePath = upSaveFilePath;
	}
	public String getBrdSeq() {
		return brdSeq;
	}
	public void setBrdSeq(String brdSeq) {
		this.brdSeq = brdSeq;
	}
	public String getBrdType() {
		return brdType;
	}
	public void setBrdType(String brdType) {
		this.brdType = brdType;
	}
	public String getBrdTitle() {
		return brdTitle;
	}
	public void setBrdTitle(String brdTitle) {
		this.brdTitle = brdTitle;
	}
	public String getBrdContent() {
		return brdContent;
	}
	public void setBrdContent(String brdContent) {
		this.brdContent = brdContent;
	}
	public String getBrdNoticeYn() {
		return brdNoticeYn;
	}
	public void setBrdNoticeYn(String brdNoticeYn) {
		this.brdNoticeYn = brdNoticeYn;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getBrdHitcount() {
		return brdHitcount;
	}
	public void setBrdHitcount(String brdHitcount) {
		this.brdHitcount = brdHitcount;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getTopicYn() {
		return topicYn;
	}
	public void setTopicYn(String topicYn) {
		this.topicYn = topicYn;
	}
	public String getOpenYear() {
		return openYear;
	}
	public void setOpenYear(String openYear) {
		this.openYear = openYear;
	}
	public String getAppNum() {
		return appNum;
	}
	public void setAppNum(String appNum) {
		this.appNum = appNum;
	}
	public String getAppSDate() {
		return appSDate;
	}
	public void setAppSDate(String appSDate) {
		this.appSDate = appSDate;
	}
	public String getAppSHour() {
		return appSHour;
	}
	public void setAppSHour(String appSHour) {
		this.appSHour = appSHour;
	}
	public String getAppSMinu() {
		return appSMinu;
	}
	public void setAppSMinu(String appSMinu) {
		this.appSMinu = appSMinu;
	}
	public String getAppEDate() {
		return appEDate;
	}
	public void setAppEDate(String appEDate) {
		this.appEDate = appEDate;
	}
	public String getAppEHour() {
		return appEHour;
	}
	public void setAppEHour(String appEHour) {
		this.appEHour = appEHour;
	}
	public String getAppEMinu() {
		return appEMinu;
	}
	public void setAppEMinu(String appEMinu) {
		this.appEMinu = appEMinu;
	}
	public String getSubject1() {
		return subject1;
	}
	public void setSubject1(String subject1) {
		this.subject1 = subject1;
	}
	public String getSubject2() {
		return subject2;
	}
	public void setSubject2(String subject2) {
		this.subject2 = subject2;
	}
	public String getSubject3() {
		return subject3;
	}
	public void setSubject3(String subject3) {
		this.subject3 = subject3;
	}
	@Override
	public String toString() {
		return "BoardVO [\nbrdSeq=" + brdSeq + "\n, brdType=" + brdType + "\n, brdTitle=" + brdTitle + "\n, brdContent="
				+ brdContent + "\n, brdNoticeYn=" + brdNoticeYn + "\n, regId=" + regId + "\n, regName=" + regName
				+ "\n, regDate=" + regDate + "\n, brdHitcount=" + brdHitcount + "\n, useYn=" + useYn + "\n, topicYn="
				+ topicYn + "\n, openYear=" + openYear + "\n, appNum=" + appNum + "\n, appSDate=" + appSDate
				+ "\n, appSHour=" + appSHour + "\n, appSMinu=" + appSMinu + "\n, appEDate=" + appEDate + "\n, appEHour="
				+ appEHour + "\n, appEMinu=" + appEMinu + "\n, subject1=" + subject1 + "\n, subject2=" + subject2
				+ "\n, subject3=" + subject3 + "\n, upSeq=" + upSeq + "\n, upOriginFileName=" + upOriginFileName
				+ "\n, upSaveFileName=" + upSaveFileName + "\n, upSaveFilePath=" + upSaveFilePath + "\n, fileDeleteChk="
				+ fileDeleteChk + "\n]";
	}
	
	
	
	
}
