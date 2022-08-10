package lcms.valueObject;

/**
 * @author Leegh
 * 
 * 과제제출VO 2020.03.19
 *
 */
public class TaskSubVO extends TaskVO { 
	
	private String subSeq = "";
	private String memberCode = "";
	private String subDate = "";
	private String lookDate = "";
	private String taskStatus = "";
	
	public String getSubSeq() {
		return subSeq;
	}
	public void setSubSeq(String subSeq) {
		this.subSeq = subSeq;
	}
	public String getMemberCode() {
		return memberCode;
	}
	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}
	public String getSubDate() {
		return subDate;
	}
	public void setSubDate(String subDate) {
		this.subDate = subDate;
	}
	public String getLookDate() {
		return lookDate;
	}
	public void setLookDate(String lookDate) {
		this.lookDate = lookDate;
	}
	public String getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}
	
	@Override
	public String toString() {
		return "TaskSubVO [subSeq=" + subSeq + ", memberCode=" + memberCode + ", subDate=" + subDate + ", lookDate="
				+ lookDate + ", taskStatus=" + taskStatus + "]";
	}
}
