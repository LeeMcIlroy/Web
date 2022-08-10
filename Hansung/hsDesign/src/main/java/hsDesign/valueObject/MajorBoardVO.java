package hsDesign.valueObject;

/**
 * @author kjhoon
 * 전공게시판 2017.06.22
 */
public class MajorBoardVO {
	private String mbSeq				= ""; // 전공게시판 SEQ
	private String mbGubun1				= ""; // 게시판 구분1
	private String mbGubun2				= ""; // 게시판 구분2
	private String mbTitle				= ""; // 게시글 제목
	private String mbContent			= ""; // 게시글 내용
	private String mbRegDate			= ""; // 게시글 등록일
	private String mbCount				= ""; // 게시글 조회수
	private String mbRegName			= ""; // 게시글 작성자 이름
	private String mbRegSeq				= ""; // 게시글 작성자 SEQ
	private String mCode				= ""; // 전공구분코드
	private String mName				= ""; // 전공구분이름
	private String mbOldYn				= ""; // 마이그레이션 여부
	
	private String mbNoticeYn			= ""; // 공지여부
	private String mbNoticeDate			= ""; // 공지일
	
	private String mbSort				= ""; // 전공소식 정렬
	
	private String mbthSeq				= ""; // 썸네일 SEQ
	private String mbthType				= ""; // 썸네일 타입
	private String mbthImgName			= ""; // 썸네일 이미지 이름
	private String mbthImgPath			= ""; // 썸네일 이미지 경로
	private String mbthUrl				= ""; // 동영상 url
	private String mbGubun1Name			= ""; // 게시판 구분1 이름
	private String mbGubun2Name			= ""; // 게시판 구분2 이름
	private String mbOldSeq					= ""; // 마이그레이션 seq
	
	private String fileDeleteChk = "";		// 삭제파일 선택
	private String mbthFileSeq				= ""; // 썸네일 SEQ
	private String mbthFileType				= ""; // 썸네일 타입
	private String mbthFileName			= ""; // 썸네일 이미지 이름
	private String mbthFilePath			= ""; // 썸네일 이미지 경로
	
