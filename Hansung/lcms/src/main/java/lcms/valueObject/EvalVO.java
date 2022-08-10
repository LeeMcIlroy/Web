package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 학생평가VO 2020.03.19
 *
 */
public class EvalVO extends MemberVO { 
	
	private String evalSeq		= ""; // 평가Seq
	private String lectSeq		= ""; // 강의Seq
	private String evalDate		= ""; // 평가일자
	private String profCode		= ""; // 평가자
	private String content		= ""; // 평가내용
	
	public String getEvalSeq() {
		return evalSeq;
	}
	public void setEvalSeq(String evalSeq) {
		this.evalSeq = evalSeq;
	}
	public String getLectSeq() {
		return lectSeq;
	}
	public void setLectSeq(String lectSeq) {
		this.lectSeq = lectSeq;
	}
	public String getEvalDate() {
		return evalDate;
	}
	public void setEvalDate(String evalDate) {
		this.evalDate = evalDate;
	}
	public String getProfCode() {
		return profCode;
	}
	public void setProfCode(String profCode) {
		this.profCode = profCode;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	@Override
	public String toString() {
		return "EvalVO [evalSeq=" + evalSeq + ", lectSeq=" + lectSeq + ", evalDate=" + evalDate + ", profCode="
				+ profCode + ", content=" + content + "]";
	}
	
}
