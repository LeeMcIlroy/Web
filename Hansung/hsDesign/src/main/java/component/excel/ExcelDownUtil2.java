package component.excel;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public class ExcelDownUtil2 extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Calendar now = new GregorianCalendar();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH)+1;
        int date = now.get(Calendar.DAY_OF_MONTH);
        String strM = (month < 10)? "0"+month : ""+month;
        String strD = (date < 10)? "0"+date : ""+date;
		String exelName = "totMngList_"+year+strM+strD;

		//한글깨짐 인코딩
		response.setHeader("Content-Disposition", "attachment; filename=\""+exelName+".xls\"");

		// sheet
		HSSFSheet sheet = workbook.createSheet("무기탄약출입고부");
		sheet.setDefaultColumnWidth(12);
		
		//sheet.setColumnWidth(2, 21*256);
		//sheet.setColumnWidth(6, 50*256);
		
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 12));
		sheet.addMergedRegion(new CellRangeAddress(2, 3, 1, 1));
		sheet.addMergedRegion(new CellRangeAddress(2, 3, 5, 5));
		sheet.addMergedRegion(new CellRangeAddress(2, 3, 6, 6));
		sheet.addMergedRegion(new CellRangeAddress(2, 3, 9, 9));
		sheet.addMergedRegion(new CellRangeAddress(2, 3, 10, 10));
		sheet.addMergedRegion(new CellRangeAddress(2, 3, 11, 11));
		sheet.addMergedRegion(new CellRangeAddress(2, 3, 12, 12));
		
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 2, 4));
		sheet.addMergedRegion(new CellRangeAddress(2, 2, 7, 8));
		
		// Header
		HSSFCellStyle headerStyle = workbook.createCellStyle();
		HSSFFont headerFont = workbook.createFont();
		setHeaderStyle(headerStyle, headerFont);
		
		int tmpNum = 1;
		drawCell(getCell(sheet, 1, tmpNum++), headerStyle, "간이무기고 무기 탄약 출입고부");
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		setCellStyle(getCell(sheet, 1, tmpNum++), headerStyle);
		
		// Title
		HSSFCellStyle titleStyle = workbook.createCellStyle();
		HSSFFont titleFont = workbook.createFont();
		setTitleStyle(titleStyle, titleFont);
		
		int idxA = 1;
		drawCell(getCell(sheet, 2, 1), titleStyle, "번호");
		drawCell(getCell(sheet, 2, 2), titleStyle, "대여자");
		drawCell(getCell(sheet, 2, 5), titleStyle, "총종");
		drawCell(getCell(sheet, 2, 6), titleStyle, "총번");
		drawCell(getCell(sheet, 2, 7), titleStyle, "탄약");
		drawCell(getCell(sheet, 2, 9), titleStyle, "출고시간");
		drawCell(getCell(sheet, 2, 10), titleStyle, "감독자확인");
		drawCell(getCell(sheet, 2, 11), titleStyle, "입고시간");
		drawCell(getCell(sheet, 2, 12), titleStyle, "감독자확인");
		
		
		setCellStyle(getCell(sheet, 3, 1), titleStyle);
		drawCell(getCell(sheet, 3, 2), titleStyle, "소속");
		drawCell(getCell(sheet, 3, 3), titleStyle, "계급");
		drawCell(getCell(sheet, 3, 4), titleStyle, "성명");
		setCellStyle(getCell(sheet, 3, 5), titleStyle);
		setCellStyle(getCell(sheet, 3, 6), titleStyle);
		drawCell(getCell(sheet, 3, 7), titleStyle, "실탄");
		drawCell(getCell(sheet, 3, 8), titleStyle, "공포탄");
		setCellStyle(getCell(sheet, 3, 9), titleStyle);
		setCellStyle(getCell(sheet, 3, 10), titleStyle);
		setCellStyle(getCell(sheet, 3, 11), titleStyle);
		setCellStyle(getCell(sheet, 3, 12), titleStyle);
		
		
		// Content
		HSSFCellStyle contentStyle = workbook.createCellStyle();
		setContentStyle(contentStyle);
		
		@SuppressWarnings("unchecked")
		List<EgovMap> resultList = (List<EgovMap>) model.get("resultList");
		
		// 행 5 열 2
		int rowNo = 3;
		int num = 0;
		for(EgovMap vo : resultList){
			int idxB = 1;
			rowNo = rowNo + 1;
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, ++num +"" );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneAppliPolOrgCd2").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneAppliPolRank2").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneAppliPolName").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneWpNm").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneWpNo").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneBullet1").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneBullet2").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneIoDttm2").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("oneSupPolName").toString() );
			if (vo.get("twoIoDttm2") != null){
				drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("twoIoDttm2").toString() ); 
			}else{
				drawCell(getCell(sheet, rowNo, idxB++), contentStyle, "" ); 
			}
			if (vo.get("twoSupPolName") != null) {
				drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("twoSupPolName").toString() ); 
			}else{
				drawCell(getCell(sheet, rowNo, idxB++), contentStyle, "" ); 
			}
		}
	}

	//제목셀 공통
	private void drawTitleCell(HSSFCell cell, HSSFCellStyle style, String value){
		cell.setCellStyle(style);
		cell.setCellValue(value);
	}

	//내용셀 공통
	private void drawCell(HSSFCell cell, Object value){
		cell.setCellValue(value+"");
	}
	
	// 셀 스타일 및 값 적용
	private void drawCell(HSSFCell cell, HSSFCellStyle style, String value){
		cell.setCellStyle(style);
		cell.setCellValue(value);
	}
	
	// 셀 스타일 적용
	private void setCellStyle(HSSFCell cell, HSSFCellStyle style){
		cell.setCellStyle(style);
	}
	
	// Header 스타일
	private void setHeaderStyle(HSSFCellStyle style, HSSFFont font){
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		font.setFontHeightInPoints((short) 24);
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		//style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		//style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		//style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	}
	
	// Title 스타일
	private void setTitleStyle(HSSFCellStyle style, HSSFFont font){
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		style.setFont(font);
		style.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	}
	
	// Content 스타일
	private void setContentStyle(HSSFCellStyle style){
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
	}
}
