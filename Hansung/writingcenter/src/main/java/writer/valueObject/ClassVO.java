package writer.valueObject;

/**
 * 반_교수
 * 	2017-01-25 최초생성
 * 	2017-02-17 수정 (clsLink 추가)
 *
 */
public class ClassVO {
	private String clsSeq = "";			// seq
	private String clsTitle = "";		// 제목
	private String clsContent = "";		// 내용
	private String clsSort = "";		// 정렬
	private String clsViewYn = "";		// 공개여부
	private String clsHitcount = "";	// 조회수
	private String clsLink = "";		// 블랙보드 링크
	private String regId = "";			// 등록자
	private String regName = "";		// 등록자명
	private String regDate = "";		// 등록일
	private String deptSeq = "";		// 계열seq
	private String smtrSeq = "";		// 학기seq
	public String getClsSeq() {
		return clsSeq;
	}
	public void setClsSeq(String clsSeq) {
		this.clsSeq = clsSeq;
	}
	public String getClsTitle() {
		return clsTitle;
	}
	public void setClsTitle(String clsTitle) {
		this.clsTitle = clsTitle;
	}
	public String getClsContent() {
		return clsContent;
	}
	public void setClsContent(String clsContent) {
		this.clsContent = clsContent;
	}
	public String getClsSort() {
		return clsSort;
	}
	public void setClsSort(String clsSort) {
		this.clsSort = clsSort;
	}
	public String getClsViewYn() {
		return clsViewYn;
	}
	public void setClsViewYn(String clsViewYn) {
		this.clsViewYn = clsViewYn;
	}
	public String getClsHitcount() {
		return clsHitcount;
	}
	public void setClsHitcount(String clsHitcount) {
		this.clsHitcount = clsHitcount;
	}
	public String getClsLink() {
		return clsLink;
	}
	public void setClsLink(String clsLink) {
		this.clsLink = clsLink;
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
	public String getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getSmtrSeq() {
		return smtrSeq;
	}
	public void setSmtrSeq(String smtrSeq) {
		this.smtrSeq = smtrSeq;
	}
	@Override
	public String toString() {
		return "ClassVO [\r\nclsSeq=" + clsSeq + "\r\n clsTitle=" + clsTitle + "\r\n clsContent=" + clsContent + "\r\n clsSort="
				+ clsSort + "\r\n clsViewYn=" + clsViewYn + "\r\n clsHitcount=" + clsHitcount + "\r\n clsLink=" + clsLink
				+ "\r\n regId=" + regId + "\r\n regName=" + regName + "\r\n regDate=" + regDate + "\r\n deptSeq=" + deptSeq
				+ "\r\n smtrSeq=" + smtrSeq + "\r\n]";
	}
}
