package component.util;

import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ComStringUtil {
	
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

		    content = content.replace(imgTag, tmpTag);
		}
		return content;
	}
}
