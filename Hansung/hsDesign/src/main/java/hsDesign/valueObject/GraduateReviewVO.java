package hsDesign.valueObject;

/**
 * @author leegh
 * 대학원&타대학 편입 2019.04.18
 * 
 */
public class GraduateReviewVO {
	private String grSeq				= ""; // 편입성공사례 SEQ
	private String grName				= ""; // 작성자 이름
	private String grAftSchool			= ""; // 작성자 전적대학
	private String grRegSemesterBegin	= ""; // 작성자 등록학기_시작
	private String grRegSemesterEnd		= ""; // 작성자 등록학기_시작
	private String grActivity			= ""; // 작성자 활동
	private String grResult				= ""; // 결과
	private String grUrl				= ""; // 편입후기 url
	private String grMajor				= ""; // 편입학과
	
	
	public String getGrMajor() {
		return grMajor;
	}
	public void setGrMajor(String grMajor) {
		this.grMajor = grMajor;
	}
	public String getGrSeq() {
		return grSeq;
	}
	public void setGrSeq(String grSeq) {
		this.grSeq = grSeq;
	}
	public String getGrName() {
		return grName;
	}
	public void setGrName(String grName) {
		this.grName = grName;
	}
	public String getGrAftSchool() {
		return grAftSchool;
	}
	public void setGrAftSchool(String grAftSchool) {
		this.grAftSchool = grAftSchool;
	}
	
	public String getGrActivity() {
		return grActivity;
	}
	public void setGrActivity(String grActivity) {
		this.grActivity = grActivity;
	}
	public String getGrResult() {
		return grResult;
	}
	public void setGrResult(String grResult) {
		this.grResult = grResult;
	}
	public String getGrUrl() {
		return grUrl;
	}
	public void setGrUrl(String grUrl) {
		this.grUrl = grUrl;
	}
	public String getGrRegSemesterBegin() {
		return grRegSemesterBegin;
	}
	public void setGrRegSemesterBegin(String grRegSemesterBegin) {
		this.grRegSemesterBegin = grRegSemesterBegin;
	}
	public String getGrRegSemesterEnd() {
		return grRegSemesterEnd;
	}
	public void setGrRegSemesterEnd(String grRegSemesterEnd) {
		this.grRegSemesterEnd = grRegSemesterEnd;
	}
	@Override
	public String toString() {
		return "TransferReviewVO [grSeq=" + grSeq + "\r\n grName=" + grName
				+ "\r\n grAftSchool=" + grAftSchool + "\r\n grRegSemesterBegin="
				+ grRegSemesterBegin + "\r\n grRegSemesterEnd=" + grRegSemesterEnd
				+ "\r\n grActivity=" + grActivity + "\r\n grResult=" + grResult
				+ "\r\n grUrl=" + grUrl + "\r\n grMajor=" + grMajor + "]";
	}
	
	
	
	
}
