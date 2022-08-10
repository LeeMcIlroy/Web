package hsDesign.valueObject;

/**
 * @author kjhoon
 * 전공메뉴 2017.06.22
 */
public class MenuVO {
	private String mmSeq = "";
	private String bcSeq = "";
	private String mCode = "";
	private String mmSortNum = "";
	private String mmUseYn = "";
	private String mmRegDttm = "";
	private String mmUdpDttm = "";
	private String bcHead = "";
	
	public String getMmSeq() {
		return mmSeq;
	}
	public void setMmSeq(String mmSeq) {
		this.mmSeq = mmSeq;
	}
	public String getBcSeq() {
		return bcSeq;
	}
	public void setBcSeq(String bcSeq) {
		this.bcSeq = bcSeq;
	}
	public String getmCode() {
		return mCode;
	}
	public void setmCode(String mCode) {
		this.mCode = mCode;
	}
	public String getMmSortNum() {
		return mmSortNum;
	}
	public void setMmSortNum(String mmSortNum) {
		this.mmSortNum = mmSortNum;
	}
	public String getMmUseYn() {
		return mmUseYn;
	}
	public void setMmUseYn(String mmUseYn) {
		this.mmUseYn = mmUseYn;
	}
	public String getMmRegDttm() {
		return mmRegDttm;
	}
	public void setMmRegDttm(String mmRegDttm) {
		this.mmRegDttm = mmRegDttm;
	}
	public String getMmUdpDttm() {
		return mmUdpDttm;
	}
	public void setMmUdpDttm(String mmUdpDttm) {
		this.mmUdpDttm = mmUdpDttm;
	}
	public String getBcHead() {
		return bcHead;
	}
	public void setBcHead(String bcHead) {
		this.bcHead = bcHead;
	}
	@Override
	public String toString() {
		return "MenuVO [mmSeq=" + mmSeq + "\r\n bcSeq=" + bcSeq + "\r\n mCode="
				+ mCode + "\r\n mmSortNum=" + mmSortNum + "\r\n mmUseYn=" + mmUseYn
				+ "\r\n mmRegDttm=" + mmRegDttm + "\r\n mmUdpDttm=" + mmUdpDttm
				+ "\r\n bcHead=" + bcHead + "]";
	}
}
