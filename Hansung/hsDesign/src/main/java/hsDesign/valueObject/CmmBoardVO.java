package hsDesign.valueObject;

/**
 * @author kjhoon 공통게시판 2017.06.22 2017-06-28 추가 (썸네일타입, 이미지명, 이미지파일경로, url주소)
 * 
 */
public class CmmBoardVO {
	private String cbSeq = ""; // 공통게시판 SEQ
	private String cbName = ""; // 게시판 이름
	private String regSeq = ""; // 게시글 작성자 SEQ
	private String regName = ""; // 게시글 작성자 이름
	private String cbTitle = ""; // 게시글 제목
	private String cbContent = ""; // 게시글 내용
	private String cbRegDate = ""; // 게시글 등록일
	private String cbCount = ""; // 게시글 조회수
	private String cbNoticeYn = ""; // 게시글 공지여부
	private String cbSecretYn = ""; // 게시글 비밀글 여부
	private String cbPassword = ""; // 게시글 비밀번호
	private String cbType = ""; // 게시판 타입
	private String cbThType = ""; // 썸네일타입
	private String cbThImgName = ""; // 이미지명
	private String cbThImgPath = ""; // 이미지파일경로
	private String cbThUrl = ""; // url 주소
	private String cbNoticeDate = ""; // 공지일
	private String cbContentReply = ""; // RE답변글
	private String cbConReplyName = ""; // RE답변글 작성자 admin 이름
	private String cbConReplyDate = ""; // RE답변글 날짜
	
	private String cbGubun = "";

	public String getCbSeq() {
		return cbSeq;
	}

	public void setCbSeq(String cbSeq) {
		this.cbSeq = cbSeq;
	}

	public String getCbName() {
		return cbName;
	}

	public void setCbName(String cbName) {
		this.cbName = cbName;
	}

	public String getRegSeq() {
		return regSeq;
	}

	public void setRegSeq(String regSeq) {
		this.regSeq = regSeq;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public String getCbTitle() {

		return cbTitle;
	}

	public void setCbTitle(String cbTitle) {

		this.cbTitle = cbTitle;
	}

	public String getCbContent() {
		return cbContent;
	}

	public void setCbContent(String cbContent) {
		this.cbContent = cbContent;
	}

	public String getCbRegDate() {
		return cbRegDate;
	}

	public void setCbRegDate(String cbRegDate) {
		this.cbRegDate = cbRegDate;
	}

	public String getCbCount() {
		return cbCount;
	}

	public void setCbCount(String cbCount) {
		this.cbCount = cbCount;
	}

	public String getCbNoticeYn() {
		return cbNoticeYn;
	}

	public void setCbNoticeYn(String cbNoticeYn) {
		this.cbNoticeYn = cbNoticeYn;
	}

	public String getCbSecretYn() {
		return cbSecretYn;
	}

	public void setCbSecretYn(String cbSecretYn) {
		this.cbSecretYn = cbSecretYn;
	}

	public String getCbPassword() {
		return cbPassword;
	}

	public void setCbPassword(String cbPassword) {
		this.cbPassword = cbPassword;
	}

	public String getCbType() {
		return cbType;
	}

	public void setCbType(String cbType) {
		this.cbType = cbType;
	}

	public String getCbThType() {
		return cbThType;
	}

	public void setCbThType(String cbThType) {
		this.cbThType = cbThType;
	}

	public String getCbThImgName() {
		return cbThImgName;
	}

	public void setCbThImgName(String cbThImgName) {
		this.cbThImgName = cbThImgName;
	}

	public String getCbThImgPath() {
		return cbThImgPath;
	}

	public void setCbThImgPath(String cbThImgPath) {
		this.cbThImgPath = cbThImgPath;
	}

	public String getCbThUrl() {
		return cbThUrl;
	}

	public void setCbThUrl(String cbThUrl) {
		this.cbThUrl = cbThUrl;
	}

	public String getCbNoticeDate() {
		return cbNoticeDate;
	}

	public void setCbNoticeDate(String cbNoticeDate) {
		this.cbNoticeDate = cbNoticeDate;
	}

	public String getCbContentReply() {
		return cbContentReply;
	}

	public void setCbContentReply(String cbContentReply) {
		this.cbContentReply = cbContentReply;
	}

	public String getCbConReplyName() {
		return cbConReplyName;
	}

	public void setCbConReplyName(String cbConReplyName) {
		this.cbConReplyName = cbConReplyName;
	}

	public String getCbConReplyDate() {
		return cbConReplyDate;
	}

	public void setCbConReplyDate(String cbConReplyDate) {
		this.cbConReplyDate = cbConReplyDate;
	}

//	200428추가	
	public String getCbGubun() {
		return cbGubun;
	}

	public void setCbGubun(String cbGubun) {
		this.cbGubun = cbGubun;
	}
//	//200428추가

	@Override
	public String toString() {
		return "CmmBoardVO [cbSeq=" + cbSeq + ", cbName=" + cbName + ", regSeq=" + regSeq + ", regName=" + regName
				+ ", cbTitle=" + cbTitle + ", cbContent=" + cbContent + ", cbRegDate=" + cbRegDate + ", cbCount="
				+ cbCount + ", cbNoticeYn=" + cbNoticeYn + ", cbSecretYn=" + cbSecretYn + ", cbPassword=" + cbPassword
				+ ", cbType=" + cbType + ", cbThType=" + cbThType + ", cbThImgName=" + cbThImgName + ", cbThImgPath="
				+ cbThImgPath + ", cbThUrl=" + cbThUrl + ", cbNoticeDate=" + cbNoticeDate + ", cbContentReply="
				+ cbContentReply + ", cbConReplyName=" + cbConReplyName + ", cbConReplyDate=" + cbConReplyDate
				+ ", cbGubun=" + cbGubun + "]";
	}
}
