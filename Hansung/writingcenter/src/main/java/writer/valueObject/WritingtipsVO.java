package writer.valueObject;

/**
 * 라이팅팁스
 *	2017-02-03 최초생성
 */
public class WritingtipsVO {
	private String tipSeq = "";				// SEQ
	private String tipTitle = "";			// 제목
	private String tipPublicDate = "";		// 발행일 (yyyy-MM-dd)
	private String tipContent = "";			// 목차 (내용)
	private String regId = "";				// 등록자
	private String regName = "";			// 등록자명
	private String regDate = "";			// 등록일
	private String tipHitcount = "";		// 조회수
	private String tipImgName = "";			// 대표이미지명
	private String tipImgPath = "";			// 대표이미지경로
	private String tipImgThumbPath = "";	// 대표이미지 썸네일경로
	private String tipFileName = "";		// 첨부파일명_PDF
	private String tipFilePath = "";		// 첨부파일경로
	
	public String getTipSeq() {
		return tipSeq;
	}
	public void setTipSeq(String tipSeq) {
		this.tipSeq = tipSeq;
	}
	public String getTipTitle() {
		return tipTitle;
	}
	public void setTipTitle(String tipTitle) {
		this.tipTitle = tipTitle;
	}
	public String getTipPublicDate() {
		return tipPublicDate;
	}
	public void setTipPublicDate(String tipPublicDate) {
		this.tipPublicDate = tipPublicDate;
	}
	public String getTipContent() {
		return tipContent;
	}
	public void setTipContent(String tipContent) {
		this.tipContent = tipContent;
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
	public String getTipHitcount() {
		return tipHitcount;
	}
	public void setTipHitcount(String tipHitcount) {
		this.tipHitcount = tipHitcount;
	}
	public String getTipImgName() {
		return tipImgName;
	}
	public void setTipImgName(String tipImgName) {
		this.tipImgName = tipImgName;
	}
	public String getTipImgPath() {
		return tipImgPath;
	}
	public void setTipImgPath(String tipImgPath) {
		this.tipImgPath = tipImgPath;
	}
	public String getTipImgThumbPath() {
		return tipImgThumbPath;
	}
	public void setTipImgThumbPath(String tipImgThumbPath) {
		this.tipImgThumbPath = tipImgThumbPath;
	}
	public String getTipFileName() {
		return tipFileName;
	}
	public void setTipFileName(String tipFileName) {
		this.tipFileName = tipFileName;
	}
	public String getTipFilePath() {
		return tipFilePath;
	}
	public void setTipFilePath(String tipFilePath) {
		this.tipFilePath = tipFilePath;
	}
	@Override
	public String toString() {
		return "WritingtipsVO [tipSeq=" + tipSeq + ", tipTitle=" + tipTitle + ", tipPublicDate=" + tipPublicDate
				+ ", tipContent=" + tipContent + ", regId=" + regId + ", regName=" + regName + ", regDate=" + regDate
				+ ", tipHitcount=" + tipHitcount + ", tipImgName=" + tipImgName + ", tipImgPath=" + tipImgPath
				+ ", tipImgThumbPath=" + tipImgThumbPath + ", tipFileName=" + tipFileName + ", tipFilePath="
				+ tipFilePath + "]";
	}
}
