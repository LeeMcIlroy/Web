package component.file;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AttachVO;

@Controller
public class CmmnFileController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmnFileController.class);

	@Resource private CmmnFileMngUtil fileUtil;
    @Resource(name = "propertiesService") protected EgovPropertyService propertyService;
    
    @Autowired private CmmDAO cmmDAO;

	//대표이미지 출력
	@RequestMapping("/showImage.do")
	public void showImage(String filePath, HttpServletResponse response) throws Exception {
		LOGGER.debug("showImage.do ("+filePath+")");
		if( EgovStringUtil.isEmpty(filePath) ){
			LOGGER.debug("이미지파일명이 존재하지 않습니다. ("+filePath+")");
			return;
		}
		String replFileName = EgovWebUtil.filePathBlackList(filePath);
		LOGGER.debug("/showImage.do = replFileName : "+replFileName);
		String uploadHome = propertyService.getString("Globals.fileStorePath.attachedFile");
		fileUtil.getImageInf(uploadHome, replFileName, response);
	}

	/** 
	 * 파일다운로드
	 * @param fileId
	 * @param type
	 */
	@RequestMapping("/cmmn/file/downloadFile.do")
//	public String downloadFile(@RequestParam String fileId, HttpServletRequest request, HttpServletResponse response) throws Exception {
	public String downloadFile(@RequestParam String fileId, @RequestParam String type, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("파일 다운로드! : "+fileId);
		/*
		 * filePath & fileName 값 세팅 후 사용!
		 * */
		String filePath = "";
		String fileName = "";
		
		AttachVO attachVO = cmmDAO.selectAttachOne(fileId);
		filePath = attachVO.getRegFileName();
		fileName = attachVO.getOrgFileName();

		if( EgovStringUtil.isEmpty(filePath) || EgovStringUtil.isEmpty(fileName) ){ //파일없음
			LOGGER.debug(fileId +" 해당 파일 없음!");
			return "/cmm/error.jsp";
		}
		
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");

		File uFile = new File(UPLOAD_HOME, filePath);
		long fSize = uFile.length();

		if( fSize < 1 ){ //파일없음
			LOGGER.debug(fileId +" 해당 파일 없음!");
			return "/cmm/error.jsp";
		}

		response.setContentType("application/octet-stream");
		//setDisposition(fileName, request, response);
		setDisposition(EgovStringUtil.removeCommaChar(fileName), request, response);

		BufferedInputStream in = null;
		BufferedOutputStream out = null;

		try {
			in = new BufferedInputStream(new FileInputStream(uFile));
			out = new BufferedOutputStream(response.getOutputStream());

			FileCopyUtils.copy(in, out);
			out.flush();
		} catch (Exception ex) {
			LOGGER.debug("IGNORED: {}", ex.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception ignore) {
					LOGGER.debug("IGNORED: {}", ignore.getMessage());
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (Exception ignore) {
					LOGGER.debug("IGNORED: {}", ignore.getMessage());
				}
			}
		}

		return null;

	}
	
	
	
	/**
	 * PDF 열기
	 * @param filePath
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping("/cmmn/file/pdfOpen.do")
	private String pdfOpen(String fileId, HttpServletRequest request, HttpServletResponse response ) throws Exception{
		
		String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.oldImage");
		
		EgovMap pdfVO = cmmDAO.selectPdfOne(fileId);
		
		String filePath = (String) pdfVO.get("pdfPath");
		String fileName = (String) pdfVO.get("pdfName");
		
		byte[] fileByte = FileUtils.readFileToByteArray(new File(UPLOAD_HOME + filePath));
		 
		response.setContentType("application/pdf");
		response.setContentLength(fileByte.length);
		
		String browser = getBrowser(request);

		String dispositionPrefix = "inline; fileName=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
			encodedFilename = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < fileName.length(); i++) {
				char c = fileName.charAt(i);
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

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
		 
		response.getOutputStream().write(fileByte);
		 
		response.getOutputStream().flush();
		response.getOutputStream().close();


		return null;
	}*/


	/**
	 * Disposition 지정하기.
	 *
	 * @param filename
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
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

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}

	/**
	 * 브라우저 구분 얻기.
	 *
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request) {
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

	/*// (구)이미지 출력
	@RequestMapping("/showOldImage.do")
	public void showOldImage(String filePath, HttpServletResponse response) throws Exception {
		LOGGER.debug("/showOldImage.do : filePath = "+filePath);
		if( EgovStringUtil.isEmpty(filePath) ){
			LOGGER.warn("이미지파일이 존재하지 않습니다. ("+filePath+")");
			return;
		}else{
			String uploadHome = propertyService.getString("Globals.fileStorePath.oldImage");

			if(!filePath.replace("/",  "\\").contains("\\")){
				String newFilePath = admCmmBoardDAO.selectShowOldImage(filePath);
				
				fileUtil.getImageInf(uploadHome, newFilePath, response);
			}else{
				
				fileUtil.getImageInf(uploadHome, filePath, response);
				
			}
		}

	}*/

	// 썸네일 이미지 출력
	@RequestMapping("/showThumbImage.do")
	public void showThumbImage(String filePath, HttpServletResponse response) throws Exception {
		LOGGER.debug("썸네일 출력! : " + filePath);
		String thumFilePath = CmmnFileMngUtil.getThumbName(filePath);
		
		if( EgovStringUtil.isEmpty(thumFilePath) ){
			LOGGER.warn("이미지파일이 존재하지 않습니다. ("+thumFilePath+")");
			return;
		}

		String uploadHome = propertyService.getString("Globals.fileStorePath.attachedFile");

		fileUtil.getImageInf(uploadHome, thumFilePath, response);
	}
	
	/** 
	 * 브로셔다운로드
	 * @param language
	 */
	@RequestMapping("/cmmn/file/downloadAmbFile.do")
//	public String downloadFile(@RequestParam String fileId, HttpServletRequest request, HttpServletResponse response) throws Exception {
	public String downloadBrochure(@RequestParam String file, @RequestParam String type, @RequestParam String ext, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("앰버서더 파일 다운로드! : "+file);
		
		final String UPLOAD_HOME = request.getSession().getServletContext().getRealPath("/qxsepmny/center/file/"+type+"/"+file+"."+ext);

		File uFile = new File(UPLOAD_HOME);
		long fSize = uFile.length();

		if( fSize < 1 ){ //파일없음
			LOGGER.debug(file +" 해당 파일 없음!");
			return "/cmm/error.jsp";
		}

		response.setContentType("application/x-msdownload");
		setDisposition(EgovStringUtil.removeCommaChar(file+"."+ext), request, response);

		BufferedInputStream in = null;
		BufferedOutputStream out = null;

		try {
			in = new BufferedInputStream(new FileInputStream(uFile));
			out = new BufferedOutputStream(response.getOutputStream());

			FileCopyUtils.copy(in, out);
			out.flush();
		} catch (Exception ex) {
			LOGGER.debug("IGNORED: {}", ex.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception ignore) {
					LOGGER.debug("IGNORED: {}", ignore.getMessage());
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (Exception ignore) {
					LOGGER.debug("IGNORED: {}", ignore.getMessage());
				}
			}
		}

		return null;

	}
}
