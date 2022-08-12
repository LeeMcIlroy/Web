package component.util;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ComStringUtil {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ComStringUtil.class);
	
	public static String createPassword(int length){
		Random random = new Random();
		StringBuffer newPassword = new StringBuffer();
		for ( int i = 0; i < length; i++ ) {
			if ( random.nextBoolean() ) {
				newPassword.append(String.valueOf((char)((int)(random.nextInt(26))+97)));
			} else {
				newPassword.append((random.nextInt(10)));
			}
		}
		return newPassword.toString();
	}

	/**
	 * 이미지 태그의 width와 height 값을 max-width와 max-height로 변경한다
	 * 	- 기존의 min-width, max-width와 min-height, max-height는 삭제한다
	 * @param content
	 * 
	 */
	public static String imgWidthHeightToMaxWidthHeight(String content){
		Pattern pattern  =  Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		String result = content;

		// 내용 중에서 이미지 태그를 찾아라!
		Matcher match = pattern.matcher(content);
		String imgTag = null;

		String tmpTag = "";
		while(match.find()){ // 이미지 태그를 찾았다면
		    imgTag = match.group();

			if(imgTag.indexOf("max-width") > 0) imgTag = imgTag.replaceAll("max-width\\s?:\\s?\\w*\\;?", "");
			if(imgTag.indexOf("min-width") > 0) imgTag = imgTag.replaceAll("min-width\\s?:\\s?\\w*\\;?", "");
			if(imgTag.indexOf("max-height") > 0) imgTag = imgTag.replaceAll("max-height\\s?:\\s?\\w*\\;?", "");
			if(imgTag.indexOf("min-height") > 0) imgTag = imgTag.replaceAll("min-height\\s?:\\s?\\w*\\;?", "");

			tmpTag = imgTag.replaceAll("width", "max-width").replaceAll("height", "max-height");

		    result = content.replace(imgTag, tmpTag);
		}
		return result;
	}
	
	public static boolean isDesktop(HttpServletRequest request) {
		// 190826  - 공지사항 데스크탑 : 10개, 모바일 : 5개
		String userAgent = request.getHeader("user-agent").toUpperCase();
		boolean flag = false;
		
		try{
			if(userAgent.indexOf("MOBILE") > 0 ) {
				flag = false;
			}else {
				flag = true;
			}
		}catch(Exception ex) {
			LOGGER.error(ex.getMessage());
		}
		
		return flag;
		
	}
	
	public static String getClientIP(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
	    LOGGER.info("> X-FORWARDED-FOR : " + ip);

	    if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");
	        LOGGER.info("> Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	        LOGGER.info(">  WL-Proxy-Client-IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	        LOGGER.info("> HTTP_CLIENT_IP : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	        LOGGER.info("> HTTP_X_FORWARDED_FOR : " + ip);
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();
	        LOGGER.info("> getRemoteAddr : "+ip);
	    }
	    LOGGER.info("> Result : IP Address : "+ip);

	    return ip;
	}
		
	public static String numberGen(int len, int dupCd ) {
        
        Random rand = new Random();
        String numStr = ""; //난수가 저장될 변수
        
        for(int i=0;i<len;i++) {
            
            //0~9 까지 난수 생성
            String ran = Integer.toString(rand.nextInt(10));
            
            if(dupCd==1) {
                //중복 허용시 numStr에 append
                numStr += ran;
            }else if(dupCd==2) {
                //중복을 허용하지 않을시 중복된 값이 있는지 검사한다
                if(!numStr.contains(ran)) {
                    //중복된 값이 없으면 numStr에 append
                    numStr += ran;
                }else {
                    //생성된 난수가 중복되면 루틴을 다시 실행한다
                    i-=1;
                }
            }
        }
        return numStr;
    }
	
	public static String getLocalMacAddress() {
	 	String result = "";
		InetAddress ip;

		try {
			ip = InetAddress.getLocalHost();
		   
			NetworkInterface network = NetworkInterface.getByInetAddress(ip);
			byte[] mac = network.getHardwareAddress();
		   
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < mac.length; i++) {
				sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
			}
				result = sb.toString();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (SocketException e){
			e.printStackTrace();
		}
		    
		return result;
	 }
	
	
	
}
