package component.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.support.RequestContextUtils;

public class RedAtUtil {
	
	public static Object get(HttpServletRequest request, String name){

		Map<String, ?> map = RequestContextUtils.getInputFlashMap(request);
		if(map==null){
			return null;
		}
		
		Object obj = map.get(name);
		if(obj==null){
			return null;
		}
		
		return obj;
	}

}
