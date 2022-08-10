package hsDesign.valueObject;

/**
 * @author kjhoon 
 * 
 * 배너VO 2017.06.22
 * 
 */
public class BannerVO {

	private String banSeq 	 		= ""; // 배너 SEQ
	private String banName	 		= ""; // 배너 이름
	private String banType			= ""; // 배너 타입
	private String banNewWindow 	= ""; // 배너 새창 여부
	private String banOrder			= ""; // 배너 순서
	private String banUseYn			= ""; // 배너 사용여부
	private String banUrl 				= ""; //URL 주소
	private String banImgName		 = ""; // 이미지명
	private String banImgPath		 = ""; // 이미지경로
	private String banAddName1		="";	// 말머리1
	private String banAddName2		="";	// 말머리2
	private String banAddName3		="";	// 말머리3
	private String banAddUrl1		="";	// URL1
	private String banAddUrl2		="";	// URL2
	private String banAddUrl3		="";	// URL3
	private String banAddWindow1		="";	// 버튼새창여부1
	private String banAddWindow2		="";	// 버튼새창여부2
	private String banAddWindow3		="";	// 버튼새창여부3

	/*200422추가*/
	private String banMp4Name		 = ""; // 동영상 이름
	private String banMp4Path		 = ""; // 동영상 경로
	
	public String getBanMp4Name() {
		return banMp4Name;
	}
	public void setBanMp4Name(String banMp4Name) {
		this.banMp4Name = banMp4Name;
	}
	public String getBanMp4Path() {
		return banMp4Path;
	}
	public void setBanMp4Path(String banMp4Path) {
		this.banMp4Path = banMp4Path;
	}
	
	/*//200422추가*/
	
	/* 20200522 추가 */
	private String banMp4Url		= ""; // 동영상 URL (youtube, vimeo)
	
	public String getBanAddWindow1() {
		return banAddWindow1;
	}
	public String getBanMp4Url() {
		return banMp4Url;
	}
	public void setBanMp4Url(String banMp4Url) {
		this.banMp4Url = banMp4Url;
	}
	/* //20200522 추가 */
	
	public void setBanAddWindow1(String banAddWindow1) {
		this.banAddWindow1 = banAddWindow1;
	}
	public String getBanAddWindow2() {
		return banAddWindow2;
	}
	public void setBanAddWindow2(String banAddWindow2) {
		this.banAddWindow2 = banAddWindow2;
	}
	public String getBanAddWindow3() {
		return banAddWindow3;
	}
	public void setBanAddWindow3(String banAddWindow3) {
		this.banAddWindow3 = banAddWindow3;
	}
	public String getBanAddName1() {
		return banAddName1;
	}
	public void setBanAddName1(String banAddName1) {
		this.banAddName1 = banAddName1;
	}
	public String getBanAddName2() {
		return banAddName2;
	}
	public void setBanAddName2(String banAddName2) {
		this.banAddName2 = banAddName2;
	}
	public String getBanAddName3() {
		return banAddName3;
	}
	public void setBanAddName3(String banAddName3) {
		this.banAddName3 = banAddName3;
	}
	public String getBanAddUrl1() {
		return banAddUrl1;
	}
	public void setBanAddUrl1(String banAddUrl1) {
		this.banAddUrl1 = banAddUrl1;
	}
	public String getBanAddUrl2() {
		return banAddUrl2;
	}
	public void setBanAddUrl2(String banAddUrl2) {
		this.banAddUrl2 = banAddUrl2;
	}
	public String getBanAddUrl3() {
		return banAddUrl3;
	}
	public void setBanAddUrl3(String banAddUrl3) {
		this.banAddUrl3 = banAddUrl3;
	}
	public String getBanSeq() {
		return banSeq;
	}
	public void setBanSeq(String banSeq) {
		this.banSeq = banSeq;
	}
	public String getBanName() {
		return banName;
	}
	public void setBanName(String banName) {
		this.banName = banName;
	}
	public String getBanType() {
		return banType;
	}
	public void setBanType(String banType) {
		this.banType = banType;
	}
	public String getBanNewWindow() {
		return banNewWindow;
	}
	public void setBanNewWindow(String banNewWindow) {
		this.banNewWindow = banNewWindow;
	}
	public String getBanOrder() {
		return banOrder;
	}
	public void setBanOrder(String banOrder) {
		this.banOrder = banOrder;
	}
	public String getBanUseYn() {
		return banUseYn;
	}
	public void setBanUseYn(String banUseYn) {
		this.banUseYn = banUseYn;
	}
	public String getBanUrl() {
		return banUrl;
	}
	public void setBanUrl(String banUrl) {
		this.banUrl = banUrl;
	}
	public String getBanImgName() {
		return banImgName;
	}
	public void setBanImgName(String banImgName) {
		this.banImgName = banImgName;
	}
	public String getBanImgPath() {
		return banImgPath;
	}
	public void setBanImgPath(String banImgPath) {
		this.banImgPath = banImgPath;
	}
	@Override
	public String toString() {
		return "BannerVO [banSeq=" + banSeq + ", banName=" + banName + ", banType=" + banType + ", banNewWindow="
				+ banNewWindow + ", banOrder=" + banOrder + ", banUseYn=" + banUseYn + ", banUrl=" + banUrl
				+ ", banImgName=" + banImgName + ", banImgPath=" + banImgPath + ", banAddName1=" + banAddName1
				+ ", banAddName2=" + banAddName2 + ", banAddName3=" + banAddName3 + ", banAddUrl1=" + banAddUrl1
				+ ", banAddUrl2=" + banAddUrl2 + ", banAddUrl3=" + banAddUrl3 + ", banAddWindow1=" + banAddWindow1
				+ ", banAddWindow2=" + banAddWindow2 + ", banAddWindow3=" + banAddWindow3 + ", banMp4Name=" + banMp4Name
				+ ", banMp4Path=" + banMp4Path + "]";
	}
}
