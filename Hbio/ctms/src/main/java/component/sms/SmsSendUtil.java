package component.sms;

import java.util.Properties;

import java.util.HashMap;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class SmsSendUtil {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SmsSendUtil.class);
	private static final String API_KEY = "NCSNDU86H6RWHRXX";
	private static final String API_SECRET = "QFDWJJEHRZJSSFK1ODFIXY16G9LIALK9";

	/**
     * SMS를 발송한다.
     * 
     * @param to SMS 받는 번호
     * @param from SMS 보내는 번호
     * @param text SMS 내용
     * @return 
     */
	public static void sendSms(String to, String from, String text) throws Exception{
	    Message coolsms = new Message(API_KEY, API_SECRET);
	    
	    String type = byteCheck(text);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", to); // "01000000000"
	    params.put("from", from); // "01000000000"
	    params.put("type", type); // SMS, MMS
	    params.put("text", text);
	    params.put("app_version", "test app 1.2"); // application name and version

	    try {
	    	JSONObject obj = (JSONObject) coolsms.send(params);
	      	System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	    	LOGGER.error(e.getMessage());
	    	System.out.println(e.getCode());
	    }
	}

	/**
	 * SMS를 얘약 발송한다.
	 * 
	 * @param to SMS 받는 번호
	 * @param from SMS 보내는 번호
	 * @param text SMS 내용
	 * @param date SMS 발송 일시
	 * @return 
	 */
	public static void sendSmsDate(String to, String from, String text, String date) throws Exception{
		Message coolsms = new Message(API_KEY, API_SECRET);
		
		String type = byteCheck(text);
		
		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", to); // "01000000000"
		params.put("from", from); // "01000000000"
		params.put("type", type); // SMS, MMS
		params.put("text", text);
		params.put("app_version", "test app 1.2"); // application name and version
		params.put("datetime", date); // Format must be(YYYYMMDDHHMISS) 20160221150000
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			LOGGER.error(e.getMessage());
			System.out.println(e.getCode());
		}
	}
	
	/**
     * 바이트를 체크한다. 기준보다 크면 MMS, 작거나 같으면 SMS
     * 
     * @param text 체크할 text
     * @return 
     */
    public static String byteCheck(String text) {
        if (EgovStringUtil.isEmpty(text)) { return "SMS"; }
        String result = "";
 
        // 바이트 체크 (영문 1, 한글 2, 특문 1)
        int en = 0;
        int ko = 0;
        int etc = 0;
 
        char[] txtChar = text.toCharArray();
        for (int j = 0; j < txtChar.length; j++) {
            if (txtChar[j] >= 'A' && txtChar[j] <= 'z') {
                en++;
            } else if (txtChar[j] >= '\uAC00' && txtChar[j] <= '\uD7A3') {
                ko++;
                ko++;
            } else {
                etc++;
            }
        }
 
        int txtByte = en + ko + etc;
        
        if(txtByte < 2000){
        	result = "SMS";
        }else{
        	result = "MMS";
        }
        
        return result;
    }
	
}
