package writer.valueObject;

/**
 * 메뉴권한
 * 	2017-02-24 최초생성
 *
 */
public class MenuAthrVO {
	
	private String athrSeq = "";	// 권한SEQ
	private String athrName = "";	// 권한이름
	private String athrUrl = "";	// URL
	
	public String getAthrSeq() {
		return athrSeq;
	}
	public void setAthrSeq(String athrSeq) {
		this.athrSeq = athrSeq;
	}
	public String getAthrName() {
		return athrName;
	}
	public void setAthrName(String athrName) {
		this.athrName = athrName;
	}
	public String getAthrUrl() {
		return athrUrl;
	}
	public void setAthrUrl(String athrUrl) {
		this.athrUrl = athrUrl;
	}
	@Override
	public String toString() {
		return "MenuAthrVO [\r\nathrSeq=" + athrSeq + "\r\n athrName=" + athrName + "\r\n athrUrl=" + athrUrl + "\r\n]";
	}
}
