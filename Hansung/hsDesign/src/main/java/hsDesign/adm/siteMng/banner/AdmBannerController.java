package hsDesign.adm.siteMng.banner;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.scripting.xmltags.TrimSqlNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.BannerVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmBannerController extends AdmCmmController  {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmBannerController.class);
	@Autowired private AdmBannerDAO admBannerDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	@Resource View jsonView;
	
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addAttribute("pageIndex", searchVO.getPageIndex());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition1", searchVO.getSearchCondition1());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition2", searchVO.getSearchCondition2());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchWord())) reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/qxerpynm/siteMng/banner/admBannerList.do";
	}
	
	//배너목록화면으로 리다이렉트합니다.
	private String redirectBannerList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/siteMng/banner/admBannerList.do";
	}

	/**
	 * 배너목록 화면으로 이동합니다.
	 * @param model
	 * @return 배너목록화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/banner/admBannerList.do")
	public String admBannerList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/banner/admBannerList.do - 배너목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "602");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1("M");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO result = admBannerDAO.selectAdmBannerList(searchVO);
		paginationInfo.setTotalRecordCount(result.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", result.getEgovList());
		
		// 로그등록
		admLogInsert(null, "배너", "목록", request);
		
		return "/adm/siteMng/banner/admBannerList";
	}
	
	/**
	 * 배너 등록&수정 화면으로 이동합니다.
	 * @param model
	 * @return 배너 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/banner/admBannerModify.do")
	public String admBannerModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String banSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/banner/admBannerModify.do - 배너 등록&수정 화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("banSeq = "+banSeq);
		
		if(banSeq.equals("0")){
			LOGGER.debug("신규 등록");
			BannerVO bannerVO = new BannerVO();
			bannerVO.setBanType(searchVO.getSearchCondition1());
			model.addAttribute("bannerVO", bannerVO);
		}else{
			LOGGER.debug("수정 조회");
			model.addAttribute("bannerVO", admBannerDAO.selectAdmBannerOne(banSeq));
		}
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/siteMng/banner/admBannerModify";
	}
	
	/**
	 * 배너 등록&수정 합니다.
	 * @param model
	 * @return 배너 목록
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/banner/admBannerUpdate.do")
	public String admBannerUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, BannerVO paramVO, String[] bannerDelChk, RedirectAttributes reda, HttpServletRequest request, ModelMap model, MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/banner/admBannerUpdate.do - 배너 등록&수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		LOGGER.debug("bannerDelChk = "+bannerDelChk );
		
		if(EgovStringUtil.isEmpty(paramVO.getBanName().trim())) {
			LOGGER.debug("배너명은 필수입력사항 입니다.");
			return redirectListPage("배너명은 필수입력사항 입니다.", searchVO, reda );
		}
		
		
		if(!"U".equals(paramVO.getBanType()) && !"S".equals(paramVO.getBanType()) && !"L".equals(paramVO.getBanType()) ){
			// 파일 용량 검사
			/*if(!cmmnFileMngUtil.uploadFileSizeChk(multiRequest)){
				LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 오류발생(-4) : fileSize check...");
				return redirectListPage("오류발생(-4)", searchVO, reda);
			}*/
			
			// 파일 확장자 검사
			if(!cmmnFileMngUtil.uploadFileExtBanChk(multiRequest)){
				LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 오류발생(-5) : fileExt check...");
				return redirectListPage("오류발생(-5)", searchVO, reda);
			}
		}
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(paramVO.getBanSeq())){
			//등록
			String resultSeq = admBannerDAO.insertAdmBanner(paramVO);
			paramVO.setBanSeq(resultSeq);

			if( ("U".equals(paramVO.getBanType()) || "S".equals(paramVO.getBanType()) || "I".equals(paramVO.getBanType()) || "F".equals(paramVO.getBanType()) || "L".equals(paramVO.getBanType())) && "Y".equals(paramVO.getBanUseYn())){
				admBannerDAO.updateAdmBannerSpYn(paramVO);
			}
			
			message = "신규 배너가 등록되었습니다.";
		}else{
			
			if(bannerDelChk!=null){
				LOGGER.debug("배너 수정 기존파일 삭제");
				for(String delType : bannerDelChk){
					BannerVO deleteVO = admBannerDAO.selectAdmBannerOne(paramVO.getBanSeq());
					String delFilePath = "";
					if("IMG".equals(delType)){
						delFilePath = deleteVO.getBanImgPath();
					}else{
						delFilePath = deleteVO.getBanMp4Path();
						paramVO.setBanMp4Path(delFilePath);
					}
					// 원본파일 삭제
					cmmnFileMngUtil.deleteFile(delFilePath);
					
					// thumbnail 삭제
					String fileExt = delFilePath.substring(delFilePath.lastIndexOf(".")+1);
					if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
						cmmnFileMngUtil.deleteFile(CmmnFileMngUtil.getThumbName(delFilePath));
					}
				}
			}
			admBannerDAO.updateAdmBanner(paramVO);
			
			if( ("U".equals(paramVO.getBanType()) || "S".equals(paramVO.getBanType()) || "I".equals(paramVO.getBanType()) || "F".equals(paramVO.getBanType()) || "L".equals(paramVO.getBanType())) && "Y".equals(paramVO.getBanUseYn())){
				admBannerDAO.updateAdmBannerSpYn(paramVO);
			}
			
			message = "배너가 수정되었습니다.";
		}
		
		
		if(!"U".equals(paramVO.getBanType()) && !"S".equals(paramVO.getBanType()) && !"L".equals(paramVO.getBanType())){
			LOGGER.debug("신규파일 등록!");
			List<FileInfoVO> fileList = cmmnFileMngUtil.uploadAttachedBanFiles(multiRequest, "BANNER");
			for(FileInfoVO fileVO : fileList){
				BannerVO tmpVO = new BannerVO();
				tmpVO.setBanSeq(paramVO.getBanSeq());
				if("MP4".equalsIgnoreCase(fileVO.getFileExt())){
					tmpVO.setBanMp4Name(fileVO.getFileName());
					tmpVO.setBanMp4Path(fileVO.getFilePath());
				}else{
					tmpVO.setBanImgName(fileVO.getFileName());
					tmpVO.setBanImgPath(fileVO.getFilePath()); 
				}
				admBannerDAO.updateAdmBannerImg(tmpVO);
			}
		}
		
		searchVO.setSearchCondition1(paramVO.getBanType());
		
		// 로그등록
		admLogInsert(null, "배너", "등록&수정", request);
		
		return redirectListPage(message, searchVO, reda );
	}
	
	/**
	 * 배너목록 배너사용여부 수정
	 * @param searchVO
	 * @param paramVO
	 * @param reda
	 * @param request
	 * @param model
	 * @return 배너목록화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/banner/admBannerUseYnUpdate.do")
	public String admBannerUseYnUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, BannerVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/banner/admBannerUseYnUpdate.do - 배너 사용여부 수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		paramVO.setBanType(searchVO.getSearchCondition1());
		
		admBannerDAO.updateAdmBannerUseYn(paramVO);
		if( ("U".equals(paramVO.getBanType()) || "S".equals(paramVO.getBanType()) || "I".equals(paramVO.getBanType()) || "F".equals(paramVO.getBanType()) || "L".equals(paramVO.getBanType())) && "Y".equals(paramVO.getBanUseYn()) ){
			admBannerDAO.updateAdmBannerSpYn(paramVO);
		}
		
		// 로그등록
		admLogInsert(null, "배너", "사용여부", request);
		
		return redirectListPage("선택하신 배너의 사용여부가 수정되었습니다.", searchVO, reda );
	}
	
	
	/**
	 * 배너 삭제
	 * @param searchVO
	 * @param paramVO
	 * @param reda
	 * @param request
	 * @param model
	 * @return 배너목록 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/banner/admBannerDelete.do")
	public String admBannerDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, BannerVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/banner/admBannerDelete.do - 배너 삭제");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		LOGGER.debug("배너 첨부파일 삭제");
		// 원본파일 삭제
		BannerVO deleteVO = admBannerDAO.selectAdmBannerOne(paramVO.getBanSeq());
		cmmnFileMngUtil.deleteFile(deleteVO.getBanImgPath());
		
		// thumbnail 삭제
		if(!paramVO.getBanType().equals("S") && !paramVO.getBanType().equals("U") && !paramVO.getBanType().equals("L")) {
			String fileExt = deleteVO.getBanImgPath().substring(deleteVO.getBanImgPath().lastIndexOf(".")+1);
			if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
				cmmnFileMngUtil.deleteFile(CmmnFileMngUtil.getThumbName(deleteVO.getBanImgPath()));
			}
			
		}
		
		admBannerDAO.deleteAdmBanner(paramVO);
		
		// 로그등록
		admLogInsert(null, "배너", "삭제", request);
		
		return redirectListPage("배너가 삭제되었습니다.", searchVO, reda );
	}
	
}
