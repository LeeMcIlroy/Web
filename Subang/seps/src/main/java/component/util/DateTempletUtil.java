package component.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class DateTempletUtil {

	/*요일 구하기*/
	public static String getDateDay(String date, String type) throws Exception {
	     
	    String day = "" ;
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy"+type+"MM"+type+"dd") ;
	    Date nDate = dateFormat.parse(date) ;
	    Calendar cal = Calendar.getInstance() ;
	    cal.setTime(nDate);
	    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
	    switch(dayNum){
	        case 1:
	            day = "일";
	            break ;
	        case 2:
	            day = "월";
	            break ;
	        case 3:
	            day = "화";
	            break ;
	        case 4:
	            day = "수";
	            break ;
	        case 5:
	            day = "목";
	            break ;
	        case 6:
	            day = "금";
	            break ;
	        case 7:
	            day = "토";
	            break ;
	             
	    }
	    return day;
	}
	
	//일 더하기
	public static String getTimeAddMonth(String defaultTime, int addNum) throws Exception{
		
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		 
        Calendar cal = Calendar.getInstance();
        Date date = format.parse(defaultTime);
		cal.setTime(date);
        cal.add(Calendar.DATE, addNum);     //일 더하기
        
        return format.format(cal.getTime());
	}
	
	//날짜 템플렛 - yyyy.mm.dd(요일) HH:mm 
	public static String[] getTempletDate(EgovMap paramMap) throws Exception {
		
		String tempDate1 = paramMap.get("baseDate").toString().subSequence(0, 4)+"."+paramMap.get("baseDate").toString().subSequence(4, 6)+"."+paramMap.get("baseDate").toString().subSequence(6, 8);
		tempDate1 = tempDate1+"("+getDateDay(tempDate1, ".")+")";
		String tempDate2 =paramMap.get("baseTime").toString().substring(0, 2)+":"+paramMap.get("baseTime").toString().substring(2, 4);
		
		return new String[]{tempDate1, tempDate2};
	}
	
	//날짜 템플렛 - dd(요일) 
	public static String getTempletDate2(EgovMap paramMap) throws Exception {
		
		String tempDate1 = paramMap.get("fcstDate").toString().subSequence(0, 4)+"."+paramMap.get("fcstDate").toString().subSequence(4, 6)+"."+paramMap.get("fcstDate").toString().subSequence(6, 8);
		return paramMap.get("fcstDate").toString().subSequence(6, 8)+"("+getDateDay(tempDate1, ".")+")";
	}
	
	//날짜 템플렛 MM/dd(요일)
	public static String getTempletDate3(String defaultTime) throws Exception{
		
		String dayName = defaultTime.substring(4,6) + "/" + defaultTime.substring(6, 8) + "("+ getDateDay(defaultTime, "") + ")";
		
		return dayName;
	}

	//날짜 템플렛 - yyyy년 mm월 dd일 HH:mm 기준 
	public static String getTempletDate4(EgovMap paramMap) throws Exception {
		
		String date1 = paramMap.get("applcDt").toString().subSequence(0, 4)+"년 "+paramMap.get("applcDt").toString().subSequence(4, 6)+"월 "+paramMap.get("applcDt").toString().subSequence(6, 8)+"일";
		String date2 = paramMap.get("applcDt").toString().subSequence(8, 10)+"시 ";
        
		return date1 + " "+ date2 + " 기준";
	}

	//날짜 템플렛 - yyyy년 mm월 dd일 기준
	public static String getTempletDate5(EgovMap paramMap) throws Exception {
		String dayName = getDateDay(paramMap.get("baseDate").toString(), "");
		if(paramMap.get("baseDate").toString().length() > 8){
			dayName = getDateDay(paramMap.get("baseDate").toString().substring(0,8), "");
		}
		return paramMap.get("baseDate").toString().subSequence(0, 4)+"년 "+paramMap.get("baseDate").toString().subSequence(4, 6)+"월 "+paramMap.get("baseDate").toString().subSequence(6, 8)+"일 ("+dayName+") "+ paramMap.get("baseDate").toString().subSequence(8, 10)+"시 기준";
	}
	
}
