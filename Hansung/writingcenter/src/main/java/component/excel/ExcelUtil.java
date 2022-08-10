package component.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import net.sf.jxls.transformer.XLSTransformer;

public class ExcelUtil extends AbstractExcelView{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ExcelUtil.class);
	
	final String EXCEL_HOME = "D:/WAS/2017/writingcenter/excel/";	// 개발
	//final String EXCEL_HOME = "/home/writer/excel/";	// 운영
	
	private String excelFileName = "consultCompleteList";
	
	public ExcelUtil(String type) {
		if(!EgovStringUtil.isEmpty(type)){
			excelFileName = type;
		}
	}
	
	
	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("************************* EXCEL_HOME = "+EXCEL_HOME);
		
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("content-Disposition", "attachedment; filename="+EgovStringUtil.getTimeStamp()+"_"+excelFileName+".xlsx");
		OutputStream os = null;
		InputStream is = null;
		
		try{
			File file = new File(EXCEL_HOME + File.separator + excelFileName +".xlsx");
			is = new FileInputStream(file);
			
			//is = new ClassPathResource("").getInputStream();
			os = response.getOutputStream();
			
			XLSTransformer transformer = new XLSTransformer();
			
			Workbook excel = transformer.transformXLS(is, model);
			excel.write(os);
			os.flush();
		}catch(IOException e){
			throw new RuntimeException(e.getMessage());
		}finally{
			if(os != null) os.close();
			if(is != null) is.close();
		}
		
	}
	
	

}
