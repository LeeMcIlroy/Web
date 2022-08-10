package lcms.valueObject;

import java.util.List;

/**
 * @author Leegh
 * 
 * 출결VO 2020.03.16
 *
 */
public class AttendVO extends MemberVO { 
	
	private String attSeq		= ""; // 출결Seq
	private String lectSeq		= ""; // 강의Seq
	private String lectTbseq	= ""; // 수업시간Seq
	private String attend		= ""; // 출결(1:출석, 2:결석, 3:지각)
	private String attDate		= ""; // 출결일
	private String lectClass	= ""; // 출결 수업시간
	
	private String attendCnt	= ""; // 출석일수
	private String absentCnt	= ""; // 결석일수
	
	private String etcSeq		= ""; // 출결Seq
	private String attEtc		= ""; // 출결비고
	
	private List<String> atteList;

	private List<AttendVO> attendList;
	
	public List<String> getAtteList() {
		return atteList;
	}
	public void setAtteList(List<String> atteList) {
		this.atteList = atteList;
	}
	
	public List<AttendVO> getAttendList() {
		return attendList;
	}
	public void setAttendList(List<AttendVO> attendList) {
		this.attendList = attendList;
	}
	
	public String getAttSeq() {
		return attSeq;
	}
	public void setAttSeq(String attSeq) {
		this.attSeq = attSeq;
	}
	public String getLectSeq() {
		return lectSeq;
	}
	public void setLectSeq(String lectSeq) {
		this.lectSeq = lectSeq;
	}
	public String getLectTbseq() {
		return lectTbseq;
	}
	public void setLectTbseq(String lectTbseq) {
		this.lectTbseq = lectTbseq;
	}
	public String getAttend() {
		return attend;
	}
	public void setAttend(String attend) {
		this.attend = attend;
	}
	public String getAttDate() {
		return attDate;
	}
	public void setAttDate(String attDate) {
		this.attDate = attDate;
	}
	public String getLectClass() {
		return lectClass;
	}
	public void setLectClass(String lectClass) {
		this.lectClass = lectClass;
	}
	
	public String getEtcSeq() {
		return etcSeq;
	}
	public void setEtcSeq(String etcSeq) {
		this.etcSeq = etcSeq;
	}
	public String getAttEtc() {
		return attEtc;
	}
	public void setAttEtc(String attEtc) {
		this.attEtc = attEtc;
	}
	
	public String getAttendCnt() {
		return attendCnt;
	}
	public void setAttendCnt(String attendCnt) {
		this.attendCnt = attendCnt;
	}
	public String getAbsentCnt() {
		return absentCnt;
	}
	public void setAbsentCnt(String absentCnt) {
		this.absentCnt = absentCnt;
	}
	
	@Override
	public String toString() {
		return "AttendVO [attSeq=" + attSeq + ", lectSeq=" + lectSeq + ", lectTbseq=" + lectTbseq + ", attend=" + attend
				+ ", attDate=" + attDate + ", lectClass=" + lectClass + ", attendCnt=" + attendCnt + ", absentCnt="
				+ absentCnt + ", etcSeq=" + etcSeq + ", attEtc=" + attEtc + ", atteList=" + atteList + ", attendList="
				+ attendList + "]";
	}
}
