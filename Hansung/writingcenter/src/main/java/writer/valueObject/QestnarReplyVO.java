package writer.valueObject;

public class QestnarReplyVO {

	private String repSeq = "";
	private String repContent = "";
	private String repChoiceCount = "";
	private String repNo = "";
	private String askNo = "";
	private String qstnrSeq = "";
	private String maxRepCnt = "";
	
	
	
	
	public String getMaxRepCnt() {
		return maxRepCnt;
	}
	public void setMaxRepCnt(String maxRepCnt) {
		this.maxRepCnt = maxRepCnt;
	}
	public String getRepSeq() {
		return repSeq;
	}
	public void setRepSeq(String repSeq) {
		this.repSeq = repSeq;
	}
	public String getRepContent() {
		return repContent;
	}
	public void setRepContent(String repContent) {
		this.repContent = repContent;
	}
	public String getRepChoiceCount() {
		return repChoiceCount;
	}
	public void setRepChoiceCount(String repChoiceCount) {
		this.repChoiceCount = repChoiceCount;
	}
	public String getRepNo() {
		return repNo;
	}
	public void setRepNo(String repNo) {
		this.repNo = repNo;
	}
	public String getAskNo() {
		return askNo;
	}
	public void setAskNo(String askNo) {
		this.askNo = askNo;
	}
	public String getQstnrSeq() {
		return qstnrSeq;
	}
	public void setQstnrSeq(String qstnrSeq) {
		this.qstnrSeq = qstnrSeq;
	}
	@Override
	public String toString() {
		return "QestnarReplyVO [repSeq=" + repSeq + "\r\n repContent="
				+ repContent + "\r\n repChoiceCount=" + repChoiceCount
				+ "\r\n repNo=" + repNo + "\r\n askNo=" + askNo + "\r\n qstnrSeq="
				+ qstnrSeq + "]";
	}
	
	
	
	
}
