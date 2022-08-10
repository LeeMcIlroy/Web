package writer.valueObject;

import java.util.List;

public class QestnarAskVO {

	private String askSeq = "";
	private String askNo = "";
	private String askContent = "";
	private String askType = "";
	private String qstnrSeq = "";
	private String repCnt = "";
	private String askChk = "";
	
	private List<QestnarReplyVO> repList = null;
	
	public List<QestnarReplyVO> getRepList() {
		return repList;
	}
	public void setRepList(List<QestnarReplyVO> repList) {
		this.repList = repList;
	}
	
	
	public String getRepCnt() {
		return repCnt;
	}
	public void setRepCnt(String repCnt) {
		this.repCnt = repCnt;
	}
	public String getAskSeq() {
		return askSeq;
	}
	public void setAskSeq(String askSeq) {
		this.askSeq = askSeq;
	}
	public String getAskNo() {
		return askNo;
	}
	public void setAskNo(String askNo) {
		this.askNo = askNo;
	}
	public String getAskContent() {
		return askContent;
	}
	public void setAskContent(String askContent) {
		this.askContent = askContent;
	}
	public String getAskType() {
		return askType;
	}
	public void setAskType(String askType) {
		this.askType = askType;
	}
	public String getQstnrSeq() {
		return qstnrSeq;
	}
	public void setQstnrSeq(String qstnrSeq) {
		this.qstnrSeq = qstnrSeq;
	}
	
	
	public String getAskChk() {
		return askChk;
	}
	public void setAskChk(String askChk) {
		this.askChk = askChk;
	}
	@Override
	public String toString() {
		return "QestnarAskVO [askSeq=" + askSeq + "\r\n askNo=" + askNo
				+ "\r\n askContent=" + askContent + "\r\n askType=" + askType
				+ "\r\n qstnrSeq=" + qstnrSeq + "\r\n askChk=" + askChk + "]";
	}
	
	
	
	
}
