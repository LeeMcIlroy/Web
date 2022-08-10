package component.file;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @author songcw
 * @date 2016.10.17
 *  파일업로드
 *
 */
@Component
public class CmmnFileMngUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmnFileMngUtil.class);
    
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	/******************************* 공통 업로드 *******************************/
	public List<FileInfoVO> totUploadFiles(MultipartHttpServletRequest multiRequest, String folder) throws Exception {
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		List<FileInfoVO> fileInfoList = new ArrayList<>();
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				String fileName = tempFile.getOriginalFilename(); //파일명
				String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자(ex> jpg | fileName.substring(fileName.lastIndexOf(".")) = .jpg) 
				
				String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
				String filePath = File.separator + folder + File.separator + fileNm;
				
				tempFile.transferTo(new File( UPLOAD_HOME + filePath) );

				FileInfoVO fileInfoVO = new FileInfoVO();
				fileInfoVO.setFileName(fileName);
				fileInfoVO.setFilePath(filePath);
				fileInfoVO.setFileKey(entry.getKey());
				
				if(fileExtCheck(fileExt, "IMG")){
					/******* start 썸네일 업로드 *******/
					// 썸네일 가로, 세로 고정 업로드
					String fileThumbPath = thumbImageUpload1(filePath, 340, 280);
					// 썸네일 가로 고정, 세로 비율
					//String fileThumbPath = thumbImageUpload2(filePath, 250);
					// 썸네일 가로 비율, 세로 고정
					//String fileThumbPath = thumbImageUpload3(filePath, 500);
					// 썸네일 가로, 세로 원본 그대로
					//String fileThumbPath = thumbImageUpload4(filePath);
					/******* end 썸네일 업로드 *******/
					fileInfoVO.setFileThumbPath(fileThumbPath);
				}
				
				fileInfoList.add(fileInfoVO);
				
			}
		}
		
		return fileInfoList;
	}
	
	// 파일 용량 검사
	public boolean uploadFileSizeChk(MultipartHttpServletRequest multiRequest) throws Exception {
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				/******* start 파일 용량검사 *******/
				int maxSize = 15*1024*1024; // 15MB
				if (!fileSizeCheck(tempFile.getSize(), maxSize)) { // 파일 용량 검사
					LOGGER.debug("파일 용량이 초과되었습니다. ("+tempFile.getSize()+")");
					return false;
				}
				/******* end 파일 용량검사 *******/
			}
		}
		
		return true;
	}
	
	// 파일 확장자 검사
	public boolean uploadFileExtChk(MultipartHttpServletRequest multiRequest) throws Exception {
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				/******* start 파일 확장자 검사 *******/
				String fileName = tempFile.getOriginalFilename(); //파일명
				String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
				if (!fileExtCheck(fileExt, "FILE") && !fileExtCheck(fileExt, "IMG")) { // 파일 확장자 검사
					LOGGER.debug("파일 확장자가 잘못되었습니다. ("+fileExt+")");
					return false;
				}
				/******* end 파일 확장자 검사 *******/
			}
		}
		
		return true;
	}
	
	// 파일 업로드 여부
	public boolean uploadFileRegiChk(MultipartHttpServletRequest multiRequest) throws Exception {
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				return true;
			}
		}
		return false;
	}
	
	/******************************* 파일 업로드 *******************************/
	// 파일 조건 검사
	public boolean uploadFileCheck(MultipartHttpServletRequest multiRequest) throws Exception {
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				/******* start 파일 용량검사 *******/
				int maxSize = 15*1024*1024; // 15MB
				if (!fileSizeCheck(tempFile.getSize(), maxSize)) { // 파일 용량 검사
					LOGGER.debug("파일 용량이 초과되었습니다. ("+tempFile.getSize()+")");
					return false;
				}
				/******* end 파일 용량검사 *******/
				
				/******* start 파일 확장자 검사 *******/
				String fileName = tempFile.getOriginalFilename(); //파일명
				String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
				if (!fileExtCheck(fileExt, "FILE")) { // 파일 확장자 검사
					LOGGER.debug("파일 확장자가 잘못되었습니다. ("+fileExt+")");
					return false;
				}
				/******* end 파일 확장자 검사 *******/
			}
		}
		
		return true;
	}
	
	//단일파일업로드
	public FileInfoVO uploadAttachedFile(MultipartHttpServletRequest multiRequest, String folder, String boardSeq) throws Exception {
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		FileInfoVO fileInfoVO = null;
		
		//대상이 되는 partFile 구하기
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){

				/******* start 파일 용량검사 *******/
				int maxSize = 5*1024*1024; // 5MB
				if (!fileSizeCheck(tempFile.getSize(), maxSize)) { // 파일 용량 검사
					LOGGER.debug("파일 용량이 초과되었습니다. ("+tempFile.getSize()+")");
					return null;
				}
				/******* end 파일 용량검사 *******/
				
				/******* start 파일 확장자 검사 *******/
				String fileName = tempFile.getOriginalFilename(); //파일명
				String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
				if (!fileExtCheck(fileExt, "FILE")) { // 파일 확장자 검사
					LOGGER.debug("파일 확장자가 잘못되었습니다. ("+fileExt+")");
					return null;
				}
				/******* end 파일 확장자 검사 *******/
				
				String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
				String filePath = File.separator + folder + File.separator + fileNm;

				tempFile.transferTo(new File( UPLOAD_HOME + filePath) );

				fileInfoVO = new FileInfoVO();
				fileInfoVO.setFileName(fileName);
				fileInfoVO.setFilePath(filePath);
				
				return fileInfoVO;
			}
		}
		//end 뽑아낸 대상을 업로드하기
		
		return fileInfoVO;
	}
	
	//다중파일업로드
	public List<FileInfoVO> uploadAttachedFiles(MultipartHttpServletRequest multiRequest, String folder) throws Exception {
//		public List<FileInfoVO> uploadAttachedFiles(MultipartHttpServletRequest multiRequest, String folder, String usrId) throws Exception {
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		List<FileInfoVO> fileInfoList = new ArrayList<>();

		//대상이 되는 partFile 구하기
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				String fileName = tempFile.getOriginalFilename(); //파일명
				String fileExt = fileName.substring(fileName.lastIndexOf(".")); // 확장자
				
				String fileNm = EgovStringUtil.getTimeStamp() + fileExt;
				String filePath = File.separator + folder + File.separator + fileNm;
				
				tempFile.transferTo(new File( UPLOAD_HOME + filePath) );

				FileInfoVO fileInfoVO = new FileInfoVO();
				fileInfoVO.setFileName(fileName);
				fileInfoVO.setFilePath(filePath);
				
				fileInfoList.add(fileInfoVO);
			}
		}
		//end 뽑아낸 대상을 업로드하기

		return fileInfoList;
	}
	
	
	/******************************* 이미지만 업로드 *******************************/ 
	
	//단일이미지업로드(공통)
	public FileInfoVO uploadAttachedImgFile(MultipartHttpServletRequest multiRequest, String folder) throws Exception {
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		FileInfoVO fileInfoVO = null;

		//대상이 되는 partFile 구하기
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){

				/******* start 파일 용량검사 *******/
				int maxSize = 15*1024*1024; // 15MB
				if (!fileSizeCheck(tempFile.getSize(), maxSize)) { // 파일 용량 검사
					LOGGER.debug("파일 용량이 초과되었습니다. ("+tempFile.getSize()+")");
					return null;
				}
				/******* end 파일 용량검사 *******/
				
				/******* start 파일 확장자 검사 *******/
				String fileName = tempFile.getOriginalFilename(); //파일명
				String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
				if (!fileExtCheck(fileExt, "IMG")) { // 파일 확장자 검사
					LOGGER.debug("파일 확장자가 잘못되었습니다. ("+fileExt+")");
					return null;
				}
				/******* end 파일 확장자 검사 *******/
				
				String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
//				String filePath = File.separator + folder + File.separator + fileNm;
				String filePath = '/' + folder + '/' + fileNm;

				tempFile.transferTo(new File( UPLOAD_HOME + filePath) );

				fileInfoVO = new FileInfoVO();
				fileInfoVO.setFileName(fileName);
				fileInfoVO.setFilePath(filePath);
				
				/******* start 썸네일 업로드 *******/
				// 썸네일 가로, 세로 고정 업로드
				//String fileThumbPath = thumbImageUpload1(filePath, 500, 500);
				// 썸네일 가로 고정, 세로 비율
				//String fileThumbPath = thumbImageUpload2(filePath, 500);
				// 썸네일 가로 비율, 세로 고정
				//String fileThumbPath = thumbImageUpload3(filePath, 500);
				// 썸네일 가로, 세로 원본 그대로
				String fileThumbPath = thumbImageUpload4(filePath);
				/******* end 썸네일 업로드 *******/
				
				fileInfoVO.setFileThumbPath(fileThumbPath);
				return fileInfoVO;
			}
		}
		//end 뽑아낸 대상을 업로드하기

		return fileInfoVO;
	}

	
	// 이미지 확장자 검사
	public boolean uploadFileImgExtChk(MultipartHttpServletRequest multiRequest) throws Exception {
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				/******* start 파일 확장자 검사 *******/
				String fileName = tempFile.getOriginalFilename(); //파일명
				String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
				if (!fileExtCheck(fileExt, "IMG")) { // 파일 확장자 검사
					LOGGER.debug("파일 확장자가 잘못되었습니다. ("+fileExt+")");
					return false;
				}
				/******* end 파일 확장자 검사 *******/
			}
		}
		
		return true;
	}

	//다중이미지업로드
	public Map<String, FileInfoVO> uploadAttachedImgFiles(MultipartHttpServletRequest multiRequest, String folder) throws Exception {
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		Map<String, FileInfoVO> filePathList = new HashMap<String, FileInfoVO>();

		//대상이 되는 partFile 구하기
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				/******* start 파일 용량검사 *******/
				int maxSize = 15*1024*1024; // 15MB
				if (!fileSizeCheck(tempFile.getSize(), maxSize)) { // 파일 용량 검사
					LOGGER.debug("파일 용량이 초과되었습니다. ("+tempFile.getSize()+")");
					return null;
				}
				/******* end 파일 용량검사 *******/
				
				/******* start 파일 확장자 검사 *******/
				String fileName = tempFile.getOriginalFilename(); //파일명
				String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
				if (!fileExtCheck(fileExt, "IMG")) { // 파일 확장자 검사
					LOGGER.debug("파일 확장자가 잘못되었습니다. ("+fileExt+")");
					return null;
				}
				/******* end 파일 확장자 검사 *******/
				
				String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
				String filePath = File.separator + folder + File.separator + fileNm;
				
				tempFile.transferTo(new File( UPLOAD_HOME + filePath) );

				FileInfoVO fileInfoVO = new FileInfoVO();
				fileInfoVO.setFileName(fileName);
				fileInfoVO.setFilePath(filePath);
				
				/******* start 썸네일 업로드 *******/
				// 썸네일 가로, 세로 고정 업로드
				//String fileThumbPath = thumbImageUpload1(filePath, 500, 500);
				// 썸네일 가로 고정, 세로 비율
				//String fileThumbPath = thumbImageUpload2(filePath, 500);
				// 썸네일 가로 비율, 세로 고정
				//String fileThumbPath = thumbImageUpload3(filePath, 500);
				// 썸네일 가로, 세로 원본 그대로
				String fileThumbPath = thumbImageUpload4(filePath);
				/******* end 썸네일 업로드 *******/
				fileInfoVO.setFileThumbPath(fileThumbPath);
				
				filePathList.put(entry.getKey(), fileInfoVO);
			}
		}
		//end 뽑아낸 대상을 업로드하기

		return filePathList;
	}

	/**
	 * (공통유틸) 파일을 업로드한다.
	 */
	public FileInfoVO uploadFile(MultipartFile multipartFile, String uploadHome, String boardType, String boardSeq, int fileKey) throws IllegalStateException, IOException{

		String fileName = multipartFile.getOriginalFilename();
	    String fileExt = fileName.substring(fileName.lastIndexOf("."));

	    String filePath = boardType + File.separator + boardSeq + "_" + EgovStringUtil.getTimeStamp() + fileKey + fileExt;
		multipartFile.transferTo(new File( uploadHome + File.separator + filePath) );

		FileInfoVO fileVO = new FileInfoVO();
		fileVO.setFileBoardType(boardType); //게시판구분
		fileVO.setFileBoardSeq(boardSeq); //게시글번호
		fileVO.setFileName( multipartFile.getOriginalFilename() ); //클라이언트에 저장되어 있던 파일명
		fileVO.setFilePath(filePath); //기본경로를 제외한 업로드경로

		LOGGER.warn("업로드파일정보 = "+fileVO.toString());
		return fileVO;
	}


	//파일삭제1
	public String deleteFile(String fileDeletePath) {

		// 인자값 유효하지 않은 경우 블랭크 리턴
		if (fileDeletePath == null || fileDeletePath.equals("")) {
			return "";
		}
		String result = "";

		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");

		File file = new File(filePathBlackList( UPLOAD_HOME + fileDeletePath ));
		if (file.isFile()) {
			result = deletePath( UPLOAD_HOME + fileDeletePath );
		} else {
			result = "";
		}
		//썸네일 삭제 추가
		
		return result;
	}
	//파일삭제2
	public String deletePath(String filePath) {
		File file = new File(filePathBlackList(filePath));
		String result = "";

		if (file.exists()) {
			result = file.getAbsolutePath();
			if (!file.delete()) {
				result = "";
			}
		}

		return result;
	}
	//파일삭제3
	public String filePathBlackList(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

		return returnValue;
	}

	//이미지를 출력한다
    public void getImageInf(String uploadHome, String filePath, HttpServletResponse response) throws Exception {

    	//실제파일의 전체경로
    	String storeFilePath = uploadHome + File.separator + filePath;
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

			boolean flag = false;
			LOGGER.debug("filePath : "+filePath);
	    	int pos = filePath.lastIndexOf( "." );
	    	String fileExt = filePath.substring( pos + 1 );
			if (fileExt != null && !"".equals(fileExt)) {
			    if ("jpg".equals(fileExt.toLowerCase()) || "jpeg".equals(fileExt.toLowerCase())) {
			    	type = "image/jpeg";
			    	flag = true;
			    } else if ( "gif".equals(fileExt.toLowerCase()) || "png".equals(fileExt.toLowerCase()) || "bmp".equals(fileExt.toLowerCase()) ) {
			    	type = "image/" + fileExt.toLowerCase();
			    	flag = true;
			    } else {
			    	LOGGER.info("이미지가 아닌 다른 확장자 파일 요청. ("+fileExt.toLowerCase()+")");
			    }
			} else {
				LOGGER.debug("Image fileType is null.");
			}

			if (flag) {
				response.setHeader("Content-Type", type);
				response.setContentLength(bStream.size());

				String encoderFileName = URLEncoder.encode(filePath, "utf-8");
				response.setHeader("Content-Disposition", "attachment; filename="+encoderFileName);
				LOGGER.debug("★★★★★★★ getImageinf : Content-Disposition - fileName = "+encoderFileName);
				bStream.writeTo(response.getOutputStream());

				response.getOutputStream().flush();
				response.getOutputStream().close();
			}else {
				LOGGER.info("파일을 찾을 수 없습니다. ("+storeFilePath+")");
			}

		} catch (FileNotFoundException fnfe){
			LOGGER.info("파일을 찾을 수 없습니다. ("+storeFilePath+", "+fnfe.getMessage()+")");
		} finally {
			EgovResourceCloseHelper.close(bStream, in, fis);
			response.getOutputStream().close();
		}
    }

    //섬네일 파일명 가져오기
	public static String getThumbName(String filePath){
		int pos = filePath.lastIndexOf(".");
		String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
		LOGGER.info("★★★ 썸네일 파일명 : "+thumbnailName+" ★★★");
		return thumbnailName;
	}


	/** 
	 * 파일 용량 검사
	 * @param fileSize 검사대상
	 * @param maxSize 기준 사이즈
	 * @return 통과 true | 실패 false
	 */
	public boolean fileSizeCheck(long fileSize, int maxSize) throws Exception {
		if (fileSize < maxSize) {
			return true;
		}
		LOGGER.info("★★★ 검사대상 파일 용량("+fileSize+")이 기준 maxSize("+maxSize+")를 초과하였습니다. ★★★");
		return false;
	}
	
	/**
	 * 파일 확장자 검사
	 * @param fileExt
	 * @return 통과 true | 실패 false
	 */
	@SuppressWarnings("unused")
	public boolean fileExtCheck(String fileExt, String type) throws Exception {
		
		if ("IMG".equals(type)) {
			if ("PNG".equals(fileExt.toUpperCase()) || "BMP".equals(fileExt.toUpperCase()) || "JPG".equals(fileExt.toUpperCase()) 
					|| "GIF".equals(fileExt.toUpperCase()) || "JPEG".equals(fileExt.toUpperCase())) {
				return true;
			}
		}else if ("FILE".equals(type)) {
			if ("PNG".equals(fileExt.toUpperCase()) || "BMP".equals(fileExt.toUpperCase()) || "JPG".equals(fileExt.toUpperCase()) 
				|| "GIF".equals(fileExt.toUpperCase()) || "JPEG".equals(fileExt.toUpperCase()) || "HWP".equals(fileExt.toUpperCase())
				|| "DOC".equals(fileExt.toUpperCase()) || "DOCX".equals(fileExt.toUpperCase()) || "TXT".equals(fileExt.toUpperCase())
				|| "PPT".equals(fileExt.toUpperCase()) || "PPTX".equals(fileExt.toUpperCase()) || "PDF".equals(fileExt.toUpperCase())
				|| "XLS".equals(fileExt.toUpperCase()) || "XLSX".equals(fileExt.toUpperCase()) || "AI".equals(fileExt.toUpperCase())){
				return true;
			}
		}
		
		LOGGER.info("★★★ 지정된 파일 확장자가 아닙니다.("+fileExt.toUpperCase()+") ★★★");
		return false;
	}
	
	/**
	 * 파일 확장자 검사2
	 * @param fileExt 파일확장자
	 * @param stdFileExt 기준이 될 확장자
	 * @return 통과 true | 실패 false
	 */
	public boolean fileExtCheck2(String fileExt, String stdFileExt){
		if (stdFileExt.contains(",")) {
			// 기준이 여러개
			String[] arrStdFileExt = stdFileExt.split(",");
			for(String ext : arrStdFileExt){
				if( (ext.toUpperCase()).equals(fileExt.toUpperCase()) ){
					return true;
				}
			}
		}else{
			// 기준이 하나
			if( (stdFileExt.toUpperCase()).equals(fileExt.toUpperCase()) ){
				return true;
			}
			
		}
		return false;
	}
	
	/**
	 * 썸네일 이미지1 ( 가로, 세로 고정 )
	 * @param originFilePath 원본파일 경로
	 * @param fixWidth 가로
	 * @param fixHeight 세로
	 * @return 썸네일이미지 경로
	 */
	@SuppressWarnings("unused")
	private String thumbImageUpload1(String originFilePath, int fixWidth, int fixHeight){
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		String fileThumbPath = "";
		try {
			File originFile = new File( UPLOAD_HOME + originFilePath );
			BufferedImage bi = ImageIO.read(originFile);
			
			fileThumbPath = getThumbName(originFilePath);
	
			//생성할 썸네일파일의 경로+썸네일파일명
			final File thumb_file_name = new File(UPLOAD_HOME + fileThumbPath);
			LOGGER.info("썸네일 파일 : "+thumb_file_name);
			final BufferedImage buffer_original_image = ImageIO.read(originFile);
			final BufferedImage buffer_thumbnail_image = new BufferedImage(fixWidth,  fixHeight, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = buffer_thumbnail_image.createGraphics();
			graphic.drawImage(buffer_original_image, 0, 0, fixWidth, fixHeight, null);
			ImageIO.write(buffer_thumbnail_image, "jpg", thumb_file_name);
		} catch (IOException e) {
			LOGGER.error("method : thumbImageUpload1");
			LOGGER.error("썸네일 생성 오류 : "+e.getMessage());
		}

		return fileThumbPath;
	}
	
	/**
	 * 썸네일 이미지2 ( 가로 고정, 세로 비율에 맞게 )
	 * @param originFilePath 원본파일 경로
	 * @param width 가로
	 * @return 썸네일 이미지 경로
	 */
	@SuppressWarnings("unused")
	private String thumbImageUpload2(String originFilePath, int width){
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		String fileThumbPath = "";
		try {
			File originFile = new File( UPLOAD_HOME + originFilePath );
			BufferedImage bi = ImageIO.read(originFile);
			
			//원본파일의 가로, 세로
			final double origin_width = bi.getWidth();
			final double origin_height = bi.getHeight();

			//섬네일의 가로, 세로(비율에 맞게 조절)
			final int custom_width = width;
			final int custom_height = (int) Math.round((custom_width*origin_height)/origin_width);
			
			fileThumbPath = getThumbName(originFilePath);
	
			//생성할 썸네일파일의 경로+썸네일파일명
			final File thumb_file_name = new File(UPLOAD_HOME + fileThumbPath);
			LOGGER.info("썸네일 파일 : "+thumb_file_name);
			final BufferedImage buffer_original_image = ImageIO.read(originFile);
			final BufferedImage buffer_thumbnail_image = new BufferedImage(custom_width,  custom_height, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = buffer_thumbnail_image.createGraphics();
			graphic.drawImage(buffer_original_image, 0, 0, custom_width, custom_height, null);
			ImageIO.write(buffer_thumbnail_image, "jpg", thumb_file_name);
		} catch (IOException e) {
			LOGGER.error("method : thumbImageUpload2");
			LOGGER.error("썸네일 생성 오류 : "+e.getMessage());
		}
		return fileThumbPath;
	}

	/**
	 * 썸네일 이미지3 ( 가로 비율, 세로 고정 )
	 * @param originFilePath 원본 파일 경로
	 * @param height 세로
	 * @return 썸네일 이미지 경로
	 */
	@SuppressWarnings("unused")
	private String thumbImageUpload3(String originFilePath, int height){
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		String fileThumbPath = "";
		try {
			File originFile = new File( UPLOAD_HOME + originFilePath );
			BufferedImage bi = ImageIO.read(originFile);
			
			//원본파일의 가로, 세로
			final double origin_width = bi.getWidth();
			final double origin_height = bi.getHeight();

			//섬네일의 가로, 세로(비율에 맞게 조절)
			final int custom_height = height;
			final int custom_width = (int) Math.round((origin_width*custom_height)/origin_height);
			
			fileThumbPath = getThumbName(originFilePath);
	
			//생성할 썸네일파일의 경로+썸네일파일명
			final File thumb_file_name = new File(UPLOAD_HOME + fileThumbPath);
			LOGGER.info("썸네일 파일 : "+thumb_file_name);
			final BufferedImage buffer_original_image = ImageIO.read(originFile);
			final BufferedImage buffer_thumbnail_image = new BufferedImage(custom_width,  custom_height, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = buffer_thumbnail_image.createGraphics();
			graphic.drawImage(buffer_original_image, 0, 0, custom_width, custom_height, null);
			ImageIO.write(buffer_thumbnail_image, "jpg", thumb_file_name);
		} catch (IOException e) {
			LOGGER.error("method : thumbImageUpload3");
			LOGGER.error("썸네일 생성 오류 : "+e.getMessage());
		}
		return fileThumbPath;
	}
	
	/**
	 * 썸네일 이미지4 ( 가로, 세로 원본 그대로 )
	 * @param originFilePath 원본 파일 경로
	 * @return 썸네일 이미지 경로
	 * @throws IOException 
	 */
	@SuppressWarnings("unused")
	private String thumbImageUpload4(String originFilePath) throws IOException{
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		String fileThumbPath = "";
		File originFile = new File( UPLOAD_HOME + originFilePath );
		BufferedImage bi = null;
		try {
			bi = ImageIO.read(originFile);
			
		} catch (Exception e) {
			LOGGER.error("method : thumbImageUpload4");
			LOGGER.error("first = 썸네일 생성 오류 : "+e.getMessage());
			
			Iterator readers = ImageIO.getImageReadersByFormatName("JPEG");
			ImageReader reader = null;
			while (readers.hasNext()) {
				reader = (ImageReader) readers.next();
				if (reader.canReadRaster()) {
					break;
				}
			}

			// Stream the image file (the original CMYK image)
			ImageInputStream input = null;
			try {
				input = ImageIO.createImageInputStream(originFile);
				reader.setInput(input);
				
				// Read the image raster
				Raster raster = reader.readRaster(0, null);
				
				// Create a new RGB image
				//bi = new BufferedImage(raster.getWidth(), raster.getHeight(), BufferedImage.TYPE_4BYTE_ABGR);
				bi = new BufferedImage(raster.getWidth(), raster.getHeight(), BufferedImage.TYPE_3BYTE_BGR);
				
				// Fill the new image with the old raster
				bi.getRaster().setRect(raster);
				
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}finally{
				input.close();
			}
			
		}
		
		//원본파일의 가로, 세로
		final int origin_width = bi.getWidth();
		final int origin_height = bi.getHeight();
		
		fileThumbPath = getThumbName(originFilePath);
		
		try {
			//생성할 썸네일파일의 경로+썸네일파일명
			final File thumb_file_name = new File(UPLOAD_HOME + fileThumbPath);
			LOGGER.info("썸네일 파일 : "+thumb_file_name);
			
			final BufferedImage buffer_thumbnail_image = new BufferedImage(origin_width,  origin_height, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = buffer_thumbnail_image.createGraphics();
			graphic.drawImage(bi, 0, 0, origin_width, origin_height, null);
			ImageIO.write(buffer_thumbnail_image, "jpg", thumb_file_name);
		} catch (IOException e) {
			LOGGER.error("third = 썸네일 생성 오류 : "+e.getMessage());
		}
		
		return fileThumbPath;
	}
/*
	2017-12-28 이미지 CMYK타입은 ImageIO 클래스로 읽어올 수 없음...
	그에 따라 메소드 변경, 라이브러리도 추가 (pom.xml or lib > jpeg-cmyk-1.1.0.jar)
	
	private String thumbImageUpload4(String originFilePath){
		String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		String fileThumbPath = "";
		try {
			File originFile = new File( UPLOAD_HOME + originFilePath );
			BufferedImage bi = ImageIO.read(originFile);
			
			//원본파일의 가로, 세로
			int origin_width = bi.getWidth();
			int origin_height = bi.getHeight();
			
			fileThumbPath = getThumbName(originFilePath);
			
			//생성할 썸네일파일의 경로+썸네일파일명
			File thumb_file_name = new File(UPLOAD_HOME + fileThumbPath);
			LOGGER.info("썸네일 파일 : "+thumb_file_name);
			BufferedImage buffer_original_image = ImageIO.read(originFile);
			BufferedImage buffer_thumbnail_image = new BufferedImage(origin_width,  origin_height, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D graphic = buffer_thumbnail_image.createGraphics();
			graphic.drawImage(buffer_original_image, 0, 0, origin_width, origin_height, null);
			ImageIO.write(buffer_thumbnail_image, "jpg", thumb_file_name);
		} catch (IOException e) {
			LOGGER.error("method : thumbImageUpload4");
			LOGGER.error("썸네일 생성 오류 : "+e.getMessage());
		}
		return fileThumbPath;
	}
*/
	
	/******************************* 기타 *******************************/
	
	/**
	 * 라이팅팁스 전용 파일업로드 (대표이미지, PDF)
	 * @param writingtipsVO
	 * @param folder
	 * @param multiRequest
	 */
	public Map<String, FileInfoVO> writingtipsFileUpload(MultipartHttpServletRequest multiRequest, String folder) throws Exception {
		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
		Map<String, FileInfoVO> fileInfoList = new HashMap<>();
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			MultipartFile tempFile = entry.getValue(); //파일객체
			if( !tempFile.isEmpty() ){
				String tagName = tempFile.getName();
				LOGGER.debug("★★★★★★★★★★★★★★★★"+tagName);
				
				if ("titleImg".equals(tagName)) {
					// 대표이미지
					LOGGER.debug("★★★★★★★대표이미지★★★★★★★");
					/******* start 파일 용량검사 *******/
					int maxSize = 5*1024*1024; // 5MB
					if (!fileSizeCheck(tempFile.getSize(), maxSize)) { // 파일 용량 검사
						LOGGER.debug("파일 용량이 초과되었습니다. ("+tempFile.getSize()+")");
						continue;
					}
					/******* end 파일 용량검사 *******/
					
					/******* start 파일 확장자 검사 *******/
					String fileName = tempFile.getOriginalFilename(); //파일명
					String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
					if (!fileExtCheck(fileExt, "IMG")) { // 파일 확장자 검사
						LOGGER.debug("파일 확장자가 잘못되었습니다. ("+fileExt+")");
						continue;
					}
					/******* end 파일 확장자 검사 *******/
					
					String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
					String filePath = File.separator + folder + File.separator + fileNm;

					tempFile.transferTo(new File( UPLOAD_HOME + filePath) );
					
					// vo 대표이미지정보 set
					FileInfoVO fileInfoVO = new FileInfoVO();
					fileInfoVO.setFileName(fileName);
					fileInfoVO.setFilePath(filePath);
					String fileThumbPath = thumbImageUpload4(filePath);

					fileInfoVO.setFileThumbPath(fileThumbPath);
					
					fileInfoList.put(tagName, fileInfoVO);
					
				}else if("attachedFile_PDF".equals(tagName)){
					// PDF파일
					LOGGER.debug("★★★★★★★PDF파일★★★★★★★");
					/******* start 파일 용량검사 *******/
					int maxSize = 5*1024*1024; // 5MB
					if (!fileSizeCheck(tempFile.getSize(), maxSize)) { // 파일 용량 검사
						LOGGER.debug("파일 용량이 초과되었습니다. ("+tempFile.getSize()+")");
						continue;
					}
					/******* end 파일 용량검사 *******/
					
					/******* start 파일 확장자 검사 *******/
					String fileName = tempFile.getOriginalFilename(); //파일명
					String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
					if (!fileExtCheck2(fileExt, "PDF")) { // 파일 확장자 검사
						LOGGER.debug("파일 확장자가 잘못되었습니다. ("+fileExt+")");
						continue;
					}
					/******* end 파일 확장자 검사 *******/
					
					String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
					String filePath = File.separator + folder + File.separator + fileNm;

					tempFile.transferTo(new File( UPLOAD_HOME + filePath) );
					
					// vo PDF정보 set
					FileInfoVO fileInfoVO = new FileInfoVO();
					fileInfoVO.setFileName(fileName);
					fileInfoVO.setFilePath(filePath);
					
					fileInfoList.put(tagName, fileInfoVO);
					
				}else{
					LOGGER.debug("지정된 태그명이 아닙니다. ("+tagName+")");
					continue;
				}
			}
		}
		return fileInfoList;
	}
}
