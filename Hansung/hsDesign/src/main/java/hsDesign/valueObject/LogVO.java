package hsDesign.valueObject;

/**
 * 관리자 로그
 * 	2017-07-06 최초생성
 *
 */
public class LogVO {
	private String logSeq = "";		// 로그Seq
	private String logId = "";		// 접속Id
	private String logIp = "";		// 접속Ip
	private String logJob = "";		// 작업내역
	private String logDttm = "";	// 작업일
	public LogVO() { }
	public LogVO(String logId, String logIp, String logJob) {
		super();
		this.logId = logId;
		this.logIp = logIp;
		this.logJob = logJob;
	}
	public String getLogSeq() {
		return logSeq;
	}
	public void setLogSeq(String logSeq) {
		this.logSeq = logSeq;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}
	public String getLogIp() {
		return logIp;
	}
	public void setLogIp(String logIp) {
		this.logIp = logIp;
	}
	public String getLogJob() {
		return logJob;
	}
	public void setLogJob(String logJob) {
		this.logJob = logJob;
	}
	public String getLogDttm() {
		return logDttm;
	}
	public void setLogDttm(String logDttm) {
		this.logDttm = logDttm;
	}
	@Override
	public String toString() {
		return "LogVO [\r\nlogSeq=" + logSeq + "\r\n logId=" + logId + "\r\n logIp=" + logIp + "\r\n logJob=" + logJob + "\r\n logDttm="
				+ logDttm + "\r\n]";
	}
}
