package lcms.valueObject;

/**
 * @author Leegh
 * 
 * 배너VO 2019.07.05
 *
 */
public class BannerVO { 
	
	private String bannerSeq 	= ""; 						// 배너_고유번호
	private String bannerName 	= "";						// 배너_이름
	private String bannerSort	= "";						// 배너_순서
	private String bannerUrl	= "";						// 배너_URL
	private String orgFileName 	= "";						// 원본파일명
	private String regFileName	= "";						// 저장파일명
	private String regName		= "";						// 작성자
	private String useYn 		= "";						// 사용여부
	private String regDttm		= "";						// 등록일시
	private String bannerType	= "";						// 배너_타입
	
	public String getBannerSeq() {
		return bannerSeq;
	}
	public void setBannerSeq(String bannerSeq) {
		this.bannerSeq = bannerSeq;
	}
	public String getBannerName() {
		return bannerName;
	}
	public void setBannerName(String bannerName) {
		this.bannerName = bannerName;
	}
	public String getBannerSort() {
		return bannerSort;
	}
	public void setBannerSort(String bannerSort) {
		this.bannerSort = bannerSort;
	}
	public String getBannerUrl() {
		return bannerUrl;
	}
	public void setBannerUrl(String bannerUrl) {
		this.bannerUrl = bannerUrl;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public String getRegFileName() {
		return regFileName;
	}
	public void setRegFileName(String regFileName) {
		this.regFileName = regFileName;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getBannerType() {
		return bannerType;
	}
	public void setBannerType(String bannerType) {
		this.bannerType = bannerType;
	}
	
	@Override
	public String toString() {
		return "BannerVO [\nbannerSeq=" + bannerSeq + "\nbannerName=" + bannerName + "\nbannerSort=" + bannerSort
				+ "\nbannerUrl=" + bannerUrl + "\norgFileName=" + orgFileName + "\nregFileName=" + regFileName
				+ "\nregName=" + regName + "\nuseYn=" + useYn + "\nregDttm=" + regDttm + "\nbannerType=" + bannerType
				+ "\n]";
	}
}
