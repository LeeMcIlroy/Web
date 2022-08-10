package lcms.valueObject;

public class CourVO {
	//	교육과정 > 교과목
	private String courSeq			= "";	//No
	private String courName			= "";	//교과목명
	private String courCode			= "";	//교과목코드
	private String courPro			= "";	//교과목 프로그램 
	private String courState		= "";	//운영여부
	
	@Override
	public String toString() {
		return "CourVO [courSeq=" + courSeq + ", courName=" + courName + ", courCode=" + courCode + ", courPro="
				+ courPro + ", courState=" + courState + "]";
	}
	
	public String getCourSeq() {
		return courSeq;
	}
	public void setCourSeq(String courSeq) {
		this.courSeq = courSeq;
	}
	public String getCourName() {
		return courName;
	}
	public void setCourName(String courName) {
		this.courName = courName;
	}
	public String getCourCode() {
		return courCode;
	}
	public void setCourCode(String courCode) {
		this.courCode = courCode;
	}
	public String getCourPro() {
		return courPro;
	}
	public void setCourPro(String courPro) {
		this.courPro = courPro;
	}
	public String getCourState() {
		return courState;
	}
	public void setCourState(String courState) {
		this.courState = courState;
	}
	
	
}