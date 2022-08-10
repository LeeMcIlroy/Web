package lcms.valueObject;

import component.file.FileInfoVO;

/**
 * @author Leegh
 * 
 * 관리자VO 2019.06.20
 *
 */
public class SyllaWeekVO { 
	private String syllaSeq			= "";						// 강의계획서 SEQ
	private String syllaweekSeq		= "";						// 강의계획서 주차별계획 SEQ
	private String syllaweekNm  	= "";						// 주차명
	private String syllaweekMon1	= "";						// 월 1,2교시
	private String syllaweekMon2	= "";						// 월 3,4교시
	private String syllaweekMonRmk	= "";						// 월 비고
	private String syllaweekTue1	= "";						// 화 1,2교시
	private String syllaweekTue2	= "";						// 화 3,4교시
	private String syllaweekTueRmk	= "";						// 화 비고
	private String syllaweekWed1	= "";						// 수 1,2교시
	private String syllaweekWed2	= "";						// 수 3,4교시
	private String syllaweekWedRmk	= "";						// 수 비고
	private String syllaweekThu1	= "";						// 목 1,2교시
	private String syllaweekThu2	= "";						// 목 3,4교시
	private String syllaweekThuRmk	= "";						// 목 비고
	private String syllaweekFri1	= "";						// 금 1,2교시
	private String syllaweekFri2	= "";						// 금 3,4교시
	private String syllaweekFriRmk	= "";						// 금 비고
	
	private String regDate		= "";						// 등록일
	private String regId		= "";						// 작성자
	private String updDate		= "";						// 수정일
	private String updId		= "";						// 수정자
	
	public SyllaWeekVO(){}
	
	public void setSyllaSeq(String syllaSeq) {
		this.syllaSeq = syllaSeq;
	}
	
	public String getSyllaSeq() {
		return syllaSeq;
	}
	
	
	
	public String getSyllaweekSeq() {
		return syllaweekSeq;
	}

	public void setSyllaweekSeq(String syllaweekSeq) {
		this.syllaweekSeq = syllaweekSeq;
	}

	public void setSyllaweekNm(String syllaweekNm) {
		this.syllaweekNm = syllaweekNm;
	}
	
	public String getSyllaweekNm() {
		return syllaweekNm;
	}
	
	public void setSyllaweekMon1(String syllaweekMon1) {
		this.syllaweekMon1 = syllaweekMon1;
	}
	
	public String getSyllaweekMon1() {
		return syllaweekMon1;
	}
	
	public void setSyllaweekMon2(String syllaweekMon2) {
		this.syllaweekMon2 = syllaweekMon2;
	}
	
	public String getSyllaweekMon2() {
		return syllaweekMon2;
	}
	
	public void setSyllaweekMonRmk(String syllaweekMonRmk) {
		this.syllaweekMonRmk = syllaweekMonRmk;
	}
	
	public String getSyllaweekMonRmk() {
		return syllaweekMonRmk;
	}
	
	public void setSyllaweekTue1(String syllaweekTue1) {
		this.syllaweekTue1 = syllaweekTue1;
	}
	
	public String getSyllaweekTue1() {
		return syllaweekTue1;
	}
	
	public void setSyllaweekTue2(String syllaweekTue2) {
		this.syllaweekTue2 = syllaweekTue2;
	}
	
	public String getSyllaweekTue2() {
		return syllaweekTue2;
	}
	
	public void setSyllaweekTueRmk(String syllaweekTueRmk) {
		this.syllaweekTueRmk = syllaweekTueRmk;
	}
	
	public String getSyllaweekTueRmk() {
		return syllaweekTueRmk;
	}
	
	public void setSyllaweekWed1(String syllaweekWed1) {
		this.syllaweekWed1 = syllaweekWed1;
	}
	
	public String getSyllaweekWed1() {
		return syllaweekWed1;
	}
	
	public void setSyllaweekWed2(String syllaweekWed2) {
		this.syllaweekWed2 = syllaweekWed2;
	}
	
	public String getSyllaweekWed2() {
		return syllaweekWed2;
	}
	
	public void setSyllaweekWedRmk(String syllaweekWedRmk) {
		this.syllaweekWedRmk = syllaweekWedRmk;
	}
	
	public String getSyllaweekWedRmk() {
		return syllaweekWedRmk;
	}
	
	public void setSyllaweekThu1(String syllaweekThu1) {
		this.syllaweekThu1 = syllaweekThu1;
	}
	
	public String getSyllaweekThu1() {
		return syllaweekThu1;
	}
	
	public void setSyllaweekThu2(String syllaweekThu2) {
		this.syllaweekThu2 = syllaweekThu2;
	}
	
	public String getSyllaweekThu2() {
		return syllaweekThu2;
	}
	
	public void setSyllaweekThuRmk(String syllaweekThuRmk) {
		this.syllaweekThuRmk = syllaweekThuRmk;
	}
	
	public String getSyllaweekThuRmk() {
		return syllaweekThuRmk;
	}
	
	public void setSyllaweekFri1(String syllaweekFri1) {
		this.syllaweekFri1 = syllaweekFri1;
	}
	
	public String getSyllaweekFri1() {
		return syllaweekFri1;
	}
	
	public void setSyllaweekFri2(String syllaweekFri2) {
		this.syllaweekFri2 = syllaweekFri2;
	}
	
	public String getSyllaweekFri2() {
		return syllaweekFri2;
	}
	
	public void setSyllaweekFriRmk(String syllaweekFriRmk) {
		this.syllaweekFriRmk = syllaweekFriRmk;
	}
	
	public String getSyllaweekFriRmk() {
		return syllaweekFriRmk;
	}
	
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getRegDate() {
		return regDate;
	}
	
	public void setRegId(String regId) {
		this.regId = regId;
	}
	
	public String getRegId() {
		return regId;
	}
	
	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}
	
	public String getUpdDate() {
		return updDate;
	}
	
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	
	public String getUpdId() {
		return updId;
	}
	
	

}
