package lcms.valueObject;

public class SemesterVO {
	private String sem_code			= "";      //'NO'
	private String sem_year			= "";      //'년도'
	private String semester			= "";      //'학기'
	private String lec_attend_s		= "";      //'재등록 신청기간 시작'
	private String lec_attend_e		= "";      //'재등록 신청기간 끝'
	private String valuation_s		= "";      //'수업 평가 기간 시작'
	private String valuation_e		= "";      //'수업 평가 기간 끝'
	private String regist_s			= "";      //'등록기간 시작'
	private String regist_e			= "";      //'등록기간 끝
	private String enter_regi_s		= "";      //'개설기간 시작'
	private String enter_regi_e		= "";      //'개설기간 끝'
	private String open_sem			= "";      //'개설여부'
	private String open_regi		= "";      //'신청여부'
	private String sem_hakgi		= "";      //'년도+학기 코드'

	
	private String  dormS			= "";      // 방학 (미포함)
	private String 	dormE			= "";      // 
	private String 	dormIncS		= "";      // 방학 (포함)
	private String 	dormIncE		= "";      // 
	
	private String gradeS			= "";      // 성적입력기간 
	private String gradeE			= "";      // 성적입력기간 
	
	private String satisPrfYn		= "";	   // 수업만족도결과공개(교사)
	
	public String getDormS() {
		return dormS;
	}
	public void setDormS(String dormS) {
		this.dormS = dormS;
	}
	public String getDormE() {
		return dormE;
	}
	public void setDormE(String dormE) {
		this.dormE = dormE;
	}
	public String getDormIncS() {
		return dormIncS;
	}
	public void setDormIncS(String dormIncS) {
		this.dormIncS = dormIncS;
	}
	public String getDormIncE() {
		return dormIncE;
	}
	public void setDormIncE(String dormIncE) {
		this.dormIncE = dormIncE;
	}
	public String getSem_hakgi() {
		return sem_hakgi;
	}
	public void setSem_hakgi(String sem_hakgi) {
		this.sem_hakgi = sem_hakgi;
	}
	public String getSem_code() {
		return sem_code;
	}
	public void setSem_code(String sem_code) {
		this.sem_code = sem_code;
	}
	public String getSem_year() {
		return sem_year;
	}
	public void setSem_year(String sem_year) {
		this.sem_year = sem_year;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public String getLec_attend_s() {
		return lec_attend_s;
	}
	public void setLec_attend_s(String lec_attend_s) {
		this.lec_attend_s = lec_attend_s;
	}
	public String getLec_attend_e() {
		return lec_attend_e;
	}
	public void setLec_attend_e(String lec_attend_e) {
		this.lec_attend_e = lec_attend_e;
	}
	public String getValuation_s() {
		return valuation_s;
	}
	public void setValuation_s(String valuation_s) {
		this.valuation_s = valuation_s;
	}
	public String getValuation_e() {
		return valuation_e;
	}
	public void setValuation_e(String valuation_e) {
		this.valuation_e = valuation_e;
	}
	public String getRegist_s() {
		return regist_s;
	}
	public void setRegist_s(String regist_s) {
		this.regist_s = regist_s;
	}
	public String getRegist_e() {
		return regist_e;
	}
	public void setRegist_e(String regist_e) {
		this.regist_e = regist_e;
	}
	public String getEnter_regi_s() {
		return enter_regi_s;
	}
	public void setEnter_regi_s(String enter_regi_s) {
		this.enter_regi_s = enter_regi_s;
	}
	public String getEnter_regi_e() {
		return enter_regi_e;
	}
	public void setEnter_regi_e(String enter_regi_e) {
		this.enter_regi_e = enter_regi_e;
	}
	public String getOpen_sem() {
		return open_sem;
	}
	public void setOpen_sem(String open_sem) {
		this.open_sem = open_sem;
	}
	public String getOpen_regi() {
		return open_regi;
	}
	public void setOpen_regi(String open_regi) {
		this.open_regi = open_regi;
	}
	
	public String getGradeS() {
		return gradeS;
	}
	public void setGradeS(String gradeS) {
		this.gradeS = gradeS;
	}
	public String getGradeE() {
		return gradeE;
	}
	public void setGradeE(String gradeE) {
		this.gradeE = gradeE;
	}
	
	public String getSatisPrfYn() {
		return satisPrfYn;
	}
	public void setSatisPrfYn(String satisPrfYn) {
		this.satisPrfYn = satisPrfYn;
	}
	
	@Override
	public String toString() {
		return "SemesterVO [sem_code=" + sem_code + ", sem_year=" + sem_year + ", semester=" + semester
				+ ", lec_attend_s=" + lec_attend_s + ", lec_attend_e=" + lec_attend_e + ", valuation_s=" + valuation_s
				+ ", valuation_e=" + valuation_e + ", regist_s=" + regist_s + ", regist_e=" + regist_e
				+ ", enter_regi_s=" + enter_regi_s + ", enter_regi_e=" + enter_regi_e + ", open_sem=" + open_sem
				+ ", open_regi=" + open_regi + ", sem_hakgi=" + sem_hakgi + ", dormS=" + dormS + ", dormE=" + dormE
				+ ", dormIncS=" + dormIncS + ", dormIncE=" + dormIncE + ", gradeS=" + gradeS + ", gradeE=" + gradeE
				+ ", satisPrfYn=" + satisPrfYn + "]";
	}
	
	
}
