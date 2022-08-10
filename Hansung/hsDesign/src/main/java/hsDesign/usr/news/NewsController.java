package hsDesign.usr.news;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import hsDesign.usr.cmm.CmmController;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class NewsController extends CmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(NewsController.class);
	
	// 취업현황
	@RequestMapping("/usr/community/employment.do")
	public String employment(HttpSession session, ModelMap model) throws Exception {
		LOGGER.info("/usr/community/employment.do - 사용자 > 한디원 뉴스 > 취업현황");
		session.setAttribute("menuNo", "601");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/community/employment";
	}
	
	
	
	// 진학현황
	@RequestMapping("/usr/community/univercity.do")
	public String univercity(HttpSession session, ModelMap model) throws Exception {
		LOGGER.info("/usr/community/univercity.do - 사용자 > 한디원 뉴스 > 진학현황");
		session.setAttribute("menuNo", "602");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/community/univercity";
	}
	
	// 공모전수상내역
	@RequestMapping("/usr/community/exhibit.do")
	public String exhibit(HttpSession session, ModelMap model) throws Exception {
		LOGGER.info("/usr/community/exhibit.do - 사용자 > 한디원 뉴스 > 공모전 수상내역");
		session.setAttribute("menuNo", "40504");

		model.addAttribute("menuType", "0702");
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/community/exhibit";
	}
	
	// 성공취업인터뷰
	@RequestMapping("/usr/community/interview.do")
	public String interview(HttpSession session, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.info("/usr/community/interview.do - 사용자 > 한디원 뉴스 > 성공취업인터뷰");
		session.setAttribute("menuNo", "603");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/community/interview";
	}
	
	// 함께하는기업들
	@RequestMapping("/usr/community/enterprise.do")
	public String enterprise(HttpSession session, ModelMap model) throws Exception {
		LOGGER.info("/usr/community/enterprise.do - 사용자 > 한디원 뉴스 > 함께하는기업들");
		session.setAttribute("menuNo", "604");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/community/enterprise";
	}
	
	// 기업연계수업
	@RequestMapping("/usr/community/association.do")
	public String association(HttpSession session, ModelMap model) throws Exception {
		LOGGER.info("/usr/community/association.do - 사용자 > 한디원 뉴스 > 기업연계수업");
		session.setAttribute("menuNo", "606");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/community/association";
	}
	
	// 입사지원서 양식 메뉴 추가 2021.05.14 반영전
	@RequestMapping("/usr/community/recurForm.do")
	public String recurForm(HttpSession session, ModelMap model) throws Exception {
		LOGGER.info("/usr/community/recurForm.do - 사용자 > 취업센터 > 입사지원서양식");
		session.setAttribute("menuNo", "607");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/community/recruForm";
	}
	
}
