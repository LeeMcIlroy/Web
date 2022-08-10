package lcms.valueObject;

import java.util.List;

public class FuncVO extends MemberVO {
	//학적변동
//	member_seq - MemberVO값 받아서 넣기

	private String funcSeq = "";
	private String funcDate = "";	//변동일자
	private String funcChangeDate = ""; //작업일자
	private String funcReason = "";
	private String funcState = "";
	private String funcWriter = "";
	private String funcBefState = "";
	private String year = "";
	private String semester = "";
	
	public String getFuncWriter() {
		return funcWriter;
	}
	public void setFuncWriter(String funcWriter) {
		this.funcWriter = funcWriter;
	}
	private List<FuncVO> funcList;
	
	public List<FuncVO> getFuncList() {
		return funcList;
	}
	public void setFuncList(List<FuncVO> funcList) {
		this.funcList = funcList;
	}
	@Override
	public String toString() {
		return "FuncVO [funcSeq=" + funcSeq + ", funcDate=" + funcDate + ", funcChangeDate=" + funcChangeDate
				+ ", funcReason=" + funcReason + ", funcState=" + funcState + ", funcWriter=" + funcWriter
				+ ", funcBefState=" + funcBefState + ", year=" + year + ", semester=" + semester + ", funcList="
				+ funcList + "]";
	}
	public String getFuncSeq() {
		return funcSeq;
	}
	public void setFuncSeq(String funcSeq) {
		this.funcSeq = funcSeq;
	}
	public String getFuncDate() {
		return funcDate;
	}
	public void setFuncDate(String funcDate) {
		this.funcDate = funcDate;
	}
	public String getFuncReason() {
		return funcReason;
	}
	public void setFuncReason(String funcReason) {
		this.funcReason = funcReason;
	}
	public String getFuncState() {
		return funcState;
	}
	public void setFuncState(String funcState) {
		this.funcState = funcState;
	}
	
	public String getFuncChangeDate() {
		return funcChangeDate;
	}
	public void setFuncChangeDate(String funcChangeDate) {
		this.funcChangeDate = funcChangeDate;
	}
	public String getFuncBefState() {
		return funcBefState;
	}
	public void setFuncBefState(String funcBefState) {
		this.funcBefState = funcBefState;
	}
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
}