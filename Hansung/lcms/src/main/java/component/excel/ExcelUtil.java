package component.excel;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.rte.fdl.property.EgovPropertyService;

@Component
public class ExcelUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(ExcelUtil.class);
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//엑셀다운로드
	public void getPerformanceExcel(Map<String, Object> dataMap, String fileName, String excelName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		dataMap.put("printTime", new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss", Locale.KOREA).format( new Date() ));
		
    	//다운로드 파일명
		String downFileName = fileName+"_"+ dataMap.get("printTime") +".xlsx";

		final String TEMPLATE_PATH = request.getSession().getServletContext().getRealPath("assets"+File.separator+"jxls");
		File file = new File( TEMPLATE_PATH + File.separator + excelName+".xlsx");

		LOGGER.debug("엑셀을 다운로드 합니다(/qxerpynm/event/admEventExcelDownload.do) UPLOAD_HOME= "+ TEMPLATE_PATH + ", filePath= "+ file.getAbsolutePath() + ", fileSize= "+ file.length());
		
        Context context = new Context();
        
        
		Iterator<String> iter = dataMap.keySet().iterator();
		while( iter.hasNext() ){
			String key = iter.next();
			context.putVar( key , dataMap.get(key) );
		}
		
		InputStream is = null;
		BufferedOutputStream os = null;

		try {
			is = new BufferedInputStream(new FileInputStream(file));
			os = new BufferedOutputStream(response.getOutputStream());
	
			response.setContentType("application/x-msdownload");
			response.setHeader("Set-Cookie", "fileDownload=true; path=/");
			setDisposition(downFileName, request, response);

			JxlsHelper.getInstance().processTemplate(is, os, context);
			LOGGER.debug(downFileName+" 엑셀 생성 완료!");
		}catch(FileNotFoundException f){
			LOGGER.debug("템플릿 파일을 찾을 수 없음!");
		}catch(IOException i){
			LOGGER.debug("템플릿 파일에 쓰기 실패!");
		}finally{
			EgovResourceCloseHelper.close(os, is);
		}
	}

	/**
	 * Disposition 지정하기.
	 * 
	 * @param filename
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public static void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) {  // IE11 문자열 깨짐 방지
			   encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("EUC-KR"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			//throw new RuntimeException("Not supported browser");
			throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

		if ("Opera".equals(browser)){
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}
	
	public static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
            return "Trident";
        } else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}
	
}
