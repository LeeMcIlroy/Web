package writer.usr.cmm.tag;

import java.util.Map;

import javax.servlet.jsp.tagext.TagSupport;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;

@SuppressWarnings("serial")
public class EcoLifeLoginTag extends TagSupport {
	
	private String pin = "";
	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin;
	}

	public int doStartTag() {

		//로그인 X
		if( !EgovUserDetailsHelper.isAuthenticatedUser() ){
        	return SKIP_BODY;
		}

		//등록자ID X
		if( EgovStringUtil.isEmpty(getPin())){
        	return SKIP_BODY;
		}
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		if( (userVO.get("memCode")).equals(getPin()) ){
        	return EVAL_BODY_INCLUDE;
		}

    	return SKIP_BODY;
		
	}

}
