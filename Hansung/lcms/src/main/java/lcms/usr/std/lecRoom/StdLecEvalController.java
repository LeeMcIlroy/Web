package lcms.usr.std.lecRoom;

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

import component.web.PaginationController;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.SurveyAnswVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class StdLecEvalController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StdLecEvalController.class);
	
	@Autowired private StdLecEvalDAO stdLecEvalDAO;
	@Resource View jsonView;
	
	// 학생 - 강의실 수업만족도 리스트
	@RequestMapping("/usr/std/lecRoom/stdLecEvalList.do")
	public String stdLecEvalList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecEvalList.do - 학생 강의실 수업만족도 리스트");
		request.getSession().setAttribute("stdMenuNo", "105");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		searchVO.setSearchLecture(selLectCode);
		
		UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
		searchVO.setSearchMemberCode(sessionVO.getMemberCode());
		
		EgovMap semester = (EgovMap) request.getSession().getAttribute("semester");
		searchVO.setSearchCondition1((String) semester.get("semYear")); 
		searchVO.setSearchCondition2((String) semester.get("semester")); 
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = stdLecEvalDAO.selectStdLecEvalList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		List<EgovMap> profList = stdLecEvalDAO.selectProfList(selLectCode);
		model.addAttribute("profList", profList);
		
		List<EgovMap> langList = stdLecEvalDAO.selectLangList(semester);
		model.addAttribute("langList", langList);
		
		return "/usr/std/lecRoom/stdLecEvalList";
	}
	
	// 학생 - 강의실 수업만족도 작성화면
	@RequestMapping("/usr/std/lecRoom/stdLecEvalModify.do")
	public String stdLecEvalModify(String surveySeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecEvalModify.do - 학생 강의실 수업만족도 작성화면");
		LOGGER.debug("surveySeq = " + surveySeq);
		
		SurveyAnswVO surveyAnswVO = new SurveyAnswVO();
		
		EgovMap resultMap = stdLecEvalDAO.selectStdLecEvalSurvey(surveySeq);
		model.addAttribute("resultMap", resultMap);
		
		List<EgovMap> resultList = stdLecEvalDAO.selectStdLecEvalModify(surveySeq);
		model.addAttribute("resultList", resultList);
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		List<EgovMap> profList = stdLecEvalDAO.selectProfList(selLectCode);
		model.addAttribute("profList", profList);

		model.addAttribute("surveyAnswVO", surveyAnswVO);
		
		return "/usr/std/lecRoom/stdLecEvalModify";
	}

	// 학생 - 강의실 수업만족도 등록
	@RequestMapping("/usr/std/lecRoom/stdLecEvalUpdate.do")
	public String stdLecEvalUpdate(SurveyAnswVO surveyAnswVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecEvalUpdate.do - 학생 강의실 수업만족도 등록");
		LOGGER.debug("surveyAnswVO = " + surveyAnswVO.toString());
		String message = "";
		
		UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		
		for(SurveyAnswVO paramVO : surveyAnswVO.getSurveyAnswList()){
			paramVO.setMemberCode(sessionVO.getMemberCode());
			paramVO.setLectSeq(selLectCode);
			stdLecEvalDAO.insertstdLecEval(paramVO);
			message = "등록이 완료되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return "/usr/std/lecRoom/stdLecEvalModify";
	}
	
	// 학생 - 강의실 수업만족도 조회
	@RequestMapping("/usr/std/lecRoom/stdLecEvalView.do")
	public String stdLecEvalView(HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecEvalView.do - 학생 강의실 수업만족도 조회");
		
		UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		
		EgovMap map = new EgovMap();
		map.put("memberCode", sessionVO.getMemberCode());
		map.put("lectSeq", selLectCode);
		
		List<EgovMap> resultList = stdLecEvalDAO.selectStdLecEvalView(map);
		model.addAttribute("resultList", resultList);
		
		String surveySeq = Integer.toString((int) resultList.get(0).get("surveySeq"));
		EgovMap resultMap = stdLecEvalDAO.selectStdLecEvalSurvey(surveySeq);
		model.addAttribute("resultMap", resultMap);
		
		List<EgovMap> profList = stdLecEvalDAO.selectProfList(selLectCode);
		model.addAttribute("profList", profList);

		return "/usr/std/lecRoom/stdLecEvalView";
	}
	
}
