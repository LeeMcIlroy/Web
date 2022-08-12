package seps.valueObject;

import java.util.ArrayList;
import java.util.List;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class UserInfoVO {
	
	private String userInfoId = "";
	private String userNm = "";
	private String userId = "";
	private String userPw = "";
	private String dept = "";
	private String userTel = "";
	private String userMail = "";
	private String useYn = "";
	private String alarmYn = "";
	private String adminYn = "";
	private String regDttm = "";
	private String udtDttm = "";
	private String uuid = "";	//앱로그인용
	private String token = ""; //앱 알람 토큰용
	private List<String> menuIds;
	private List<AuthVO> menuList = new ArrayList<AuthVO>(); //메뉴리스트
	
	private String userTel1 = "";
	private String userTel2 = "";
	private String userTel3 = "";
	public String getUserTel1() { return userTel1; }
	public void setUserTel1(String userTel1) { this.userTel1 = userTel1; }
	public String getUserTel2() { return userTel2; }
	public void setUserTel2(String userTel2) { this.userTel2 = userTel2; }
	public String getUserTel3() { return userTel3; }
	public void setUserTel3(String userTel3) { this.userTel3 = userTel3; }
	
	private String userMail1 = "";
	private String userMail2 = "";
	public String getUserMail1() { return userMail1; }
	public void setUserMail1(String userMail1) { this.userMail1 = userMail1; }
	public String getUserMail2() { return userMail2; }
	public void setUserMail2(String userMail2) { this.userMail2 = userMail2; }
	
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getUserInfoId() {
		return userInfoId;
	}
	public void setUserInfoId(String userInfoId) {
		this.userInfoId = userInfoId;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
		if(!EgovStringUtil.isEmpty(userTel)){
			setUserTel1(userTel.split("-")[0]);
			setUserTel2(userTel.split("-")[1]);
			setUserTel3(userTel.split("-")[2]);
		}
	}
	public String getUserMail() {
		return userMail;
	}
	public void setUserMail(String userMail) {
		this.userMail = userMail;
		if(!EgovStringUtil.isEmpty(userMail)){
			setUserMail1(userMail.split("@")[0]);
			setUserMail2(userMail.split("@")[1]);
		}
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getAlarmYn() {
		return alarmYn;
	}
	public void setAlarmYn(String alarmYn) {
		this.alarmYn = alarmYn;
	}
	public String getAdminYn() {
		return adminYn;
	}
	public void setAdminYn(String adminYn) {
		this.adminYn = adminYn;
	}
	public String getRegDttm() {
		return regDttm;
	}
	public void setRegDttm(String regDttm) {
		this.regDttm = regDttm;
	}
	public String getUdtDttm() {
		return udtDttm;
	}
	public void setUdtDttm(String udtDttm) {
		this.udtDttm = udtDttm;
	}
	public List<String> getMenuIds() {
		return menuIds;
	}
	public void setMenuIds(List<String> menuIds) {
		this.menuIds = menuIds;
	}
	public List<AuthVO> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<AuthVO> menuList) {
		this.menuList = menuList;
	}
	@Override
	public String toString() {
		return "UserInfoVO [userInfoId=" + userInfoId + "\r\n userNm=" + userNm
				+ "\r\n userId=" + userId + "\r\n userPw=" + userPw + "\r\n dept="
				+ dept + "\r\n userTel=" + userTel + "\r\n userMail=" + userMail
				+ "\r\n useYn=" + useYn + "\r\n alarmYn=" + alarmYn + "\r\n adminYn="
				+ adminYn + "\r\n regDttm=" + regDttm + "\r\n udtDttm=" + udtDttm
				+ "\r\n menuIds=" + menuIds + "\r\n menuList=" + menuList + ""
				+ "\r\n uuid="+uuid+"]";
	}
}
