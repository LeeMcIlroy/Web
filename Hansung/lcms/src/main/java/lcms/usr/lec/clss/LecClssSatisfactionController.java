package lcms.usr.lec.clss;

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
import lcms.cmm.CmmDAO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecClssSatisfactionController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecClssSatisfactionController.class);
	
	@Autowired private LecClssSatisfactionDAO lecClssSatisfactionDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource View jsonView;
	
	// 강사 - 수업 - 수업만족도 목록
	@RequestMapping("/usr/lec/clss/lecClssSatisfactionList.do")
	public String lecClssSatisfactionList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssSatisfactionList.do - 강사 -수업-수업만족도 목록");
		request.getSession().setAttribute("lecMenuNo", "106");
		
		EgovMap lecSession = (EgovMap) request.getSession().getAttribute("lecSession");
		UsrVO usrSession = (UsrVO) request.getSession().getAttribute("usrSession");
		
		searchVO.setSearchCondition1((String) lecSession.get("lectYear"));
		searchVO.setSearchCondition2((String) lecSession.get("lectSem"));
		searchVO.setSearchLecture(String.valueOf(lecSession.get("lectSeq")));
		searchVO.setSearchMemberCode(usrSession.getMemberCode());
		
		EgovMap resultMap = lecClssSatisfactionDAO.selectSatisView(searchVO);
		model.addAttribute("resultMap", resultMap);
		
		searchVO.setSearchType("PRF");
		searchVO.setSearchCondition8(String.valueOf(resultMap.get("surveySeq")));
		
		List<EgovMap> scoreList = lecClssSatisfactionDAO.selectSatisScoreList(searchVO);
		model.addAttribute("scoreList", scoreList);
		
		// 오점척도
		searchVO.setSearchCondition7("1");
		List<EgovMap> quesList = lecClssSatisfactionDAO.selectSatisQuesList(searchVO);
		model.addAttribute("quesList", quesList);

		// 단답형
		searchVO.setSearchCondition7("2");
		List<EgovMap> shortList = lecClssSatisfactionDAO.selectSatisQuesList(searchVO);
		model.addAttribute("shortList", shortList);
		
		// 자유기재형
		List<EgovMap> txtList = lecClssSatisfactionDAO.selectStatisTxtList(searchVO);
		model.addAttribute("txtList", txtList);
		
		return "/usr/lec/clss/lecClssSatisfactionList";
	}

	// 강사 - 수업 - 수업만족도 질문지 조회
	@RequestMapping("/usr/lec/clss/lecClssSatisfactionView.do")
	public String lecClssSatisfactionView(HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssSatisfactionView.do - 강사 -수업-수업만족도 질문지 조회");
		
		EgovMap map = new EgovMap();
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		map.put("lectSeq", selLectCode);
		
		EgovMap semester = (EgovMap) request.getSession().getAttribute("semester");
		map.put("semYear", semester.get("semYear"));
		map.put("semester", semester.get("semester"));
		
		UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
		map.put("profCode", sessionVO.getMemberCode());
		
		List<EgovMap> resultList = lecClssSatisfactionDAO.selectLecClssSatisfactionView(map);
		model.addAttribute("resultList", resultList);
		
		return "/usr/lec/clss/lecClssSatisfactionView";
	}
}
