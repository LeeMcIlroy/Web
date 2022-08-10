package lcms.valueObject;

import java.util.List;

/**
 * @author Leegh
 * 
 * 수업만족도 답변VO 2020.05.11
 *
 */
public class SurveyAnswVO extends SurveyQuesVO { 
	
	private String answSeq		= "";
	private String memberCode	= "";
	private String lectSeq		= "";
	private String answerTxt	= "";
	private String answer		= "";
	private String regDate		= "";
	private String quesType		= "";
	private String profCode		= "";
	
	private List<SurveyAnswVO> surveyAnswList;
	
	public List<SurveyAnswVO> getSurveyAnswList() {
		return surveyAnswList;
	}
	public void setSurveyAnswList(List<SurveyAnswVO> surveyAnswList) {
		this.surveyAnswList = surveyAnswList;
	}
	
	public String getAnswSeq() {
		return answSeq;
	}
	public void setAnswSeq(String answSeq) {
		this.answSeq = answSeq;
	}
	public String getMemberCode() {
		return memberCode;
	}
	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	public String getLectSeq() {
		return lectSeq;
	}
	public void setLectSeq(String lectSeq) {
		this.lectSeq = lectSeq;
	}
	public String getAnswerTxt() {
		return answerTxt;
	}
	public void setAnswerTxt(String answerTxt) {
		this.answerTxt = answerTxt;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getQuesType() {
		return quesType;
	}
	public void setQuesType(String quesType) {
		this.quesType = quesType;
	}
	public String getProfCode() {
		return profCode;
	}
	public void setProfCode(String profCode) {
		this.profCode = profCode;
	}
	
	@Override
	public String toString() {
		return "SurveyAnswVO [answSeq=" + answSeq + ", memberCode=" + memberCode + ", lectSeq=" + lectSeq
				+ ", answerTxt=" + answerTxt + ", answer=" + answer + ", regDate=" + regDate + ", quesType=" + quesType
				+ ", profCode=" + profCode + ", surveyAnswList=" + surveyAnswList + "]";
	}
}
