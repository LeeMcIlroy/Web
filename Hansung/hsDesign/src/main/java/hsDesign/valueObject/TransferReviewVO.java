package hsDesign.valueObject;

/**
 * @author kjhoon
 * 편입성공사례 2017.06.22
 * 
 */
public class TransferReviewVO {
	private String trSeq				= ""; // 편입성공사례 SEQ
	private String trName				= ""; // 작성자 이름
	private String trPreSchool			= ""; // 작성자 전적대학
	private String trRegSemesterBegin	= ""; // 작성자 등록학기_시작
	private String trRegSemesterEnd		= ""; // 작성자 등록학기_시작
	private String trActivity			= ""; // 작성자 활동
	private String trResult				= ""; // 결과
	private String trUrl				= ""; // 편입후기 url
	private String trMajor				= ""; // 편입학과
	
	
	public String getTrMajor() {
		return trMajor;
	}
	public void setTrMajor(String trMajor) {
		this.trMajor = trMajor;
	}
	public String getTrSeq() {
		return trSeq;
	}
	public void setTrSeq(String trSeq) {
		this.trSeq = trSeq;
	}
	public String getTrName() {
		return trName;
	}
	public void setTrName(String trName) {
		this.trName = trName;
	}
	public String getTrPreSchool() {
		return trPreSchool;
	}
	public void setTrPreSchool(String trPreSchool) {
		this.trPreSchool = trPreSchool;
	}
	
	public String getTrActivity() {
		return trActivity;
	}
	public void setTrActivity(String trActivity) {
		this.trActivity = trActivity;
	}
	public String getTrResult() {
		return trResult;
	}
	public void setTrResult(String trResult) {
		this.trResult = trResult;
	}
	public String getTrUrl() {
		return trUrl;
	}
	public void setTrUrl(String trUrl) {
		this.trUrl = trUrl;
	}
	public String getTrRegSemesterBegin() {
		return trRegSemesterBegin;
	}
	public void setTrRegSemesterBegin(String trRegSemesterBegin) {
		this.trRegSemesterBegin = trRegSemesterBegin;
	}
	public String getTrRegSemesterEnd() {
		return trRegSemesterEnd;
	}
	public void setTrRegSemesterEnd(String trRegSemesterEnd) {
		this.trRegSemesterEnd = trRegSemesterEnd;
	}
	@Override
	public String toString() {
		return "TransferReviewVO [trSeq=" + trSeq + "\r\n trName=" + trName
				+ "\r\n trPreSchool=" + trPreSchool + "\r\n trRegSemesterBegin="
				+ trRegSemesterBegin + "\r\n trRegSemesterEnd=" + trRegSemesterEnd
				+ "\r\n trActivity=" + trActivity + "\r\n trResult=" + trResult
				+ "\r\n trUrl=" + trUrl + "\r\n trMajor=" + trMajor + "]";
	}
	
	
	
	
}
