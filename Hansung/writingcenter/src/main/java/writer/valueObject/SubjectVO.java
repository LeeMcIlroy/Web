package writer.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * 주제
 * 	2017-01-31 최초생성
 * 	2017-02-01 수정 ( hmwkCnt 추가 )
 *	2017-02-21 수정 ( sbjtStartTime, sbjtEndTime 추가 )
 *	2018-05-24 수정 ( sbjtSort 추가 )
 *
 */
public class SubjectVO {
	private String sbjtSeq = "";			// SEQ
	private String sbjtTitle = "";			// 제목
	private String sbjtContent = "";		// 내용
	private String sbjtStartDate = "";		// 시작일
	private String sbjtStartTime = "";		// 시작시간
	private String sbjtEndDate = "";		// 종료일
	private String sbjtEndTime = "";		// 종료시간
	private String sbjtViewYn = "";			// 공개여부
	private String sbjtHitcount = "";		// 조회수
	private String regId = "";				// 등록자
	private String regName = "";			// 등록자명
	private String regDate = "";			// 등록일
	private String clsSeq = "";				// 반_교수 SEQ
	
	private String sbjtSort = "";			// 주제 정렬
	
	private String fileDeleteChk = "";		// 삭제파일 선택
	public String getFileDeleteChk() { return fileDeleteChk; }
	public void setFileDeleteChk(String fileDeleteChk) { this.fileDeleteChk = fileDeleteChk; }
	
	private String hmwkCnt = "";			// 과제 목록 수
	public String getHmwkCnt() { return hmwkCnt; }
	public void setHmwkCnt(String hmwkCnt) { this.hmwkCnt = hmwkCnt; }
	
	/* view */
	private String sbjtStartTime1 = "";		// 시작시간1
	public String getSbjtStartTime1() { return sbjtStartTime1; }
	public void setSbjtStartTime1(String sbjtStartTime1) { this.sbjtStartTime1 = sbjtStartTime1; }
	private String sbjtStartTime2 = "";		// 시작시간2
	public String getSbjtStartTime2() { return sbjtStartTime2; }
	public void setSbjtStartTime2(String sbjtStartTime2) { this.sbjtStartTime2 = sbjtStartTime2; }
	private String sbjtEndTime1 = "";		// 종료시간1
	public String getSbjtEndTime1() { return sbjtEndTime1; }
	public void setSbjtEndTime1(String sbjtEndTime1) { this.sbjtEndTime1 = sbjtEndTime1; }
	private String sbjtEndTime2 = "";		// 종료시간2
	public String getSbjtEndTime2() { return sbjtEndTime2; }
	public void setSbjtEndTime2(String sbjtEndTime2) { this.sbjtEndTime2 = sbjtEndTime2; }
	
	
	public String getSbjtSeq() {
		return sbjtSeq;
	}
	public void setSbjtSeq(String sbjtSeq) {
		this.sbjtSeq = sbjtSeq;
	}
	public String getSbjtTitle() {
		return sbjtTitle;
	}
	public void setSbjtTitle(String sbjtTitle) {
		this.sbjtTitle = sbjtTitle;
	}
	public String getSbjtContent() {
		return sbjtContent;
	}
	public void setSbjtContent(String sbjtContent) {
		this.sbjtContent = sbjtContent;
	}
	public String getSbjtStartDate() {
		return sbjtStartDate;
	}
	public void setSbjtStartDate(String sbjtStartDate) {
		this.sbjtStartDate = sbjtStartDate;
	}
	public String getSbjtStartTime() {
		return sbjtStartTime;
	}
	public void setSbjtStartTime(String sbjtStartTime) {
		this.sbjtStartTime = sbjtStartTime;
		if (!EgovStringUtil.isEmpty(sbjtStartTime)) {
			String[] str = sbjtStartTime.split(":");
			setSbjtStartTime1(str[0]);
			setSbjtStartTime2(str[1]);
		}
	}
	public String getSbjtEndDate() {
		return sbjtEndDate;
	}
	public void setSbjtEndDate(String sbjtEndDate) {
		this.sbjtEndDate = sbjtEndDate;
	}
	public String getSbjtEndTime() {
		return sbjtEndTime;
	}
	public void setSbjtEndTime(String sbjtEndTime) {
		this.sbjtEndTime = sbjtEndTime;
		if (!EgovStringUtil.isEmpty(sbjtEndTime)) {
			String[] str = sbjtEndTime.split(":");
			setSbjtEndTime1(str[0]);
			setSbjtEndTime2(str[1]);
		}
	}
	public String getSbjtViewYn() {
		return sbjtViewYn;
	}
	public void setSbjtViewYn(String sbjtViewYn) {
		this.sbjtViewYn = sbjtViewYn;
	}
	public String getSbjtHitcount() {
		return sbjtHitcount;
	}
	public void setSbjtHitcount(String sbjtHitcount) {
		this.sbjtHitcount = sbjtHitcount;
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
	public String getClsSeq() {
		return clsSeq;
	}
	public void setClsSeq(String clsSeq) {
		this.clsSeq = clsSeq;
	}
	public String getSbjtSort() {
		return sbjtSort;
	}
	public void setSbjtSort(String sbjtSort) {
		this.sbjtSort = String.valueOf(EgovStringUtil.zeroConvert(sbjtSort));
	}
	@Override
	public String toString() {
		return "SubjectVO [\nsbjtSeq=" + sbjtSeq + "\n, sbjtTitle=" + sbjtTitle + "\n, sbjtContent=" + sbjtContent
				+ "\n, sbjtStartDate=" + sbjtStartDate + "\n, sbjtStartTime=" + sbjtStartTime + "\n, sbjtEndDate="
				+ sbjtEndDate + "\n, sbjtEndTime=" + sbjtEndTime + "\n, sbjtViewYn=" + sbjtViewYn + "\n, sbjtHitcount="
				+ sbjtHitcount + "\n, regId=" + regId + "\n, regName=" + regName + "\n, regDate=" + regDate
				+ "\n, clsSeq=" + clsSeq + "\n, sbjtSort=" + sbjtSort + "\n, fileDeleteChk=" + fileDeleteChk
				+ "\n, hmwkCnt=" + hmwkCnt + "\n, sbjtStartTime1=" + sbjtStartTime1 + "\n, sbjtStartTime2="
				+ sbjtStartTime2 + "\n, sbjtEndTime1=" + sbjtEndTime1 + "\n, sbjtEndTime2=" + sbjtEndTime2 + "\n]";
	}
}
