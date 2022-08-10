package component.file;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class CkEditorFileController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CkEditorFileController.class);

	@Resource private CmmnFileMngUtil fileUtil;
	@Resource View jsonView;

    @Resource(name = "propertiesService") protected EgovPropertyService propertyService;

	/**
	 * 파일을 업로드합니다 (CKEditor 용)
	 * @param atchmnflName TNATCHMNFL 테이블의 ATCHMNFL_NAME과 매칭되는 파일명
	 * @return 파일 업로드
	 */
	@RequestMapping("/cmmn/ckeditor/uploadCkeditorFile.do")
	public String updatePoupImage(@RequestParam("upload") MultipartFile mFile, String CKEditorFuncNum, ModelMap model) throws Exception {

		String message = "";
		String filepath = "";

		LOGGER.error("CKEditorFuncNum="+CKEditorFuncNum);
		LOGGER.error("mFile="+mFile);
		if( mFile == null ){
			message = "파일이 확인되지 않습니다.";
		}else{
			int maxSize = 5*1024*1024;
			int pos = mFile.getOriginalFilename().lastIndexOf(".");
			String fileExt = mFile.getOriginalFilename().substring(pos+1).toUpperCase();
			if( mFile.isEmpty() || mFile.getSize() == 0 ){
				message = "파일의 사이즈가 0 입니다.";
			/*
			}else if (mFile.getSize() > maxSize) {
				message = "첨부된 파일의 용량이 초과하였습니다.";
			 */
			}else if (!"PNG".equals(fileExt) && !"BMP".equals(fileExt) && !"JPG".equals(fileExt) && !"GIF".equals(fileExt) ){
				message = "파일의 확장자를 확인해주세요.";
			}else{

				final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.ckeditor");
			    String newFileName = EgovStringUtil.getTimeStamp() + "_" + mFile.getOriginalFilename().replaceAll("\\+", "_");
				mFile.transferTo(new File( UPLOAD_HOME + File.separator + newFileName) );

				message = "업로드하였습니다.";
				filepath = propertyService.getString("Globals.domain") + "/cmmn/ckeditor/downloadCkeditorFile.do?fileName="+newFileName;
			}

		}
		LOGGER.error("CKEditorFuncNum="+CKEditorFuncNum);
		LOGGER.error("filepath="+filepath);
		LOGGER.error("message="+message);

		model.addAttribute("CKEditorFuncNum", CKEditorFuncNum);
		model.addAttribute("file_path", filepath);
		model.addAttribute("message", message);
		return "/cmm/fileUpload";
	}

	//(구)첨부이미지 출력
	@RequestMapping("/cmmn/ckeditor/showCkeditorOldImage.do")
	public void showCkeditorOldImage(@RequestParam String fileName, HttpServletResponse response) throws Exception {
		String uploadHome = propertyService.getString("Globals.fileStorePath.ckeditor") ;
		fileUtil.getImageInf(uploadHome, "old"+ File.separator + fileName, response);
	}

	/**
	 * 파일을 다운로드 합니다 (CKEditor 용)
	 * @param atchmnflName TNATCHMNFL 테이블의 ATCHMNFL_NAME과 매칭되는 파일명
	 * @return 파일 다운로드
	 */
	@RequestMapping("/cmmn/ckeditor/downloadCkeditorFile.do")
	public void downloadFile2(@RequestParam String fileName, HttpServletResponse response) throws Exception {
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.ckeditor");
		String replFileName = EgovWebUtil.filePathBlackList(fileName);
		LOGGER.debug("/downloadCkeditorFile.do = replFileName : "+replFileName);
		fileUtil.getImageInf(UPLOAD_HOME, replFileName, response);

		/*
		LOGGER.error("UPLOAD_HOME="+UPLOAD_HOME);
		LOGGER.error("fileName="+fileName);

    	//실제파일의 전체경로
    	String storeFilePath = UPLOAD_HOME + fileName;

		File file = null;
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;

		try {
		    file = new File(storeFilePath);
		    fis = new FileInputStream(file);

		    in = new BufferedInputStream(fis);
		    bStream = new ByteArrayOutputStream();

		    int imgByte;
		    while ((imgByte = in.read()) != -1) {
		    	bStream.write(imgByte);
		    }

			String type = "";
	    	int pos = fileName.lastIndexOf( "." );
	    	String fileExt = fileName.substring( pos + 1 );
			if (fileExt != null && !"".equals(fileExt)) {
			    if ("jpg".equals(fileExt.toLowerCase())) {
				type = "image/jpeg";
			    } else {
			    	type = "image/" + fileExt.toLowerCase();
			    }
			    type = "image/" + fileExt.toLowerCase();

			} else {
				LOGGER.debug("Image fileType is null.");
			}
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());

			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();

		} catch (FileNotFoundException fnfe){
			LOGGER.info("파일을 찾을 수 없습니다. ("+storeFilePath+", "+fnfe.getMessage()+")");
		} finally {
			EgovResourceCloseHelper.close(bStream, in, fis);
		}
		*/
	}   
	
	@RequestMapping(value = "/cmmn/ckeditor/uploadCkeditorDropFile.do", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public View uploadCkeditorDropFile(@RequestParam("upload") MultipartFile mFile, ModelMap model) {
        try {
        	if( mFile == null ){
    		}else{
    			int maxSize = 5*1024*1024;
    			int pos = mFile.getOriginalFilename().lastIndexOf(".");
    			String fileExt = mFile.getOriginalFilename().substring(pos+1).toUpperCase();
    			if( mFile.isEmpty() || mFile.getSize() == 0 ){
    			/*
    			}else if (mFile.getSize() > maxSize) {
    				message = "첨부된 파일의 용량이 초과하였습니다.";
    			 */
    			}else if (!"PNG".equals(fileExt) && !"BMP".equals(fileExt) && !"JPG".equals(fileExt) && !"GIF".equals(fileExt) ){
    				model.addAttribute("uploaded", 0);
    				model.addAttribute("error", "{'message': '파일 형식을 확인해 주세요.'}");
    			}else{
    				final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.ckeditor");
    			    String newFileName = EgovStringUtil.getTimeStamp() + "_" + mFile.getOriginalFilename();
    				mFile.transferTo(new File( UPLOAD_HOME + File.separator + newFileName) );
    				model.addAttribute("uploaded", 1);
    				model.addAttribute("url",(propertyService.getString("Globals.domain") + "/cmmn/ckeditor/downloadCkeditorFile.do?fileName="+newFileName));
    				model.addAttribute("fileName", newFileName);
    				model.addAttribute("alt", mFile.getOriginalFilename().substring(0, pos));
    			}
    		}
        } catch (Exception e) {
        	model.addAttribute("uploaded", 0);
        	model.addAttribute("error", "{'message': '" + e.getMessage() + "'}");
        }     
        return jsonView;
	} 

}
