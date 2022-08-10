package hsDesign.valueObject;

/**
 * @author kjhoon
 * 공통게시판 댓글	2017.06.22
 */
public class CBCommentVO {
	private String cbcoSeq				= ""; // 댓글 SEQ
	private String cbcoRegSeq			= ""; // 댓글 작성자 SEQ
	private String cbcoRegName			= ""; // 댓글 작성자 이름
	private String cbcoContent			= ""; // 댓글 내용
	private String cbcoRegDate			= ""; // 댓글 작성일
	private String cbcoPassword			= ""; // 댓글 비밀번호
	private String cbSeq				= ""; // 공통게시판 SEQ
	public String getCbcoSeq() {
		return cbcoSeq;
	}
	public void setCbcoSeq(String cbcoSeq) {
		this.cbcoSeq = cbcoSeq;
	}
	public String getCbcoRegSeq() {
		return cbcoRegSeq;
	}
	public void setCbcoRegSeq(String cbcoRegSeq) {
		this.cbcoRegSeq = cbcoRegSeq;
	}
	public String getCbcoRegName() {
		return cbcoRegName;
	}
	public void setCbcoRegName(String cbcoRegName) {
		this.cbcoRegName = cbcoRegName;
	}
	public String getCbcoContent() {
		return cbcoContent;
	}
	public void setCbcoContent(String cbcoContent) {
		this.cbcoContent = cbcoContent;
	}
	public String getCbcoRegDate() {
		return cbcoRegDate;
	}
	public void setCbcoRegDate(String cbcoRegDate) {
		this.cbcoRegDate = cbcoRegDate;
	}
	public String getCbcoPassword() {
		return cbcoPassword;
	}
	public void setCbcoPassword(String cbcoPassword) {
		this.cbcoPassword = cbcoPassword;
	}
	public String getCbSeq() {
		return cbSeq;
	}
	public void setCbSeq(String cbSeq) {
		this.cbSeq = cbSeq;
	}
	@Override
	public String toString() {
		return "CBCommentVO [cbcoSeq=" + cbcoSeq + "\r\n cbcoRegSeq=" + cbcoRegSeq
				+ "\r\n cbcoRegName=" + cbcoRegName + "\r\n cbcoContent="
				+ cbcoContent + "\r\n cbcoRegDate=" + cbcoRegDate
				+ "\r\n cbcoPassword=" + cbcoPassword + "\r\n cbSeq=" + cbSeq + "]";
	}
	
	
	
}
