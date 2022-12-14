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
import hsDesign.adm.cmmBoard.AdmCmmBoardDAO;
import hsDesign.adm.enter.brodata.AdmBroDataDAO;
import hsDesign.adm.general.info.AdmGeneralInfoDAO;
import hsDesign.adm.majorBoard.AdmMajorBoardDAO;
import hsDesign.adm.majorBoard.teacher.AdmMajorBoardTeacherDAO;
import hsDesign.adm.webtoon.AdmWebtoonDAO;
import hsDesign.usr.cmm.CmmDAO;
import hsDesign.valueObject.BrodataVO;
import hsDesign.valueObject.CBUpfileVO;
import hsDesign.valueObject.CmmBoardVO;
import hsDesign.valueObject.GEUpfileVO;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.WebtoonVO;

@Controller
public class CmmnFileController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmnFileController.class);

	@Resource private CmmnFileMngUtil fileUtil;
    @Resource(name = "propertiesService") protected EgovPropertyService propertyService;
    
    @Autowired private AdmCmmBoardDAO admCmmBoardDAO;
    @Autowired private AdmGeneralInfoDAO admGeneralInfoDAO;
    @Autowired private CmmDAO cmmDAO;
    @Autowired private AdmMajorBoardDAO admMajorBoardDAO;
    @Autowired private AdmMajorBoardTeacherDAO admTeacherDAO;
    @Autowired private AdmBroDataDAO admBroDataDAO;
    @Autowired private AdmWebtoonDAO admWebtoonDAO;

	//??????????????? ??????
	@RequestMapping("/showImage.do")
	public void showImage(String filePath, HttpServletResponse response) throws Exception {
		LOGGER.debug("showImage.do ("+filePath+")");
		if( EgovStringUtil.isEmpty(filePath) ){
			LOGGER.debug("????????????????????? ???????????? ????????????. ("+filePath+")");
			return;
		}
		String replFileName = EgovWebUtil.filePathBlackList(filePath);
		LOGGER.debug("/showImage.do = replFileName : "+replFileName);
		String uploadHome = propertyService.getString("Globals.fileStorePath.attachedFile");
		fileUtil.getImageInf(uploadHome, replFileName, response);
	}

	//??????????????? ??????
	@RequestMapping("/showVideo.do")
	public void showVideo(String filePath, HttpServletResponse response) throws Exception {
		LOGGER.debug("showVideo.do ("+filePath+")");
		if( EgovStringUtil.isEmpty(filePath) ){
			LOGGER.debug("????????????????????? ???????????? ????????????. ("+filePath+")");
			return;
		}
		String replFileName = EgovWebUtil.filePathBlackList(filePath);
		LOGGER.debug("/showVideo.do = replFileName : "+replFileName);
		String uploadHome = propertyService.getString("Globals.fileStorePath.attachedFile");
		fileUtil.getVideoInf(uploadHome, replFileName, response);
	}

	/** 
	 * ??????????????????
	 * @param fileId
	 * @param type
	 */
	@RequestMapping("/cmmn/file/downloadFile.do")
