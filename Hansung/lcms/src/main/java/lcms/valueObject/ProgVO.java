package lcms.valueObject;

public class ProgVO {
	// 교육과정 > 프로그램
	private String progSeq					= "";	//seq
	private String progName					= "";	//프로그램명
	private String progCode					= "";	//과정코드
	private String progState				= "";	//상태
	
	@Override
	public String toString() {
		return "progVO [progSeq=" + progSeq + ", progName=" + progName + ", progCode=" + progCode + ", progState="
				+ progState + "]";
	}
	
	public String getProgSeq() {
		return progSeq;
	}
	public void setProgSeq(String progSeq) {
		this.progSeq = progSeq;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getProgCode() {
		return progCode;
	}
	public void setProgCode(String progCode) {
		this.progCode = progCode;
	}
	public String getProgState() {
		return progState;
	}
	public void setProgState(String progState) {
		this.progState = progState;
	}

}