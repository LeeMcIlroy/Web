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
import lcms.valueObject.SemesterVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class StdScheduleController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StdScheduleController.class);
	
	@Autowired private StdScheduleDAO stdScheduleDAO;
	@Resource View jsonView;
	
	// 학생 - 시간표
	@RequestMapping("/usr/std/myPage/stdScheduleView.do")
	public String stdScheduleView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, SemesterVO semesterVO ,HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/myPage/stdScheduleView.do - 학생 시간표");
		request.getSession().setAttribute("stdMenuNo", "202");
		
		//세션값
		UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
		EgovMap semester = cmmDAO.selectOpenSeme();
		
		searchVO.setSearchMemberCode(usrVO.getMemberCode());
		searchVO.setSearchCondition5((String) semester.get("semYear"));
		searchVO.setSearchCondition6((String) semester.get("semester"));
		
		// 학생 신청 과목 리스트 (상단표시)
		List<EgovMap> stdScheduleView = stdScheduleDAO.stdLectView(searchVO);
		model.addAttribute("resultList",stdScheduleView);

     	// 학생 신청 과목 시간표 (하단표시)
     	// List<LectureTimeTableVO> resultList = stdScheduleDAO.selectStdLectTimetables(map);
     	//지원한 강의 리스트
     	/*List<EgovMap> lecSeqList = stdScheduleDAO.selectStdLectSeq(map);*/
     	
     	// List<EgovMap> timeTableList = replaceTimeTable(resultList);
     	
     	// model.addAttribute("timeTableList", timeTableList);
     	
		return "/usr/std/myPage/stdScheduleView";
	}
	
     /*private List<EgovMap> replaceTimeTable(List<LectureTimeTableVO> paramList){
		
		List<EgovMap> resultList = new ArrayList<EgovMap>();

		for(int i=1; i<=6; i++){
			EgovMap time = new EgovMap();
		
			for(LectureTimeTableVO lttVO : paramList){
				
				int stdRegiCnt = Integer.parseInt(lttVO.getLectStdRegiCnt());
				for(int J=1; J<=stdRegiCnt; J++){
					if (lttVO.getLectCode().equals("11") ) {
						if(Integer.parseInt(lttVO.getLectSclass()) <= i && Integer.parseInt(lttVO.getLectEclass()) >= i){
							time.put(lttVO.getLectWeek(), lttVO.getLectGrammar());
						}
					}
				}
				resultList.add(time);
			}
		}
		
		return resultList;
     }*/
}
