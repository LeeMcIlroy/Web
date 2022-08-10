package hsDesign.usr.hdaCampus;

import java.nio.channels.SeekableByteChannel;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import hsDesign.usr.cmm.CmmController;
import hsDesign.usr.cmmBoard.CmmBoardController;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class HdaCampusController extends CmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CmmBoardController.class);

	// 학사일정
	@RequestMapping("/usr/hdaCampus/adcal/academicCalendar.do")
	public String academicCalendar(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/hdaCampus/adcal/academicCalendar.do - 사용자 > 한디원캠퍼스 > 학사안내");
		session.setAttribute("menuNo", "301");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/hdaCampus/adcal/academicCalendar";
	}
	
	// 학사안내
	@RequestMapping("/usr/hdaCampus/guide/affairsGuide.do")
	public String affairsGuide(ModelMap model, HttpSession session, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.info("/usr/hdaCampus/guide/affairsGuide.do - 사용자 > 한디원캠퍼스 > 학사안내");
		session.setAttribute("menuNo", "302");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/hdaCampus/guide/affairsGuide";
	}
	// 장학제도
	@RequestMapping("/usr/hdaCampus/scholarship.do")
	public String scholarship(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/hdaCampus/scholarship.do - 사용자 > 한디원캠퍼스 > 장학제도");
		session.setAttribute("menuNo", "303");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/hdaCampus/scholarship";
	}
	
	// 보유과목안내
	@RequestMapping("/usr/hdaCampus/liberal.do")
	public String liberal(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/hdaCampus/liberal.do - 사용자 > 한디원캠퍼스 > 보유과목안내");
		session.setAttribute("menuNo", "409");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		
		//pdf
		model.addAttribute("pdfList", selectPdfList("3"));
		
		return "/usr/hdaCampus/liberal";
	}
}