//	public String downloadFile(@RequestParam String fileId, HttpServletRequest request, HttpServletResponse response) throws Exception {
	public String downloadFile(@RequestParam String fileId, @RequestParam String type, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.debug("?????? ????????????! : "+fileId);
		/*
		 * filePath & fileName ??? ?????? ??? ??????!
		 * */
		String filePath = "";
		String fileName = "";
		EgovMap fileInfoVO = null;
		
		if("CMMBOARD".equals(type)){
			CBUpfileVO cbUpfileVO = admCmmBoardDAO.selectCmmBoardUpfileOne(fileId);
			filePath = cbUpfileVO.getCbupSaveFilepath();
			fileName = cbUpfileVO.getCbupOriginFilename();
		}else if("CMMBOARD_THUMB".equals(type)){
			CmmBoardVO cmmBoardVO = admCmmBoardDAO.selectCmmBoardOne(fileId);
			filePath = cmmBoardVO.getCbThImgPath();
			fileName = cmmBoardVO.getCbThImgName();
		}else if("GENERALEDU".equals(type)){
			GEUpfileVO geUpfileVO = admGeneralInfoDAO.selectGeneralInfoUpfileOne(fileId);
			filePath = geUpfileVO.getGeupSaveFilepath();
			fileName = geUpfileVO.getGeupOriginFilename();
		}else if("old".equals(type)) {
			MajorBoardVO majorBoardVO = admMajorBoardDAO.selectMajorBoardOne(fileId);
			filePath = majorBoardVO.getMbthImgPath();
			fileName = majorBoardVO.getMbthImgName();
			
		}else if("major".equals(type)) {
			MajorBoardVO majorBoardVO = admMajorBoardDAO.selectMajorBoardOne(fileId);
			filePath = majorBoardVO.getMbthImgPath();
			fileName = majorBoardVO.getMbthImgName();
			
			
		}else if("majorFile".equals(type)) {
			
			MajorBoardVO majorBoardVO = admMajorBoardDAO.selectMajorBoardFileOne(fileId);
	
			filePath = majorBoardVO.getMbthFilePath();
			fileName = majorBoardVO.getMbthFileName();
		}else if("teacher".equals(type)) {
			EgovMap teacherVO = admTeacherDAO.selectTeacherUpfileOne(fileId);
			filePath = teacherVO.get("tcupSaveFilepath").toString();
			fileName = teacherVO.get("tcupOriginFilename").toString();
		}else if("BRODATA".equals(type)){
			BrodataVO brodataVO = admBroDataDAO.selectBroDataOne(fileId);
			filePath = brodataVO.getBdSaveFilePath();
			fileName = brodataVO.getBdOriginFileName();
		}else if("WEBTOON_THUMB".equals(type)){
			WebtoonVO webtoonVO = admWebtoonDAO.selectWebtoonOne(fileId);
			filePath = webtoonVO.getwThImgPath();
			fileName = webtoonVO.getwThImgName();
		}
		
		
		filePath = EgovStringUtil.isEmpty(filePath)? fileInfoVO.get("upSaveFilePath").toString() : filePath;
		fileName = EgovStringUtil.isEmpty(fileName)? fileInfoVO.get("upOriginFileName").toString() : fileName;


		if( EgovStringUtil.isEmpty(filePath) || EgovStringUtil.isEmpty(fileName) ){ //????????????
			LOGGER.debug(fileId +" ?????? ?????? ??????!");
			return "/cmm/error.jsp";
		}
		
		String UPLOAD_HOME = "";
		if("old".equals(type)) {
			UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.oldImage");
		}else {
			
			UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		}

		File uFile = new File(UPLOAD_HOME, filePath);
		long fSize = uFile.length();

		if( fSize < 1 ){ //????????????
			LOGGER.debug(fileId +" ?????? ?????? ??????!");
			return "/cmm/error.jsp";
		}

		response.setContentType("application/x-msdownload");
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
	 * PDF ??????
	 * @param filePath
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/file/pdfOpen.do")
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
		} else if (browser.equals("Trident")) { // IE11 ????????? ?????? ??????
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
	}


	/**
	 * Disposition ????????????.
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
		} else if (browser.equals("Trident")) { // IE11 ????????? ?????? ??????
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
	 * ???????????? ?????? ??????.
	 *
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE11 ????????? ?????? ??????
			return "Trident";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}

	// (???)????????? ??????
	@RequestMapping("/showOldImage.do")
	public void showOldImage(String filePath, HttpServletResponse response) throws Exception {
		LOGGER.debug("/showOldImage.do : filePath = "+filePath);
		if( EgovStringUtil.isEmpty(filePath) ){
			LOGGER.warn("?????????????????? ???????????? ????????????. ("+filePath+")");
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

	}

	// ????????? ????????? ??????
	@RequestMapping("/showThumbImage.do")
	public void showThumbImage(String filePath, HttpServletResponse response) throws Exception {
		LOGGER.debug("????????? ??????! : " + filePath);
		String thumFilePath = CmmnFileMngUtil.getThumbName(filePath);
		
		if( EgovStringUtil.isEmpty(thumFilePath) ){
			LOGGER.warn("?????????????????? ???????????? ????????????. ("+thumFilePath+")");
			return;
		}

		String uploadHome = propertyService.getString("Globals.fileStorePath.attachedFile");

		fileUtil.getImageInf(uploadHome, thumFilePath, response);
	}
}
