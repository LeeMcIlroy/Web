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

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class ExcelDownUtil extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Calendar now = new GregorianCalendar();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH)+1;
        int date = now.get(Calendar.DAY_OF_MONTH);
        String strM = (month < 10)? "0"+month : ""+month;
        String strD = (date < 10)? "0"+date : ""+date;
		String exelName = "simplarmoryChkList_"+year+strM+strD;

		//한글깨짐 인코딩
		response.setHeader("Content-Disposition", "attachment; filename=\""+exelName+".xls\"");

		HSSFSheet sheet = workbook.createSheet("간이무기고점검이력");
		sheet.setDefaultColumnWidth(6);
		
		sheet.setColumnWidth(2, 21*256);
		sheet.setColumnWidth(6, 50*256);
		
		// Header
		HSSFCellStyle headerStyle = workbook.createCellStyle();
		HSSFFont headerFont = workbook.createFont();
		headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		headerFont.setFontHeightInPoints((short) 24);
		headerStyle.setFont(headerFont);
		headerStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		headerStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		headerStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		headerStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		headerStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		HSSFCell cell = null;
		cell = getCell(sheet, 1, 1);
		cell.setCellStyle(headerStyle);
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 6));
		setText(cell, "간이무기고점검이력");
		cell = getCell(sheet, 1, 2);
		cell.setCellStyle(headerStyle);
		cell = getCell(sheet, 1, 3);
		cell.setCellStyle(headerStyle);
		cell = getCell(sheet, 1, 4);
		cell.setCellStyle(headerStyle);
		cell = getCell(sheet, 1, 5);
		cell.setCellStyle(headerStyle);
		cell = getCell(sheet, 1, 6);
		cell.setCellStyle(headerStyle);
		
		// Title
		HSSFCellStyle titleStyle = workbook.createCellStyle();
		HSSFFont titleFont = workbook.createFont();
		titleFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		titleStyle.setFont(titleFont);
		titleStyle.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index);
		titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		titleStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		titleStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		int idxA = 1;
		drawCell(getCell(sheet, 2, idxA++), titleStyle, "번호");
		drawCell(getCell(sheet, 2, idxA++), titleStyle, "점검시간");
		drawCell(getCell(sheet, 2, idxA++), titleStyle, "직급");
		drawCell(getCell(sheet, 2, idxA++), titleStyle, "직책");
		drawCell(getCell(sheet, 2, idxA++), titleStyle, "점검자");
		drawCell(getCell(sheet, 2, idxA++), titleStyle, "비고");
		
		// Content
		HSSFCellStyle contentStyle = workbook.createCellStyle();
		contentStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		contentStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		contentStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		contentStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		contentStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		@SuppressWarnings("unchecked")
		List<EgovMap> resultList = (List<EgovMap>) model.get("resultList");
		
		int rowNo = 2;
		int num = 0;
		for(EgovMap vo : resultList){
			int idxB = 1;
			rowNo = rowNo + 1;
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, ++num +"" );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("checkDttm2").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("checkPolRankNm").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("checkRankType").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("checkPolName").toString() );
			drawCell(getCell(sheet, rowNo, idxB++), contentStyle, vo.get("checkNote").toString() );
		}
	}

	//제목셀 공통
	/*private void drawTitleCell(HSSFCell cell, HSSFCellStyle style, String value){
		cell.setCellStyle(style);
		cell.setCellValue(value);
	}*/

	//내용셀 공통
	private void drawCell(HSSFCell cell, HSSFCellStyle style, String value){
		cell.setCellStyle(style);
		cell.setCellValue(value);
	}
}
