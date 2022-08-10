package hsDesign.valueObject;

/**
 * @author kjhoon
 * 팝업 2017.06.22
 * 	2018-01-30 팝업URL 추가
 */
public class PopupVO {
	private String popSeq				= ""; // 팝업 SEQ
	private String popTitle				= ""; // 팝업 제목
	private String popWidth				= ""; // 팝업 창넓이
	private String popHeight			= ""; // 팝업 창높이
	private String popTop				= ""; // 팝업 창위치_top
	private String popLeft				= ""; // 팝업 창위치_left
	private String popScrollYn			= ""; // 팝업 스크롤 존재여부
	private String popResizeYn			= ""; // 팝업 창크기 변동여부
	private String popContent			= ""; // 팝업 내용
	private String popUseYn				= ""; // 팝업 보이기 여부
	private String popRegDate			= ""; // 팝업 등록일
	private String popType				= ""; // 팝업타입
	private String popImgName			= ""; // 팝업이미지명
	private String popImgPath			= ""; // 팝업이미지경로
	
	private String popUrl				= ""; // 팝업URL
	public String getPopUrl() {
		return popUrl;
	}
	public void setPopUrl(String popUrl) {
		this.popUrl = popUrl;
	}
	public String getPopSeq() {
		return popSeq;
	}
	public void setPopSeq(String popSeq) {
		this.popSeq = popSeq;
	}
	public String getPopTitle() {
		return popTitle;
	}
	public void setPopTitle(String popTitle) {
		this.popTitle = popTitle;
	}
	public String getPopWidth() {
		return popWidth;
	}
	public void setPopWidth(String popWidth) {
		this.popWidth = popWidth;
	}
	public String getPopHeight() {
		return popHeight;
	}
	public void setPopHeight(String popHeight) {
		this.popHeight = popHeight;
	}
	public String getPopTop() {
		return popTop;
	}
	public void setPopTop(String popTop) {
		this.popTop = popTop;
	}
	public String getPopLeft() {
		return popLeft;
	}
	public void setPopLeft(String popLeft) {
		this.popLeft = popLeft;
	}
	public String getPopScrollYn() {
		return popScrollYn;
	}
	public void setPopScrollYn(String popScrollYn) {
		this.popScrollYn = popScrollYn;
	}
	public String getPopResizeYn() {
		return popResizeYn;
	}
	public void setPopResizeYn(String popResizeYn) {
		this.popResizeYn = popResizeYn;
	}
	public String getPopContent() {
		return popContent;
	}
	public void setPopContent(String popContent) {
		this.popContent = popContent;
	}
	public String getPopUseYn() {
		return popUseYn;
	}
	public void setPopUseYn(String popUseYn) {
		this.popUseYn = popUseYn;
	}
	public String getPopRegDate() {
		return popRegDate;
	}
	public void setPopRegDate(String popRegDate) {
		this.popRegDate = popRegDate;
	}
	public String getPopType() {
		return popType;
	}
	public void setPopType(String popType) {
		this.popType = popType;
	}
	public String getPopImgName() {
		return popImgName;
	}
	public void setPopImgName(String popImgName) {
		this.popImgName = popImgName;
	}
	public String getPopImgPath() {
		return popImgPath;
	}
	public void setPopImgPath(String popImgPath) {
		this.popImgPath = popImgPath;
	}
	@Override
	public String toString() {
		return "PopupVO [\npopSeq=" + popSeq + "\npopTitle=" + popTitle + "\npopWidth=" + popWidth + "\npopHeight="
				+ popHeight + "\npopTop=" + popTop + "\npopLeft=" + popLeft + "\npopScrollYn=" + popScrollYn
				+ "\npopResizeYn=" + popResizeYn + "\npopContent=" + popContent + "\npopUseYn=" + popUseYn
				+ "\npopRegDate=" + popRegDate + "\npopType=" + popType + "\npopImgName=" + popImgName + "\npopImgPath="
				+ popImgPath + "\npopUrl=" + popUrl + "\n]";
	}
}
