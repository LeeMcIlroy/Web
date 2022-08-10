package lcms.valueObject;

public class CountryVO {
	//tb_lcms_code
	//	나라이름
	private String name		= ""; 
	private String seq		= "";
	private String purpose	= "";
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	@Override
	public String toString() {
		return "CountryVO [name=" + name + ", seq=" + seq + ", purpose=" + purpose + "]";
	}
	
	
}