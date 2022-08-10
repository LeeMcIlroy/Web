package egovframework.rte.ptl.mvc.validation;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.validator.Field;
import org.apache.commons.validator.GenericValidator;
import org.apache.commons.validator.ValidatorAction;
import org.springframework.validation.Errors;
import org.springmodules.validation.commons.FieldChecks;

public class MuctFieldChecks extends RteFieldChecks{
	
	/**
	 *  serialVersion UID
	 */
	private static final long serialVersionUID = 611324405170619860L;

	//한글 외의 영문자, 숫자, 특수문자로 구성되어 있다면 return true
	//한글이 하나라도 존재하면 return false
	public static boolean validateNonKorean(Object bean, ValidatorAction va, Field field, Errors errors) {

		String value = FieldChecks.extractValue(bean, field);
		
		if (isOneKorean(value)) {
			FieldChecks.rejectValue(errors, field, va);
			return false;
		}
		
		return true;
	}
	
	//숫자, -, (), ~을 제외한 문자열이면 return true, 아니면 return false
	public static boolean validatePhone(Object bean, ValidatorAction va, Field field, Errors errors) {

		String value = FieldChecks.extractValue(bean, field);
		value = value.replace(" ", "");
		String pattern1 = "^[0-9\\(\\)\\-\\~]+$";
		boolean result = false;
		
		Pattern p1 = Pattern.compile(pattern1);
		Matcher m1 = p1.matcher(value);
		
		if(value.length()==0){
			result = true;
		}else if(m1.find()){
			result = true;
		}else{
			FieldChecks.rejectValue(errors, field, va);
		}
		
		return result;
	}
	
	//입력받은 문자열이 메일형식에 부합하면 return true, 아니면 return false
	public static boolean validateEmail2(Object bean, ValidatorAction va, Field field, Errors errors){
	    String value = extractValue(bean, field);
	    if(value.length()==0){
	    	return true;
	    }else if ( (!GenericValidator.isBlankOrNull(value)) && (!GenericValidator.isEmail(value)) )
	    {
	      rejectValue(errors, field, va);
	      return false;
	    }
	    return true;
	 }
	
	/**
	 * 한글이 존재하는지 검사합니다.
	 * @param value 검사할 문자열
	 * @return 한글이 하나라도 존재하면 true, 아니면 false
	 */
	public static boolean isOneKorean(String value) {

		char[] charArray = value.toCharArray();
		for (int i = 0; i < charArray.length; i++) {
			if (Character.getType(charArray[i]) == 5) {
				return true;
			}
		}
		return false;
	}
}
