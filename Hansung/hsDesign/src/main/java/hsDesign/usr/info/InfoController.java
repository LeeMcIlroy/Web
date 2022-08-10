package hsDesign.usr.info;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import hsDesign.usr.cmm.CmmController;
import hsDesign.usr.cmmBoard.CmmBoardController;

@Controller
public class InfoController extends CmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmBoardController.class);
	
	// 한디원소개
	@RequestMapping("/usr/info/hdIntro.do")
	public String hdIntro(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/info/hdIntro.do - 사용자 > 한디원소개 > 한디원소개");
		session.setAttribute("menuNo", "401");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/info/hdIntro";
	}
	
	// 총장 인사말
	@RequestMapping("/usr/info/presidentGreeting.do")
	public String presidentGreeting(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/info/presidentGreeting.do - 사용자 > 한디원소개 > 총장인사말");
		session.setAttribute("menuNo", "402");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/info/presidentGreeting";
	}
	
	// 원장 인사말
	@RequestMapping("/usr/info/ledgerGreeting.do")
	public String ledgerGreeting(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/info/ledgerGreeting.do - 사용자 > 한디원소개 > 원장인사말");
		session.setAttribute("menuNo", "403");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/info/ledgerGreeting";
	}
	
	// 오시는길
	@RequestMapping("/usr/info/location.do")
	public String location(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/info/location.do - 사용자 > 한디원소개 > 오시는길");
		session.setAttribute("menuNo", "404");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/info/location";
	}
	
	// 조직 및 연락처
	@RequestMapping("/usr/info/hotline.do")
	public String hotline(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/info/hotline.do - 사용자 > 한디원소개 > 기관정보공시");
		session.setAttribute("menuNo", "405");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/info/hotline";
	}
	
	// 해외프로그램
	@RequestMapping("/usr/info/promotionVideo.do")
	public String promotionVideo(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/info/promotionVideo.do - 사용자 > 한디원소개 > 해외프로그램");
		session.setAttribute("menuNo", "23001");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/info/promotionVideo";
	}
	// 기관정보공시
	@RequestMapping("/usr/info/disclosure.do")
	public String disclosure(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/info/disclosure.do - 사용자 > 한디원소개 > 기관정보공시");
		session.setAttribute("menuNo", "407");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/info/disclosure";
	}
	
	
	
}
