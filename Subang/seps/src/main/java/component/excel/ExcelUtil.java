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
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import seps.valueObject.HotLineVO;
import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.string.EgovStringUtil;

@Component
public class ExcelUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(ExcelUtil.class);
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//엑셀다운로드
	public void getPerformanceExcel(Map<String, Object> dataMap, String fileName, String excelName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
    	//다운로드 파일명
		String downFileName = fileName+"_"+ new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA).format( new Date() ) +".xlsx";

		final String TEMPLATE_PATH = request.getSession().getServletContext().getRealPath("jxls");
		File file = new File( TEMPLATE_PATH + File.separator + excelName+".xlsx");

		LOGGER.debug("엑셀을 다운로드 합니다(/mgr/perf/getStatusExcel.do) UPLOAD_HOME= "+ TEMPLATE_PATH + ", filePath= "+ file.getAbsolutePath() + ", fileSize= "+ file.length());
		
        Context context = new Context();
        
        dataMap.put("printTime", new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss", Locale.KOREA).format( new Date() ));
        
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
	
	
	final String UPLOAD_HOME = "D:/WAS/2018/seps/upload/attachedFile/";
	// 핫라인용 엑셀 업로드 
	public Map<String, Object> getExcelUploadData(String filePath) throws Exception {
		
		FileInputStream fis=new FileInputStream(UPLOAD_HOME+filePath);
		XSSFWorkbook workbook=new XSSFWorkbook(fis);
		
		//결과 변수
		Map<String, Object> resultMap = new HashMap<>();
		List<HotLineVO> paramList = new ArrayList<HotLineVO>();
		StringBuffer errorStr = new StringBuffer();
		errorStr.append("");
		XSSFSheet sheet=workbook.getSheetAt(0);
		
		//행의 수
		int rows=sheet.getPhysicalNumberOfRows();
		for(int rowindex=1; rowindex<rows; rowindex++){
		    //행을읽는다
		    XSSFRow row=sheet.getRow(rowindex);
		    if(row !=null){
		        //셀의 수
		        int cells=row.getPhysicalNumberOfCells();
		        HotLineVO paramVO = new HotLineVO();
		        boolean flag = true;
		        for(int columnindex=0; columnindex<=cells; columnindex++){
		            //셀값을 읽는다
		            XSSFCell cell=row.getCell(columnindex);
		            //셀이 빈값일경우를 위한 널체크
		            if(cell==null){
		                continue;
		            }else{
		            	String tempVal = cell.getStringCellValue();
		            	if(!EgovStringUtil.isEmpty(tempVal)){
		            		switch (columnindex){
		            		case 1:
	            				paramVO.setHotLineDept(tempVal);
		            			break;
		            		case 2:
		            			paramVO.setHotLineName(tempVal);
		            			break;
		            		case 3:
		            			String[] tempArr = tempVal.split("-");
		            			if(tempVal.length()<=15 && tempVal.length()>=11 && tempArr.length==3){
		            				paramVO.setHotLineTel(tempVal);
		            			}else{
		            				LOGGER.debug((rowindex+1)+"열에 잘못된 형식의 연락처가 있습니다.");
		            				errorStr.append((rowindex+1)+"열에 잘못된 형식의 연락처가 있습니다.\r\n");
		            				flag = false;
		            			}
		            			break;
		            		case 4:
		            			if(tempVal.contains("@")){
		            				paramVO.setHotLineEmail(tempVal);
		            			}else{
		            				LOGGER.debug((rowindex+1)+"열에 잘못된 형식의 이메일이 있습니다.");
		            				errorStr.append((rowindex+1)+"열에 잘못된 형식의 이메일이 있습니다.\r\n");
		            				flag = false;
		            			}
		            			break;
		            		default:
		            			LOGGER.debug((rowindex+1)+"열에 잘못된 형식의 데이터가 있습니다.");
	            				errorStr.append((rowindex+1)+"열에 잘못된 형식의 데이터가 있습니다.\r\n");
	            				flag = false;
	            				break;
		            		}
		            	}
		            }
		        }
		        if(flag && !EgovStringUtil.isEmpty(paramVO.getHotLineDept())){
		        	paramList.add(paramVO);
		        }
		        flag = true;
		    }
		}
		
		resultMap.put("paramList", paramList);
		resultMap.put("errorStr", errorStr.toString());
		
		return resultMap;
		
	}
}
