package seps.valueObject;

public class AuthVO {

	private String authId = "";
	private String url= "";
	private String authNm = "";
	
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getAuthNm() {
		return authNm;
	}
	public void setAuthNm(String authNm) {
		this.authNm = authNm;
	}
	
	@Override
	public String toString() {
		return "AuthVO [authId=" + authId + ", url=" + url + ", authNm="
				+ authNm + "]";
	}
	
	
}
