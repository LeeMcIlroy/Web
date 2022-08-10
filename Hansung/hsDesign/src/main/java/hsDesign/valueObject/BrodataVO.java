package hsDesign.valueObject;

/**
 * @author songcw
 *	2017-12-06 최초생성
 */
public class BrodataVO {
	private String bdSeq 				= "";	// 브로셔자료SEQ
	private String bdName 				= "";	// 브로셔명
	private String bdOriginFileName 	= "";	// 대표이미지명
	private String bdSaveFilePath 		= "";	// 대표이미지경로
	private String bdUrl 				= "";	// 공유URL
	private String regDate 				= "";	// 등록일
	private String regSeq 				= "";	// 등록자SEQ
	private String regName 				= "";	// 등록자명
	public String getBdSeq() {
		return bdSeq;
	}
	public void setBdSeq(String bdSeq) {
		this.bdSeq = bdSeq;
	}
	public String getBdName() {
		return bdName;
	}
	public void setBdName(String bdName) {
		this.bdName = bdName;
	}
	public String getBdOriginFileName() {
		return bdOriginFileName;
	}
	public void setBdOriginFileName(String bdOriginFileName) {
		this.bdOriginFileName = bdOriginFileName;
	}
	public String getBdSaveFilePath() {
		return bdSaveFilePath;
	}
	public void setBdSaveFilePath(String bdSaveFilePath) {
		this.bdSaveFilePath = bdSaveFilePath;
	}
	public String getBdUrl() {
		return bdUrl;
	}
	public void setBdUrl(String bdUrl) {
		this.bdUrl = bdUrl;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegSeq() {
		return regSeq;
	}
	public void setRegSeq(String regSeq) {
		this.regSeq = regSeq;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	@Override
	public String toString() {
		return "BrodataVO [\nbdSeq=" + bdSeq + "\nbdName=" + bdName + "\nbdOriginFileName=" + bdOriginFileName
				+ "\nbdSaveFilePath=" + bdSaveFilePath + "\nbdUrl=" + bdUrl + "\nregDate=" + regDate + "\nregSeq="
				+ regSeq + "\nregName=" + regName + "\n]";
	}
}
