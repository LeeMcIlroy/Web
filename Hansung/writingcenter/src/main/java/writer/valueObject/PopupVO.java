package writer.valueObject;

/**
 * @author kjhoon
 * @ 팝업
 * 2017-02-07 생성
 */
public class PopupVO {

	private String popSeq = "";				//팝업SEQ
	private String popTitle = "";			//팝업제목
	private String popWidth = "";			//팝업창넒이
	private String popHeight = "";			//팝업창높이
	private String popTop = "";				//창위치_top
	private String popLeft = "";			//창위치_left
	private String popScrollYn = "";		//스크롤존재여부
	private String popResizeYn = "";		//창크기변동여부
	private String popContent = "";			//내용
	private String popViewYn = "";			//보이기여부
	private String regId = "";				//등록자
	private String regDate = "";			//등록일
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
	public String getPopViewYn() {
		return popViewYn;
	}
	public void setPopViewYn(String popViewYn) {
		this.popViewYn = popViewYn;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "PopupVO [popSeq=" + popSeq + "\r\n popTitle=" + popTitle
				+ "\r\n popWidth=" + popWidth + "\r\n popHeight=" + popHeight
				+ "\r\n popTop=" + popTop + "\r\n popLeft=" + popLeft
				+ "\r\n popScrollYn=" + popScrollYn + "\r\n popResizeYn="
				+ popResizeYn + "\r\n popContent=" + popContent + "\r\n popViewYn="
				+ popViewYn + "\r\n regId=" + regId + "\r\n regDate=" + regDate + "]";
	}
	
	
	
	
	
}
