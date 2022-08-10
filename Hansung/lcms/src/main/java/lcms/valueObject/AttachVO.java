package lcms.valueObject;

import component.file.FileInfoVO;

/**
 * @author Leegh
 * 
 * 첨부파일VO 2020.02.27
 *
 */
public class AttachVO { 
	
	private String attachSeq 	= ""; 						// 첨부파일_고유번호
	private String boardSeq		= "";						// 게시판_고유번호
	private String boardType   	= "";						// 게시판_구분
	private String orgFileName	= "";						// 원본파일명
	private String regFileName	= "";						// 저장파일명
	private String regName		= "";						// 작성자
	
	public AttachVO(){}
	public AttachVO(FileInfoVO paramVO) {
		this.regFileName = paramVO.getFilePath();
		this.orgFileName = paramVO.getFileName();
	}
	
	public String getAttachSeq() {
		return attachSeq;
	}
	public void setAttachSeq(String attachSeq) {
		this.attachSeq = attachSeq;
	}
	public String getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(String boardSeq) {
		this.boardSeq = boardSeq;
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
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	
	@Override
	public String toString() {
		return "AttachVO [\nattachSeq=" + attachSeq + "\nboardSeq=" + boardSeq + "\nboardType=" + boardType
				+ "\norgFileName=" + orgFileName + "\nregFileName=" + regFileName + "\nregName=" + regName + "\n]";
	}
}
