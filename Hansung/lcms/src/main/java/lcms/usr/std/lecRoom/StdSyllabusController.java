package lcms.usr.std.lecRoom;

import java.util.ArrayList;
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
import lcms.valueObject.AttachVO;
import lcms.valueObject.LectureTimeTableVO;
import lcms.valueObject.SyllabusVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class StdSyllabusController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StdSyllabusController.class);
	
	@Autowired private StdSyllabusDAO stdSyllabusDAO;
	@Resource View jsonView;
	
	// 학생 - 강의계획서
	@RequestMapping("/usr/std/lecRoom/stdSyllabusView.do")
	public String stdSyllabusView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String memberSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdSyllabusView.do - 학생 강의계획서");
		request.getSession().setAttribute("stdMenuNo", "102");
		
		// 세션에서 강의 SEQ 정보 가져오기
		EgovMap lectSession = (EgovMap)session.getAttribute("lecSession");
		
		//강의 계획서 조회
		SyllabusVO syllabusVO = stdSyllabusDAO.stdSelectLecSyll(String.valueOf((int)lectSession.get("lectSeq")));
		
		if(syllabusVO != null){
			//강의 계획서 업로드 파일 조회
			List<EgovMap> syllaFiles = stdSyllabusDAO.stdSelectSyllaFiles(syllabusVO.getSyllaSeq());
			EgovMap map = new EgovMap();
			map.put("boardSeq", syllabusVO.getSyllaSeq());
			map.put("boardType", "SYLL");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			//강의계획서 주차별계획 조회

		  //List<EgovMap> lecSyllaWeek = stdSyllabusDAO.stdSelectSyllaWeek(syllabusVO.getSyllaSeq());
			List<LectureTimeTableVO> resultList = stdSyllabusDAO.selectLectTimetables(syllabusVO.getClssSeq());
			List<EgovMap> timeTableList = replaceTimeTable(resultList);
			model.addAttribute("fileList", syllaFiles);
			model.addAttribute("attachList", attachList);
			model.addAttribute("timeTableList", timeTableList);
			
		  //model.addAttribute("weekList", lecSyllaWeek);
		}
		
		model.addAttribute("result", syllabusVO);
		model.addAttribute("lectSession", lectSession);

		return "/usr/std/lecRoom/stdSyllabusView";
	}

	private List<EgovMap> replaceTimeTable(List<LectureTimeTableVO> paramList){
		
		List<EgovMap> resultList = new ArrayList<EgovMap>();
		
		for(int i = 1; i<=6; i++){
			EgovMap time = new EgovMap();
			for(LectureTimeTableVO lttVO : paramList){
				if(Integer.parseInt(lttVO.getLectSclass()) <= i && Integer.parseInt(lttVO.getLectEclass())>=i){
					time.put(lttVO.getLectWeek(), lttVO.getLectGrammar());
				} 
			}
			resultList.add(time);	
		}
		return resultList;
	}
	
}
