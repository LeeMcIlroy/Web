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
	
	private String fileKey = "";
	
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
	public String getFileKey() {
		return fileKey;
	}
	public void setFileKey(String fileKey) {
		this.fileKey = fileKey;
	}
	@Override
	public String toString() {
		return "FileInfoVO [fileId=" + fileId + ", fileName=" + fileName + ", filePath=" + filePath + ", fileTagName="
				+ fileTagName + ", fileThumbPath=" + fileThumbPath + ", fileThumbName=" + fileThumbName
				+ ", fileBoardSeq=" + fileBoardSeq + ", fileBoardType=" + fileBoardType + ", fileKey=" + fileKey + "]";
	}
	
}