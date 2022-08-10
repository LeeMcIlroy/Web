package hsDesign.valueObject;

/**
 * @author kjhoon
 * 교강사 2017.06.22
 */
public class TeacherVO {
	private String tcSeq			= ""; // 교강사 SEQ
	private String tcContent		= ""; // 교강사 연혁
	private String tcRegDate		= ""; // 등록일
	private String turn				= ""; // 순서
	private String tcMCode			= ""; // 전공구분
	private String tcSubject		= ""; // 전공과목
	private String tcName			= ""; // 이름
	
	/* 
	 * 첨부파일*/
	private String upSeq="";										//SEQ
	private String upOriginFileName="";								//원본파일명
	private String upSaveFileName="";								//저장파일명
	private String upSaveFilePath="";								//저장경로
	
	private String fileDeleteChk = "";		// 삭제파일 선택
	
	public String getTcSeq() {
		return tcSeq;
	}
	public void setTcSeq(String tcSeq) {
		this.tcSeq = tcSeq;
	}
	public String getTcContent() {
		return tcContent;
	}
	public void setTcContent(String tcContent) {
		this.tcContent = tcContent;
	}
	public String getTcRegDate() {
		return tcRegDate;
	}
	public void setTcRegDate(String tcRegDate) {
		this.tcRegDate = tcRegDate;
	}
	public String getTurn() {
		return turn;
	}
	public void setTurn(String turn) {
		this.turn = turn;
	}
	public String getTcMCode() {
		return tcMCode;
	}
	public void setTcMCode(String tcMCode) {
		this.tcMCode = tcMCode;
	}
	public String getTcSubject() {
		return tcSubject;
	}
	public void setTcSubject(String tcSubject) {
		this.tcSubject = tcSubject;
	}
	public String getTcName() {
		return tcName;
	}
	public void setTcName(String tcName) {
		this.tcName = tcName;
	}
	
	
	public String getUpSeq() {
		return upSeq;
	}
	public void setUpSeq(String upSeq) {
		this.upSeq = upSeq;
	}
	public String getUpOriginFileName() {
		return upOriginFileName;
	}
	public void setUpOriginFileName(String upOriginFileName) {
		this.upOriginFileName = upOriginFileName;
	}
	public String getUpSaveFileName() {
		return upSaveFileName;
	}
	public void setUpSaveFileName(String upSaveFileName) {
		this.upSaveFileName = upSaveFileName;
	}
	public String getUpSaveFilePath() {
		return upSaveFilePath;
	}
	public void setUpSaveFilePath(String upSaveFilePath) {
		this.upSaveFilePath = upSaveFilePath;
	}
	public String getFileDeleteChk() {
		return fileDeleteChk;
	}
	public void setFileDeleteChk(String fileDeleteChk) {
		this.fileDeleteChk = fileDeleteChk;
	}
	@Override
	public String toString() {
		return "TeacherVO [tcSeq=" + tcSeq + "\r\n tcContent=" + tcContent
				+ "\r\n tcRegDate=" + tcRegDate + "\r\n turn=" + turn + "\r\n tcMCode="
				+ tcMCode + "\r\n tcSubject=" + tcSubject + "\r\n tcName=" + tcName
				+ "\r\n upSeq=" + upSeq + "\r\n upOriginFileName=" + upOriginFileName
				+ "\r\n upSaveFileName=" + upSaveFileName + "\r\n upSaveFilePath="
				+ upSaveFilePath + "\r\n fileDeleteChk=" + fileDeleteChk + "]";
	}
	
	
	
}
