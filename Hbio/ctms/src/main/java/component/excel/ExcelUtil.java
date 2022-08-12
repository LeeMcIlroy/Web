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

import java.util.List;
import java.util.ArrayList;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

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
import egovframework.rte.psl.dataaccess.util.EgovMap;

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

	//일괄 업로드 item 시험제품 rs 연구과제  plan 연구계획서 
	public List<EgovMap> getExcelUploadData(String filePath, String uploadType) throws Exception {
		
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		
		//String[] colNmArr = {
				//"corpCd"			// 회사고유번호	                  
				//,"rsNo1"			// 연구고유번호
				//,"rsNo2"			// 임상종류
				//,"rsNo3"			// 임상분류
				//,"rsNo4"			// 프로토콜
				//,"rsNo5"			// 연구연도
				//,"rsNo6"			// 임상번호
				//,"rsNo7"			// 차수
				//,"regDt"			// 등록일자
				//,"vendNo"			// 거래처번호
				//,"vmngName"			// 거래처담당자명
				//,"vmnghpNo"			// 거래처담당자휴대폰
				//,"vmngEmail"		// 거래처담당자이메일
				//,"itemCls"			// 제품정보
				//,"itemName"			// 제품명       
		//};
		
		String[] colNmArr = getExcelColNmArr(uploadType);
		
		List<EgovMap> list = new ArrayList<EgovMap>();
		FileInputStream fis= null; 
		XSSFWorkbook workbook = null;
		
		try {
			fis=new FileInputStream(new File(UPLOAD_HOME, filePath));
			workbook = new XSSFWorkbook(fis);
			
			XSSFSheet sheet = workbook.getSheetAt(0);
			
			//결과 변수
			StringBuffer errorStr = new StringBuffer();
			errorStr.append("");
			
			//행의 수
			int rows=sheet.getPhysicalNumberOfRows();
			for(int rowindex=1; rowindex<rows; rowindex++){
			    //행을읽는다
			    XSSFRow row=sheet.getRow(rowindex);
			    if(row !=null){
			        //셀의 수
			        int cells=row.getPhysicalNumberOfCells();
			        
			        EgovMap result = new EgovMap();
			        
			        for(int columnindex=0; columnindex<=(colNmArr.length-1); columnindex++){
				        	//셀값을 읽는다
				            XSSFCell cell=row.getCell(columnindex);

				            String value = "";
				            int cellType = 6;
				            
				            //셀이 빈값일경우를 위한 널체크
				            if(cell!=null){
				            	cellType = cell.getCellType();
				            	if(cellType == 0 ) {
				            		value = String.valueOf(cell.getNumericCellValue());
				            		value = value.replace(".0", "");
				            	}else {
				            		value = cell.getStringCellValue();
				            	}
				           }
				           result.put(colNmArr[columnindex], value.trim());  
			         }
			         list.add(result);			        
			    }
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(fis!=null) fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public String[] getExcelColNmArr(String uploadType) throws Exception {
		
		String[] colNmArr;
		int arrCnt = 0;
		if(uploadType.equals("item")) {
			arrCnt = 16;
		}else if(uploadType.equals("rs")) {
			arrCnt = 15;
		}else if(uploadType.equals("plan")) {
			arrCnt = 25;
		}else if(uploadType.equals("cs")) {
			arrCnt = 9;
		}else if(uploadType.equals("in")) {
			arrCnt = 6;
		}else if(uploadType.equals("ast")) {
			arrCnt = 11;
		}else if(uploadType.equals("sj")) {
			arrCnt = 11;
		}
			
		colNmArr = new String[arrCnt];
		if(uploadType.equals("item")) {
			String[] colNmArr2 = {
					"corpCd"			// 회사고유번호	                  
					,"rsNo1"			// 연구고유번호
					,"rsNo2"			// 임상종류
					,"rsNo3"			// 임상분류
					,"rsNo4"			// 프로토콜
					,"rsNo5"			// 연구연도
					,"rsNo6"			// 임상번호
					,"rsNo7"			// 차수
					,"itemCls"			// 제품정보
					,"itemName"			// 제품명   
					,"inhDt"			// 입고일자
					,"outDt"			// 반출일자
					,"sendDt"			// 발송일자
					,"reDt"				// 회수일자
					,"reYn"				// 회수여부
					,"dispoDt"			// 폐기일자
			};
			colNmArr = colNmArr2;
		}else if(uploadType.equals("rs")) {
			String[] colNmArr2 = {
					"corpCd"			// 회사고유번호	                  
					,"rsNo1"			// 연구고유번호
					,"rsNo2"			// 임상종류
					,"rsNo3"			// 임상분류
					,"rsNo4"			// 프로토콜
					,"rsNo5"			// 연구연도
					,"rsNo6"			// 임상번호
					,"rsNo7"			// 차수
					,"regDt"			// 등록일자
					,"vendNo"			// 거래처번호
					,"vmngName"			// 거래처담당자명
					,"vmnghpNo"			// 거래처담당자휴대폰
					,"vmngEmail"		// 거래처담당자이메일
					,"itemCls"			// 제품정보
					,"itemName"			// 제품명       
			};
			colNmArr = colNmArr2;
		}else if(uploadType.equals("plan")) {
			String[] colNmArr2 = {
					"corpCd"			// 회사고유번호	                  
					,"rsNo1"			// 연구고유번호
					,"rsNo2"			// 임상종류
					,"rsNo3"			// 임상분류
					,"rsNo4"			// 프로토콜
					,"rsNo5"			// 연구연도
					,"rsNo6"			// 임상번호
					,"regDt"			// 등록일자
					,"rsMscnt"			// 모집인원
					,"rsplDt"			// 연구계획서일자
					,"rsitDt"			// 시험물질확인일
					,"rsirbDt"			// IRB승인일
					,"rsrStdt"			// 연구대상자모집시작일
					,"rsrEndt"			// 연구대상자모집종료일
					,"rsStdt"			// 연구시작일자
					,"rsEndt"			// 연구종료일자
					,"rep2Dt"			// 초안보고일
					,"repDt"			// 최종보고일
					,"rsstCls"			// 연구상태
					,"visitCnt"			// 방문횟수
					,"duplYn"			// 중복참여여부
					,"rsName"			// 연구명
					,"rsPps"			// 연구목적
					,"rsPtc"			// 연구방법
					,"irbsmYn"			// IRB승인필요
			};
			colNmArr = colNmArr2;
		}else if(uploadType.equals("cs")) {
			String[] colNmArr2 = {
					"corpCd"			// 회사고유번호	                  
					,"csDt"				// 상담일
					,"vendNo"			// 고객사
					,"csCls"			// 상담분류
					,"csCont"			// 상담내용
					,"rcsName"			// 담당자
					,"rcsTel"			// 담당자연락처
					,"rcsEmail"			// 담당자이메일
					,"remk"				// 비고					
			};
			colNmArr = colNmArr2;
		}else if(uploadType.equals("in")) {
			String[] colNmArr2 = {
					"corpCd"			// 회사고유번호	                  
					,"ctrtCd"			// 계약번호
					,"inDt"				// 입금일
					,"reciDt"			// 세금계산서일
					,"inAmt"			// 입금액
					,"remk"				// 비고					
			};
			colNmArr = colNmArr2;
		}else if(uploadType.equals("ast")) {
			String[] colNmArr2 = {
					"corpCd"			// 회사고유번호	                  
					,"astName"			// 자산명
					,"astCls"			// 자산구분
					,"fctvName"			// 제조사
					,"pchvName"			// 구매처
					,"pchDt"			// 구매일자
					,"pchAmt"			// 구매가격
					,"pchAmtvt"			// 부가세
					,"pchTamt"			// 합계
					,"useYn"			// 사용여부
					,"remk"				// 비고
			};
			colNmArr = colNmArr2;
		}else if(uploadType.equals("sj")) {
			String[] colNmArr2 = {
					"corpCd"			// 회사고유번호	                  
					,"rsNo1"			// 연구고유번호
					,"rsNo2"			// 임상종류
					,"rsNo3"			// 임상분류
					,"rsNo4"			// 프로토콜
					,"rsNo5"			// 연구연도
					,"rsNo6"			// 임상번호
					,"rsiNo"			// 식별번호
					,"rsjName"			// 이름
					,"genYn"			// 성별
					,"age"				// 나이
			};
			colNmArr = colNmArr2;
		}
		
		return colNmArr;
	}
	
	
}
