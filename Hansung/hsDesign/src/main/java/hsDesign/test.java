package hsDesign;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class test {
	
	 public static void main(String[] args) {
		 
		 //String temp = "[spb_text_block pb_margin_bottom=\"no\" pb_border_bottom=\"no\" width=\"1/1\" el_position=\"first last\"]■ 시네마4D수업 기말과제■ Designed By: 디지털아트 전공 2학년 박주형■ 영상주소: <a href=\"https://www.youtube.com/watch?v=GBf9KxDDTms\">https://www.youtube.com/watch?v=GBf9KxDDTms</a>[/spb_text_block] [spb_video link=\"https://www.youtube.com/watch?v=GBf9KxDDTms\" full_width=\"no\" width=\"1/1\" el_position=\"first last\"]";
		// String temp = "<a href=\"#\" alt=\"2017/03/170321실내특강1.jpg\"><img class=\"alignnone size-full wp-image-37707\" alt=\"170321실내특강1\" src=\"/showOldImage.do?filePath=2017/03/170321실내특강1.jpg\" width=\"686\" height=\"455\" />";
		 String temp = "<iframe frameborder=\"0\" webkitallowfullscreen=\"\" mozallowfullscreen=\"\" allowfullscreen=\"\" width=\"100%\"	height=\"500px\" src=\"https://youtube.com/embed/JcfN0r-9Gmw\"></iframe>";
		 System.out.println(temp);

		/*temp = test.replaceHr(temp);
		temp = test.replaceClose(temp);
		temp = test.replaceVideo(temp);
		temp = test.replaceImg(temp);
		temp = test.replaceHr2(temp);
		temp = temp.replaceAll("src=\"http://edubank.hansung.ac.kr/wp-content/uploads/", "src=\"/showOldImage.do?filePath=");
		temp = temp.replaceAll(System.getProperty("line.separator"), "<br/>");*/
		temp = test.replaceAlign(temp);
		temp = test.replaceImgSize(temp);
		System.out.println("@@@@@@@@@@@@@@@@@@@@");
		System.out.println(temp);
	 }

	 
	 public static String replaceHr(String tempStr){
		 System.out.println("replaceHr Start!");
		 Pattern pattern = Pattern.compile("\\[spb_t[^\\]]*(\"?)\\]", Pattern.CASE_INSENSITIVE); // <hr /> 치환
		 Matcher matcher = pattern.matcher(tempStr);
	        StringBuffer replacedString = new StringBuffer();
	        while(matcher.find()) {
	            // 찾은 대상을 치환
	            System.out.println(matcher.group() + " => 자바 로 치환 실행");
	            matcher.appendReplacement(replacedString, "<p>");
	        }
	        // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
	        matcher.appendTail(replacedString);
	        
	        String result = replacedString.toString();
	        System.out.println("replaceHr end!");
		 return result;
	 }
	 
	 public static String replaceHr2(String tempStr){
		 System.out.println("replaceHr Start!");
		 Pattern pattern = Pattern.compile("\\[(/?)spb_t[^\\]]*(\"?)\\]", Pattern.CASE_INSENSITIVE); // <hr /> 치환
		 Matcher matcher = pattern.matcher(tempStr);
		 StringBuffer replacedString = new StringBuffer();
		 while(matcher.find()) {
			 // 찾은 대상을 치환
			 System.out.println(matcher.group() + " => 자바 로 치환 실행");
			 matcher.appendReplacement(replacedString, "</p>");
		 }
		 // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
		 matcher.appendTail(replacedString);
		 
		 String result = replacedString.toString();
		 System.out.println("replaceHr end!");
		 return result;
	 }
	 
	 public static String replaceVideo(String tempStr){
		 System.out.println("replaceVideo Start!");
		 Pattern pattern = Pattern.compile("\\[spb_v[^\\]]*(link=\")", Pattern.CASE_INSENSITIVE); // 시작부터 image까지
		 Matcher matcher = pattern.matcher(tempStr);
		 StringBuffer replacedString = new StringBuffer();
		 while(matcher.find()) {
			 // 찾은 대상을 치환
			 System.out.println(matcher.group() + " => 자바 로 치환 실행");
			 matcher.appendReplacement(replacedString, "<div class=\"videoEmbed\"><iframe frameborder=\"0\" webkitallowfullscreen=\"\" mozallowfullscreen=\"\" allowfullscreen=\"\" width=\"100%\"	height=\"500px\" src=\"");
		 }
		 
		 // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
		 matcher.appendTail(replacedString);
		 
		 String result = replacedString.toString();
		 result = result.replace("http://youtu.be/", "https://youtube.com/embed/");
		 result = result.replace("https://youtu.be/", "https://youtube.com/embed/");
		 result = result.replace("http://vimeo.com/", "https://player.vimeo.com/video/");
		 result = result.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
		 result = result.replace("&amp;feature=youtu.be", "");
		 result = result.replace("feature=player_detailpage", "");
		 result = result.replace("feature=player_embeded", "");
		 result = result.replace("feature=player_embedded", "");
		 result = result.replace("feature=youtu.be", "");
		 if(result.contains("watch?v=")){
			 result = result.replace("watch?v=", "embed/");
			 System.out.println(1);
		 }
		 System.out.println("replaceVideo end!");
		 return result;
	 }
	 
	 public static String replaceVideo2(String tempStr){
		 System.out.println("replaceVideo2 Start!");
		 Pattern pattern = Pattern.compile("\\[ef[^\\]]*(href=\")", Pattern.CASE_INSENSITIVE); // 시작부터 image까지
		 Matcher matcher = pattern.matcher(tempStr);
		 StringBuffer replacedString = new StringBuffer();
		 while(matcher.find()) {
			 // 찾은 대상을 치환
			 System.out.println(matcher.group() + " => 자바 로 치환 실행");
			 matcher.appendReplacement(replacedString, "<div class=\"videoEmbed\"><iframe frameborder=\"0\" webkitallowfullscreen=\"\" mozallowfullscreen=\"\" allowfullscreen=\"\" width=\"100%\"	height=\"500px\" src=\"");
		 }
		 
		 // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
		 matcher.appendTail(replacedString);
		 
		 String result = replacedString.toString();
		 result = result.replace("http://youtu.be/", "https://youtube.com/embed/");
		 result = result.replace("https://youtu.be/", "https://youtube.com/embed/");
		 result = result.replace("http://vimeo.com/", "https://player.vimeo.com/video/");
		 result = result.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
		 result = result.replace("feature=youtu.be", "");
		 result = result.replace("feature=player_detailpage", "");
		 result = result.replace("feature=player_embeded", "");
		 result = result.replace("feature=player_embedded", "");
		 result = result.replace("feature=youtu.be", "");
		 result = result.replace("&amp;", "");
		 if(result.contains("watch?v=")){
			 result = result.replace("watch?v=", "embed/");
			 System.out.println(1);
		 }
		 System.out.println("replaceVideo2 end!");
		 return result;
	 }
	 
	 public static String replaceImg(String tempStr){
		 System.out.println("replaceImg Start!");
		 Pattern pattern = Pattern.compile("\\[spb_s[^\\]]*(image=\")", Pattern.CASE_INSENSITIVE); // 시작부터 image까지
		 Matcher matcher = pattern.matcher(tempStr);
		 StringBuffer replacedString = new StringBuffer();
		 while(matcher.find()) {
			 // 찾은 대상을 치환
			 System.out.println(matcher.group() + " => 자바 로 치환 실행");
			 matcher.appendReplacement(replacedString, "<img alt=\"사진 미리보기\"  style=\"width:90%; height:90%; text-align:center;\" src=\"/showOldImage.do?filePath=");
		 }
		 // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
		 matcher.appendTail(replacedString);
		 String result = replacedString.toString();
		 System.out.println("replaceImg end!");
		 return result;
	 }
	 
	 public static String replaceClose(String tempStr){
		 System.out.println("replaceClose Start!");
		 Pattern pattern = Pattern.compile("\"\\s[^\\]]*(\")\\]", Pattern.CASE_INSENSITIVE); // id이후부터 끝까지 치환
		 Matcher matcher = pattern.matcher(tempStr);
		 StringBuffer replacedString = new StringBuffer();
		 while(matcher.find()) {
			 // 찾은 대상을 치환
			 System.out.println(matcher.group() + " => 자바 로 치환 실행");
			 if(matcher.group().contains("image_size")){
				 matcher.appendReplacement(replacedString, "\">");
			 }else{
				 matcher.appendReplacement(replacedString, "\"></iframe></div>");
			 }
			 
		 }
		 // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
		 matcher.appendTail(replacedString);
		 
		 String result = replacedString.toString();
		 System.out.println("replaceClose end!");
		 return result;
	 }
	 
	 public static String replaceClose2(String tempStr){
		 System.out.println("replaceClose2 Start!");
		 Pattern pattern = Pattern.compile("\\]\\[\\/ef-video\\]", Pattern.CASE_INSENSITIVE); // id이후부터 끝까지 치환
		 Matcher matcher = pattern.matcher(tempStr);
		 StringBuffer replacedString = new StringBuffer();
		 while(matcher.find()) {
			 // 찾은 대상을 치환
			 System.out.println(matcher.group() + " => 자바 로 치환 실행");
			 matcher.appendReplacement(replacedString, "></iframe></div>");
		 }
		 // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
		 matcher.appendTail(replacedString);
		 
		 String result = replacedString.toString();
		 System.out.println("replaceClose2 end!");
		 return result;
	 }
	 
	 
	 public static String replaceAlign(String tempStr){
		 System.out.println("replaceAlign start!");
		 Pattern pattern = Pattern.compile("\\s(class=\"align((\\s)?(\\w+)?(\\-)?(\\w+)?)*\")", Pattern.CASE_INSENSITIVE);
		 Matcher matcher = pattern.matcher(tempStr);
		 StringBuffer replacedString = new StringBuffer();
		 while(matcher.find()){
			 System.out.println(matcher.group() + " =>  공백으로 치환실행");
			 matcher.appendReplacement(replacedString, "");
		 }
		 // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
		 matcher.appendTail(replacedString);
		 String result = replacedString.toString();
		 System.out.println("replaceAlign end!");
		 return result;
	 }
	 
	 public static String replaceImgSize(String tempStr){
		 System.out.println("replaceImgSize start!");
		 Pattern pattern = Pattern.compile("\\s(width=\"\\w+\")\\s(height=\"\\w+)", Pattern.CASE_INSENSITIVE);
		 Matcher matcher = pattern.matcher(tempStr);
		 StringBuffer replacedString = new StringBuffer();
		 while(matcher.find()){
			 System.out.println(matcher.group() + " =>  style로 치환실행");
			 String tempReplaceStr = matcher.group().replace(" width=\"", " style=\"width:").replace("\" height=\"", "px; height:")+"px";
			 System.out.println(tempReplaceStr);
			 matcher.appendReplacement(replacedString, tempReplaceStr);
		 }
		 // 검색에 마지막으로 찾은 부분 이후의 검색 대상 문자열을 결합
		 matcher.appendTail(replacedString);
		 String result = replacedString.toString();
		 System.out.println("replaceImgSize end!");
		 return result;
	 }
	 
}
