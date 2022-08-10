package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 장학/수상VO 2020.04.01
 *
 */
public class ScholarVO extends MemberVO {
	
	private String scholarSeq	= "";	// 장학/수상Seq
	private String year			= "";	// 년도
	private String semester		= "";	// 학기
	private String scholarType	= "";	// 장학/수상구분
	private String scholarship	= "";	// 장학금
	private String scholarDate	= "";	// 선정일자
	private String scholarEtc	= "";	// 비고
	private String regDate		= "";	// 등록일시
	private String scholarNum	= "";	// 발급번호
	
	public String getScholarSeq() {
		return scholarSeq;
	}
	public void setScholarSeq(String scholarSeq) {
		this.scholarSeq = scholarSeq;
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
	public String getScholarType() {
		return scholarType;
	}
	public void setScholarType(String scholarType) {
		this.scholarType = scholarType;
	}
	public String getScholarship() {
		return scholarship;
	}
	public void setScholarship(String scholarship) {
		this.scholarship = scholarship;
	}
	public String getScholarDate() {
		return scholarDate;
	}
	public void setScholarDate(String scholarDate) {
		this.scholarDate = scholarDate;
	}
	public String getScholarEtc() {
		return scholarEtc;
	}
	public void setScholarEtc(String scholarEtc) {
		this.scholarEtc = scholarEtc;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getScholarNum() {
		return scholarNum;
	}
	public void setScholarNum(String scholarNum) {
		this.scholarNum = scholarNum;
	}
	
	@Override
	public String toString() {
		return "ScholarVO [scholarSeq=" + scholarSeq + ", year=" + year + ", semester=" + semester + ", scholarType="
				+ scholarType + ", scholarship=" + scholarship + ", scholarDate=" + scholarDate + ", scholarEtc="
				+ scholarEtc + ", regDate=" + regDate + ", scholarNum=" + scholarNum + "]";
	}
	
}
