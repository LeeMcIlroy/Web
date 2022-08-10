package hsDesign.valueObject;

public class WebtoonVO {
	// 웹툰
	private String wSeq 		= "";	// 웹툰SEQ
	private String wTitle 		= "";	// 웹툰 제목
	private String wThImgName 	= "";	// 웹툰 썸네일 이미지명
	private String wThImgPath 	= "";	// 웹툰 썸네일 이미지 경로
	private String wOrder		= "";	// 웹툰 회차
	private String wCount		= "";	// 웹툰 조회수
	private String wContent		= "";	// 웹툰 내용
	private String regSeq 		= "";	// 등록자SEQ
	private String regName 		= "";	// 등록자명
	private String regDate 		= "";	// 등록일
	
	// 웹툰 category
	private String wcSeq 		= "";	// 웹툰카테고리SEQ
	private String wcTitle 		= "";	// 웹툰카테고리 제목
	private String wcOrder 		= "";	// 웹툰카테고리 순서
	
	private String beforeWSeq 	= "";	// 이전
	private String afterWSeq	= "";	// 이후	
	public String getBeforeWSeq() { return beforeWSeq; }
	public void setBeforeWSeq(String beforeWSeq) { this.beforeWSeq = beforeWSeq; }
	public String getAfterWSeq() { return afterWSeq; }
	public void setAfterWSeq(String afterWSeq) { this.afterWSeq = afterWSeq; }
	
	
	/** view */
	private String webtoonCount = "";	// 웹툰 등록수
	public String getWebtoonCount() { return webtoonCount; }
	public void setWebtoonCount(String webtoonCount) { this.webtoonCount = webtoonCount; }
	
	public String getwSeq() {
		return wSeq;
	}
	public void setwSeq(String wSeq) {
		this.wSeq = wSeq;
	}
	public String getwTitle() {
		return wTitle;
	}
	public void setwTitle(String wTitle) {
		this.wTitle = wTitle;
	}
	public String getwThImgName() {
		return wThImgName;
	}
	public void setwThImgName(String wThImgName) {
		this.wThImgName = wThImgName;
	}
	public String getwThImgPath() {
		return wThImgPath;
	}
	public void setwThImgPath(String wThImgPath) {
		this.wThImgPath = wThImgPath;
	}
	public String getwOrder() {
		return wOrder;
	}
	public void setwOrder(String wOrder) {
		this.wOrder = wOrder;
	}
	public String getwCount() {
		return wCount;
	}
	public void setwCount(String wCount) {
		this.wCount = wCount;
	}
	public String getwContent() {
		return wContent;
	}
	public void setwContent(String wContent) {
		this.wContent = wContent;
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
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getWcSeq() {
		return wcSeq;
	}
	public void setWcSeq(String wcSeq) {
		this.wcSeq = wcSeq;
	}
	public String getWcTitle() {
		return wcTitle;
	}
	public void setWcTitle(String wcTitle) {
		this.wcTitle = wcTitle;
	}
	public String getWcOrder() {
		return wcOrder;
	}
	public void setWcOrder(String wcOrder) {
		this.wcOrder = wcOrder;
	}
	@Override
	public String toString() {
		return "WebtoonVO [\nwSeq=" + wSeq + "\nwTitle=" + wTitle + "\nwThImgName=" + wThImgName + "\nwThImgPath="
				+ wThImgPath + "\nwOrder=" + wOrder + "\nwCount=" + wCount + "\nwContent=" + wContent + "\nregSeq="
				+ regSeq + "\nregName=" + regName + "\nregDate=" + regDate + "\nwcSeq=" + wcSeq + "\nwcTitle=" + wcTitle
				+ "\nwcOrder=" + wcOrder + "\nbeforeWSeq=" + beforeWSeq + "\nafterWSeq=" + afterWSeq + "\nwebtoonCount="
				+ webtoonCount + "\n]";
	}
}
