package lcms.valueObject;


 /**
 * @author Leegh
 * 
 * 입학VO 2019.07.08
 *
 */
public class EnterVO { 
	
	private String enterSeq = "";
	private String enterYear = "";
	private String enterSeme = "";
	private String enterNum = "";
	private String enterCode = "";
	private String enterDate = "";
	private String enterName = "";
	private String enterNation = "";
	private String enterBtYear = "";
	private String enterBtMonth = "";
	private String enterBtDay = "";
	private String enterBirth = "";
	private String enterStdType = "";
	private String enterType = "";
	private String enterTel = "";
	private String enterEmail = "";
	private String enterStatus = "";
	private String enterEtc = "";
	private String enterRegrade = "";
	private String enterEName = "";
	private String enterGender = "";
	
	
	
	/**
	 * 입학연기 추가 
	 * 이규호 - 2020.06.26
	 */
	private String delayYn = "";		// 입학연기여부
	private String delayDate = "";		// 입학연기일
	private String delayEtc = "";		// 입학연기사유
	private String delayEntrYear = "";	// 입학연기 입학연도
	private String delayEntrSeme = "";	// 입학연기 입학학기
	private String delayEntrDate = "";	// 입학연기 입학일
	private String delayEntrGrade = "";	// 입학연기 입학등급
	private String delayTuinYn = "";	// 등록금 선납 적용여부
	
	private String bankAccount = "";
	/**
	 * 사용여부 추가 
	 * 이형종 - 2021.08.27
	 */
	private String useYn="";
	/**
	 * 비고 추가 
	 * 이형종 - 2022.01.25
	 */
	private String enterRemk ="";		// 비고
	
	public String getEnterSeq() {
		return enterSeq;
	}
	public void setEnterSeq(String enterSeq) {
		this.enterSeq = enterSeq;
	}
	public String getEnterYear() {
		return enterYear;
	}
	public void setEnterYear(String enterYear) {
		this.enterYear = enterYear;
	}
	public String getEnterSeme() {
		return enterSeme;
	}
	public void setEnterSeme(String enterSeme) {
		this.enterSeme = enterSeme;
	}
	public String getEnterNum() {
		return enterNum;
	}
	public void setEnterNum(String enterNum) {
		this.enterNum = enterNum;
	}
	public String getEnterCode() {
		return enterCode;
	}
	public void setEnterCode(String enterCode) {
		this.enterCode = enterCode;
	}
	public String getEnterDate() {
		return enterDate;
	}
	public void setEnterDate(String enterDate) {
		this.enterDate = enterDate;
	}
	public String getEnterName() {
		return enterName;
	}
	public void setEnterName(String enterName) {
		this.enterName = enterName;
	}
	public String getEnterNation() {
		return enterNation;
	}
	public void setEnterNation(String enterNation) {
		this.enterNation = enterNation;
	}
	public String getEnterBtYear() {
		return enterBtYear;
	}
	public void setEnterBtYear(String enterBtYear) {
		this.enterBtYear = enterBtYear;
	}
	public String getEnterBtMonth() {
		return enterBtMonth;
	}
	public void setEnterBtMonth(String enterBtMonth) {
		this.enterBtMonth = enterBtMonth;
	}
	public String getEnterBtDay() {
		return enterBtDay;
	}
	public void setEnterBtDay(String enterBtDay) {
		this.enterBtDay = enterBtDay;
	}
	public String getEnterBirth() {
		return enterBirth;
	}
	public void setEnterBirth(String enterBirth) {
		this.enterBirth = enterBirth;
	}
	public String getEnterStdType() {
		return enterStdType;
	}
	public void setEnterStdType(String enterStdType) {
		this.enterStdType = enterStdType;
	}
	public String getEnterType() {
		return enterType;
	}
	public void setEnterType(String enterType) {
		this.enterType = enterType;
	}
	public String getEnterTel() {
		return enterTel;
	}
	public void setEnterTel(String enterTel) {
		this.enterTel = enterTel;
	}
	public String getEnterEmail() {
		return enterEmail;
	}
	public void setEnterEmail(String enterEmail) {
		this.enterEmail = enterEmail;
	}
	public String getEnterStatus() {
		return enterStatus;
	}
	public void setEnterStatus(String enterStatus) {
		this.enterStatus = enterStatus;
	}
	public String getEnterEtc() {
		return enterEtc;
	}
	public void setEnterEtc(String enterEtc) {
		this.enterEtc = enterEtc;
	}
	public String getEnterRegrade() {
		return enterRegrade;
	}
	public void setEnterRegrade(String enterRegrade) {
		this.enterRegrade = enterRegrade;
	}
	public String getEnterEName() {
		return enterEName;
	}
	public void setEnterEName(String enterEName) {
		this.enterEName = enterEName;
	}
	public String getEnterGender() {
		return enterGender;
	}
	public void setEnterGender(String enterGender) {
		this.enterGender = enterGender;
	}
	
