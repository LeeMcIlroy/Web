package hsDesign.valueObject;

/**
 * @author kjhoon
 * 브로셔 2017.08.04
 * 
 */
public class AdmissionVO {
	private String adSeq			= ""; // 상담신청 SEQ
	private String adName			= ""; // 신청자 이름
	private String adSchool		= ""; // 신청자 학교
	private String adTel			= ""; // 신청자 연락처
	private String adMajor			= ""; // 신청자 관심학과
	private String adZipcode		= ""; // 신청자 우편번호
	private String adAddr1			= ""; // 신청자 주소1
	private String adAddr2			= ""; // 신청자 주소2
	
	/** view */
	private String adTel1			= ""; // 신청자 연락처1
	private String adTel2			= ""; // 신청자 연락처2
	private String adTel3			= ""; // 신청자 연락처3
	
	public String getAdTel1() { return adTel1; }
	public void setAdTel1(String adTel1) { this.adTel1 = adTel1; }
	public String getAdTel2() { return adTel2; }
	public void setAdTel2(String adTel2) { this.adTel2 = adTel2; }
	public String getAdTel3() { return adTel3; }
	public void setAdTel3(String adTel3) { this.adTel3 = adTel3; }
	
	
	public String getAdSeq() {
		return adSeq;
	}
	public void setAdSeq(String adSeq) {
		this.adSeq = adSeq;
	}
	public String getAdName() {
		return adName;
	}
	public void setAdName(String adName) {
		this.adName = adName;
	}
	public String getAdSchool() {
		return adSchool;
	}
	public void setAdSchool(String adSchool) {
		this.adSchool = adSchool;
	}
	public String getAdTel() {
		return adTel;
	}
	public void setAdTel(String adTel) {
		String[] str = adTel.split("-");
		setAdTel1(str[0]);
		setAdTel1(str[1]);
		setAdTel1(str[2]);
		this.adTel = adTel;
	}
	public String getAdMajor() {
		return adMajor;
	}
	public void setAdMajor(String adMajor) {
		this.adMajor = adMajor;
	}
	public String getAdZipcode() {
		return adZipcode;
	}
	public void setAdZipcode(String adZipcode) {
		this.adZipcode = adZipcode;
	}
	public String getAdAddr1() {
		return adAddr1;
	}
	public void setAdAddr1(String adAddr1) {
		this.adAddr1 = adAddr1;
	}
	public String getAdAddr2() {
		return adAddr2;
	}
	public void setAdAddr2(String adAddr2) {
		this.adAddr2 = adAddr2;
	}
	@Override
	public String toString() {
		return "BrochureVO [\nadSeq=" + adSeq + "\nadName=" + adName + "\nadSchool=" + adSchool + "\nadTel="
				+ adTel + "\nadMajor=" + adMajor + "\nadZipcode=" + adZipcode + "\nadAddr1=" + adAddr1
				+ "\nadAddr2=" + adAddr2 + "\nadTel1=" + adTel1 + "\nadTel2=" + adTel2 + "\nadTel3=" + adTel3
				+ "\n]";
	}
}
