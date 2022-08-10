package writer.valueObject;

/**
 * 우리반게시판
 * 	2017-01-31 최초생성
 *
 */
public class ClsNoticeVO {
	private String ntSeq = "";			// SEQ
	private String ntTitle = "";		// 제목
	private String ntContent = "";		// 내용
	private String ntNoticeYn = "";		// 공지여부
	private String ntHitcount = "";		// 조회수
	private String regId = "";			// 등록자
	private String regName = "";		// 등록자명
	private String regDate = "";		// 등록일
	private String clsSeq = "";			// 반_교수SEQ
	
	private String fileDeleteChk = "";	// 삭제파일 선택
	public String getFileDeleteChk() { return fileDeleteChk; }
	public void setFileDeleteChk(String fileDeleteChk) { this.fileDeleteChk = fileDeleteChk; }
	
	
	public String getNtSeq() {
		return ntSeq;
	}
	public void setNtSeq(String ntSeq) {
		this.ntSeq = ntSeq;
	}
	public String getNtTitle() {
		return ntTitle;
	}
	public void setNtTitle(String ntTitle) {
		this.ntTitle = ntTitle;
	}
	public String getNtContent() {
		return ntContent;
	}
	public void setNtContent(String ntContent) {
		this.ntContent = ntContent;
	}
	public String getNtNoticeYn() {
		return ntNoticeYn;
	}
	public void setNtNoticeYn(String ntNoticeYn) {
		this.ntNoticeYn = ntNoticeYn;
	}
	public String getNtHitcount() {
		return ntHitcount;
	}
	public void setNtHitcount(String ntHitcount) {
		this.ntHitcount = ntHitcount;
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
	@Override
	public String toString() {
		return "ClsNoticeVO [\r\nntSeq=" + ntSeq + "\r\n ntTitle=" + ntTitle + "\r\n ntContent=" + ntContent + "\r\n ntNoticeYn="
				+ ntNoticeYn + "\r\n ntHitcount=" + ntHitcount + "\r\n regId=" + regId + "\r\n regName=" + regName + "\r\n regDate="
				+ regDate + "\r\n clsSeq=" + clsSeq + "\r\n fileDeleteChk=" + fileDeleteChk + "\r\n]";
	}
	
}
