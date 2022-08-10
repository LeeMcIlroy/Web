package writer.adm.siteMng.popup;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.PopupVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmSiteMngPopupController {

	private final static Logger LOGGER=LoggerFactory.getLogger(AdmSiteMngPopupController.class);
	@Autowired private AdmSiteMngPopupDAO admSiteMngPopupDAO;
	
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/siteMng/popup/admSiteMngPopupList.do";		// 목록
		
		return redirectPage;
		
	}
	
	
	//팝업 목록
	@RequestMapping("/xabdmxgr/siteMng/popup/admSiteMngPopupList.do")
	public String admSiteMngPopupList(ModelMap model, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		request.getSession().setAttribute("admMenuNo", "602");
		LOGGER.info("/xabdmxgr/siteMng/popup/admSiteMngPopupList.do - 관리자 > 사이트관리 > 팝업관리 목록");
		LOGGER.debug("searchVO - "+searchVO);
		
		PaginationInfo paginationInfo=PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admSiteMngPopupDAO.selectSiteMngPopupList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/siteMng/popup/admSiteMngPopupList";
	}
	
	//등록 & 수정화면
	@RequestMapping("/xabdmxgr/siteMng/popup/admSiteMngPopupModifyView.do")
	public String admSiteMngPopupModifyView(ModelMap model, String popSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/siteMng/popup/admSiteMngPopupModifyView.do - 관리자 > 사이트관리 > 팝업관리 등록 & 수정화면");
		LOGGER.debug("popSeq - "+popSeq);
		
		PopupVO popupVO = null;
		if(EgovStringUtil.isEmpty(popSeq)){
			//등록
			popupVO = new PopupVO();
			
		}else{
			//수정
			popupVO = admSiteMngPopupDAO.selectSiteMngPopupOne(popSeq);
			if(popupVO == null){
				searchVO.setMessage("선택한 팝업은 없습니다.");
				LOGGER.debug(searchVO.getMessage());
				return redirectListPage(searchVO, reda);
			}
		}
		
		model.addAttribute("popupVO",popupVO);
		return "/adm/siteMng/popup/admSiteMngPopupModify";
	}
	
	//등록 & 수정 
	@RequestMapping("/xabdmxgr/siteMng/popup/admSiteMngPopupModify.do")
	public String admSiteMngPopupModify(ModelMap model, PopupVO popupVO, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/siteMng/popup/admSiteMngPopupModify.do - 관리자 > 사이트관리 > 팝업관리 등록 & 수정");
		LOGGER.debug("popupVO - "+popupVO);
		
		
		if("".equals(popupVO.getPopTitle()) || popupVO.getPopTitle() ==null){
			searchVO.setMessage("제목이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			
			return redirectListPage(searchVO, reda);
		}
		if("".equals(popupVO.getPopWidth()) || popupVO.getPopWidth() ==null){
			searchVO.setMessage("넓이를 지정하십시오.");
			LOGGER.debug(searchVO.getMessage());
			
			return redirectListPage(searchVO, reda);
		}
		if("".equals(popupVO.getPopHeight()) || popupVO.getPopHeight() ==null){
			searchVO.setMessage("높이를 지정하십시오.");
			LOGGER.debug(searchVO.getMessage());
			
			return redirectListPage(searchVO, reda);
		}
		if("".equals(popupVO.getPopTop()) || popupVO.getPopTop() ==null){
			popupVO.setPopTop("0");
		}
		if("".equals(popupVO.getPopLeft()) || popupVO.getPopLeft() ==null){
			popupVO.setPopLeft("0");
		}
		
		String logJob = "";
		if(EgovStringUtil.isEmpty(popupVO.getPopSeq())){
			//등록
			admSiteMngPopupDAO.insertSiteMngPopupOne(popupVO);
			logJob = "사이트 관리 > 팝업 관리 > 새 팝업 등록";
		}else{
			//수정
			admSiteMngPopupDAO.updateSiteMngPopupOne(popupVO);
			logJob = "사이트 관리 > 팝업 관리 > 팝업 수정("+popupVO.getPopSeq()+")";
		}
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne(logJob, ip);
		
		searchVO.setMessage("저장되었습니다.");
		LOGGER.debug(searchVO.getMessage());
		return redirectListPage(searchVO, reda);
	}
	
	//삭제
	@RequestMapping("/xabdmxgr/siteMng/popup/admSiteMngPopupDelete.do")
	public String admSiteMngPopupDelete(String popSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/siteMng/popup/admSiteMngPopupDelete.do - 관리자 > 사이트관리 > 팝업관리 삭제");
		LOGGER.debug("popSeq - "+popSeq);
		
		admSiteMngPopupDAO.deleteSiteMngPopupOne(popSeq);
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("사이트 관리 > 팝업 관리 > 팝업 삭제("+popSeq+")", ip);
		
		searchVO.setMessage("삭제되었습니다.");
		return redirectListPage(searchVO, reda);
	}

	//팝업 미리보기
	@RequestMapping("/xabdmxgr/siteMng/popup/admSiteMngPopupOpen.do")
	public String admSiteMngPopupOpen(ModelMap model, String popSeq, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/siteMng/popup/admSiteMngPopupOpen.do - 관리자 > 사이트관리 > 팝업관리 미리보기");
		LOGGER.debug("popSeq = "+popSeq);

		PopupVO popupVO=admSiteMngPopupDAO.selectSiteMngPopupOne(popSeq);
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("사이트 관리 > 팝업 관리 > 팝업 조회("+popSeq+")", ip);
		
		model.addAttribute("popupVO",popupVO);
		return "/adm/siteMng/popup/admSiteMngPopupView";
	}
}
