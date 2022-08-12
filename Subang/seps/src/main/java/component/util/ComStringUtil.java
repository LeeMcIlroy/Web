package component.util;

import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import seps.cmmn.SepsCommonCode;

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
	
	/**
	 * 전화번호 형식으로 return
	 * @param tel1
	 * @param tel2
	 * @param tel3
	 * @return
	 */
	public static String setTelFormat(String tel1, String tel2, String tel3){
		String result = "";
		result = String.format("%s-%s-%s", tel1, tel2, tel3);
		return result;
	}
	
	/**
	 * 이메일 형식으로 return
	 * @param mail1
	 * @param mail2
	 * @return
	 */
	public static String setEmailFormat(String mail1, String mail2){
		String result = "";
		result = String.format("%s@%s", mail1, mail2);
		return result;
	}
	
	/**
	 * 시간 형식으로 return
	 * @param hour
	 * @param minute
	 * @return
	 */
	public static String setTimeFormat(String hour, String minute){
		String result = "";
		result = String.format("%s:%s", hour, minute);
		return result;
	}
	
	/**
	 * 첫번째 글자 대문자 return
	 * @param str
	 * @return
	 */
	public static String setFirstStringUpper(String str){
		return str.replaceFirst(String.valueOf(str.charAt(0)), ((String.valueOf(str.charAt(0))).toUpperCase()));
	}
	
	public enum DataType{
		
		WOLGYE1(SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, SepsCommonCode.WOLGYE1_WATER_LEVEL_3, SepsCommonCode.WOLGYE1_WATER_LEVEL_2_2, SepsCommonCode.WOLGYE1_WATER_LEVEL_2_1, SepsCommonCode.WOLGYE1_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2_2(), getLevel2_1(), getLevel1());
			}
		}, YEOUI(SepsCommonCode.YEOUI_WATER_LEVEL_CODE, SepsCommonCode.YEOUI_WATER_LEVEL_3, SepsCommonCode.YEOUI_WATER_LEVEL_2, SepsCommonCode.YEOUI_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2(), getLevel1());
			}
		}, SINGOK(SepsCommonCode.SINGOK_WATER_LEVEL_CODE, SepsCommonCode.SINGOK_WATER_LEVEL_3){
			int retunResult(float val){
				return compare(val, getLevel3());
			}
		}, HANGANG(SepsCommonCode.HANGANG_WATER_LEVEL_CODE, SepsCommonCode.HANGANG_WATER_LEVEL_3, SepsCommonCode.HANGANG_WATER_LEVEL_2, SepsCommonCode.HANGANG_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2(), getLevel1());
			}
		}, PALDANG(SepsCommonCode.PALDANG_TOTOTF_CODE, SepsCommonCode.PALDANG_TOTOTF_3){
			int retunResult(float val){
				return compare(val, getLevel3());
			}
		}, CHEONGDAM(SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE, SepsCommonCode.CHEONGDAM_WATER_LEVEL_3, SepsCommonCode.CHEONGDAM_WATER_LEVEL_2, SepsCommonCode.CHEONGDAM_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2(), getLevel1());
			}
		}, OGEUM(SepsCommonCode.OGEUM_WATER_LEVEL_CODE, SepsCommonCode.OGEUM_WATER_LEVEL_3, SepsCommonCode.OGEUM_WATER_LEVEL_2, SepsCommonCode.OGEUM_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2(), getLevel1());
			}
		}, DAEGOK(SepsCommonCode.DAEGOK_WATER_LEVEL_CODE, SepsCommonCode.DAEGOK_WATER_LEVEL_3, SepsCommonCode.DAEGOK_WATER_LEVEL_2, SepsCommonCode.DAEGOK_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2(), getLevel1());
			}
		}, JINGWAN(SepsCommonCode.JINGWAN_WATER_LEVEL_CODE, SepsCommonCode.JINGWAN_WATER_LEVEL_3, SepsCommonCode.JINGWAN_WATER_LEVEL_2, SepsCommonCode.JINGWAN_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2(), getLevel1());
			}
		}, WOLLEUNG(SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, SepsCommonCode.WOLLEUNG_WATER_LEVEL_3, SepsCommonCode.WOLLEUNG_WATER_LEVEL_2_2,  SepsCommonCode.WOLLEUNG_WATER_LEVEL_2_1, SepsCommonCode.WOLLEUNG_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2_2(), getLevel2_1(), getLevel1());
			}
		}, JOONGRANG(SepsCommonCode.JOONGRANG_WATER_LEVEL_CODE, SepsCommonCode.JOONGRANG_WATER_LEVEL_3, SepsCommonCode.JOONGRANG_WATER_LEVEL_2, SepsCommonCode.JOONGRANG_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2(), getLevel1());
			}
		};

		/*
			JOONGRANG(SepsCommonCode.JOONGRANG_WATER_LEVEL_CODE, SepsCommonCode.JOONGRANG_WATER_LEVEL_3, SepsCommonCode.JOONGRANG_WATER_LEVEL_2_2, SepsCommonCode.JOONGRANG_WATER_LEVEL_2_1, SepsCommonCode.JOONGRANG_WATER_LEVEL_1){
				int retunResult(float val){
					return compare(val, getLevel3(), getLevel2_2(), getLevel2_1(), getLevel1());
				}
			}
			
			JOONGRANG(SepsCommonCode.JOONGRANG_WATER_LEVEL_CODE, SepsCommonCode.JOONGRANG_WATER_LEVEL_3, SepsCommonCode.JOONGRANG_WATER_LEVEL_2, SepsCommonCode.JOONGRANG_WATER_LEVEL_1){
			int retunResult(float val){
				return compare(val, getLevel3(), getLevel2(), getLevel1());
			}
		}
		
		*/
		abstract int retunResult(float val);
		
		private static int compare(float val, String ... levels){
			int result = 0;
			for(int i = 0; i < levels.length; i++){
				//Logger.debug(String.format("\nval = %2f\nlevel = %s", val, levels[i]));
				if(val >= Float.parseFloat(levels[i])){
					
					result = levels.length - i;
					
					break;
				}
			}
			return result;
		}
		private String code;
		private String level3;
		private String level2;
		private String level1;
		private String level2_1;
		private String level2_2;
		private DataType(String code) {
			this.code = code;
		}
		private DataType(String code,  String level3, String level2_2, String level2_1, String level1) {
			this.code = code;
			this.level3 = level3;
			this.level2_1 = level2_1;
			this.level2_2 = level2_2;
			this.level1 = level1;
		}
		private DataType(String code, String level3, String level2, String level1) {
			this.code = code;
			this.level3 = level3;
			this.level2 = level2;
			this.level1 = level1;
		}
		private DataType(String code, String level3) {
			this.code = code;
			this.level3 = level3;
		}
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}

		public String getLevel3() {
			return level3;
		}
		public void setLevel3(String level3) {
			this.level3 = level3;
		}
		public String getLevel2() {
			return level2;
		}
		public void setLevel2(String level2) {
			this.level2 = level2;
		}
		public String getLevel1() {
			return level1;
		}
		public void setLevel1(String level1) {
			this.level1 = level1;
		}
		public String getLevel2_1() {
			return level2_1;
		}
		public void setLevel2_1(String level2_1) {
			this.level2_1 = level2_1;
		}
		public String getLevel2_2() {
			return level2_2;
		}
		public void setLevel2_2(String level2_2) {
			this.level2_2 = level2_2;
		}
	}
	
	/**
	 * 서울시실관리공단 수방 통합시스템 전용
	 * 	- 교량별 단계를 가져온다.
	 * 	
	 * 	월계1교 			0000001
	 * 	여의상류			0000002
	 * 	신곡교 			1018665
	 * 	한강대교 			1018683
	 * 	팔당댐			1017310
	 * 	청담대교			1018662
	 * 	오금교(안양천)	1018697
	 * 	대곡교(탄천)		1018655
	 * 	진관교(왕숙천)	1018630
	 */
	public static int sepsReturnLevel(String placeCode, float val){
		int result = 0;
		for(DataType type : DataType.values()){
			if(placeCode.equals(type.getCode())){
				result = type.retunResult(val);
			}
		}
		return result;
	}
	
	/**
	 * 서울시설관리공단 수방 통합시스템 전용
	 * 	- 단계를 설정한다.
	 * 
	 * 평시(관심)		1
	 * 포트홀단계(예방)	2
	 * 보강(주의)		3
	 * 1단계(주의)		4
	 * 2단계(경계)		5
	 * 3단계(심각)		6
	 * 
	 */
	public static String sepsReturnWeatherLevel(String floodLevel){
		String result = "확인중";
		switch (floodLevel) {
			case "1": result = "1단계(주의)"; break;
			case "2": result = "2단계(경계)"; break;
			case "3": result = "3단계(심각)"; break;
			case "4": result = "평시(관심)"; break;
			case "5": result = "포트홀단계(예방)"; break;
			case "6": result = "보강(주의)"; break;
		}
		return result;
	}
	
	/**
	 * 서울시설관리공단 수방 통합시스템 전용
	 * 	- 알람구분을 설정한다
	 * 
	 * 수방단계		FC
	 * 수위			wl
	 * SNS공유		K
	 * 수방근무현황		D
	 * 
	 */
	public static String sepsReturnAlarmType(String tType){
		String result = "확인중";
		switch (tType) {
			case "FC": result = "수방단계"; break;
			case "wl": result = "수위"; break;
			case "K": result = "SNS공유"; break;
			case "D": result = "수방근무현황"; break;
		}
		return result;
	}
}