	public String getDelayYn() {
		return delayYn;
	}
	public void setDelayYn(String delayYn) {
		this.delayYn = delayYn;
	}
	public String getDelayDate() {
		return delayDate;
	}
	public void setDelayDate(String delayDate) {
		this.delayDate = delayDate;
	}
	public String getDelayEtc() {
		return delayEtc;
	}
	public void setDelayEtc(String delayEtc) {
		this.delayEtc = delayEtc;
	}
	public String getDelayEntrYear() {
		return delayEntrYear;
	}
	public void setDelayEntrYear(String delayEntrYear) {
		this.delayEntrYear = delayEntrYear;
	}
	public String getDelayEntrSeme() {
		return delayEntrSeme;
	}
	public void setDelayEntrSeme(String delayEntrSeme) {
		this.delayEntrSeme = delayEntrSeme;
	}
	public String getDelayEntrDate() {
		return delayEntrDate;
	}
	public void setDelayEntrDate(String delayEntrDate) {
		this.delayEntrDate = delayEntrDate;
	}
	public String getDelayEntrGrade() {
		return delayEntrGrade;
	}
	public void setDelayEntrGrade(String delayEntrGrade) {
		this.delayEntrGrade = delayEntrGrade;
	}
	public String getDelayTuinYn() {
		return delayTuinYn;
	}
	public void setDelayTuinYn(String delayTuinYn) {
		this.delayTuinYn = delayTuinYn;
	}
	
	public String getBankAccount() {
		return bankAccount;
	}
	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}
	
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	
	public String getEnterRemk() {
		return enterRemk;
	}
	public void setEnterRemk(String enterRemk) {
		this.enterRemk = enterRemk;
	}
	@Override
	public String toString() {
		return "EnterVO [enterSeq=" + enterSeq + ", enterYear=" + enterYear + ", enterSeme=" + enterSeme + ", enterNum="
				+ enterNum + ", enterCode=" + enterCode + ", enterDate=" + enterDate + ", enterName=" + enterName
				+ ", enterNation=" + enterNation + ", enterBtYear=" + enterBtYear + ", enterBtMonth=" + enterBtMonth
				+ ", enterBtDay=" + enterBtDay + ", enterBirth=" + enterBirth + ", enterStdType=" + enterStdType
				+ ", enterType=" + enterType + ", enterTel=" + enterTel + ", enterEmail=" + enterEmail
				+ ", enterStatus=" + enterStatus + ", enterEtc=" + enterEtc + ", enterRegrade=" + enterRegrade
				+ ", enterEName=" + enterEName + ", enterGender=" + enterGender + ", delayYn=" + delayYn
				+ ", delayDate=" + delayDate + ", delayEtc=" + delayEtc + ", delayEntrYear=" + delayEntrYear
				+ ", delayEntrSeme=" + delayEntrSeme + ", delayEntrDate=" + delayEntrDate + ", delayEntrGrade="
				+ delayEntrGrade + ", delayTuinYn=" + delayTuinYn + ", bankAccount=" + bankAccount + ", useYn=" + useYn+", enterRemk=" + enterRemk
				+ "]";
	}
	
	
}
