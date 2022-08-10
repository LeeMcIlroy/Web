package writer.valueObject.cmmn;

/**
 * 댓글
 * 	2017-02-01 최초생성
 *	2017-02-21 수정 (
 */
public class CmmnCommentVO {
	private String cmtSeq = "";			// SEQ
	private String cmtContent = "";		// 내용
	private String regId = "";			// 등록자
	private String regName = "";		// 등록자명
	private String regDate = "";		// 등록일
	
	private String ntSeq = "";			// 우리반게시판SEQ
	public String getNtSeq() { return ntSeq; }
	public void setNtSeq(String ntSeq) { this.ntSeq = ntSeq; }

	private String hmwkSeq = "";		// 과제SEQ
	public String getHmwkSeq() { return hmwkSeq; }
	public void setHmwkSeq(String hmwkSeq) { this.hmwkSeq = hmwkSeq; }
	
	private String brdSeq = "";			// 공통게시판SEQ
	public String getBrdSeq() { return brdSeq; }
	public void setBrdSeq(String brdSeq) { this.brdSeq = brdSeq; }
	
	public String getCmtSeq() {
		return cmtSeq;
	}
	public void setCmtSeq(String cmtSeq) {
		this.cmtSeq = cmtSeq;
	}
	public String getCmtContent() {
		return cmtContent;
	}
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
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
	@Override
	public String toString() {
		return "CmmCommentVO [\r\ncmtSeq=" + cmtSeq + "\r\n cmtContent=" + cmtContent + "\r\n regId=" + regId + "\r\n regName="
				+ regName + "\r\n regDate=" + regDate + "\r\n ntSeq=" + ntSeq + "\r\n hmwkSeq=" + hmwkSeq + "\r\n" + "\r\n brdSeq=" + brdSeq + "\r\n]";
	}
}
