package writer.valueObject;

/**
 * 도서목록
 *	2017-02-06 최초생성
 *
 */
public class BookcatalogVO {
	private String ctlSeq = "";					// SEQ
	private String ctlType = "";				// 게시판 구분
	private String ctlBkType = "";				// 책분류
	private String ctlTitle = "";				// 제목
	private String ctlWriter = "";				// 지은이
	private String ctlPublisher = "";			// 출판사
	private String ctlContent = "";				// 내용
	private String regId = "";					// 등록자
	private String regName = "";				// 등록자명
	private String regDate = "";				// 등록일
	private String ctlHitcount = "";			// 조회수
	private String ctlImgName = "";				// 대표이미지명
	private String ctlImgPath = "";				// 대표이미지경로
	private String ctlImgThumbPath = "";		// 대표이미지썸네일경로
	
	public String getCtlSeq() {
		return ctlSeq;
	}
	public void setCtlSeq(String ctlSeq) {
		this.ctlSeq = ctlSeq;
	}
	public String getCtlType() {
		return ctlType;
	}
	public void setCtlType(String ctlType) {
		this.ctlType = ctlType;
	}
	public String getCtlBkType() {
		return ctlBkType;
	}
	public void setCtlBkType(String ctlBkType) {
		this.ctlBkType = ctlBkType;
	}
	public String getCtlTitle() {
		return ctlTitle;
	}
	public void setCtlTitle(String ctlTitle) {
		this.ctlTitle = ctlTitle;
	}
	public String getCtlWriter() {
		return ctlWriter;
	}
	public void setCtlWriter(String ctlWriter) {
		this.ctlWriter = ctlWriter;
	}
	public String getCtlPublisher() {
		return ctlPublisher;
	}
	public void setCtlPublisher(String ctlPublisher) {
		this.ctlPublisher = ctlPublisher;
	}
	public String getCtlContent() {
		return ctlContent;
	}
	public void setCtlContent(String ctlContent) {
		this.ctlContent = ctlContent;
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
	public String getCtlHitcount() {
		return ctlHitcount;
	}
	public void setCtlHitcount(String ctlHitcount) {
		this.ctlHitcount = ctlHitcount;
	}
	public String getCtlImgName() {
		return ctlImgName;
	}
	public void setCtlImgName(String ctlImgName) {
		this.ctlImgName = ctlImgName;
	}
	public String getCtlImgPath() {
		return ctlImgPath;
	}
	public void setCtlImgPath(String ctlImgPath) {
		this.ctlImgPath = ctlImgPath;
	}
	public String getCtlImgThumbPath() {
		return ctlImgThumbPath;
	}
	public void setCtlImgThumbPath(String ctlImgThumbPath) {
		this.ctlImgThumbPath = ctlImgThumbPath;
	}
	@Override
	public String toString() {
		return "BookcatalogVO [\r\nctlSeq=" + ctlSeq + "\r\n ctlType=" + ctlType + "\r\n ctlBkType=" + ctlBkType + "\r\n ctlTitle="
				+ ctlTitle + "\r\n ctlWriter=" + ctlWriter + "\r\n ctlPublisher=" + ctlPublisher + "\r\n ctlContent="
				+ ctlContent + "\r\n regId=" + regId + "\r\n regName=" + regName + "\r\n regDate=" + regDate + "\r\n ctlHitcount="
				+ ctlHitcount + "\r\n ctlImgName=" + ctlImgName + "\r\n ctlImgPath=" + ctlImgPath + "\r\n ctlImgThumbPath="
				+ ctlImgThumbPath + "\r\n]";
	}
}
