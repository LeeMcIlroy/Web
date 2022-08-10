package lcms.usr.std.myPage;

import java.util.List;

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

import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class StdCompletionController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StdCompletionController.class);
	
	@Autowired private StdCompletionDAO stdCompletionDAO;
	@Resource View jsonView;
	
	// 학생 - 수료현황 리스트
	@RequestMapping("/usr/std/myPage/stdCompletionList.do")
	public String stdDormitoryList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/myPage/stdCompletionList.do - 학생 수료현황 리스트");
		request.getSession().setAttribute("stdMenuNo", "204	");
		
		/*List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		List<EgovMap> semeList = cmmDAO.selectSemeList(yearList.get(0));
		model.addAttribute("semeList", semeList);
		
		EgovMap semester = (EgovMap) request.getSession().getAttribute("semester");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) semester.get("semYear"));
		}
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}*/
		
		UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
		searchVO.setSearchMemberCode(sessionVO.getMemberCode());
		
		List<EgovMap> resultList = stdCompletionDAO.selectStdCompletionList(searchVO);
		model.addAttribute("resultList", resultList);
		
		return "/usr/std/myPage/stdCompletionList";
	}
	
	
	
	
}
