package ctms.valueObject;

import component.file.FileInfoVO;

/**
 * @author 이규호
 * 
 * 첨부파일VO 2020.11.30
 *
 */
public class Ct7000mVO { 
	
	private String attachNo 	= ""; 						// 첨부파일_고유번호
	private String boardNo		= "";						// 게시판_고유번호
	private String boardType   	= "";						// 게시판_구분
	private String orgFileName	= "";						// 원본파일명
	private String regFileName	= "";						// 저장파일명
	private String fileKey		= "";
	private String regName		= "";						// 작성자
	private String regDate		= "";						// 등록일 추가

	
	public Ct7000mVO(){}
	public Ct7000mVO(FileInfoVO paramVO) {
		this.regFileName = paramVO.getFilePath();
		this.orgFileName = paramVO.getFileName();
		this.fileKey = paramVO.getFileKey();
	}
	
	public String getAttachNo() {
		return attachNo;
	}
	public void setAttachNo(String attachNo) {
		this.attachNo = attachNo;
	}
	public String getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}
	public String getRegFileName() {
		return regFileName;
	}
	public void setRegFileName(String regFileName) {
		this.regFileName = regFileName;
	}
	public String getFileKey() {
		return fileKey;
	}
	public void setFileKey(String fileKey) {
		this.fileKey = fileKey;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	
	
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "Ct7000mVO [attachNo=" + attachNo + ", boardNo=" + boardNo + ", boardType=" + boardType
				+ ", orgFileName=" + orgFileName + ", regFileName=" + regFileName + ", fileKey=" + fileKey
				+ ", regName=" + regName + ", regDate=" + regDate + "]";
	}
	
}
