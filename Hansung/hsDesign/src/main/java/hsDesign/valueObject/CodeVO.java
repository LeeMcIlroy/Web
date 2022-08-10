package hsDesign.valueObject;

/**
 * @author kjhoon
 * 코드관리 2017.06.22
 */
public class CodeVO {
	private String bcSeq = "";
	private String bcName = "";
	private String bcType = "";
	private String bcUseYn = "";
	private String bcRegDttm = "";
	
	public String getBcSeq() {
		return bcSeq;
	}
	public void setBcSeq(String bcSeq) {
		this.bcSeq = bcSeq;
	}
	public String getBcName() {
		return bcName;
	}
	public void setBcName(String bcName) {
		this.bcName = bcName;
	}
	public String getBcType() {
		return bcType;
	}
	public void setBcType(String bcType) {
		this.bcType = bcType;
	}
	public String getBcUseYn() {
		return bcUseYn;
	}
	public void setBcUseYn(String bcUseYn) {
		this.bcUseYn = bcUseYn;
	}
	public String getBcRegDttm() {
		return bcRegDttm;
	}
	public void setBcRegDttm(String bcRegDttm) {
		this.bcRegDttm = bcRegDttm;
	}
	@Override
	public String toString() {
		return "CodeVO [bcSeq=" + bcSeq + "\r\n bcName=" + bcName + "\r\n bcType="
				+ bcType + "\r\n bcUseYn=" + bcUseYn + "\r\n bcRegDttm=" + bcRegDttm
				+ "]";
	}
}