	public String getMbOldYn() {
		return mbOldYn;
	}
	public void setMbOldYn(String mbOldYn) {
		this.mbOldYn = mbOldYn;
	}
	public String getMbOldSeq() {
		return mbOldSeq;
	}
	public void setMbOldSeq(String mbOldSeq) {
		this.mbOldSeq = mbOldSeq;
	}
	public String getFileDeleteChk() {
		return fileDeleteChk;
	}
	public void setFileDeleteChk(String fileDeleteChk) {
		this.fileDeleteChk = fileDeleteChk;
	}
	public String getMbGubun1Name() {
		return mbGubun1Name;
	}
	public void setMbGubun1Name(String mbGubun1Name) {
		this.mbGubun1Name = mbGubun1Name;
	}
	public String getMbGubun2Name() {
		return mbGubun2Name;
	}
	public void setMbGubun2Name(String mbGubun2Name) {
		this.mbGubun2Name = mbGubun2Name;
	}
	public String getMbthSeq() {
		return mbthSeq;
	}
	public void setMbthSeq(String mbthSeq) {
		this.mbthSeq = mbthSeq;
	}
	public String getMbthType() {
		return mbthType;
	}
	public void setMbthType(String mbthType) {
		this.mbthType = mbthType;
	}
	public String getMbthImgName() {
		return mbthImgName;
	}
	public void setMbthImgName(String mbthImgName) {
		this.mbthImgName = mbthImgName;
	}
	public String getMbthImgPath() {
		return mbthImgPath;
	}
	public void setMbthImgPath(String mbthImgPath) {
		this.mbthImgPath = mbthImgPath;
	}
	public String getMbthUrl() {
		return mbthUrl;
	}
	public void setMbthUrl(String mbthUrl) {
		this.mbthUrl = mbthUrl;
	}
	public String getMbSeq() {
		return mbSeq;
	}
	public void setMbSeq(String mbSeq) {
		this.mbSeq = mbSeq;
	}
	public String getMbGubun1() {
		return mbGubun1;
	}
	public void setMbGubun1(String mbGubun1) {
		this.mbGubun1 = mbGubun1;
	}
	public String getMbGubun2() {
		return mbGubun2;
	}
	public void setMbGubun2(String mbGubun2) {
		this.mbGubun2 = mbGubun2;
	}
	public String getMbTitle() {
		return mbTitle;
	}
	public void setMbTitle(String mbTitle) {
		this.mbTitle = mbTitle;
	}
	public String getMbContent() {
		return mbContent;
	}
	public void setMbContent(String mbContent) {
		this.mbContent = mbContent;
	}
	public String getMbRegDate() {
		return mbRegDate;
	}
	public void setMbRegDate(String mbRegDate) {
		this.mbRegDate = mbRegDate;
	}
	public String getMbCount() {
		return mbCount;
	}
	public void setMbCount(String mbCount) {
		this.mbCount = mbCount;
	}
	public String getMbRegName() {
		return mbRegName;
	}
	public void setMbRegName(String mbRegName) {
		this.mbRegName = mbRegName;
	}
	public String getMbRegSeq() {
		return mbRegSeq;
	}
	public void setMbRegSeq(String mbRegSeq) {
		this.mbRegSeq = mbRegSeq;
	}
	public String getmCode() {
		return mCode;
	}
	public void setmCode(String mCode) {
		this.mCode = mCode;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getMbNoticeYn() {
		return mbNoticeYn;
	}
	public void setMbNoticeYn(String mbNoticeYn) {
		this.mbNoticeYn = mbNoticeYn;
	}
	public String getMbNoticeDate() {
		return mbNoticeDate;
	}
	public void setMbNoticeDate(String mbNoticeDate) {
		this.mbNoticeDate = mbNoticeDate;
	}
	public String getMbSort() {
		return mbSort;
	}
	public void setMbSort(String mbSort) {
		this.mbSort = mbSort;
	}
	
	public String getMbthFileSeq() {
		return mbthFileSeq;
	}
	public void setMbthFileSeq(String mbthFileSeq) {
		this.mbthFileSeq = mbthFileSeq;
	}
	public String getMbthFileType() {
		return mbthFileType;
	}
	public void setMbthFileType(String mbthFileType) {
		this.mbthFileType = mbthFileType;
	}
	public String getMbthFileName() {
		return mbthFileName;
	}
	public void setMbthFileName(String mbthFileName) {
		this.mbthFileName = mbthFileName;
	}
	public String getMbthFilePath() {
		return mbthFilePath;
	}
	public void setMbthFilePath(String mbthFilePath) {
		this.mbthFilePath = mbthFilePath;
	}
	@Override
	public String toString() {
		return "MajorBoardVO [\nmbSeq=" + mbSeq + "\nmbGubun1=" + mbGubun1 + "\nmbGubun2=" + mbGubun2 + "\nmbTitle="
				+ mbTitle + "\nmbContent=" + mbContent + "\nmbRegDate=" + mbRegDate + "\nmbCount=" + mbCount
				+ "\nmbRegName=" + mbRegName + "\nmbRegSeq=" + mbRegSeq + "\nmCode=" + mCode + "\nmName=" + mName
				+ "\nmbOldYn=" + mbOldYn + "\nmbNoticeYn=" + mbNoticeYn + "\nmbNoticeDate=" + mbNoticeDate + "\nmbSort="
				+ mbSort + "\nmbthSeq=" + mbthSeq + "\nmbthType=" + mbthType + "\nmbthImgName=" + mbthImgName
				+ "\nmbthImgPath=" + mbthImgPath + "\nmbthUrl=" + mbthUrl + "\nmbGubun1Name=" + mbGubun1Name
				+ "\nmbGubun2Name=" + mbGubun2Name + "\nmbOldSeq=" + mbOldSeq + "\nfileDeleteChk=" + fileDeleteChk
				+ "\nmbthFileSeq=" + mbthFileSeq + "\nmbthFileType=" + mbthFileType + "\nmbthFileName=" + mbthFileName
				+ "\nmbthFilePath=" + mbthFilePath + "\n]";
	}

	

	
	
	
	
	
	
	
}
