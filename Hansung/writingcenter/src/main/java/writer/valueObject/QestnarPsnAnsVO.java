package writer.valueObject;



/**
 * @author kjhoon
 * 설문 답변자 답변 목록
 * 	2017-03-20
 * 	2017-07-25 추가
 */
public class QestnarPsnAnsVO {
	private String pansSeq = "";		// 설문조사_답변자_답변내용_SEQ
	private String askNo = "";			// 설문조사_답변자_답변내용_질문번호
	private String preNo = "";			// 설문조사_답변자_답변내용_선택답변번호
	private String psnSeq = "";			// 답변자 SEQ
	private String repSeq = "";			// 설문조사_답변지 SEQ
	private String askType = "";		// 질문유형
	
	
	private String pansTxt = "";		// 주관식답변
	public String getPansTxt() { return pansTxt; }
	public void setPansTxt(String pansTxt) { this.pansTxt = pansTxt; }
	
	
	public QestnarPsnAnsVO() {
		super();
	}
	public QestnarPsnAnsVO(String pansSeq, String askNo, String preNo,
			String psnSeq, String repSeq, String askType) {
		super();
		this.pansSeq = pansSeq;
		this.askNo = askNo;
		this.preNo = preNo;
		this.psnSeq = psnSeq;
		this.repSeq = repSeq;
		this.askType = askType;
	}
	public QestnarPsnAnsVO(String askNo, String preNo, String psnSeq) {
		super();
		this.askNo = askNo;
		this.preNo = preNo;
		this.psnSeq = psnSeq;
	}
	public String getAskType() {
		return askType;
	}
	public void setAskType(String askType) {
		this.askType = askType;
	}
	public String getRepSeq() {
		return repSeq;
	}
	public void setRepSeq(String repSeq) {
		this.repSeq = repSeq;
	}
	public String getPansSeq() {
		return pansSeq;
	}
	public void setPansSeq(String pansSeq) {
		this.pansSeq = pansSeq;
	}
	public String getAskNo() {
		return askNo;
	}
	public void setAskNo(String askNo) {
		this.askNo = askNo;
	}
	public String getPreNo() {
		return preNo;
	}
	public void setPreNo(String preNo) {
		this.preNo = preNo;
	}
	public String getPsnSeq() {
		return psnSeq;
	}
	public void setPsnSeq(String psnSeq) {
		this.psnSeq = psnSeq;
	}
	@Override
	public String toString() {
		return "QestnarPsnAnsVO [\npansSeq=" + pansSeq + "\n, askNo=" + askNo + "\n, preNo=" + preNo + "\n, psnSeq="
				+ psnSeq + "\n, repSeq=" + repSeq + "\n, askType=" + askType + "\n, pansTxt=" + pansTxt + "\n]";
	}
}
