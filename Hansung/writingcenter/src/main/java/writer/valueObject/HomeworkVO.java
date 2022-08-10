package writer.valueObject;

/**
 * 과제
 * 	2017-02-07 최초생성
 *
 */
public class HomeworkVO {
	private String hmwkSeq = "";			// SEQ
	private String hmwkContent = "";		// 내용
	private String hmwkRegId = "";			// 제출자
	private String hmwkRegName = "";		// 제출자명
	private String hmwkRegDept = "";		// 제출자학과
	private String hmwkRegDate = "";		// 제출일
	private String hmwkContent2 = "";		// 총평
	private String hmwkUpdtId = "";			// 첨삭자
	private String hmwkUpdtName = "";		// 첨삭자명
	private String hmwkUpdtDate = "";		// 첨삭일
	private String hmwkStatus = "";			// 상태
	private String hmwkHitcount = "";		// 조회수
	private String hmwkNames = "";			// 이름
	private String hmwkHakbuns = "";		// 학번
	private String hmwkDepts = "";			// 학과
	private String sbjtSeq = "";			// 주제SEQ
	
	private String fileDeleteChk = "";		// 삭제파일 선택
	public String getFileDeleteChk() { return fileDeleteChk; }
	public void setFileDeleteChk(String fileDeleteChk) { this.fileDeleteChk = fileDeleteChk; }
	
	private String prevHmwkSeq = "";		// 이전 SEQ
	private String nextHmwkSeq = "";		// 다음 SEQ
	public String getPrevHmwkSeq() { return prevHmwkSeq; }
	public void setPrevHmwkSeq(String prevHmwkSeq) { this.prevHmwkSeq = prevHmwkSeq; }
	public String getNextHmwkSeq() { return nextHmwkSeq; }
	public void setNextHmwkSeq(String nextHmwkSeq) { this.nextHmwkSeq = nextHmwkSeq; }
	
	public String getHmwkSeq() {
		return hmwkSeq;
	}
	public void setHmwkSeq(String hmwkSeq) {
		this.hmwkSeq = hmwkSeq;
	}
	public String getHmwkContent() {
		return hmwkContent;
	}
	public void setHmwkContent(String hmwkContent) {
		this.hmwkContent = hmwkContent;
	}
	public String getHmwkRegId() {
		return hmwkRegId;
	}
	public void setHmwkRegId(String hmwkRegId) {
		this.hmwkRegId = hmwkRegId;
	}
	public String getHmwkRegName() {
		return hmwkRegName;
	}
	public void setHmwkRegName(String hmwkRegName) {
		this.hmwkRegName = hmwkRegName;
	}
	public String getHmwkRegDept() {
		return hmwkRegDept;
	}
	public void setHmwkRegDept(String hmwkRegDept) {
		this.hmwkRegDept = hmwkRegDept;
	}
	public String getHmwkRegDate() {
		return hmwkRegDate;
	}
	public void setHmwkRegDate(String hmwkRegDate) {
		this.hmwkRegDate = hmwkRegDate;
	}
	public String getHmwkContent2() {
		return hmwkContent2;
	}
	public void setHmwkContent2(String hmwkContent2) {
		this.hmwkContent2 = hmwkContent2;
	}
	public String getHmwkUpdtId() {
		return hmwkUpdtId;
	}
	public void setHmwkUpdtId(String hmwkUpdtId) {
		this.hmwkUpdtId = hmwkUpdtId;
	}
	public String getHmwkUpdtName() {
		return hmwkUpdtName;
	}
	public void setHmwkUpdtName(String hmwkUpdtName) {
		this.hmwkUpdtName = hmwkUpdtName;
	}
	public String getHmwkUpdtDate() {
		return hmwkUpdtDate;
	}
	public void setHmwkUpdtDate(String hmwkUpdtDate) {
		this.hmwkUpdtDate = hmwkUpdtDate;
	}
	public String getHmwkStatus() {
		return hmwkStatus;
	}
	public void setHmwkStatus(String hmwkStatus) {
		this.hmwkStatus = hmwkStatus;
	}
	public String getHmwkHitcount() {
		return hmwkHitcount;
	}
	public void setHmwkHitcount(String hmwkHitcount) {
		this.hmwkHitcount = hmwkHitcount;
	}
	public String getHmwkNames() {
		return hmwkNames;
	}
	public void setHmwkNames(String hmwkNames) {
		this.hmwkNames = hmwkNames;
	}
	public String getHmwkHakbuns() {
		return hmwkHakbuns;
	}
	public void setHmwkHakbuns(String hmwkHakbuns) {
		this.hmwkHakbuns = hmwkHakbuns;
	}
	public String getHmwkDepts() {
		return hmwkDepts;
	}
	public void setHmwkDepts(String hmwkDepts) {
		this.hmwkDepts = hmwkDepts;
	}
	public String getSbjtSeq() {
		return sbjtSeq;
	}
	public void setSbjtSeq(String sbjtSeq) {
		this.sbjtSeq = sbjtSeq;
	}
	@Override
	public String toString() {
		return "HomeworkVO [\nhmwkSeq=" + hmwkSeq + "\n, hmwkContent=" + hmwkContent + "\n, hmwkRegId=" + hmwkRegId
				+ "\n, hmwkRegName=" + hmwkRegName + "\n, hmwkRegDept=" + hmwkRegDept + "\n, hmwkRegDate=" + hmwkRegDate
				+ "\n, hmwkContent2=" + hmwkContent2 + "\n, hmwkUpdtId=" + hmwkUpdtId + "\n, hmwkUpdtName="
				+ hmwkUpdtName + "\n, hmwkUpdtDate=" + hmwkUpdtDate + "\n, hmwkStatus=" + hmwkStatus
				+ "\n, hmwkHitcount=" + hmwkHitcount + "\n, hmwkNames=" + hmwkNames + "\n, hmwkHakbuns=" + hmwkHakbuns
				+ "\n, hmwkDepts=" + hmwkDepts + "\n, sbjtSeq=" + sbjtSeq + "\n, fileDeleteChk=" + fileDeleteChk
				+ "\n, prevHmwkSeq=" + prevHmwkSeq + "\n, nextHmwkSeq=" + nextHmwkSeq + "\n]";
	}
}
