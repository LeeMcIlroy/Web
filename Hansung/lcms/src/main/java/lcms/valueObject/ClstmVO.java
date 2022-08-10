package lcms.valueObject;

public class ClstmVO {
// 교육과정 > 수업시간
	private String clstmSeq			= "";	//seq
	private String clstmName			= "";	//프로그램명
	private String clstmCode			= "";	//교시
	private String clstmStimeS		= "";	//강의시작시간
	private String clstmStimeE		= "";	//강의시작시간
	private String clstmEtimeS		= "";	//강의종료시잔
	private String clstmEtimeE		= "";	//강의종료시잔
	private String clstmState			= "";	//상태
	private String clstmYear		= "";	// 년도
	private String clstmSeme		= "";	// 학기
	
	@Override
	public String toString() {
		return "ClstmVO [clstmSeq=" + clstmSeq + ", clstmName=" + clstmName + ", clstmCode=" + clstmCode
				+ ", clstmStimeS=" + clstmStimeS + ", clstmStimeE=" + clstmStimeE + ", clstmEtimeS=" + clstmEtimeS
				+ ", clstmEtimeE=" + clstmEtimeE + ", clstmState=" + clstmState + ", clstmYear=" + clstmYear
				+ ", clstmSeme=" + clstmSeme + "]";
	}
	
	public String getClstmSeq() {
		return clstmSeq;
	}
	public void setClstmSeq(String clstmSeq) {
		this.clstmSeq = clstmSeq;
	}
	public String getClstmName() {
		return clstmName;
	}
	public void setClstmName(String clstmName) {
		this.clstmName = clstmName;
	}
	public String getClstmCode() {
		return clstmCode;
	}
	public void setClstmCode(String clstmCode) {
		this.clstmCode = clstmCode;
	}
	public String getClstmStimeS() {
		return clstmStimeS;
	}
	public void setClstmStimeS(String clstmStimeS) {
		this.clstmStimeS = clstmStimeS;
	}
	public String getClstmStimeE() {
		return clstmStimeE;
	}
	public void setClstmStimeE(String clstmStimeE) {
		this.clstmStimeE = clstmStimeE;
	}
	public String getClstmEtimeS() {
		return clstmEtimeS;
	}
	public void setClstmEtimeS(String clstmEtimeS) {
		this.clstmEtimeS = clstmEtimeS;
	}
	public String getClstmEtimeE() {
		return clstmEtimeE;
	}
	public void setClstmEtimeE(String clstmEtimeE) {
		this.clstmEtimeE = clstmEtimeE;
	}
	public String getClstmState() {
		return clstmState;
	}
	public void setClstmState(String clstmState) {
		this.clstmState = clstmState;
	}
	public String getClstmYear() {
		return clstmYear;
	}
	public void setClstmYear(String clstmYear) {
		this.clstmYear = clstmYear;
	}
	public String getClstmSeme() {
		return clstmSeme;
	}
	public void setClstmSeme(String clstmSeme) {
		this.clstmSeme = clstmSeme;
	}
}
