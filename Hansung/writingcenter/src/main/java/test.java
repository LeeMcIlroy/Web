import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Pattern;

public class test {
	public static void main(String[] args) {
		/*
		String str = "asdfsadf.txt";
		System.out.println(str.substring(str.lastIndexOf(".")));
		*/
		/*
		String str = "20170202";
		String str2 = "20170204";
		
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		try {
			Date d1 = format.parse(str);
			Date d2 = format.parse(str2);
			
			
			long diff = d2.getTime() - d1.getTime();
		    long diffDays = diff / (24 * 60 * 60 * 1000);
			
		    System.out.println(diffDays);
		    Calendar cal = Calendar.getInstance();
		    cal.setTime(d1);
		    cal.add(Calendar.DATE, 1);
		    
		    String dd1 = format.format(cal.getTime());
		    System.out.println(dd1);
		    
		    for (int i = 0; i < diffDays+1; i++) {
		    	Calendar cal = Calendar.getInstance();
			    cal.setTime(d1);
			    cal.add(Calendar.DATE, i);
			    String dd = format.format(cal.getTime());
				System.out.println(dd);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
/*		
		String returnValue = "<script>alert(\"111\")</script>";
		returnValue = returnValue.replaceAll("&", "&amp;");
		System.out.println(returnValue);
		returnValue = returnValue.replaceAll("<", "&lt;");
		System.out.println(returnValue);
		returnValue = returnValue.replaceAll(">", "&gt;");
		System.out.println(returnValue);
		returnValue = returnValue.replaceAll("\"", "&#34;");
		System.out.println(returnValue);
		returnValue = returnValue.replaceAll("\'", "&#39;");
		System.out.println(returnValue);
		returnValue = returnValue.replaceAll("\\.", "&#46;");
		System.out.println(returnValue);
		returnValue = returnValue.replaceAll("%2E", "&#46;");
		returnValue = returnValue.replaceAll("%2F", "&#47;");
		System.out.println(returnValue);
*/		
		/*
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String nowDate = format.format(new Date());
		System.out.println(nowDate);
		
		if("2017-02-21 15:00".compareTo(nowDate) < 0){
			System.out.println("111");
		}
		*/
		
		/*
			Vy3zFyENGINEx5F1zTyGIDx5FDEMO1zCy1487741229zPy86400zAy43zEyH419jndkuHx789XL212hsJU7haSpWPmp0x79XI1Kx7A4mmnKHo23E8WlY3lKl4FAlv0TaYx78Ux2BQVsZ2HWMLGwXb4WZ2x7AB7aLI76M8PpAMsd84iaSwsx3DzKyR0WL7IXsr4OLkrS1mx2FmMdmVnH7MKrB2M66b8lAEaa0nSx79x2BNIx78FWSXd0ZGf7x2FaDC3zSSy00000000110zUURy959f3d58d71622cbzMyU85NYQrdGHsx3Dz
		 */
		/*
		String ss_id = "";
		SSO sso = new SSO();
		int nResult = sso.verifyToken("Vy3zFyENGINEx5F1zTyGIDx5FDEMO1zCy1487741229zPy86400zAy43zEyH419jndkuHx789XL212hsJU7haSpWPmp0x79XI1Kx7A4mmnKHo23E8WlY3lKl4FAlv0TaYx78Ux2BQVsZ2HWMLGwXb4WZ2x7AB7aLI76M8PpAMsd84iaSwsx3DzKyR0WL7IXsr4OLkrS1mx2FmMdmVnH7MKrB2M66b8lAEaa0nSx79x2BNIx78FWSXd0ZGf7x2FaDC3zSSy00000000110zUURy959f3d58d71622cbzMyU85NYQrdGHsx3Dz");
		ss_id= sso.getValueUserID();
		
		System.out.println(ss_id);
		*/
/*
		boolean flag = false;
		
		String reqeustURI1 = "/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do";
		String reqeustURI2 = "/usr/wcGuide/tips/wcGuideTipsList.do";
		String reqeustURI3 = "/xabdmxgr/boardMng/notice/admBoardMngNoticeList.do";
		String reqeustURI4 = "/xabdmxgr/lec/admLecClassList.do?searchSemester=3";
		String reqeustURI5 = "/xabdmxgr/cnslt/list/admCnsltList.do";
		
		Pattern p = Pattern.compile("/xabdmxgr/cnslt/.*\\.do.*");
		if( p.matcher(reqeustURI5).matches() ){
			flag = true;
		}
		System.out.println(flag);
	
*/
/*
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, 1);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String addDate = format.format(cal.getTime());
		System.out.println(addDate);
*/
/*
		System.out.println(99.97*40/100);
		System.out.println(99.97*0.4*100);
		System.out.println(Math.floor(99.97*0.4*100));
		System.out.println(Math.floor(99.97*0.4*100)/100);
*/		
		try {
			String str = "http://writingcenter.hansung.ac.kr/cmmn/ckeditor/downloadCkeditorFile.do?fileName="+URLEncoder.encode("20171108044519610_한성대_아이디비밀번호찾기_01.JPG", "utf-8");
			System.out.println(str);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
