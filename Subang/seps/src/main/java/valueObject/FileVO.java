package valueObject;

import component.file.FileInfoVO;

public class FileVO {

	private String attachFileId = "";
	private String saveFileNm = "";
	private String orgFileNm = "";
	private String boardId = "";
	private String boardType = "";
	private String regDttm = "";
	private String regNm = "";
	
	public FileVO(FileInfoVO paramVO) {
		this.saveFileNm = paramVO.getFilePath();
		this.orgFileNm = paramVO.getFileName();
	}
	
	public String getBoardId() {
		return boardId;
	}
	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}
	public String getAttachFileId() {
		return attachFileId;
	}
	public void setAttachFileId(String attachFileId) {
		this.attachFileId = attachFileId;
	}
	public String getSaveFileNm() {
		return saveFileNm;
	}
	public void setSaveFileNm(String saveFileNm) {
		this.saveFileNm = saveFileNm;
	}
	public String getOrgFileNm() {
		return orgFileNm;
	}
	public void setOrgFileNm(String orgFileNm) {
		this.orgFileNm = orgFileNm;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getRegNm() {
		return regNm;
	}
	public void setRegNm(String regNm) {
		this.regNm = regNm;
	}
	@Override
	public String toString() {
		return "FileVO [attachFileId=" + attachFileId + ", saveFileNm="
				+ saveFileNm + ", orgFileNm=" + orgFileNm + ", boardId="
				+ boardId + ", boardType=" + boardType + ", regDttm=" + regDttm
				+ ", regNm=" + regNm + "]";
	}
}
