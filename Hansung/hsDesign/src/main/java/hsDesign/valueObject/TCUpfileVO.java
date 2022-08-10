package hsDesign.valueObject;


/**
 * @author kjhoon
 * 교강사 첨부파일 
 * 2017-06-27
 */
public class TCUpfileVO {

	private String tcupSeq = "";					// 첨부파일 SEQ
	private String tcupOriginFilename = "";			// 원본파일명
	private String tcupSaveFilename = "";			// 저장파일명
	private String tcupSaveFilepath = "";			// 저장파일경로
	private String tcSeq = "";						// 교강사 SEQ
	public String getTcupSeq() {
		return tcupSeq;
	}
	public void setTcupSeq(String tcupSeq) {
		this.tcupSeq = tcupSeq;
	}
	public String getTcupOriginFilename() {
		return tcupOriginFilename;
	}
	public void setTcupOriginFilename(String tcupOriginFilename) {
		this.tcupOriginFilename = tcupOriginFilename;
	}
	public String getTcupSaveFilename() {
		return tcupSaveFilename;
	}
	public void setTcupSaveFilename(String tcupSaveFilename) {
		this.tcupSaveFilename = tcupSaveFilename;
	}
	public String getTcupSaveFilepath() {
		return tcupSaveFilepath;
	}
	public void setTcupSaveFilepath(String tcupSaveFilepath) {
		this.tcupSaveFilepath = tcupSaveFilepath;
	}
	public String getTcSeq() {
		return tcSeq;
	}
	public void setTcSeq(String tcSeq) {
		this.tcSeq = tcSeq;
	}
	@Override
	public String toString() {
		return "TCUpfileVO [tcupSeq=" + tcupSeq + "\r\n tcupOriginFilename="
				+ tcupOriginFilename + "\r\n tcupSaveFilename=" + tcupSaveFilename
				+ "\r\n tcupSaveFilepath=" + tcupSaveFilepath + "\r\n tcSeq=" + tcSeq
				+ "]";
	}
	
	
	
}
