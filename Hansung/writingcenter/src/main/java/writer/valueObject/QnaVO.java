package writer.valueObject;



/**
 * @author kjhoon
 * @ 질의응답
 * 2017-02-06 생성
 */
public class QnaVO {
	private String qnaSeq=""; 		//SEQ
	private String qstTitle=""; 	//질문제목
	private String qstContent="";	//질문내용
	private String qstRegId="";		//작성자
	private String qstRegDate="";	//작성일
	private String qstRegName="";	//작성자명
	private String qnaHitcount="";	//조회수
	private String ansTitle="";		//답변제목
	private String ansContent="";	//답변내용
	private String ansRegId="";		//답변자
	private String ansRegDate="";	//답변일
	private String ansRegName="";   //답변자명
	
	
	
	public String getQstRegName() {
		return qstRegName;
	}
	public void setQstRegName(String qstRegName) {
		this.qstRegName = qstRegName;
	}
	public String getAnsRegName() {
		return ansRegName;
	}
	public void setAnsRegName(String ansRegName) {
		this.ansRegName = ansRegName;
	}
	public String getQnaSeq() {
		return qnaSeq;
	}
	public void setQnaSeq(String qnaSeq) {
		this.qnaSeq = qnaSeq;
	}
	public String getQstTitle() {
		return qstTitle;
	}
	public void setQstTitle(String qstTitle) {
		this.qstTitle = qstTitle;
	}
	public String getQstContent() {
		return qstContent;
	}
	public void setQstContent(String qstContent) {
		this.qstContent = qstContent;
	}
	public String getQstRegId() {
		return qstRegId;
	}
	public void setQstRegId(String qstRegId) {
		this.qstRegId = qstRegId;
	}
	public String getQstRegDate() {
		return qstRegDate;
	}
	public void setQstRegDate(String qstRegDate) {
		this.qstRegDate = qstRegDate;
	}
	public String getQnaHitcount() {
		return qnaHitcount;
	}
	public void setQnaHitcount(String qnaHitcount) {
		this.qnaHitcount = qnaHitcount;
	}
	public String getAnsTitle() {
		return ansTitle;
	}
	public void setAnsTitle(String ansTitle) {
		this.ansTitle = ansTitle;
	}
	public String getAnsContent() {
		return ansContent;
	}
	public void setAnsContent(String ansContent) {
		this.ansContent = ansContent;
	}
	public String getAnsRegId() {
		return ansRegId;
	}
	public void setAnsRegId(String ansRegId) {
		this.ansRegId = ansRegId;
	}
	public String getAnsRegDate() {
		return ansRegDate;
	}
	public void setAnsRegDate(String ansRegDate) {
		this.ansRegDate = ansRegDate;
	}
	@Override
	public String toString() {
		return "QnaVO [qnaSeq=" + qnaSeq + "\r\n qstTitle=" + qstTitle
				+ "\r\n qstContent=" + qstContent + "\r\n qstRegId=" + qstRegId
				+ "\r\n qstRegDate=" + qstRegDate + "\r\n qstRegName=" + qstRegName
				+ "\r\n qnaHitcount=" + qnaHitcount + "\r\n ansTitle=" + ansTitle
				+ "\r\n ansContent=" + ansContent + "\r\n ansRegId=" + ansRegId
				+ "\r\n ansRegDate=" + ansRegDate + "\r\n ansRegName=" + ansRegName
				+ "]";
	}
	
	
	
	
	
	
}
