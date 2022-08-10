package hsDesign.usr.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.usr.cmm.CmmController;
import hsDesign.usr.cmmBoard.CmmBoardDAO;
import hsDesign.usr.majorBoard.MajorBoardDAO;
import hsDesign.valueObject.PopupVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class MainController extends CmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(MainController.class);
	@Autowired private MainDAO mainDAO;
	@Autowired private CmmBoardDAO cmmBoardDAO;
	@Autowired private MajorBoardDAO majorBoardDAO;
	
	// 검색조건을 가지고 (실내디자인)목록으로 이동합니다.
	
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/usr/majorBoard/interior/majorInteriorInfo.do";
	}
	
	// 메인 화면
	@RequestMapping("/usr/main/index.do")
	public String index(ModelMap model, HttpServletRequest request, RedirectAttributes reda, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/main/index.do - 사용자 > 메인화면");
		LOGGER.debug("searchVO.toString() = {}", searchVO.toString());
		session.setAttribute("menuNo", "0");
		// 공지사항
		searchVO.setMenuType("0501");
		
		//searchVO.setSearchType("Y");
		PaginationController.getPaginationInfo(searchVO , 10, 1);
		CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
		model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 1);		
		// 자랑스런 한디원
		searchVO.setSearchType("");
		searchVO.setMenuType("0601");
		CmmnListVO listVO1 = cmmBoardDAO.selectCmmBoardList(searchVO);
		model.addAttribute("proudList", replaceTag(listVO1.getEgovList(), "cb"));
		
		
		// 한디원 행사
		searchVO.setMenuType("0701");
		CmmnListVO listVO2 = cmmBoardDAO.selectCmmBoardList(searchVO);
		model.addAttribute("festivalList", replaceTag(listVO2.getEgovList(), "cb"));
		
		// 전공 소식
		List<EgovMap> listVO3 = majorBoardDAO.selectMajorMainList();
		model.addAttribute("majorMainList", replaceTag(listVO3, "mb"));
		
		// 팝업 목록
		List<PopupVO> popupList = mainDAO.selectPopupList();
		model.addAttribute("popupList", popupList);
		
		
		// 전공메뉴
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 배너목록
		model.addAttribute("bannerList", mainDAO.selectBannerList());
		List<EgovMap> mainBannerList = mainDAO.selectBannerList("M");
		for (EgovMap egovMap : mainBannerList) {
			String tempBanPath = egovMap.get("banImgPath").toString();
			
			tempBanPath = tempBanPath.replace("\\", "/");
			egovMap.put("banImgPath", tempBanPath);
			/*
			String tempAddName1 = egovMap.get("banAddName1").toString().replace("\r\n", "<br/>");
			egovMap.put("banAddName1", tempAddName1);
			
			String tempAddName2 = egovMap.get("banAddName2").toString().replace("\r\n", "<br/>");
			egovMap.put("banAddName2", tempAddName2);
			*/
		}
		model.addAttribute("mainBannerList", mainBannerList);
		model.addAttribute("subBannerList", mainDAO.selectBannerList("S"));
		model.addAttribute("imgBannerList", mainDAO.selectBannerList("I"));
		List<EgovMap> aviBannerList = mainDAO.selectBannerList("U");
		
		model.addAttribute("aviBannerList", aviBannerList);
		model.addAttribute("aviBannerOne", aviBannerList.get(0));
		List<EgovMap> slideBannerList = mainDAO.selectBannerList("L");
		for (EgovMap egovMap : slideBannerList) {
			String tempAddName1 = egovMap.get("banAddName1").toString().replace("\r\n", "<br/>");
			egovMap.put("banAddName1", tempAddName1);
			
			String tempAddName2 = egovMap.get("banAddName2").toString().replace("\r\n", "<br/>");
			egovMap.put("banAddName2", tempAddName2);
		}
		
		model.addAttribute("slideBannerList", slideBannerList);
		
		// 현재주소 가져오기
		String pageUrl = request.getContextPath();
		model.addAttribute("pagrUrl", pageUrl);
		
		return "/usr/index";
	}
	
	// 팝업 조회
	@RequestMapping("/usr/main/popupView.do")
	public String popupView(@RequestParam String popSeq, ModelMap model) throws Exception {
		LOGGER.info("/usr/main/popupView.do - 사용자 > 메인 > 팝업");
		LOGGER.debug("popSeq - "+popSeq);
		PopupVO popupVO = mainDAO.selectPopupOne(popSeq);
		model.addAttribute("popupVO", popupVO);
		return "/usr/popupView";
	}
	
	// 통합 검색
	@RequestMapping("/usr/main/searchList.do")
	public String searchList( ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, String word, HttpSession session) throws Exception {
		LOGGER.info("/usr/main/popupView.do - 사용자 > 메인 > 통합검색");
		LOGGER.debug("searchVO - "+searchVO.toString());
		
		session.setAttribute("menuNo", "901");
		
		if(!EgovStringUtil.isEmpty(word)) {
			searchVO.setSearchWord(word);
		}
		
		model.addAttribute("searchVO", searchVO);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = mainDAO.selectSearchList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		// incleftmenu
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", replaceTag(listVO.getEgovList(), "total"));
		
		return "/usr/searchList";
	}
		
		
	
	
	/***************************************** 롤링 배너 *****************************************/
	// 하단 롤링 배너
	@RequestMapping("/usr/incBtmRollingBanner.do")
	public String incBtmRollingBanner(ModelMap model) throws Exception {
		LOGGER.info("/usr/incBtmRollingBanner.do - 사용자 > 하단 롤링 배너");
		
		// set "R"=롤링배너
		List<EgovMap> btmRollingBannerList = mainDAO.selectBannerList("R");
		
		model.addAttribute("btmRollingBannerList", btmRollingBannerList);
		return "/usr/inc/incBtmRollingBanner";
	}
	@RequestMapping("/usr/main/index_test.do")
	public String index_test(ModelMap model, HttpServletRequest request, RedirectAttributes reda, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/main/index.do - 사용자 > 메인화면");
		LOGGER.debug("searchVO.toString() = {}", searchVO.toString());
		session.setAttribute("menuNo", "0");
		// 공지사항
		searchVO.setMenuType("0501");
		
		//searchVO.setSearchType("Y");
		PaginationController.getPaginationInfo(searchVO , 10, 1);
		CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
		model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 1);		
		// 자랑스런 한디원
		searchVO.setSearchType("");
		searchVO.setMenuType("0601");
		CmmnListVO listVO1 = cmmBoardDAO.selectCmmBoardList(searchVO);
		model.addAttribute("proudList", replaceTag(listVO1.getEgovList(), "cb"));
		
		
		// 한디원 행사
		searchVO.setMenuType("0701");
		CmmnListVO listVO2 = cmmBoardDAO.selectCmmBoardList(searchVO);
		model.addAttribute("festivalList", replaceTag(listVO2.getEgovList(), "cb"));
		
		// 전공 소식
		List<EgovMap> listVO3 = majorBoardDAO.selectMajorMainList();
		model.addAttribute("majorMainList", replaceTag(listVO3, "mb"));
		
		// 팝업 목록
		List<PopupVO> popupList = mainDAO.selectPopupList();
		model.addAttribute("popupList", popupList);
		
		
		// 전공메뉴
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 배너목록
		model.addAttribute("bannerList", mainDAO.selectBannerList());
		List<EgovMap> mainBannerList = mainDAO.selectBannerList("M");
		for (EgovMap egovMap : mainBannerList) {
			String tempBanPath = egovMap.get("banImgPath").toString();
			
			tempBanPath = tempBanPath.replace("\\", "/");
			egovMap.put("banImgPath", tempBanPath);
			/*
			String tempAddName1 = egovMap.get("banAddName1").toString().replace("\r\n", "<br/>");
			egovMap.put("banAddName1", tempAddName1);
			
			String tempAddName2 = egovMap.get("banAddName2").toString().replace("\r\n", "<br/>");
			egovMap.put("banAddName2", tempAddName2);
			*/
		}
		model.addAttribute("mainBannerList", mainBannerList);
		model.addAttribute("subBannerList", mainDAO.selectBannerList("S"));
		model.addAttribute("imgBannerList", mainDAO.selectBannerList("I"));
		List<EgovMap> aviBannerList = mainDAO.selectBannerList("U");
		
		model.addAttribute("aviBannerList", aviBannerList);
		model.addAttribute("aviBannerOne", aviBannerList.get(0));
		List<EgovMap> slideBannerList = mainDAO.selectBannerList("L");
		for (EgovMap egovMap : slideBannerList) {
			String tempAddName1 = egovMap.get("banAddName1").toString().replace("\r\n", "<br/>");
			egovMap.put("banAddName1", tempAddName1);
			
			String tempAddName2 = egovMap.get("banAddName2").toString().replace("\r\n", "<br/>");
			egovMap.put("banAddName2", tempAddName2);
		}
		
		model.addAttribute("slideBannerList", slideBannerList);
		
		// 현재주소 가져오기
		String pageUrl = request.getContextPath();
		model.addAttribute("pagrUrl", pageUrl);
		
		return "/usr/index_test";
	}
}
