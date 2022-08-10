package hsDesign.valueObject;

/**
 * @author kjhoon
 * 공통게시판 썸네일 	2017.6.22
 */
public class CBThumbnailVO {
	private String cbthSeq					= ""; // 썸네일 SEQ
	private String cbthType					= ""; // 썸네일 타입
	private String cbthName					= ""; // 썸네일 이미지 이름
	private String cbthSaveFilepath			= ""; // 썸네일 이미지 경로
	private String cbthUrlAddr				= ""; // 썸네일 url
	private String cbSeq					= ""; // 공통게시판 SEQ
	public String getCbthSeq() {
		return cbthSeq;
	}
	public void setCbthSeq(String cbthSeq) {
		this.cbthSeq = cbthSeq;
	}
	public String getCbthType() {
		return cbthType;
	}
	public void setCbthType(String cbthType) {
		this.cbthType = cbthType;
	}
	public String getCbthName() {
		return cbthName;
	}
	public void setCbthName(String cbthName) {
		this.cbthName = cbthName;
	}
	public String getCbthSaveFilepath() {
		return cbthSaveFilepath;
	}
	public void setCbthSaveFilepath(String cbthSaveFilepath) {
		this.cbthSaveFilepath = cbthSaveFilepath;
	}
	public String getCbthUrlAddr() {
		return cbthUrlAddr;
	}
	public void setCbthUrlAddr(String cbthUrlAddr) {
		this.cbthUrlAddr = cbthUrlAddr;
	}
	public String getCbSeq() {
		return cbSeq;
	}
	public void setCbSeq(String cbSeq) {
		this.cbSeq = cbSeq;
	}
	@Override
	public String toString() {
		return "CBThumbnailVO [cbthSeq=" + cbthSeq + "\r\n cbthType=" + cbthType
				+ "\r\n cbthName=" + cbthName + "\r\n cbthSaveFilepath="
				+ cbthSaveFilepath + "\r\n cbthUrlAddr=" + cbthUrlAddr
				+ "\r\n cbSeq=" + cbSeq + "]";
	}
	
	
	
}
