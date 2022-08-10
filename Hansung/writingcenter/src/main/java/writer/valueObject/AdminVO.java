package writer.valueObject;

import java.util.ArrayList;
import java.util.List;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * 교수\r\n 연구원\r\n 관리자
 * 
 * 	2017-01-25 최초 생성
 * 	2017-01-26 수정 (추가 : athrYn)
 * 	2017-02-02 수정 (추가 : memLevel\r\n 삭제 : memId\r\n memDept)
 * 	2017-02-24 수정 (추가 : athrList, 교수강사정보)
 */
public class AdminVO {
	
	/* 교수강사 정보 */
	private String profCode = "";
	private String profName = "";
	private String profSosok = "";
	private String profStatus = "";
	public String getProfCode() {
		return profCode;
	}
	public void setProfCode(String profCode) {
		this.profCode = profCode;
	}
	public String getProfName() {
		return profName;
	}
	public void setProfName(String profName) {
		this.profName = profName;
	}
	public String getProfSosok() {
		return profSosok;
	}
	public void setProfSosok(String profSosok) {
		this.profSosok = profSosok;
	}
	public String getProfStatus() {
		return profStatus;
	}
	public void setProfStatus(String profStatus) {
		this.profStatus = profStatus;
	}
	
	/* TB_HSWC_MEMBER */
	private String memSeq = "";									// seq
	private String memCode = "";								// 사번
	private String memName = "";								// 이름
	private String memEmail = "";								// 이메일
	private String memMphone = "";								// 휴대전화
	private String memLevel = "";								// 회원레벨
	private String memUpdtYn = "";								// 첨삭가능여부 (Y or N)
	private String memMemo = "";								// 관리자 메모
	private String regId = "";									// 등록자
	private String regDate = "";								// 등록일
	
	/* view */
	private String memMphone1 = "";								// 휴대전화1
	private String memMphone2 = "";								// 휴대전화2
	private String memMphone3 = "";								// 휴대전화3
	public String getMemMphone1() { return memMphone1; }
	public void setMemMphone1(String memMphone1) { this.memMphone1 = memMphone1; }
	public String getMemMphone2() { return memMphone2; }
	public void setMemMphone2(String memMphone2) { this.memMphone2 = memMphone2; }
	public String getMemMphone3() { return memMphone3; }
	public void setMemMphone3(String memMphone3) { this.memMphone3 = memMphone3; }
	
	private String memEmail1 = "";								// 이메일1
	private String memEmail2 = "";								// 이메일2
	public String getMemEmail1() { return memEmail1; }
	public void setMemEmail1(String memEmail1) { this.memEmail1 = memEmail1; }
	public String getMemEmail2() { return memEmail2; }
	public void setMemEmail2(String memEmail2) { this.memEmail2 = memEmail2; }
	
	private String athrYn = "";									// 권한자여부 (Y or N)
	public String getAthrYn() { return athrYn; }
	public void setAthrYn(String athrYn) { this.athrYn = athrYn; }
	
	private List<MenuAthrVO> athrList = new ArrayList<>();		// 메뉴권한리스트
	public List<MenuAthrVO> getAthrList() { return athrList; }
	public void setAthrList(List<MenuAthrVO> athrList) { this.athrList = athrList; }
	
	
	public String getMemSeq() {
		return memSeq;
	}
	public void setMemSeq(String memSeq) {
		this.memSeq = memSeq;
	}
	public String getMemCode() {
		return memCode;
	}
	public void setMemCode(String memCode) {
		this.memCode = memCode;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemEmail() {
		return memEmail;
	}
	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
		if(!EgovStringUtil.isEmpty(memEmail)){
			String[] str=memEmail.split("@");
			setMemEmail1(str[0]);
			setMemEmail2(str[1]);
		}
	}
	public String getMemMphone() {
		return memMphone;
	}
	public void setMemMphone(String memMphone) {
		this.memMphone = memMphone;
		if(!EgovStringUtil.isEmpty(memMphone)){
			String[] str = memMphone.split("-");
			setMemMphone1(str[0]);
			setMemMphone2(str[1]);
			setMemMphone3(str[2]);
		}
	}
	public String getMemLevel() {
		return memLevel;
	}
	public void setMemLevel(String memLevel) {
		this.memLevel = memLevel;
	}
	public String getMemUpdtYn() {
		return memUpdtYn;
	}
	public void setMemUpdtYn(String memUpdtYn) {
		this.memUpdtYn = memUpdtYn;
	}
	public String getMemMemo() {
		return memMemo;
	}
	public void setMemMemo(String memMemo) {
		this.memMemo = memMemo;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "AdminVO [memSeq=" + memSeq + "\r\n memCode=" + memCode
				+ "\r\n memName=" + memName + "\r\n memEmail=" + memEmail
				+ "\r\n memMphone=" + memMphone + "\r\n memLevel=" + memLevel
				+ "\r\n memUpdtYn=" + memUpdtYn + "\r\n memMemo=" + memMemo
				+ "\r\n regId=" + regId + "\r\n regDate=" + regDate + "\r\n memMphone1="
				+ memMphone1 + "\r\n memMphone2=" + memMphone2 + "\r\n memMphone3="
				+ memMphone3 + "\r\n memEmail1=" + memEmail1 + "\r\n memEmail2="
				+ memEmail2 + "\r\n athrYn=" + athrYn + "\r\n athrList=" + athrList + "]";
	}
	
	
}
