package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 게시판VO 2019.06.20
 *
 */
public class BoardVO { 
	
	private String boardSeq 	= ""; 						// 게시판_고유번호
	private String boardType 	= "";						// 게시판_구분 : NO=공지사항, FA=FAQ
	private String title		= "";						// 제목
	private String content  	= "";						// 내용
	private String hitCnt		= "";						// 조회수
	private String noticeYn		= "";						// 공지여부
	private String regName 		= "";						// 작성자
	private String regDttm		= "";						// 등록일시
	private String udtDttm		= "";						// 수정일시
	private String regFileName	= "";						// 썸네일 (갤러리)
	
	public String getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(String boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
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
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getUdtDttm() {
		return udtDttm;
	}
	public void setUdtDttm(String udtDttm) {
		this.udtDttm = udtDttm;
	}
	public String getRegFileName() {
		return regFileName;
	}
	public void setRegFileName(String regFileName) {
		this.regFileName = regFileName;
	}
	
	@Override
	public String toString() {
		return "BoardVO [\nboardSeq=" + boardSeq + "\nboardType=" + boardType + "\ntitle=" + title + "\ncontent="
				+ content + "\nhitCnt=" + hitCnt + "\nnoticeYn=" + noticeYn + "\nregName=" + regName + "\nregDttm="
				+ regDttm + "\nudtDttm=" + udtDttm + "\nregFileName=" + regFileName + "\n]";
	}
}
