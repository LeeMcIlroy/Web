package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * QnaVO 2019.06.20
 *
 */
public class QnaVO { 
	
	private String qnaSeq 		= ""; 						// qna_고유번호
	private String regName 		= "";						// 작성자
	private String email   		= "";						// 이메일
	private String title  		= "";						// 제목
	private String content		= "";						// 내용
	private String answerYn		= "";						// 답변여부
	private String regDttm		= "";						// 등록일시
	
	public String getQnaSeq() {
		return qnaSeq;
	}
	public void setQnaSeq(String qnaSeq) {
		this.qnaSeq = qnaSeq;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAnswerYn() {
		return answerYn;
	}
	public void setAnswerYn(String answerYn) {
		this.answerYn = answerYn;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	
	@Override
	public String toString() {
		return "QnaVO [\nqnaSeq=" + qnaSeq + "\nregName=" + regName + "\nemail=" + email + "\ntitle="
				+ title + "\ncontent=" + content + "\nanswerYn=" + answerYn + "\nregDttm=" + regDttm + "\n]";
	}
}
