package lcms.valueObject;

import java.util.List;

/**
 * @author Leegh
 * 
 * 수업만족도항목VO 2020.03.11
 *
 */
public class SurveyQuesVO extends SurveyVO { 
	
	private String quesSeq = "";
	private String phrSeq = "";
	private String surveyType = "";
	private String question = "";
	private String answer1 = "";
	private String answer2 = "";
	private String answer3 = "";
	private String answer4 = "";
	private String answer5 = "";
	private String quesNum = "";
	
	private List<SurveyQuesVO> surveyQuesList;
	
	public List<SurveyQuesVO> getSurveyQuesList() {
		return surveyQuesList;
	}
	public void setSurveyQuesList(List<SurveyQuesVO> surveyQuesList) {
		this.surveyQuesList = surveyQuesList;
	}
	
	public String getQuesSeq() {
		return quesSeq;
	}
	public void setQuesSeq(String quesSeq) {
		this.quesSeq = quesSeq;
	}
	public String getPhrSeq() {
		return phrSeq;
	}
	public void setPhrSeq(String phrSeq) {
		this.phrSeq = phrSeq;
	}
	public String getSurveyType() {
		return surveyType;
	}
	public void setSurveyType(String surveyType) {
		this.surveyType = surveyType;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer1() {
		return answer1;
	}
	public void setAnswer1(String answer1) {
		this.answer1 = answer1;
	}
	public String getAnswer2() {
		return answer2;
	}
	public void setAnswer2(String answer2) {
		this.answer2 = answer2;
	}
	public String getAnswer3() {
		return answer3;
	}
	public void setAnswer3(String answer3) {
		this.answer3 = answer3;
	}
	public String getAnswer4() {
		return answer4;
	}
	public void setAnswer4(String answer4) {
		this.answer4 = answer4;
	}
	public String getAnswer5() {
		return answer5;
	}
	public void setAnswer5(String answer5) {
		this.answer5 = answer5;
	}
	public String getQuesNum() {
		return quesNum;
	}
	public void setQuesNum(String quesNum) {
		this.quesNum = quesNum;
	}
	
	@Override
	public String toString() {
		return "SurveyQuesVO [quesSeq=" + quesSeq + ", phrSeq=" + phrSeq + ", surveyType=" + surveyType + ", question="
				+ question + ", answer1=" + answer1 + ", answer2=" + answer2 + ", answer3=" + answer3 + ", answer4="
				+ answer4 + ", answer5=" + answer5 + ", quesNum=" + quesNum + ", surveyQuesList=" + surveyQuesList + "]";
	}
	
}
