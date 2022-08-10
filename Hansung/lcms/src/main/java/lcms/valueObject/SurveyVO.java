package lcms.valueObject;

import java.util.List;

/**
 * @author Leegh
 * 
 * 수업만족도항목VO 2020.03.11
 *
 */
public class SurveyVO { 
	
	private String surveySeq = "";
	private String year = "";
	private String seme = "";
	private String lang = "";
	private String title = "";
	private String useYn = "";
	private String content = "";
	private String stDate = "";
	private String stHour = "";
	private String stMinu = "";
	private String edDate = "";
	private String edHour = "";
	private String edMinu = "";
	private String regDate = "";
	private String regName = "";
	
	public String getSurveySeq() {
		return surveySeq;
	}
	public void setSurveySeq(String surveySeq) {
		this.surveySeq = surveySeq;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getSeme() {
		return seme;
	}
	public void setSeme(String seme) {
		this.seme = seme;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStDate() {
		return stDate;
	}
	public void setStDate(String stDate) {
		this.stDate = stDate;
	}
	public String getStHour() {
		return stHour;
	}
	public void setStHour(String stHour) {
		this.stHour = stHour;
	}
	public String getStMinu() {
		return stMinu;
	}
	public void setStMinu(String stMinu) {
		this.stMinu = stMinu;
	}
	public String getEdDate() {
		return edDate;
	}
	public void setEdDate(String edDate) {
		this.edDate = edDate;
	}
	public String getEdHour() {
		return edHour;
	}
	public void setEdHour(String edHour) {
		this.edHour = edHour;
	}
	public String getEdMinu() {
		return edMinu;
	}
	public void setEdMinu(String edMinu) {
		this.edMinu = edMinu;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	
	@Override
	public String toString() {
		return "SurveyVO [surveySeq=" + surveySeq + ", year=" + year + ", seme=" + seme + ", lang=" + lang + ", title="
				+ title + ", useYn=" + useYn + ", content=" + content + ", stDate=" + stDate + ", stHour=" + stHour
				+ ", stMinu=" + stMinu + ", edDate=" + edDate + ", edHour=" + edHour + ", edMinu=" + edMinu
				+ ", regDate=" + regDate + ", regName=" + regName + "]";
	}
	
}
