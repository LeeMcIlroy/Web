package lcms.valueObject;

public class CurrVO {

//교육과정 > 교육과정
	private String currSeq				= "";	//seq
	private String currName				= "";	//교육과정명
	private String currCode				= "";	//과정코드
	private String currState			= "";	//상태\
	
	@Override
	public String toString() {
		return "CurrVO [currSeq=" + currSeq + ", currName=" + currName + ", currCode=" + currCode + ", currState="
				+ currState + "]";
	}
	public String getCurrSeq() {
		return currSeq;
	}
	public void setCurrSeq(String currSeq) {
		this.currSeq = currSeq;
	}
	public String getCurrName() {
		return currName;
	}
	public void setCurrName(String currName) {
		this.currName = currName;
	}
	public String getCurrCode() {
		return currCode;
	}
	public void setCurrCode(String currCode) {
		this.currCode = currCode;
	}
	public String getCurrState() {
		return currState;
	}
	public void setCurrState(String currState) {
		this.currState = currState;
	}
	
	

	
}
