package writer.valueObject;

/**
 * 학기
 *	2017-01-25 최초생성
 *	2017-01-31 수정 ( choiceYn 추가 )
 *
 */
public class SemesterVO {
	private String smtrSeq = "";		// seq
	private String smtrTitle = "";		// 제목
	private String smtrContent = "";	// 내용
	private String smtrSort = "";		// 정렬
	private String smtrViewYn = "";		// 공개여부
	private String smtrHitcount = "";	// 조회수
	private String regId = "";			// 등록자
	private String regName = "";		// 등록자명
	private String regDate = "";		// 등록일
	
	private String choiceYn = "";		// 선택여부
	public String getChoiceYn() { return choiceYn; }
	public void setChoiceYn(String choiceYn) { this.choiceYn = choiceYn; }
	
	public String getSmtrSeq() {
		return smtrSeq;
	}
	public void setSmtrSeq(String smtrSeq) {
		this.smtrSeq = smtrSeq;
	}
	public String getSmtrTitle() {
		return smtrTitle;
	}
	public void setSmtrTitle(String smtrTitle) {
		this.smtrTitle = smtrTitle;
	}
	public String getSmtrContent() {
		return smtrContent;
	}
	public void setSmtrContent(String smtrContent) {
		this.smtrContent = smtrContent;
	}
	public String getSmtrSort() {
		return smtrSort;
	}
	public void setSmtrSort(String smtrSort) {
		this.smtrSort = smtrSort;
	}
	public String getSmtrViewYn() {
		return smtrViewYn;
	}
	public void setSmtrViewYn(String smtrViewYn) {
		this.smtrViewYn = smtrViewYn;
	}
	public String getSmtrHitcount() {
		return smtrHitcount;
	}
	public void setSmtrHitcount(String smtrHitcount) {
		this.smtrHitcount = smtrHitcount;
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
		return "SemesterVO [\r\nsmtrSeq=" + smtrSeq + "\r\n smtrTitle=" + smtrTitle + "\r\n smtrContent=" + smtrContent
				+ "\r\n smtrSort=" + smtrSort + "\r\n smtrViewYn=" + smtrViewYn + "\r\n smtrHitcount=" + smtrHitcount
				+ "\r\n regId=" + regId + "\r\n regName=" + regName + "\r\n regDate=" + regDate + "\r\n]";
	}
	
}
