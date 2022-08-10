package component.util;

import java.util.Iterator;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindingResult;

public class BindingResultLoggerUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(BindingResultLoggerUtil.class);
	
	public static void loggerWarn(BindingResult errors){
		Map<String, Object> map = errors.getModel();
		Iterator<String> iter = map.keySet().iterator();
		while(iter.hasNext()) {
			Object key = iter.next();
			Object val = map.get(key);
			LOGGER.warn(key + " = " + val);
		}
	}

}
