package lcms.valueObject;

import component.file.FileInfoVO;

/**
 * @author Leegh
 * 
 * 관리자VO 2019.06.20
 *
 */
public class TaskVO { 
	
	private String taskSeq 		= ""; 						// 과제 SEQ
	private String lectTbseq	= "";						// 강의 SEQ
	private String taskNm   	= "";						// 과제명
	private String taskContent	= "";						// 평가기준
	private String taskSdate	= "";						// 제출시작일
	private String taskSdateT	= "";						// 제출시작일_시
	private String taskSdateM	= "";						// 제출시작일_분
	private String taskEdate	= "";						// 제출종료일
	private String taskEdateT	= "";						//제출종료일_시
	private String taskEdateM	= "";						//제출종료일_분
	private String taskYn		= "";						//게시여부
	private String taskHit		= "";						//조회수		
	private String regDate		= "";						// 등록일		
	private String regId		= "";						// 등록자
	private String updDate		= "";						// 수정일
	private String updId		= "";						// 수정자
	
	private String taskStatus	= "";						// 진행상태
	private String taskResultCnt		= "";				// 등록인원
	private String taskAllCnt		= "";					// 수강인원
	
	public TaskVO(){}
	
	public void setTaskSeq(String taskSeq) {
		this.taskSeq = taskSeq;
	}
	
	public String getTaskSeq() {
		return taskSeq;
	}
	
	public void setLectTbseq(String lectTbseq) {
		this.lectTbseq = lectTbseq;
	}
	
	public String getLectTbseq() {
		return lectTbseq;
	}
	
	public void setTaskNm(String taskNm) {
		this.taskNm = taskNm;
	}
	
	public String getTaskNm() {
		return taskNm;
	}
	
	public void setTaskContent(String taskContent) {
		this.taskContent = taskContent;
	}
	
	public String getTaskContent() {
		return taskContent;
	}
	
	public void setTaskSdate(String taskSdate) {
		this.taskSdate = taskSdate;
	}
	
	public String getTaskSdate() {
		return taskSdate;
	}
	
	public void setTaskSdateT(String taskSdateT) {
		this.taskSdateT = taskSdateT;
	}
	
	public String getTaskSdateT() {
		return taskSdateT;
	}
	
	public void setTaskSdateM(String taskSdateM) {
		this.taskSdateM = taskSdateM;
	}
	
	public String getTaskSdateM() {
		return taskSdateM;
	}
	
	public void setTaskEdate(String taskEdate) {
		this.taskEdate = taskEdate;
	}
	
	public String getTaskEdate() {
		return taskEdate;
	}
	
	public void setTaskEdateT(String taskEdateT) {
		this.taskEdateT = taskEdateT;
	}
	
	public String getTaskEdateT() {
		return taskEdateT;
	}
	
	public void setTaskEdateM(String taskEdateM) {
		this.taskEdateM = taskEdateM;
	}
	
	public String getTaskEdateM() {
		return taskEdateM;
	}
	
	public void setTaskYn(String taskYn) {
		this.taskYn = taskYn;
	}
	
	public String getTaskYn() {
		return taskYn;
	}
	
	public void setTaskHit(String taskHit) {
		this.taskHit = taskHit;
	}
	
	public String getTaskHit() {
		return taskHit;
	}
	
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getRegDate() {
		return regDate;
	}
	
	public void setRegId(String regId) {
		this.regId = regId;
	}
	
	public String getRegId() {
		return regId;
	}
	
	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}
	
	public String getUpdDate() {
		return updDate;
	}
	
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	
	public String getUpdId() {
		return updId;
	}
	

	public String getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}

	public String getTaskResultCnt() {
		return taskResultCnt;
	}

	public void setTaskResultCnt(String taskResultCnt) {
		this.taskResultCnt = taskResultCnt;
	}

	public String getTaskAllCnt() {
		return taskAllCnt;
	}

	public void setTaskAllCnt(String taskAllCnt) {
		this.taskAllCnt = taskAllCnt;
	}

}
