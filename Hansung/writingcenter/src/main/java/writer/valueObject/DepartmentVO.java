package writer.valueObject;

/**
 * 계열
 * 	2017-01-25 최초생성
 *	2017-02-28 수정 (추가 : clsCnt)
 */
public class DepartmentVO {
	private String deptSeq = "";		// seq
	private String deptTitle = "";		// 제목
	private String deptContent = "";	// 내용
	private String deptSort = "";		// 정렬
	private String deptViewYn = "";		// 공개여부
	private String regId = "";			// 등록자
	private String regName = "";		// 등록자명
	private String regDate = "";		// 등록일
	
	/* view */
	private String clsCnt = "";			// 반_교수 cnt
	public String getClsCnt() { return clsCnt; }
	public void setClsCnt(String clsCnt) { this.clsCnt = clsCnt; }
	private String qstnrCnt = "";		// 계열별 설문 cnt
	
	
	
	public String getQstnrCnt() {
		return qstnrCnt;
	}
	public void setQstnrCnt(String qstnrCnt) {
		this.qstnrCnt = qstnrCnt;
	}
	public String getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getDeptTitle() {
		return deptTitle;
	}
	public void setDeptTitle(String deptTitle) {
		this.deptTitle = deptTitle;
	}
	public String getDeptContent() {
		return deptContent;
	}
	public void setDeptContent(String deptContent) {
		this.deptContent = deptContent;
	}
	public String getDeptSort() {
		return deptSort;
	}
	public void setDeptSort(String deptSort) {
		this.deptSort = deptSort;
	}
	public String getDeptViewYn() {
		return deptViewYn;
	}
	public void setDeptViewYn(String deptViewYn) {
		this.deptViewYn = deptViewYn;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "DepartmentVO [\r\ndeptSeq=" + deptSeq + "\r\n deptTitle=" + deptTitle + "\r\n deptContent=" + deptContent
				+ "\r\n deptSort=" + deptSort + "\r\n deptViewYn=" + deptViewYn + "\r\n regId=" + regId + "\r\n regName=" + regName
				+ "\r\n regDate=" + regDate + "\r\n clsCnt=" + clsCnt + "\r\n]";
	}
}
