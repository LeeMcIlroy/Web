package hsDesign.adm.majorBoard;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmMajorBoardController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmMajorBoardController.class);
	@Autowired private AdmMajorBoardDAO admMajorBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	@Resource View jsonView;
	
	// 말머리 목록
	@RequestMapping("/qxerpynm/majorBoard/admMajorHeadList.do")
	public View admMajorHeadList(ModelMap model, String mmSeq)throws Exception{
		LOGGER.info("/qxerpynm/majorBoard/admMajorHeadList.do - 관리자 > 전공 > 말머리목록");
		LOGGER.debug("mmSeq - "+mmSeq);
		
		List<EgovMap> listVO = admMajorBoardDAO.selectMajorHeadList(mmSeq);
		
		model.addAttribute("listVO", listVO);
		
		return jsonView;
	}
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/majorBoard/{dept}/{jspPage}List.do";
	}
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectEliteListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/qxerpynm/elite/{dept}/{jspPage}List.do";
	}
	
	
	
	// 목록
	@RequestMapping("/qxerpynm/majorBoard/{dept}/{jspPage}List.do")
	public String admMajorBoardList(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
									ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) {
		LOGGER.info("/qxerpynm/majorBoard/{dept}/{jspPage}List.do - 관리자 > 전공 > 목록", dept, jspPage);
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		String admMenuNo = "";
		String bCode = "";
		String joblog = "";
		if("interior".equals(dept) ){
			admMenuNo = "101";
			bCode = "01";
			joblog = "전공-실내디자인";
		}else if("visual".equals(dept) ) {
			admMenuNo = "102";
			bCode = "02";
			joblog = "전공-시각디자인";
		}else if("industrial".equals(dept) ) {
			admMenuNo = "103";
			bCode = "03";
			joblog = "전공-산업디자인";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "104";
			bCode = "04";
			joblog = "전공-디지털아트";
		}else if ("digitalEnt".equals(dept)) {	
		      admMenuNo = "10B";	
		      bCode = "11";	
		      joblog = "전공-디지털아트(디자인)";	
		}else if("fassion".equals(dept) ) {
			admMenuNo = "105";
			bCode = "05";
			joblog = "전공-패션디자인";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "106";
			bCode = "06";
			joblog = "전공-패션비즈니스";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "107";
			bCode = "07";
			joblog = "전공-미용학";
		}else if("beautyOne".equals(dept)){
			admMenuNo = "108";
			bCode = "08";
			joblog = "전공-미용학(oneday)";
		}
		session.setAttribute("admMenuNo", admMenuNo);
		searchVO.setSearchCondition1(bCode);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admMajorBoardDAO.selectMajorBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> boardCode = admMajorBoardDAO.selectBoardCodeList(bCode);
		model.addAttribute("boardCode", boardCode);
		
		if(!EgovStringUtil.isEmpty(searchVO.getSearchType())) {
			List<EgovMap> headList = admMajorBoardDAO.selectMajorHeadList(searchVO.getSearchType());
			model.addAttribute("headList", headList);
		}
		
		// 로그등록
		admLogInsert(null, joblog, "목록", request);
		
		return String.format("/adm/majorBoard/%s/%sList",dept,jspPage);
	}
	
	
	// 조회
	@RequestMapping("/qxerpynm/majorBoard/{dept}/{jspPage}View.do")
	public String admMajorBoardView(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
									ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, @RequestParam("mbSeq") String mbSeq, RedirectAttributes reda) {
		LOGGER.info("/qxerpynm/majorBoard/{dept}/{jspPage}View.do - 관리자 > 전공 > 조회", dept, jspPage);
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("mbSeq = "+mbSeq);
		
		String admMenuNo = "";
		String bCode = "";
		String joblog = "";
		if("interior".equals(dept) ){
			admMenuNo = "101";
			bCode = "01";
			joblog = "전공-실내디자인";
		}else if("visual".equals(dept) ) {
			admMenuNo = "102";
			bCode = "02";
			joblog = "전공-시각디자인";
		}else if("industrial".equals(dept) ) {
			admMenuNo = "103";
			bCode = "03";
			joblog = "전공-산업디자인";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "104";
			bCode = "04";
			joblog = "전공-디지털아트";
		}else if("fassion".equals(dept) ) {
			admMenuNo = "105";
			bCode = "05";
			joblog = "전공-패션디자인";
		}else if ("digitalEnt".equals(dept)) {	
		      admMenuNo = "10B";	
		      bCode = "11";	
		      joblog = "전공-디지털아트(디자인)";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "106";
			bCode = "06";
			joblog = "전공-패션비즈니스";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "107";
			bCode = "07";
			joblog = "전공-미용학";
		}else if("beautyOne".equals(dept)){
			admMenuNo = "108";
			bCode = "08";
			joblog = "전공-미용학(oneday)";
		}
		session.setAttribute("admMenuNo", admMenuNo);
		
		MajorBoardVO resultVO = admMajorBoardDAO.selectMajorBoardOne(mbSeq);
		
		if(resultVO == null) {
			String message = "게시글이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		
		resultVO.setMbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getMbContent())); // style 수정
		model.addAttribute("resultVO", resultVO);
		
		// 로그등록
		admLogInsert(null, joblog, mbSeq, request);
		
		return String.format("/adm/majorBoard/%s/%sView",dept,jspPage);
	}
	
	
	// 등록 & 수정화면
	@RequestMapping("/qxerpynm/majorBoard/{dept}/{jspPage}Modify.do")
	public String admMajorBoardModify(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
									String mbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/{dept}/{jspPage}Modify.do - 관리자 > 전공 > 등록&수정화면", dept, jspPage);
		LOGGER.debug("mbSeq = "+mbSeq);
		
		String admMenuNo = "";
		String bCode = "";
		if("interior".equals(dept) ){
			admMenuNo = "101";
			bCode = "01";
		}else if("visual".equals(dept) ) {
			admMenuNo = "102";
			bCode = "02";
		}else if("industrial".equals(dept) ) {
			admMenuNo = "103";
			bCode = "03";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "104";
			bCode = "04";
		}else if("fassion".equals(dept) ) {
			admMenuNo = "105";
			bCode = "05";
		}else if ("digitalEnt".equals(dept)) {	
		    admMenuNo = "10B";	
		    bCode = "11";
//			200417수정
//		}else if("fbusiness".equals(dept) ) {
//			admMenuNo = "106";
//			bCode = "06";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "107";
			bCode = "07";
		}else if("beautyOne".equals(dept)){
			admMenuNo = "108";
			bCode = "08";
		}
		
		MajorBoardVO majorBoardVO = null;
		
		List<EgovMap> bCodeList = admMajorBoardDAO.selectBoardCodeList(bCode);
		model.addAttribute("bCodeList", bCodeList);
		
		if(EgovStringUtil.isEmpty(mbSeq)){
			// 등록화면
			majorBoardVO = new MajorBoardVO();
		}else{
			// 수정화면
			majorBoardVO = admMajorBoardDAO.selectMajorBoardOne(mbSeq);
			
			List<EgovMap> listVO = admMajorBoardDAO.selectMajorHeadList(majorBoardVO.getMbGubun1());
			model.addAttribute("listVO", listVO);
		}
		model.addAttribute("majorBoardVO", majorBoardVO);
		
		return String.format("/adm/majorBoard/%s/%sModify",dept,jspPage);
	}
	

	/*// 등록&수정
	@RequestMapping("/qxerpynm/majorBoard/{dept}/{jspPage}Update.do")
	public String admMajorBoardUpdate(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
										MajorBoardVO majorBoardVO, MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") CmmnSearchVO searchVO,String fileType, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/majorBoard/{dept}/{jspPage}Update.do - 관리자 > 전공 >  등록&수정", dept, jspPage);
		LOGGER.debug("majorBoardVO = "+majorBoardVO.toString());
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		String admMenuNo = "";
		String bCode = "";
		String joblog = "";
		if("interior".equals(dept) ){
			admMenuNo = "101";
			bCode = "01";
			joblog = "전공-실내디자인";
		}else if("visual".equals(dept) ) {
			admMenuNo = "102";
			bCode = "02";
			joblog = "전공-시각디자인";
		}else if("industrial".equals(dept) ) {
			admMenuNo = "103";
			bCode = "03";
			joblog = "전공-산업디자인";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "104";
			bCode = "04";
			joblog = "전공-디지털아트";
		}else if("fassion".equals(dept) ) {
			admMenuNo = "105";
			bCode = "05";
			joblog = "전공-패션디자인";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "106";
			bCode = "06";
			joblog = "전공-패션비즈니스";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "107";
			bCode = "07";
			joblog = "전공-미용학";
		}else if("beautyOne".equals(dept)){
			admMenuNo = "108";
			bCode = "08";
			joblog = "전공-미용학(oneday)";
		}
		
		String message = "오류가 발생하였습니다.";
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbContent().trim())) {
			searchVO.setMessage("내용이 없습니다");
			return redirectListPage(message, searchVO, reda);
		}else if(EgovStringUtil.isEmpty(majorBoardVO.getMbTitle().trim())) {
			searchVO.setMessage("제목이 없습니다");
			return redirectListPage(message, searchVO, reda);
		}
		
		majorBoardVO.setMbTitle(EgovWebUtil.clearXSSMinimum(majorBoardVO.getMbTitle()));
		
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
			return redirectListPage(message, searchVO, reda);
		}
		
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSession");
		
		majorBoardVO.setMbRegSeq(adminVO.getAdmSeq());
		majorBoardVO.setMbRegName(adminVO.getAdmName());
		majorBoardVO.setmCode(bCode);
		String rsMbSeq = "";
		
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbSeq())){
			// 등록
			rsMbSeq = admMajorBoardDAO.insertMajorBoardOne(majorBoardVO);
						
			majorBoardVO.setMbSeq(rsMbSeq);
			message = "등록되었습니다.";
			// 로그등록
			admLogInsert(null, joblog+"등록", rsMbSeq, request);
			
		}else{
			// 수정
			
			// 썸네일 삭제
			if(
				!EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && !cmmnFileMngUtil.uploadFileRegiChk(multiRequest) ||
				EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && cmmnFileMngUtil.uploadFileRegiChk(multiRequest)
			){
				
				EgovMap upfile = admMajorBoardDAO.selectMajorBoardThumbOne(majorBoardVO.getMbthSeq());
				if("IMAGE".equals(upfile.get("mbthType").toString())){
					
					cmmnFileMngUtil.deleteFile(upfile.get("mbthImgPath").toString());	// 파일 삭제
					
					String filePath = upfile.get("mbthImgPath").toString();
					int pos = filePath.lastIndexOf(".");
					String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
					
					
					cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
					
				}
				admMajorBoardDAO.deleteMajorBoardThumbOne(majorBoardVO.getMbthSeq()); // 데이터 삭제
				
			}
			
			// 수정
			admMajorBoardDAO.updateMajorBoardOne(majorBoardVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, joblog+"수정", majorBoardVO.getMbSeq(), request);
		}
		// 썸네일 등록
		
		if(majorBoardVO.getMbthType().equals("IMAGE")) {
			// 썸네일이 이미지 타입
			List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest.getAttribute("attach"), "major");
			
			
			//List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "major");
			if(fileInfoList != null) {
				for(FileInfoVO vo : fileInfoList){
					majorBoardVO.setMbthImgName(vo.getFileName());
					majorBoardVO.setMbthImgPath(vo.getFilePath());
					majorBoardVO.setFileType("thumb");

					admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
				}
				
			}
			
		}else if(majorBoardVO.getMbthType().equals("VIDEO")) {
			// 썸네일이 비디오 타입
			admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
			
		}
		if(fileType.equals("FILE")) {
		
			// 첨부파일 등록
			List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "major");
			if(fileInfoList != null){
				for(FileInfoVO vo : fileInfoList){
					majorBoardVO.setMbthType(fileType);
					majorBoardVO.setMbthImgName(vo.getFileName());
					majorBoardVO.setMbthImgPath(vo.getFilePath());
					majorBoardVO.setFileType("file");
					admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
				}
			}
		}
		
		
		return redirectListPage(message, searchVO, reda);
	}*/
	// 등록&수정
		@RequestMapping("/qxerpynm/majorBoard/{dept}/{jspPage}Update.do")
		public String admMajorBoardUpdate(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
											MajorBoardVO majorBoardVO, MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") CmmnSearchVO searchVO,String fileType, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
			LOGGER.info("/qxerpynm/majorBoard/{dept}/{jspPage}Update.do - 관리자 > 전공 >  등록&수정", dept, jspPage);
			LOGGER.debug("majorBoardVO = "+majorBoardVO.toString());
			LOGGER.debug("searchVO = "+searchVO.toString());
			
			String admMenuNo = "";
			String bCode = "";
			String joblog = "";
			if("interior".equals(dept) ){
				admMenuNo = "101";
				bCode = "01";
				joblog = "전공-실내디자인";
			}else if("visual".equals(dept) ) {
				admMenuNo = "102";
				bCode = "02";
				joblog = "전공-시각디자인";
			}else if("industrial".equals(dept) ) {
				admMenuNo = "103";
				bCode = "03";
				joblog = "전공-산업디자인";
			}else if("digitalArt".equals(dept) ) {
				admMenuNo = "104";
				bCode = "04";
				joblog = "전공-디지털아트";
			}else if ("digitalEnt".equals(dept)) {	
			    admMenuNo = "10B";	
			    bCode = "11";	
			    joblog = "전공-디지털아트(디자인)";
			}else if("fassion".equals(dept) ) {
				admMenuNo = "105";
				bCode = "05";
				joblog = "전공-패션디자인";
			}else if("fbusiness".equals(dept) ) {
				admMenuNo = "106";
				bCode = "06";
				joblog = "전공-패션비즈니스";
			}else if("beauty".equals(dept) ) {
				admMenuNo = "107";
				bCode = "07";
				joblog = "전공-미용학";
			}else if("beautyOne".equals(dept)){
				admMenuNo = "108";
				bCode = "08";
				joblog = "전공-미용학(oneday)";
			}
			
			String message = "오류가 발생하였습니다.";
			if(EgovStringUtil.isEmpty(majorBoardVO.getMbContent().trim())) {
				searchVO.setMessage("내용이 없습니다");
				return redirectListPage(message, searchVO, reda);
			}else if(EgovStringUtil.isEmpty(majorBoardVO.getMbTitle().trim())) {
				searchVO.setMessage("제목이 없습니다");
				return redirectListPage(message, searchVO, reda);
			}
			
			majorBoardVO.setMbTitle(EgovWebUtil.clearXSSMinimum(majorBoardVO.getMbTitle()));
			
			// 첨부파일 조건확인
			boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
			if(!flag){
				LOGGER.debug("첨부된 파일이 잘못되었습니다.");
				searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
				return redirectListPage(message, searchVO, reda);
			}
			
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSession");
			
			majorBoardVO.setMbRegSeq(adminVO.getAdmSeq());
			majorBoardVO.setMbRegName(adminVO.getAdmName());
			majorBoardVO.setmCode(bCode);
			String rsMbSeq = "";
			
			if(EgovStringUtil.isEmpty(majorBoardVO.getMbSeq())){
				// 등록
				rsMbSeq = admMajorBoardDAO.insertMajorBoardOne(majorBoardVO);
							
				majorBoardVO.setMbSeq(rsMbSeq);
				message = "등록되었습니다.";
				// 로그등록
				admLogInsert(null, joblog+"등록", rsMbSeq, request);
				
			}else{
				// 수정
				
				// 썸네일 삭제
				if(
					!EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && !cmmnFileMngUtil.uploadFileRegiChk(multiRequest) ||
					EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && cmmnFileMngUtil.uploadFileRegiChk(multiRequest)
				){
					
					Map<String, MultipartFile> files = multiRequest.getFileMap();
					Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
					while (itr.hasNext()) {
						Entry<String, MultipartFile> entry = itr.next();
					 
						MultipartFile tempFile = entry.getValue(); //파일객체
						if( !tempFile.isEmpty() ){
							
							String fileName = tempFile.getOriginalFilename(); //파일명
							//String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자(ex> jpg | fileName.substring(fileName.lastIndexOf(".")) = .jpg) 
							
							//String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
							String filePath ="";
							//multipart로 가져오는 네임값이 썸네일이면
							if( !tempFile.getName().equals("attachedFile")){
								
								EgovMap upfile = admMajorBoardDAO.selectMajorBoardThumbOne(majorBoardVO.getMbthSeq());
	
								cmmnFileMngUtil.deleteFile(upfile.get("mbthImgPath").toString());	// 파일 삭제
								
								filePath = upfile.get("mbthImgPath").toString();
								int pos = filePath.lastIndexOf(".");
								String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
								
								
								cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
								
								admMajorBoardDAO.deleteMajorBoardThumbOne(majorBoardVO.getMbthSeq()); // 데이터 삭제
	
								 
							}else{
								//게시물의 등록된 첨부파일 가져오기
								EgovMap file = admMajorBoardDAO.selectMajorBoardFileList(majorBoardVO.getMbSeq());
	                            //첨부파일 삭제
								cmmnFileMngUtil.deleteFile(file.get("mbthImgPath").toString());	
								
								filePath = file.get("mbthImgPath").toString();
								int pos = filePath.lastIndexOf(".");
								fileName = filePath.substring(0,pos) + filePath.substring(pos);
	
								cmmnFileMngUtil.deleteFile(fileName);	
								//테이블 데이터 삭제
								admMajorBoardDAO.deleteMajorBoardThumbOne(file.get("mbthSeq").toString()); 
	
							}
					}
					/*EgovMap upfile = admMajorBoardDAO.selectMajorBoardThumbOne(majorBoardVO.getMbthSeq());
					if("IMAGE".equals(upfile.get("mbthType").toString())){
						
						cmmnFileMngUtil.deleteFile(upfile.get("mbthImgPath").toString());	// 파일 삭제
						
						String filePath = upfile.get("mbthImgPath").toString();
						int pos = filePath.lastIndexOf(".");
						String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
						
						
						cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
						
						admMajorBoardDAO.deleteMajorBoardThumbOne(majorBoardVO.getMbthSeq()); // 데이터 삭제
					}*/
					
					
					
					}
				}
				
				// 수정
				admMajorBoardDAO.updateMajorBoardOne(majorBoardVO);
				message = "수정되었습니다.";
				
				// 로그등록
				admLogInsert(null, joblog+"수정", majorBoardVO.getMbSeq(), request);
			}
			// 썸네일 / 첨부파일 등록
			
			if(majorBoardVO.getMbthType().equals("IMAGE")) {
				// 썸네일이 이미지 타입
				//List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "major");
				//FileInfoVO fileInfo = cmmnFileMngUtil.uploadAttachedFile(multiRequest, "major");

				List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles_major(multiRequest, "major");
				if(fileInfoList != null) {
					for(FileInfoVO vo : fileInfoList){
						if(vo.getFilePath().contains("majorFile")){
							
							majorBoardVO.setMbthType("FILE");
							majorBoardVO.setMbthImgName(vo.getFileName());
							majorBoardVO.setMbthImgPath(vo.getFilePath());
							
						}else{
							majorBoardVO.setMbthImgName(vo.getFileName());
							majorBoardVO.setMbthImgPath(vo.getFilePath());
						}
						
						admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
				
						}
					}
					
				
				/*if(fileInfo != null) {
					
							
							majorBoardVO.setMbthImgName(fileInfo.getFileName());
							majorBoardVO.setMbthImgPath(fileInfo.getFilePath());
	
							admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
							
						else{
							int index2 = vo.getFileName().lastIndexOf(".");
							vo.getFileName().substring( index2+1 );
							//String fileNm = EgovStringUtil.getTimeStamp() + "." + vo.getFileName().substring( index2+1 );

							majorBoardVO.setMbthType("FILE");
							majorBoardVO.setMbthImgName(vo.getFileName());
							majorBoardVO.setMbthImgPath(vo.getFilePath());
							admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
							
						}
	
				}*/
				
			}else if(majorBoardVO.getMbthType().equals("VIDEO")) {
				// 썸네일이 비디오 타입
				admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
				
			}
			
			return redirectListPage(message, searchVO, reda);
		}
	
	// 삭제
	@RequestMapping("/qxerpynm/majorBoard/{dept}/{jspPage}Delete.do")
	public String admMajorBoardDelete(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
										ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, String mbSeq)throws Exception{
		LOGGER.info("//qxerpynm/majorBoard/{dept}/{jspPage}Delete.do - 관리자 > 전공 > 삭제");
		LOGGER.debug("searchVO - "+searchVO);
		LOGGER.debug("mbSeq - "+mbSeq);
		
		String admMenuNo = "";
		String bCode = "";
		String joblog = "";
		if("interior".equals(dept) ){
			admMenuNo = "101";
			bCode = "01";
			joblog = "전공-실내디자인";
		}else if("visual".equals(dept) ) {
			admMenuNo = "102";
			bCode = "02";
			joblog = "전공-시각디자인";
		}else if("industrial".equals(dept) ) {
			admMenuNo = "103";
			bCode = "03";
			joblog = "전공-산업디자인";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "104";
			bCode = "04";
			joblog = "전공-디지털아트";
		}else if ("digitalEnt".equals(dept)) {	
	        admMenuNo = "10B";	
	        bCode = "11";	
	        joblog = "전공-디지털아트(디자인)";
		}else if("fassion".equals(dept) ) {
			admMenuNo = "105";
			bCode = "05";
			joblog = "전공-패션디자인";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "106";
			bCode = "06";
			joblog = "전공-패션비즈니스";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "107";
			bCode = "07";
			joblog = "전공-미용학";
		}else if("beautyOne".equals(dept)){
			admMenuNo = "108";
			bCode = "08";
			joblog = "전공-미용학(oneday)";
		}
		
		
		// 썸네일 첨부파일 삭제
		EgovMap upfileOne = admMajorBoardDAO.selectMajorBoardThumbList(mbSeq);
		if(!(upfileOne==null)){
			if(!EgovStringUtil.isEmpty(upfileOne.get("mbthImgPath").toString())) {
				
				cmmnFileMngUtil.deleteFile(upfileOne.get("mbthImgPath").toString());	// 파일 삭제
				
				String filePath = upfileOne.get("mbthImgPath").toString();
				int pos = filePath.lastIndexOf(".");
				String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
				
				
				cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
			}
			
			admMajorBoardDAO.deleteMajorBoardThumbOne(upfileOne.get("mbthSeq")+""); // 데이터 삭제
		}
		//첨부파일삭제
		EgovMap fileOne = admMajorBoardDAO.selectMajorBoardFileList(mbSeq);
		if(!(fileOne==null)){
			if(!EgovStringUtil.isEmpty(fileOne.get("mbthImgPath").toString())) {
				
				cmmnFileMngUtil.deleteFile(fileOne.get("mbthImgPath").toString());	// 파일 삭제
				
			}
			
			admMajorBoardDAO.deleteMajorBoardFileOne(fileOne.get("mbthSeq")+""); // 데이터 삭제
		}
		
		admMajorBoardDAO.deleteMajorBoardOne(mbSeq);// 주제 삭제
	
		searchVO.setMessage("삭제되었습니다.");
		
		// 로그등록
		admLogInsert(null, joblog+"삭제", mbSeq, request);
		
		return redirectListPage(searchVO.getMessage(), searchVO, reda);
	}
		

	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*******************************************일학습 엘리트과정*******************************************/
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 목록
	@RequestMapping("/qxerpynm/elite/{dept}/{jspPage}List.do")
	public String admEliteList(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
									ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request) {
		LOGGER.info("/qxerpynm/elite/{dept}/{jspPage}List.do - 관리자 > 일학습엘리트과정 > 목록", dept, jspPage);
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		String admMenuNo = "";
		String bCode = "";
		String joblog = "";
		if("interior".equals(dept) ){
			admMenuNo = "801";
			bCode = "11";
			joblog = "일학습엘리트과정-실내디자인";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "802";
			bCode = "12";
			joblog = "일학습엘리트과정-디지털아트";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "803";
			bCode = "13";
			joblog = "일학습엘리트과정-패션비즈니스";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "804";
			bCode = "14";
			joblog = "일학습엘리트과정-미용학";
		}
		session.setAttribute("admMenuNo", admMenuNo);
		searchVO.setSearchCondition1(bCode);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admMajorBoardDAO.selectMajorBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> boardCode = admMajorBoardDAO.selectBoardCodeList(bCode);
		model.addAttribute("boardCode", boardCode);
		
		if(!EgovStringUtil.isEmpty(searchVO.getSearchType())) {
			List<EgovMap> headList = admMajorBoardDAO.selectMajorHeadList(searchVO.getSearchType());
			model.addAttribute("headList", headList);
		}
		
		// 로그등록
		admLogInsert(null, joblog, "목록", request);
		
		return String.format("/adm/elite/%s/%sList",dept,jspPage);
	}
	
	
	// 조회
	@RequestMapping("/qxerpynm/elite/{dept}/{jspPage}View.do")
	public String admEliteView(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
									ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, @RequestParam("mbSeq") String mbSeq, RedirectAttributes reda) {
		LOGGER.info("/qxerpynm/elite/{dept}/{jspPage}View.do - 관리자 > 일학습엘리트과정 > 조회", dept, jspPage);
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("mbSeq = "+mbSeq);
		
		String admMenuNo = "";
		String bCode = "";
		String joblog = "";
		if("interior".equals(dept) ){
			admMenuNo = "801";
			bCode = "11";
			joblog = "일학습엘리트과정-실내디자인";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "802";
			bCode = "12";
			joblog = "일학습엘리트과정-디지털아트";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "803";
			bCode = "13";
			joblog = "일학습엘리트과정-패션비즈니스";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "804";
			bCode = "14";
			joblog = "일학습엘리트과정-미용학";
		}
		session.setAttribute("admMenuNo", admMenuNo);
		
		MajorBoardVO resultVO = admMajorBoardDAO.selectMajorBoardOne(mbSeq);
		
		if(resultVO == null) {
			String message = "게시글이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		
		resultVO.setMbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getMbContent())); // style 수정
		model.addAttribute("resultVO", resultVO);
		
		// 로그등록
		admLogInsert(null, joblog, mbSeq, request);
		
		return String.format("/adm/elite/%s/%sView",dept,jspPage);
	}
	
	
	// 등록 & 수정화면
	@RequestMapping("/qxerpynm/elite/{dept}/{jspPage}Modify.do")
	public String admEliteModify(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
									String mbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/elite/{dept}/{jspPage}Modify.do - 관리자 > 일학습엘리트과정 > 등록&수정화면", dept, jspPage);
		LOGGER.debug("mbSeq = "+mbSeq);
		
		String admMenuNo = "";
		String bCode = "";
		if("interior".equals(dept) ){
			admMenuNo = "801";
			bCode = "11";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "802";
			bCode = "12";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "803";
			bCode = "13";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "804";
			bCode = "14";
		}
		
		MajorBoardVO majorBoardVO = null;
		
		List<EgovMap> bCodeList = admMajorBoardDAO.selectBoardCodeList(bCode);
		model.addAttribute("bCodeList", bCodeList);
		
		if(EgovStringUtil.isEmpty(mbSeq)){
			// 등록화면
			majorBoardVO = new MajorBoardVO();
		}else{
			// 수정화면
			majorBoardVO = admMajorBoardDAO.selectMajorBoardOne(mbSeq);
			
			List<EgovMap> listVO = admMajorBoardDAO.selectMajorHeadList(majorBoardVO.getMbGubun1());
			model.addAttribute("listVO", listVO);
		}
		model.addAttribute("majorBoardVO", majorBoardVO);
		
		return String.format("/adm/elite/%s/%sModify",dept,jspPage);
	}
	

	// 등록&수정
	@RequestMapping("/qxerpynm/elite/{dept}/{jspPage}Update.do")
	public String admEliteUpdate(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
										MajorBoardVO majorBoardVO, MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/qxerpynm/elite/{dept}/{jspPage}Update.do - 관리자 > 일학습엘리트과정 >  등록&수정", dept, jspPage);
		LOGGER.debug("majorBoardVO = "+majorBoardVO.toString());
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		String admMenuNo = "";
		String bCode = "";
		String joblog = "";
		if("interior".equals(dept) ){
			admMenuNo = "801";
			bCode = "11";
			joblog = "일학습엘리트과정-실내디자인";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "802";
			bCode = "12";
			joblog = "일학습엘리트과정-디지털아트";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "803";
			bCode = "13";
			joblog = "일학습엘리트과정-패션비즈니스";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "804";
			bCode = "14";
			joblog = "일학습엘리트과정-미용학";
		}
		
		String message = "오류가 발생하였습니다.";
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbContent().trim())) {
			searchVO.setMessage("내용이 없습니다");
			return redirectListPage(message, searchVO, reda);
		}else if(EgovStringUtil.isEmpty(majorBoardVO.getMbTitle().trim())) {
			searchVO.setMessage("제목이 없습니다");
			return redirectListPage(message, searchVO, reda);
		}
		
		majorBoardVO.setMbTitle(EgovWebUtil.clearXSSMinimum(majorBoardVO.getMbTitle()));
		
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
			return redirectListPage(message, searchVO, reda);
		}
		
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSession");
		
		majorBoardVO.setMbRegSeq(adminVO.getAdmSeq());
		majorBoardVO.setMbRegName(adminVO.getAdmName());
		majorBoardVO.setmCode(bCode);
		String rsMbSeq = "";
		
		if(EgovStringUtil.isEmpty(majorBoardVO.getMbSeq())){
			// 등록
			rsMbSeq = admMajorBoardDAO.insertMajorBoardOne(majorBoardVO);
						
			majorBoardVO.setMbSeq(rsMbSeq);
			message = "등록되었습니다.";
			// 로그등록
			admLogInsert(null, joblog+"등록", rsMbSeq, request);
			
		}else{
			// 수정
			
			// 썸네일 삭제
			if(
				!EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && !cmmnFileMngUtil.uploadFileRegiChk(multiRequest) ||
				EgovStringUtil.isEmpty(majorBoardVO.getMbthUrl()) && cmmnFileMngUtil.uploadFileRegiChk(multiRequest)
			){
				
				EgovMap upfile = admMajorBoardDAO.selectMajorBoardThumbOne(majorBoardVO.getMbthSeq());
				if("IMAGE".equals(upfile.get("mbthType").toString())){
					
					cmmnFileMngUtil.deleteFile(upfile.get("mbthImgPath").toString());	// 파일 삭제
					
					String filePath = upfile.get("mbthImgPath").toString();
					int pos = filePath.lastIndexOf(".");
					String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
					
					
					cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
					
				}
				admMajorBoardDAO.deleteMajorBoardThumbOne(majorBoardVO.getMbthSeq()); // 데이터 삭제
				
			}
			
			// 수정
			admMajorBoardDAO.updateMajorBoardOne(majorBoardVO);
			message = "수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, joblog+"수정", majorBoardVO.getMbSeq(), request);
		}
		// 썸네일 등록
		
		if(majorBoardVO.getMbthType().equals("IMAGE")) {
			// 썸네일이 이미지 타입
			List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "major");
			
			
			//List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "major");
			if(fileInfoList != null) {
				for(FileInfoVO vo : fileInfoList){
					majorBoardVO.setMbthImgName(vo.getFileName());
					majorBoardVO.setMbthImgPath(vo.getFilePath());
					
					admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
				}
				
			}
			
		}else if(majorBoardVO.getMbthType().equals("VIDEO")) {
			// 썸네일이 비디오 타입
			admMajorBoardDAO.insertMajorBoardThumbOne(majorBoardVO);
		}
		
		
		return redirectEliteListPage(message, searchVO, reda);
	}
	
	
	// 삭제
	@RequestMapping("/qxerpynm/elite/{dept}/{jspPage}Delete.do")
	public String admEliteDelete(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
										ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, String mbSeq)throws Exception{
		LOGGER.info("//qxerpynm/elite/{dept}/{jspPage}Delete.do - 관리자 > 일학습엘리트과정 > 삭제");
		LOGGER.debug("searchVO - "+searchVO);
		LOGGER.debug("mbSeq - "+mbSeq);
		
		String admMenuNo = "";
		String bCode = "";
		String joblog = "";
		if("interior".equals(dept) ){
			admMenuNo = "801";
			bCode = "11";
			joblog = "일학습엘리트과정-실내디자인";
		}else if("digitalArt".equals(dept) ) {
			admMenuNo = "802";
			bCode = "12";
			joblog = "일학습엘리트과정-디지털아트";
		}else if("fbusiness".equals(dept) ) {
			admMenuNo = "803";
			bCode = "13";
			joblog = "일학습엘리트과정-패션비즈니스";
		}else if("beauty".equals(dept) ) {
			admMenuNo = "804";
			bCode = "14";
			joblog = "일학습엘리트과정-미용학";
		}
		
		
		// 첨부파일 삭제
			
		EgovMap upfileOne = admMajorBoardDAO.selectMajorBoardThumbList(mbSeq);
		if(!(upfileOne==null)){
			if(!EgovStringUtil.isEmpty(upfileOne.get("mbthImgPath").toString())) {
				
				cmmnFileMngUtil.deleteFile(upfileOne.get("mbthImgPath").toString());	// 파일 삭제
				
				String filePath = upfileOne.get("mbthImgPath").toString();
				int pos = filePath.lastIndexOf(".");
				String thumbnailName = filePath.substring(0,pos) + "_thumbnail" + filePath.substring(pos);
				
				
				cmmnFileMngUtil.deleteFile(thumbnailName);	// 썸네일 파일 삭제
			}
			
			admMajorBoardDAO.deleteMajorBoardThumbOne(upfileOne.get("mbthSeq")+""); // 데이터 삭제
		}
		admMajorBoardDAO.deleteMajorBoardOne(mbSeq);// 주제 삭제
	
		searchVO.setMessage("삭제되었습니다.");
		
		// 로그등록
		admLogInsert(null, joblog+"삭제", mbSeq, request);
		
		return redirectEliteListPage(searchVO.getMessage(), searchVO, reda);
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*******************************************일학습 엘리트과정*******************************************/
	/////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
}
