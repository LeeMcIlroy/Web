package hsDesign.adm.siteMng.news;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmNewsController extends AdmCmmController  {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmNewsController.class);
	@Autowired private AdmNewsDAO admNewsDAO;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	@Resource View jsonView;
	
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addAttribute("pageIndex", searchVO.getPageIndex());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition1", searchVO.getSearchCondition1());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition2", searchVO.getSearchCondition2());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchWord())) reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/qxerpynm/siteMng/news/admNewsList.do";
	}
	
	//전공 소식 목록화면으로 리다이렉트합니다.
	private String redirectNewsList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxerpynm/siteMng/news/admNewsList.do";
	}

	/**
	 * 전공소식목록 화면으로 이동합니다.
	 * @param searchVO
	 * @param request
	 * @param model
	 * @return 전공소식목록화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/news/admNewsList.do")
	public String admNewsList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/news/admNewsList.do - 전공소식목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "607");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO result = admNewsDAO.selectAdmNewsList(searchVO);
		
		List<EgovMap> sortList = admNewsDAO.selectAdmNewsSortList(searchVO);
		List<EgovMap> deptList = admNewsDAO.selectAdmNewsDeptList();
		
		paginationInfo.setTotalRecordCount(result.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", result.getEgovList());
		model.addAttribute("sortList", sortList);
		model.addAttribute("deptList", deptList);
		
		// 로그등록
		admLogInsert(null, "전공소식", "목록", request);
		
		return "/adm/siteMng/news/admNewsList";
	}
	
	/**
	 * 전공소식상세 화면으로 이동합니다.
	 * @param searchVO
	 * @param mbSeq
	 * @param request
	 * @param model
	 * @return 전공소식상세화면
	 * @throws Exception
	 */
	@RequestMapping("/qxerpynm/siteMng/news/admNewsView.do")
	public String admNewsView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, @RequestParam("mbSeq") String mbSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/news/admNewsView.do - 전공소식상세");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		MajorBoardVO resultVO = admNewsDAO.selectAdmNewsOne(mbSeq);
		
		model.addAttribute("resultVO", resultVO);
		
		// 로그등록
		admLogInsert(null, "전공소식", "목록", request);
		
		return "/adm/siteMng/news/admNewsView";
	}
	
	/**
	 * 전공소식 정렬 수정
	 * @param searchVO
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return 전공소식목록화면
	 */
	@RequestMapping("/qxerpynm/siteMng/news/admNewsSortUpdate.do")
	public View admBannerUseYnUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, MajorBoardVO paramVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxerpynm/siteMng/news/admNewsSortUpdate.do - 전공소식 정렬 수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("paramVO = "+paramVO.toString());
		
		if(!"0".equals(paramVO.getMbSort())){
			int result = admNewsDAO.selectAdmNewsSortChk(paramVO);
			
			if(0 < result){
				admNewsDAO.updateAdmNewsPreSort(paramVO);
			}
		}
		admNewsDAO.updateAdmNewsSort(paramVO);
		
		// 로그등록
		admLogInsert(null, "전공소식", "정렬", request);
		
		model.put("result", "1");
		return jsonView;
	}
	
}
