package hsDesign.usr.general.exper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.usr.cmm.CmmController;
import hsDesign.usr.majorBoard.MajorBoardDAO;
import hsDesign.valueObject.BrochureVO;
import hsDesign.valueObject.ExperVO;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class ExperienceController extends CmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ExperienceController.class);
	
	@Autowired private ExperienceDAO experienceDAO;
	@Autowired private MajorBoardDAO majorBoardDAO;
	
	/***************************************** 진로체험 안내 *****************************************/
	// 진로체험 안내
	@RequestMapping("/usr/general/exper/experInfo.do")
	public String experInfo(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/general/exper/experInfo.do - 진로&교양과정 > 진로체험안내");
		LOGGER.debug("searhVO.toString = "+searchVO.toString());
		
		// incLeft menu
		session.setAttribute("menuNo", "22001");
		
		if(EgovStringUtil.isEmpty(searchVO.getMenuType())) searchVO.setMenuType("01");
		
		return "/usr/general/exper/experInfo";
	}
	
	/***************************************** 진로체험 신청 *****************************************/
	// 진로체험 신청 - 화면
	@RequestMapping("/usr/general/exper/experModify.do")
	public String experModify(HttpSession session) throws Exception {
		LOGGER.info("/usr/general/exper/experModify.do - 진로&교양과정 > 진로체험신청 - 화면");
		// incLeft menu
		session.setAttribute("menuNo", "22002");
		
		return "/usr/general/exper/experModify";
	}
	
	// 진로체험 신청 - 신청
	@RequestMapping("/usr/general/exper/experUpdate.do")
	public String experUpdate(ExperVO experVO, String[] excCd, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/general/exper/experUpdate.do - 진로&교양과정 > 진로체험신청 - 신청");
		LOGGER.debug("experVO.toString = "+experVO.toString());
		LOGGER.debug("excCd.length = {}", excCd.length);
		
		if(
			EgovStringUtil.isEmpty(experVO.getExaAplyName()) || EgovStringUtil.isEmpty(experVO.getExaSchName()) || EgovStringUtil.isEmpty(experVO.getExaTel1())
			|| EgovStringUtil.isEmpty(experVO.getExaTel2()) || EgovStringUtil.isEmpty(experVO.getExaTel3()) || excCd.length == 0
		){
			reda.addFlashAttribute("message", "오류발생(-1)");
			return "redirect:/usr/general/exper/experModify.do";
		}
		
		// 연락처 set
		experVO.setExaTel(experVO.getExaTel1()+"-"+experVO.getExaTel2()+"-"+experVO.getExaTel3());
		
		// 신청 등록
		String rsExaSeq = experienceDAO.experAplyInsert(experVO);

		// 과정 등록 - start
		Map<String, String> experCource = new HashMap<>();
		experCource.put("rsExaSeq", rsExaSeq);
		
		for(String p : excCd){
			experCource.put("excCd", p);
			experienceDAO.experCourceInsert(experCource);
		}
		// 과정 등록 - end
		
		reda.addFlashAttribute("message", "진로체험신청이 완료되었습니다.");
		return "redirect:/usr/general/exper/experModify.do";
	}
	
	/***************************************** 진로체험 소식 *****************************************/
	private String mCode = "21";
	private String mmSeq = "52";
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addAttribute("menuType", searchVO.getMenuType());
		reda.addAttribute("pageIndex", searchVO.getPageIndex());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition3())) reda.addAttribute("searchCondition3", searchVO.getSearchCondition3());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition2())) reda.addAttribute("searchCondition2", searchVO.getSearchCondition2());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchWord())) reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/usr/general/exper/experNewsList.do";
	}
	
	// 진로체험 소식 - 목록
	@RequestMapping("/usr/general/exper/experNewsList.do")
	public String experNewsList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/general/exper/experNewsList.do - 진로&교양과정 > 진로체험소식 - 목록");
		LOGGER.debug("searchVO.toString = "+searchVO.toString());
		
		// incLeft menu
		session.setAttribute("menuNo", "22003");
		// 진로체험 소식 set
		searchVO.setMenuType(mCode);
		searchVO.setSearchType(mmSeq);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 10, 5);
		CmmnListVO listVO = majorBoardDAO.selectMajorBoardList(searchVO);
		
		// 말머리 목록
		List<EgovMap> menuList = majorBoardDAO.selectMajorHeadList(mmSeq);
		model.addAttribute("menuList", menuList);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 목록 태그 치환
		model.addAttribute("resultList", replaceTag(listVO.getEgovList(),"mb"));
		
		return "/usr/general/exper/experNewsList";
	}
	
	// 진로체험 소식 - 조회
	@RequestMapping("/usr/general/exper/experNewsView.do")
	public String experNewsView(@RequestParam String mbSeq, @ModelAttribute("searchVO")	CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/general/exper/experNewsView.do - 진로&교양과정 > 진로체험 소식 - 조회");
		LOGGER.debug("mbSeq = {}", mbSeq);
		
		MajorBoardVO resultVO = majorBoardDAO.selectMajorBoardOne(mbSeq);
		if(resultVO == null) return redirectListPage("게시글이 존재하지 않습니다.", searchVO, reda);

		// 관련글
		searchVO.setMenuType(resultVO.getmCode());
		searchVO.setSearchType(resultVO.getMbGubun1());
		searchVO.setSearchCondition3(resultVO.getMbGubun2());
		searchVO.setSearchCondition4(mbSeq);
		int pageIndex = searchVO.getPageIndex();
		searchVO.setPageIndex(1);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO,4,1);
		CmmnListVO listVO = majorBoardDAO.selectMajorBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("recentList", listVO.getEgovList());
		searchVO.setPageIndex(pageIndex);

		
		resultVO.setMbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getMbContent()));	// style 제거
		model.addAttribute("resultVO", resultVO);		
		return "/usr/general/exper/experNewsView";
	}
}