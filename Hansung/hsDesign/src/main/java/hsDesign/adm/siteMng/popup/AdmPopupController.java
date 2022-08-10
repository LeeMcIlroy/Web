package hsDesign.adm.siteMng.popup;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import hsDesign.valueObject.PopupVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmPopupController extends AdmCmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmPopupController.class);
	@Autowired private AdmPopupDAO admPopupDAO;
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
		return "redirect:/qxerpynm/siteMng/popup/admPopupList.do";
	}
	
	//팝업목록화면으로 리다이렉트합니다.
	private String redirectPopupList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/siteMng/popup/admPopupList.do";
	}

	/**
	 * 팝업목록 화면으로 이동합니다.
	 * @param model
	 * @return 팝업목록화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/popup/admPopupList.do")
	public String admPopupList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/popup/admPopupList.do - 팝업목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "603");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO result = admPopupDAO.selectAdmPopupList(searchVO);
		paginationInfo.setTotalRecordCount(result.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", result.getEgovList());
		
		// 로그 등록
		admLogInsert(null, "팝업", "목록",request);
		
		return "/adm/siteMng/popup/admPopupList";
	}
	
	/**
	 * 팝업 등록&수정 화면으로 이동합니다.
	 * @param model
	 * @return 팝업 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/popup/admPopupModify.do")
	public String admPopupModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String popSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/popup/admPopupModify.do - 팝업 등록&수정 화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("popSeq = "+popSeq);
		
		if(popSeq.equals("0")){
			LOGGER.debug("신규 등록");
			model.addAttribute("popupVO", new PopupVO());
		}else{
			LOGGER.debug("수정 조회");
			model.addAttribute("popupVO", admPopupDAO.selectAdmPopupOne(popSeq));
		}
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/siteMng/popup/admPopupModify";
	}
	
	/**
	 * 팝업 등록&수정 합니다.
	 * @param model
	 * @return 팝업 목록
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/popup/admPopupUpdate.do")
	public String admPopupUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, PopupVO paramVO, String[] popupDelChk, RedirectAttributes reda, HttpServletRequest request, ModelMap model, MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/popup/admPopupUpdate.do - 팝업 등록&수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		LOGGER.debug("popupDelChk = "+popupDelChk );
		
		if(EgovStringUtil.isEmpty(paramVO.getPopTitle().trim())) {
			LOGGER.debug("팝업명은 필수 입력항목입니다.");
			return redirectListPage("팝업명은 필수 입력항목입니다.", searchVO, reda );
		}else if(EgovStringUtil.isEmpty(paramVO.getPopHeight().trim()) || EgovStringUtil.isEmpty(paramVO.getPopWidth().trim())) {
			LOGGER.debug("팝업명의 크기를 지정해 주세요.");
			return redirectListPage("팝업명의 크기를 지정해 주세요.", searchVO, reda );
		}else if(EgovStringUtil.isEmpty(paramVO.getPopTop().trim()) || EgovStringUtil.isEmpty(paramVO.getPopLeft().trim())) {
			LOGGER.debug("팝업명의 위치를 지정해 주세요.");
			return redirectListPage("팝업명의 위치를 지정해 주세요.", searchVO, reda );
		}
		
		// 파일 용량 검사
		if(!cmmnFileMngUtil.uploadFileSizeChk(multiRequest)){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 오류발생(-4) : fileSize check...");
			return redirectListPage("오류발생(-4)", searchVO, reda);
		}
		
		// 파일 확장자 검사
/*		if(!cmmnFileMngUtil.uploadFileExtChk(multiRequest)){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 오류발생(-5) : fileExt check...");
			return redirectListPage("오류발생(-5)", searchVO, reda);
		}
*/
		
		
		String message = "";
		
		if(EgovStringUtil.isEmpty(paramVO.getPopSeq())){
			//등록
			String resultSeq = admPopupDAO.insertAdmPopup(paramVO);
			paramVO.setPopSeq(resultSeq);
			message = "신규 팝업이 등록되었습니다.";
		}else{
			if(popupDelChk!=null){
				LOGGER.debug("팝업 수정 기존파일 삭제");
				// 원본파일 삭제
				PopupVO deleteVO = admPopupDAO.selectAdmPopupOne(paramVO.getPopSeq());
				cmmnFileMngUtil.deleteFile(deleteVO.getPopImgPath());
				
				// thumbnail 삭제
				String fileExt = deleteVO.getPopImgPath().substring(deleteVO.getPopImgPath().lastIndexOf(".")+1);
				if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
					cmmnFileMngUtil.deleteFile(CmmnFileMngUtil.getThumbName(deleteVO.getPopImgPath()));
				}
			}
			admPopupDAO.updateAdmPopup(paramVO);
			message = "팝업이 수정되었습니다.";
		}
		
		if(popupDelChk!=null){
			LOGGER.debug("신규파일 등록!");
			FileInfoVO fileVO = cmmnFileMngUtil.uploadAttachedImgFile(multiRequest, "POPUP");
			paramVO.setPopImgName(fileVO.getFileName());
			paramVO.setPopImgPath(fileVO.getFilePath());
			
			admPopupDAO.updateAdmPopupImg(paramVO);
		}
		
		// 로그 등록
		admLogInsert(null, "팝업등록&수정", paramVO.getPopSeq() ,request);
		
		searchVO.setSearchCondition1(paramVO.getPopType());
		
		return redirectListPage(message, searchVO, reda );
	}
	
	/**
	 * 팝업목록 팝업사용여부 수정
	 * @param searchVO
	 * @param paramVO
	 * @param reda
	 * @param request
	 * @param model
	 * @return 팝업목록화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/popup/admPopupUseYnUpdate.do")
	public String admPopupUseYnUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, PopupVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/popup/admPopupUseYnUpdate.do - 팝업 사용여부 수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		admPopupDAO.updateAdmPopupUseYn(paramVO);
		
		// 로그 등록
		admLogInsert(null, "팝업사용여부수정", paramVO.getPopSeq() ,request);
		
		return redirectListPage("선택하신 팝업의 사용여부가 수정되었습니다.", searchVO, reda );
	}
	//팝업 미리보기
	@RequestMapping("/qxerpynm/siteMng/popup/admPopupOpen.do")
	public String admPopupOpen(ModelMap model, String popSeq, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		LOGGER.info("/qxerpynm/siteMng/popup/admPopupOpen.do - 관리자 > 사이트관리 > 팝업관리 미리보기");
		LOGGER.debug("popSeq = "+popSeq);

		PopupVO popupVO= admPopupDAO.selectAdmPopupOne(popSeq);
		
		// 로그 등록
		admLogInsert(null, "팝업미리보기", popSeq,request);
		
		model.addAttribute("popupVO",popupVO);
		return "/adm/siteMng/popup/admPopupView";
	}
	
	
	@RequestMapping("/qxerpynm/siteMng/popup/admPopupDelete.do")
	public String admPopupDelete(@ModelAttribute("searchVO") CmmnSearchVO searchVO, PopupVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/popup/admPopupDelete.do - 팝업 삭제");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		LOGGER.debug("팝업 첨부파일 삭제");
		// 원본파일 삭제
		PopupVO deleteVO = admPopupDAO.selectAdmPopupOne(paramVO.getPopSeq());
		cmmnFileMngUtil.deleteFile(deleteVO.getPopImgPath());
		
		// thumbnail 삭제
		String fileExt = deleteVO.getPopImgPath().substring(deleteVO.getPopImgPath().lastIndexOf(".")+1);
		if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
			cmmnFileMngUtil.deleteFile(CmmnFileMngUtil.getThumbName(deleteVO.getPopImgPath()));
		}
		
		admPopupDAO.deleteAdmPopup(paramVO);
		
		return redirectListPage("팝업가 삭제되었습니다.", searchVO, reda );
	}
	
}
