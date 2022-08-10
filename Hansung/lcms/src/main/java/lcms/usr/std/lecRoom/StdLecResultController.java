package lcms.usr.std.lecRoom;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class StdLecResultController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StdLecResultController.class);
	
	@Autowired private StdLecResultDAO stdLecResultDAO;
	@Resource View jsonView;
	
	// 학생 - 강의실 출결/성적 리스트
	@RequestMapping("/usr/std/lecRoom/stdLecResultList.do")
	public String stdLecResultList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecResultList.do - 학생 강의실 출결/성적 리스트");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("stdMenuNo", "104");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		UsrVO sessionVO = (UsrVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		searchVO.setSearchLecture(selLectCode);
		searchVO.setSearchMemberCode(sessionVO.getMemberCode());
		
		EgovMap attend = stdLecResultDAO.selectAttendView(searchVO);
		model.addAttribute("attend", attend);
		
		EgovMap grade = stdLecResultDAO.selectGradeView(searchVO);
		model.addAttribute("grade", grade);
		
		return "/usr/std/lecRoom/stdLecResultList";
	}
	
}
