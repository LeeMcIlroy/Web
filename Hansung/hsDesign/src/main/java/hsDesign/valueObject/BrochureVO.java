package hsDesign.valueObject;

/**
 * @author kjhoon
 * 브로셔 2017.06.22
 * 	- 2017-07-13 수정 및 추가 (u: brcAddr → brcAddr1, a: brcZipcode, brcAddr2)
 */
public class BrochureVO {
	private String brcSeq			= ""; // 브로셔 SEQ
	private String brcName			= ""; // 신청자 이름
	private String brcSchool		= ""; // 신청자 학교
	private String brcTel			= ""; // 신청자 연락처
	private String brcMajor			= ""; // 신청자 관심학과
	private String brcZipcode		= ""; // 신청자 우편번호
	private String brcAddr1			= ""; // 신청자 주소1
	private String brcAddr2			= ""; // 신청자 주소2
	
	/** view */
	private String brcTel1			= ""; // 신청자 연락처1
	private String brcTel2			= ""; // 신청자 연락처2
	private String brcTel3			= ""; // 신청자 연락처3
	
	public String getBrcTel1() { return brcTel1; }
	public void setBrcTel1(String brcTel1) { this.brcTel1 = brcTel1; }
	public String getBrcTel2() { return brcTel2; }
	public void setBrcTel2(String brcTel2) { this.brcTel2 = brcTel2; }
	public String getBrcTel3() { return brcTel3; }
	public void setBrcTel3(String brcTel3) { this.brcTel3 = brcTel3; }
	
	public String getBrcSeq() {
		return brcSeq;
	}
	public void setBrcSeq(String brcSeq) {
		this.brcSeq = brcSeq;
	}
	public String getBrcName() {
		return brcName;
	}
	public void setBrcName(String brcName) {
		this.brcName = brcName;
	}
	public String getBrcSchool() {
		return brcSchool;
	}
	public void setBrcSchool(String brcSchool) {
		this.brcSchool = brcSchool;
	}
	public String getBrcTel() {
		return brcTel;
	}
	public void setBrcTel(String brcTel) {
		String[] str = brcTel.split("-");
		setBrcTel1(str[0]);
		setBrcTel2(str[1]);
		setBrcTel3(str[2]);
		this.brcTel = brcTel;
	}
	public String getBrcMajor() {
		return brcMajor;
	}
	public void setBrcMajor(String brcMajor) {
		this.brcMajor = brcMajor;
	}
	public String getBrcZipcode() {
		return brcZipcode;
	}
	public void setBrcZipcode(String brcZipcode) {
		this.brcZipcode = brcZipcode;
	}
	public String getBrcAddr1() {
		return brcAddr1;
	}
	public void setBrcAddr1(String brcAddr1) {
		this.brcAddr1 = brcAddr1;
	}
	public String getBrcAddr2() {
		return brcAddr2;
	}
	public void setBrcAddr2(String brcAddr2) {
		this.brcAddr2 = brcAddr2;
	}
	@Override
	public String toString() {
		return "BrochureVO [\nbrcSeq=" + brcSeq + "\nbrcName=" + brcName + "\nbrcSchool=" + brcSchool + "\nbrcTel="
				+ brcTel + "\nbrcMajor=" + brcMajor + "\nbrcZipcode=" + brcZipcode + "\nbrcAddr1=" + brcAddr1
				+ "\nbrcAddr2=" + brcAddr2 + "\nbrcTel1=" + brcTel1 + "\nbrcTel2=" + brcTel2 + "\nbrcTel3=" + brcTel3
				+ "\n]";
	}
}
