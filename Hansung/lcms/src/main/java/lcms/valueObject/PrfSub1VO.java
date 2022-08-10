package lcms.valueObject;

public class PrfSub1VO extends MemberVO{
	private String prfFSeq				= "";	//seq
	private String prfFYear				= "";	//년도
	private String prfFSem				= "";	//학기
	private String prfFSDate				= "";	//시작일자
	private String prfFEDate				= "";	//종료일자
	private String prfFHour				= "";	//시수
	private String prfFGrade				= "";	//등급
	private String prfFGubun				= "";	//강사구분 1:정강사, 2:임시강사
	private String prfFWorkDay			= "";	//작업일자
	@Override
	public String toString() {
		return "prfFSub1VO [prfFSeq=" + prfFSeq + ", prfFYear=" + prfFYear + ", prfFSem=" + prfFSem + ", prfFSDate=" + prfFSDate
				+ ", prfFEDate=" + prfFEDate + ", prfFHour=" + prfFHour + ", prfFGrade=" + prfFGrade + ", prfFGubun="
				+ prfFGubun + ", prfFWorkDay=" + prfFWorkDay + "]";
	}
	public String getprfFSeq() {
		return prfFSeq;
	}
	public void setprfFSeq(String prfFSeq) {
		this.prfFSeq = prfFSeq;
	}
	public String getprfFYear() {
		return prfFYear;
	}
	public void setprfFYear(String prfFYear) {
		this.prfFYear = prfFYear;
	}
	public String getprfFSem() {
		return prfFSem;
	}
	public void setprfFSem(String prfFSem) {
		this.prfFSem = prfFSem;
	}
	public String getprfFSDate() {
		return prfFSDate;
	}
	public void setprfFSDate(String prfFSDate) {
		this.prfFSDate = prfFSDate;
	}
	public String getprfFEDate() {
		return prfFEDate;
	}
	public void setprfFEdate(String prfFEDate) {
		this.prfFEDate = prfFEDate;
	}
	public String getprfFHour() {
		return prfFHour;
	}
	public void setprfFHour(String prfFHour) {
		this.prfFHour = prfFHour;
	}
	public String getprfFGrade() {
		return prfFGrade;
	}
	public void setprfFGrade(String prfFGrade) {
		this.prfFGrade = prfFGrade;
	}
	public String getprfFGubun() {
		return prfFGubun;
	}
	public void setprfFGubun(String prfFGubun) {
		this.prfFGubun = prfFGubun;
	}
	public String getprfFWorkDay() {
		return prfFWorkDay;
	}
	public void setprfFWorkDay(String prfFWorkDay) {
		this.prfFWorkDay = prfFWorkDay;
	}

	
	
}
