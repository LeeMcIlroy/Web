package hsDesign.adm.siteMng.code;

import javax.annotation.Resource;
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
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.CodeVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmMajorCodeController extends AdmCmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmMajorCodeController.class);
	@Autowired private AdmMajorCodeDAO admMajorCodeDAO;

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//코드목록화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/siteMng/code/admMajorCodeList.do";
	}

	/**
	 * 코드목록 화면으로 이동합니다.
	 * @param model
	 * @return 코드목록화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/code/admMajorCodeList.do")
	public String admMajorCodeList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/code/admMajorCodeList.do - 코드목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "605");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO result = admMajorCodeDAO.selectAdmMajorCodeList(searchVO);
		paginationInfo.setTotalRecordCount(result.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", result.getEgovList());
		
		// 로그등록
		admLogInsert(null, "코드", "목록", request);
		
		return "/adm/siteMng/code/admMajorCodeList";
	}
	
	/**
	 * 코드 등록&수정 화면으로 이동합니다.
	 * @param model
	 * @return 코드 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/code/admMajorCodeModify.do")
	public String admMajorCodeModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String bcSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/code/admMajorCodeList.do - 코드목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("bcSeq = "+bcSeq);
		
		if(bcSeq.equals("0")){
			LOGGER.debug("신규 등록");
			model.addAttribute("codeVO", new CodeVO());
		}else{
			LOGGER.debug("수정 조회");
			model.addAttribute("codeVO", admMajorCodeDAO.selectAdmMajorCodeOne(bcSeq));
		}
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/siteMng/code/admMajorCodeModify";
	}
	
	/**
	 * 코드 등록&수정 화면으로 이동합니다.
	 * @param model
	 * @return 코드 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/code/admMajorCodeUpdate.do")
	public String admMajorCodeUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, CodeVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/code/admMajorCodeList.do - 코드목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		String message="";
		if(EgovStringUtil.isEmpty(paramVO.getBcSeq())){
			LOGGER.debug("신규 등록");
			admMajorCodeDAO.insertAdmMajorCode(paramVO);
			message = "신규 코드가 등록되었습니다.";
			
			// 로그등록
			admLogInsert(null, "코드", "등록", request);
		}else{
			LOGGER.debug("수정");
			admMajorCodeDAO.updateAdmMajorCode(paramVO);
			message = "코드가 수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "코드 수정", paramVO.getBcSeq(), request);
		}
		
		return redirectLoginView(reda, message);
	}
	
}
