package seps.valueObject;

public class NoticeVO {

	private String noticeId = "";
	private String title = "";
	private String content = "";
	private String hitCnt = "";
	private String noticeYn = "";
	private String regDttm = "";
	private String regNm = "";
	private String udtDttm = "";
	private String udtNm = "";
	
	public String getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getHitCnt() {
		return hitCnt;
	}
	public void setHitCnt(String hitCnt) {
		this.hitCnt = hitCnt;
	}
	public String getNoticeYn() {
		return noticeYn;
	}
	public void setNoticeYn(String noticeYn) {
		this.noticeYn = noticeYn;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	public String getUdtDttm() {
		return udtDttm;
	}
	public void setUdtDttm(String udtDttm) {
		this.udtDttm = udtDttm;
	}
	public String getUdtNm() {
		return udtNm;
	}
	public void setUdtNm(String udtNm) {
		this.udtNm = udtNm;
	}
	@Override
	public String toString() {
		return "NoticeVO [noticeId=" + noticeId + ", title=" + title
				+ ", content=" + content + ", hitCnt=" + hitCnt + ", noticeYn="
				+ noticeYn + ", regDttm=" + regDttm + ", regNm=" + regNm
				+ ", udtDttm=" + udtDttm + ", udtNm=" + udtNm + "]";
	}
}
