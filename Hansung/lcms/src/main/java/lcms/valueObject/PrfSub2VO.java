package lcms.valueObject;

public class PrfSub2VO extends MemberVO{
	private String prfSSeq				= "";	//seq
	private String prfSYear				= "";	//년도
	private String prfSSem				= "";	//학기
	private String prfSStep				= "";	//급 >> lectName
	private String prfSDivi				= "";	//분반
	private String prfSSDate 			= "";	//시작일자
	private String prfSEDate				= "";	//종료일자
	private String prfSPosition			= "";	//직책 1:담임 2:부담임
	@Override
	public String toString() {
		return "PrfSub2VO [prfSSeq=" + prfSSeq + ", prfSYear=" + prfSYear + ", prfSSem=" + prfSSem + ", prfSStep="
				+ prfSStep + ", prfSDivi=" + prfSDivi + ", prfSSDate=" + prfSSDate + ", prfSEDate=" + prfSEDate
				+ ", prfSPosition=" + prfSPosition + "]";
	}
	public String getPrfSSeq() {
		return prfSSeq;
	}
	public void setPrfSSeq(String prfSSeq) {
		this.prfSSeq = prfSSeq;
	}
	public String getPrfSYear() {
		return prfSYear;
	}
	public void setPrfSYear(String prfSYear) {
		this.prfSYear = prfSYear;
	}
	public String getPrfSSem() {
		return prfSSem;
	}
	public void setPrfSSem(String prfSSem) {
		this.prfSSem = prfSSem;
	}
	public String getPrfSStep() {
		return prfSStep;
	}
	public void setPrfSStep(String prfSStep) {
		this.prfSStep = prfSStep;
	}
	public String getPrfSDivi() {
		return prfSDivi;
	}
	public void setPrfSDivi(String prfSDivi) {
		this.prfSDivi = prfSDivi;
	}
	public String getPrfSSDate() {
		return prfSSDate;
	}
	public void setPrfSSDate(String prfSSDate) {
		this.prfSSDate = prfSSDate;
	}
	public String getPrfSEDate() {
		return prfSEDate;
	}
	public void setPrfSEDate(String prfSEDate) {
		this.prfSEDate = prfSEDate;
	}
	public String getPrfSPosition() {
		return prfSPosition;
	}
	public void setPrfSPosition(String prfSPosition) {
		this.prfSPosition = prfSPosition;
	}
	
}
