package writer.valueObject;

import java.util.List;



/**
 * @author kjhoon
 * 설문 답변자 VO
 * 2017-03-20
 */
public class QestnarPsnVO {
	private String psnSeq = "";
	private String deptSeq = "";
	private String clsSeq = "";
	private String psnHakbun = "";
	private String psnName = "";
	private String regDate = "";
	private String qstnrSeq = "";
	
	private List<QestnarPsnAnsVO> ansList = null;
	
	public List<QestnarPsnAnsVO> getAnsList() {
		return ansList;
	}
	public void setAnsList(List<QestnarPsnAnsVO> ansList) {
		this.ansList = ansList;
	}
	public String getPsnSeq() {
		return psnSeq;
	}
	public void setPsnSeq(String psnSeq) {
		this.psnSeq = psnSeq;
	}
	public String getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getClsSeq() {
		return clsSeq;
	}
	public void setClsSeq(String clsSeq) {
		this.clsSeq = clsSeq;
	}
	public String getPsnHakbun() {
		return psnHakbun;
	}
	public void setPsnHakbun(String psnHakbun) {
		this.psnHakbun = psnHakbun;
	}
	public String getPsnName() {
		return psnName;
	}
	public void setPsnName(String psnName) {
		this.psnName = psnName;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getQstnrSeq() {
		return qstnrSeq;
	}
	public void setQstnrSeq(String qstnrSeq) {
		this.qstnrSeq = qstnrSeq;
	}
	@Override
	public String toString() {
		return "QestnarPsnVO [psnSeq=" + psnSeq + "\r\n deptSeq=" + deptSeq
				+ "\r\n clsSeq=" + clsSeq + "\r\n psnHakbun=" + psnHakbun
				+ "\r\n psnName=" + psnName + "\r\n regDate=" + regDate
				+ "\r\n qstnrSeq=" + qstnrSeq + "]";
	}
	
	

}
