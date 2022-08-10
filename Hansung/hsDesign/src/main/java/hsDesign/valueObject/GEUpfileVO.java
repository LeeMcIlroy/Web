package hsDesign.valueObject;

/**
 * @author kjhoon
 * 교양과정 첨부파일 	2017.06.22
 * 
 */
public class GEUpfileVO {
	private String geupSeq				= ""; // 교양과정 첨부파일 SEQ
	private String geupOriginFilename	= ""; // 원본파일명
	private String geupSaveFilepath		= ""; // 첨부파일경로
	private String geupSaveFilename		= ""; // 저장파일명
	private String geSeq				= ""; // 교양과정 SEQ
	public String getGeupSeq() {
		return geupSeq;
	}
	public void setGeupSeq(String geupSeq) {
		this.geupSeq = geupSeq;
	}
	public String getGeupOriginFilename() {
		return geupOriginFilename;
	}
	public void setGeupOriginFilename(String geupOriginFilename) {
		this.geupOriginFilename = geupOriginFilename;
	}
	public String getGeupSaveFilepath() {
		return geupSaveFilepath;
	}
	public void setGeupSaveFilepath(String geupSaveFilepath) {
		this.geupSaveFilepath = geupSaveFilepath;
	}
	public String getGeupSaveFilename() {
		return geupSaveFilename;
	}
	public void setGeupSaveFilename(String geupSaveFilename) {
		this.geupSaveFilename = geupSaveFilename;
	}
	public String getGeSeq() {
		return geSeq;
	}
	public void setGeSeq(String geSeq) {
		this.geSeq = geSeq;
	}
	@Override
	public String toString() {
		return "GEUpfileVO [geupSeq=" + geupSeq + "\r\n geupOriginFilename="
				+ geupOriginFilename + "\r\n geupSaveFilepath=" + geupSaveFilepath
				+ "\r\n geupSaveFilename=" + geupSaveFilename + "\r\n geSeq=" + geSeq
				+ "]";
	}
	
	
	
}
