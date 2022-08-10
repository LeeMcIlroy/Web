package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 앰버서더VO 2019.07.08
 *
 */
public class AmbVO { 
	
	private String ambSeq 			= ""; 		// 앰버서더_고유번호
	private String name 			= ""; 		// 이름
	private String gender 			= ""; 		// 성별
	private String nationality 		= ""; 		// 국적
	private String lecClass 		= ""; 		// 분반
	private String birth 			= ""; 		// 생년월일
	private String tel 				= ""; 		// 전화번호
	private String addr 			= "";		// 주소
	private String email 			= "";		// 이메일
	private String motiOfPlan 		= "";		// 동기 및 계획
	private String regDttm	 		= "";		// 신청일
	
	public String getAmbSeq() {
		return ambSeq;
	}
	public void setAmbSeq(String ambSeq) {
		this.ambSeq = ambSeq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getLecClass() {
		return lecClass;
	}
	public void setLecClass(String lecClass) {
		this.lecClass = lecClass;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMotiOfPlan() {
		return motiOfPlan;
	}
	public void setMotiOfPlan(String motiOfPlan) {
		this.motiOfPlan = motiOfPlan;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	
	@Override
	public String toString() {
		return "AmbVO [\nambSeq=" + ambSeq + "\nname=" + name + "\ngender=" + gender + "\nnationality=" + nationality
				+ "\nlecClass=" + lecClass + "\nbirth=" + birth + "\ntel=" + tel + "\naddr=" + addr + "\nemail=" + email
				+ "\nmotiOfPlan=" + motiOfPlan + "\nregDttm=" + regDttm + "\n]";
	}
}
