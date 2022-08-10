package hsDesign.valueObject;

/**
 * @author kjhoon
 * 게시판구분 2017.06.22
 */
public class BoardGubunVO {

	private String bgSeq			= "";	//게시판 구분 SEQ
	private String bgName			= "";	//게시판 구분 이름
	private String bgCode			= "";	//게시판 구분 코드
	public String getBgSeq() {
		return bgSeq;
	}
	public void setBgSeq(String bgSeq) {
		this.bgSeq = bgSeq;
	}
	public String getBgName() {
		return bgName;
	}
	public void setBgName(String bgName) {
		this.bgName = bgName;
	}
	public String getBgCode() {
		return bgCode;
	}
	public void setBgCode(String bgCode) {
		this.bgCode = bgCode;
	}
	@Override
	public String toString() {
		return "BoardGubunVO [bgSeq=" + bgSeq + "\r\n bgName=" + bgName
				+ "\r\n bgCode=" + bgCode + "]";
	}
	
	
	
	
	
	
}
