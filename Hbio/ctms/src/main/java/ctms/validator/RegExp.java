package ctms.validator;

public class RegExp {
	
	public static String dtWarn = "[1970-01-01] 형식과 같이 입력하셔야 됩니다.";
	public static String numberWarn = "숫자만 입력가능합니다.";
	public static String emailWarn = "이메일을 올바르게 입력해 주십시오.";

	public static String phoneWarn = getMaxLengWarnTxt(30,"n");
	public static String zipCodeWarn = getMaxLengWarnTxt(10,"n");
	public static String addrWarn = getMaxLengWarnTxt(60, "");
	public static String organWarn = getMaxLengWarnTxt(30, "");

	// 숫자
	public static String MEM_NUM = "^[0-9]*$";
	// 시퀀스
	public static String SEQUENCE = "^[0-9]+$";
	
	// ====================  회원 기본정보  =================================
	// 이름
	public static String MEM_NAME = "^[가-힣a-zA-Z0-9_!@#$%^&*(),.?\\\":{}|<>-]{1,50}$";
	// 전문분야
	public static String MEM_PROFIELD = "^[1-9]{0,9}$";
	// 전화번호, 휴대폰번호 ,팩스번호
	public static String MEM_PHONE = "^[0-9-]{0,30}$";
	// 이메일
	public static String MEM_EMAIL = "^([0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3})?$";
	// 우편번호
	public static String MEM_POST_CODE = "^[0-9-]{0,10}$";
	// 등록일
	public static String MEM_REG_DATE = "^([0-9]{4}-(0[1-9]|1[0-2])-[0-9]{2})?$";
	// 유료도서회원 연우 회원
	public static String MEM_IS_YUNWOO_MEM = "^(Y|N)?$";
	// 존칭
	public static String MEM_RESPECT = "^(님 귀하|귀중)$";
	// 성별
	public static String MEM_GENDER = "^(1|2|3)$";
	// 우편물수령처
	public static String MEM_DESTINATION = "^(1|2)$";
	
	// ====================  기본정보  =================================
	
	// ====================  현지/크레이 =================================
	// 주작목종류/작목명
	public static String CROP_TYPE = "^(곡물|과수|과채|채소|축산|특작|가공및유통|6차산업|기타)$";
	public static String CROP_NAME = "^.{1,20}$";
	// ====================  현지/크레이 =================================
	
	
	// ==================== CRM 사용자/관리자 -=============================
	// 이름
	public static String NAME2 = "^[a-zA-Z가-힣]{3,20}$";
	public static String AGE1 = "^[1-9][0-9]?$";
	
	// 아이디
	// 8 ~ 20자리, 첫 글자 영문자 + 영문자,숫자,_,- 가능			
	public static String ID1 = "^[a-zA-Z][a-zA-Z0-9_-]{7,19}$";

	// 비밀번호
	
	// 8 ~ 16자리, 숫자, 문자, 특수문자 각각 1개 이상 포함					 
	public static String PWD1 = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&~])[A-Za-z\\d$@$!%*#?&~]{8,16}$";
	// 8 ~ 16자리, 대문자 1자리 소문자 1자리 숫자 1자리 특수문자 1자리
	public static String PWD2 = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&~])[A-Za-z\\d$@$!%*?&~]{8,16}";
	
	// ====================	메서드 ====================================
	
	// 정규표현식 검사 메서드
	public static boolean check(String regex, String value) {
		return value.matches(regex);
	}
	
	/// 경고 문자열 생성 메서드
	public static String getMaxLengWarnTxt(int max, String type) {
		if("n".equals(type)) {
			return "최대 "+max+"글자까지 입력 가능하며, 숫자 [0-9] 및 하이픈(-)만 입력하실 수 있습니다.";
		} else if("en".equals(type)) {
			return max + "자리 이내, 영문자, 숫자이어야 합니다.";
		}else {
			return "최대 "+max+"글자까지만 입력하실 수 있습니다.";
		}
	}
	
	public static String getLengthRegExp(int min, int max) {
		return "^.{"+min+","+max+"}$";
	}
	
}
