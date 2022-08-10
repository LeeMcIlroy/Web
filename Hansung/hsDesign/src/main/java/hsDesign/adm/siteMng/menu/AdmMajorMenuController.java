package hsDesign.adm.siteMng.menu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.MenuVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmMajorMenuController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmMajorMenuController.class);
	@Autowired private AdmMajorMenuDAO admMajorMenuDAO;

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addAttribute("pageIndex", searchVO.getPageIndex());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition1", searchVO.getSearchCondition1());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchType())) reda.addAttribute("searchType", searchVO.getSearchType());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchWord())) reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/qxerpynm/siteMng/menu/admMajorMenuList.do";
	}
	
	/**
	 * 전공메뉴목록 화면으로 이동합니다.
	 * @param model
	 * @return 전공메뉴목록화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/menu/admMajorMenuList.do")
	public String admMajorMenuList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/menu/admMajorMenuList.do - 전공메뉴목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "604");
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO result = admMajorMenuDAO.selectAdmMenuList(searchVO);
		paginationInfo.setTotalRecordCount(result.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", result.getEgovList());
		
		List<EgovMap> majorList = admMajorMenuDAO.selectAdmMajorList();
		model.addAttribute("majorList", majorList);
		
		// 로그등록
		admLogInsert(null, "전공메뉴", "등록", request);
		
		return "/adm/siteMng/menu/admMajorMenuList";
	}
	
	/**
	 * 전공메뉴 등록&수정 화면으로 이동합니다.
	 * @param model
	 * @return 전공메뉴 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/menu/admMajorMenuModify.do")
	public String admMajorMenuModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String mmSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/menu/admMajorMenuModify.do - 전공메뉴목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("mmSeq = "+mmSeq);
		
		if(EgovStringUtil.isEmpty(mmSeq) || "0".equals(mmSeq)){
			LOGGER.debug("신규 등록");
			model.addAttribute("menuVO", new MenuVO());
		}else{
			LOGGER.debug("수정 조회");
			MenuVO resultVO = admMajorMenuDAO.selectAdmMenuOne(mmSeq);
			model.addAttribute("menuVO", resultVO);
		}
		model.addAttribute("searchVO", searchVO);
		
		List<EgovMap> majorList = admMajorMenuDAO.selectAdmMajorList();
		model.addAttribute("majorList", majorList);
		
		List<EgovMap> boardList = admMajorMenuDAO.selectMajorMenuBoardList();
		model.addAttribute("boardList", boardList);
		
		List<EgovMap> headerList = admMajorMenuDAO.selectMajorMenuHeaderList();
		model.addAttribute("headerList", headerList);
		
		return "/adm/siteMng/menu/admMajorMenuModify";
	}
	
	/**
	 * 전공메뉴 등록&수정 화면으로 이동합니다.
	 * @param model
	 * @return 전공메뉴 등록&수정 화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/menu/admMajorMenuUpdate.do")
	public String admMajorMenuUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, MenuVO paramVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/Menu/admMajorMenuUpdate.do - 전공메뉴목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		String message="";
		String[] headArray = paramVO.getBcHead().split(",");
		if(EgovStringUtil.isEmpty(paramVO.getMmSeq())){
			LOGGER.debug("신규 등록");
			String mmSeq = admMajorMenuDAO.insertAdmMenu(paramVO);
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("mmSeq", mmSeq);
			for (String head : headArray) {
				paramMap.put("head", head);
				admMajorMenuDAO.insertAdmMenuHead(paramMap);
			}
			message = "신규 전공메뉴가 등록되었습니다.";
			
			// 로그등록
			admLogInsert(null, "전공메뉴", "등록", request);
		}else{
			LOGGER.debug("수정");
			
			admMajorMenuDAO.updateAdmMenu(paramVO);
			//기존 말머리 삭제
			admMajorMenuDAO.deleteAdmMenuHead(paramVO.getMmSeq());
			
			//수정된 말머리 추가
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("mmSeq", paramVO.getMmSeq());
			for (String head : headArray) {
				paramMap.put("head", head);
				admMajorMenuDAO.insertAdmMenuHead(paramMap);
			}
			message = "전공메뉴가 수정되었습니다.";
			
			// 로그등록
			admLogInsert(null, "전공메뉴", paramVO.getMmSeq(), request);
		}
		
		return redirectListPage(message, searchVO, reda);
	}
	
}
