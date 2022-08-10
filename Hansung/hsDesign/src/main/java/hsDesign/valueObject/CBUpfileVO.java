package hsDesign.valueObject;

/**
 * @author kjhoon
 * 공통게시판 첨부파일 	2017.06.22
 */
public class CBUpfileVO {
	private String cbupSeq					= ""; // 첨부파일 SEQ
	private String cbupOriginFilename		= ""; // 원본파일명
	private String cbupSaveFilepath			= ""; // 파일경로
	private String cbupSaveFilename			= ""; // 저장파일명
	private String cbSeq					= ""; // 공통게시판 SEQ
	public String getCbupSeq() {
		return cbupSeq;
	}
	public void setCbupSeq(String cbupSeq) {
		this.cbupSeq = cbupSeq;
	}
	public String getCbupOriginFilename() {
		return cbupOriginFilename;
	}
	public void setCbupOriginFilename(String cbupOriginFilename) {
		this.cbupOriginFilename = cbupOriginFilename;
	}
	public String getCbupSaveFilepath() {
		return cbupSaveFilepath;
	}
	public void setCbupSaveFilepath(String cbupSaveFilepath) {
		this.cbupSaveFilepath = cbupSaveFilepath;
	}
	public String getCbupSaveFilename() {
		return cbupSaveFilename;
	}
	public void setCbupSaveFilename(String cbupSaveFilename) {
		this.cbupSaveFilename = cbupSaveFilename;
	}
	public String getCbSeq() {
		return cbSeq;
	}
	public void setCbSeq(String cbSeq) {
		this.cbSeq = cbSeq;
	}
	@Override
	public String toString() {
		return "CBUpfileVO [cbupSeq=" + cbupSeq + "\r\n cbupOriginFilename="
				+ cbupOriginFilename + "\r\n cbupSaveFilepath=" + cbupSaveFilepath
				+ "\r\n cbupSaveFilename=" + cbupSaveFilename + "\r\n cbSeq=" + cbSeq
				+ "]";
	}
	
	
	
}
