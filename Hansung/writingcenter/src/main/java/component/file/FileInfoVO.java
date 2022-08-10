package component.file;

/**
 * @author songcw
 * @date 2016.10.17
 *	파일 VO
 */
public class FileInfoVO {
	
	private String fileId = "";
	private String fileName = "";
	private String filePath = "";
	private String fileTagName = "";
	private String fileThumbPath = "";
	private String fileThumbName = "";
	
	/* board 구분 */
	private String fileBoardSeq = "";
	private String fileBoardType = "";
	
	public FileInfoVO() { }
	public FileInfoVO(String fileName, String filePath) {
		super();
		this.fileName = fileName;
		this.filePath = filePath;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileTagName() {
		return fileTagName;
	}
	public void setFileTagName(String fileTagName) {
		this.fileTagName = fileTagName;
	}
	public String getFileThumbPath() {
		return fileThumbPath;
	}
	public void setFileThumbPath(String fileThumbPath) {
		this.fileThumbPath = fileThumbPath;
	}
	public String getFileThumbName() {
		return fileThumbName;
	}
	public void setFileThumbName(String fileThumbName) {
		this.fileThumbName = fileThumbName;
	}
	public String getFileBoardSeq() {
		return fileBoardSeq;
	}
	public void setFileBoardSeq(String fileBoardSeq) {
		this.fileBoardSeq = fileBoardSeq;
	}
	public String getFileBoardType() {
		return fileBoardType;
	}
	public void setFileBoardType(String fileBoardType) {
		this.fileBoardType = fileBoardType;
	}
	@Override
	public String toString() {
		return "FileInfoVO [\r\n fileId=" + fileId + "\r\n fileName=" + fileName + "\r\n filePath=" + filePath + "\r\n fileTagName="
				+ fileTagName + "\r\n fileThumbPath=" + fileThumbPath + "\r\n fileThumbName=" + fileThumbName
				+ "\r\n fileBoardSeq=" + fileBoardSeq + "\r\n fileBoardType=" + fileBoardType + "\r\n]";
	}
	
}