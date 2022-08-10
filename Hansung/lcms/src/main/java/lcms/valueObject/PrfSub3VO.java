package lcms.valueObject;

public class PrfSub3VO extends MemberVO{
	private String prfTSeq				= "";	//seq
	private String prfTYear				= "";	//년도
	private String prfTSem				= "";	//학기
	private String prfTAnnoDate			= "";	//발령일자
	private String prfTBelong 			= "";	//소속
	private String prfTPosition			= "";	//직함 1:강사실장 2:선임강사 3:강사
	private String prfTWorkDay			= "";	//작업일자
	public String getPrfTSeq() {
		return prfTSeq;
	}
	public void setPrfTSeq(String prfTSeq) {
		this.prfTSeq = prfTSeq;
	}
	public String getPrfTYear() {
		return prfTYear;
	}
	public void setPrfTYear(String prfTYear) {
		this.prfTYear = prfTYear;
	}
	public String getPrfTSem() {
		return prfTSem;
	}
	public void setPrfTSem(String prfTSem) {
		this.prfTSem = prfTSem;
	}
	public String getPrfTAnnoDate() {
		return prfTAnnoDate;
	}
	public void setPrfTAnnoDate(String prfTAnnoDate) {
		this.prfTAnnoDate = prfTAnnoDate;
	}
	public String getPrfTBelong() {
		return prfTBelong;
	}
	public void setPrfTBelong(String prfTBelong) {
		this.prfTBelong = prfTBelong;
	}
	public String getPrfTPosition() {
		return prfTPosition;
	}
	public void setPrfTPosition(String prfTPosition) {
		this.prfTPosition = prfTPosition;
	}
	public String getPrfTWorkDay() {
		return prfTWorkDay;
	}
	public void setPrfTWorkDay(String prfTWorkDay) {
		this.prfTWorkDay = prfTWorkDay;
	}
	@Override
	public String toString() {
		return "PrfSub3VO [prfTSeq=" + prfTSeq + ", prfTYear=" + prfTYear + ", prfTSem=" + prfTSem + ", prfTAnnoDate="
				+ prfTAnnoDate + ", prfTBelong=" + prfTBelong + ", prfTPosition=" + prfTPosition + ", prfTWorkDay="
				+ prfTWorkDay + "]";
	}
	
}
