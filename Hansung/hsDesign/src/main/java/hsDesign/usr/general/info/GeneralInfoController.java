 package hsDesign.usr.general.info;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

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

import component.file.CmmnFileMngUtil;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.usr.cmm.CmmController;
import hsDesign.valueObject.GeneralEduVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class GeneralInfoController extends CmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(GeneralInfoController.class);
	
	@Autowired private GeneralInfoDAO generalInfoDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/usr/general/info/generalInfoList.do";
	}
	
	// 목록
	@RequestMapping("/usr/general/info/generalInfoList.do")
	public String GeneralInfoList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/general/info/GeneralInfoList.do - 사용자 > 교양과정 > 교양과정안내 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft menu
		session.setAttribute("menuNo", "801");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		
		//첫 리스트 화면 현재 년도만 표시되게
		if("".equals(searchVO.getSearchCondition3()) || searchVO.getSearchCondition3() == null){
			SimpleDateFormat format = new SimpleDateFormat("yyyy");
			Date time = new Date();
					
			searchVO.setSearchCondition3(format.format(time));
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 30, 10);
		CmmnListVO listVO = generalInfoDAO.selectGeneralInfoList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());

		return "/usr/general/info/generalInfoList";
	}
	
	// 조회
	@RequestMapping("/usr/general/info/generalInfoView.do")
	public String generalInfoView(@RequestParam String geSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/general/info/generalInfoView.do - 사용자 > 교양과정 > 교양과정안내 조회");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("geSeq = "+geSeq);
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		
		GeneralEduVO generalEduVO = generalInfoDAO.selectGeneralInfoOne(geSeq);
		model.addAttribute("generalEduVO", generalEduVO);
		
		// 첨부파일
		CmmnListVO geUpfileListVO = generalInfoDAO.selectGeneralInfoUpfileList(geSeq);
		model.addAttribute("geUpfileList", geUpfileListVO.getEgovList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/general/info/generalInfoView";
	}
}
