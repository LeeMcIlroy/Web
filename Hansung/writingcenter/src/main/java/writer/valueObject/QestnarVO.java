package writer.valueObject;

import java.util.List;


/**
 * @author kjhoon
 * 설문 2017-03-08 생성
 */
public class QestnarVO {
	/////////////////////기본정보
	private String qstnrSeq = "";
	private String qstnrTitle = "";
	private String qstnrSubTitle = "";
	private String qstnrContent = "";
	private String qstnrStartDate = "";
	private String qstnrEndDate = "";
	private String qstnrRespCount = "";
	private String regId = "";
	private String regDate = "";
	private String smtrSeq = "";
	private String smtrTitle = "";
	
	/////////////////////질문지
	private String askSeq = "";
	private String askNo = "";
	private String repNo = "";
	private String askContent = "";
	private String askType = "";
	
	
	/////////////////////답변지
	private String repSeq = "";
	private String repContent = "";
	private String repChoiceCount = "";
	
	/////////////////////답변자
	private String psnSeq = "";
	private String deptSeq = "";
	private String clsSeq = "";
	private String psnHakbun = "";
	private String psnName = "";
	
	/////////////////////답변내용
	private String pansSeq = "";
	private String preNo = "";
	
	private List<QestnarAskVO> askList = null;
	
	
	public String getSmtrTitle() {
		return smtrTitle;
	}
	public void setSmtrTitle(String smtrTitle) {
		this.smtrTitle = smtrTitle;
	}
	public List<QestnarAskVO> getAskList() {
		return askList;
	}
	public void setAskList(List<QestnarAskVO> askList) {
		this.askList = askList;
	}
	public String getQstnrSeq() {
		return qstnrSeq;
	}
	public void setQstnrSeq(String qstnrSeq) {
		this.qstnrSeq = qstnrSeq;
	}
	public String getQstnrTitle() {
		return qstnrTitle;
	}
	public void setQstnrTitle(String qstnrTitle) {
		this.qstnrTitle = qstnrTitle;
	}
	public String getQstnrSubTitle() {
		return qstnrSubTitle;
	}
	public void setQstnrSubTitle(String qstnrSubTitle) {
		this.qstnrSubTitle = qstnrSubTitle;
	}
	public String getQstnrContent() {
		return qstnrContent;
	}
	public void setQstnrContent(String qstnrContent) {
		this.qstnrContent = qstnrContent;
	}
	public String getQstnrStartDate() {
		return qstnrStartDate;
	}
	public void setQstnrStartDate(String qstnrStartDate) {
		this.qstnrStartDate = qstnrStartDate;
	}
	public String getQstnrEndDate() {
		return qstnrEndDate;
	}
	public void setQstnrEndDate(String qstnrEndDate) {
		this.qstnrEndDate = qstnrEndDate;
	}
	public String getQstnrRespCount() {
		return qstnrRespCount;
	}
	public void setQstnrRespCount(String qstnrRespCount) {
		this.qstnrRespCount = qstnrRespCount;
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
	
	public String getSmtrSeq() {
		return smtrSeq;
	}
	public void setSmtrSeq(String smtrSeq) {
		this.smtrSeq = smtrSeq;
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
	public String getRepNo() {
		return repNo;
	}
	public void setRepNo(String repNo) {
		this.repNo = repNo;
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
	public String getPsnSeq() {
		return psnSeq;
	}
	public void setPsnSeq(String psnSeq) {
		this.psnSeq = psnSeq;
	}
	public String getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getClsSeq() {
		return clsSeq;
	}
	public void setClsSeq(String clsSeq) {
		this.clsSeq = clsSeq;
	}
	public String getPsnHakbun() {
		return psnHakbun;
	}
	public void setPsnHakbun(String psnHakbun) {
		this.psnHakbun = psnHakbun;
	}
	public String getPsnName() {
		return psnName;
	}
	public void setPsnName(String psnName) {
		this.psnName = psnName;
	}
	public String getPansSeq() {
		return pansSeq;
	}
	public void setPansSeq(String pansSeq) {
		this.pansSeq = pansSeq;
	}
	public String getPreNo() {
		return preNo;
	}
	public void setPreNo(String preNo) {
		this.preNo = preNo;
	}
	@Override
	public String toString() {
		return "QestnarVO [qstnrSeq=" + qstnrSeq + "\r\n qstnrTitle=" + qstnrTitle
				+ "\r\n qstnrSubTitle=" + qstnrSubTitle + "\r\n qstnrContent="
				+ qstnrContent + "\r\n qstnrStartDate=" + qstnrStartDate
				+ "\r\n qstnrEndDate=" + qstnrEndDate + "\r\n qstnrRespCount="
				+ qstnrRespCount + "\r\n regId=" + regId + "\r\n regDate=" + regDate
				+ "\r\n smtrSeq=" + smtrSeq + "\r\n askSeq=" + askSeq + "\r\n askNo="
				+ askNo + "\r\n repNo=" + repNo + "\r\n askContent=" + askContent
				+ "\r\n askType=" + askType + "\r\n repSeq=" + repSeq
				+ "\r\n repContent=" + repContent + "\r\n repChoiceCount="
				+ repChoiceCount + "\r\n psnSeq=" + psnSeq + "\r\n deptSeq="
				+ deptSeq + "\r\n clsSeq=" + clsSeq + "\r\n psnHakbun=" + psnHakbun
				+ "\r\n psnName=" + psnName + "\r\n pansSeq=" + pansSeq + "\r\n preNo="
				+ preNo + "]";
	}
	
	

}
