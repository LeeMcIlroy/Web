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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.MeetLogVO;
import lcms.valueObject.MeetProfVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecClssMeetController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecClssMeetController.class);
	
	@Autowired private LecClssMeetDAO lecClssMeetDAO;
	@Resource View jsonView;
	@Resource private CmmnFileMngUtil fileUtil;
	
	private String redirectList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/clss/lecClssMeetList.do";
	}
	
	// 강사 - 수업 - 급별회의록 목록 화면
	@RequestMapping("/usr/lec/clss/lecClssMeetList.do")
	public String lecClssMeetList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssMeetList.do - 강사 -수업-급별회의록 목록 화면");
		request.getSession().setAttribute("lecMenuNo", "107");
		
		EgovMap lecSession = (EgovMap) request.getSession().getAttribute("lecSession");
		
		searchVO.setSearchCondition1((String) lecSession.get("lectYear"));
		searchVO.setSearchCondition2((String) lecSession.get("lectSem"));
		searchVO.setSearchCondition3((String) lecSession.get("lectGrade"));
		searchVO.setSearchCondition4((String) lecSession.get("lectProg"));
		
		List<EgovMap> resultList = lecClssMeetDAO.selectLecClssMeetList(searchVO);
		model.addAttribute("resultList", resultList);
		
		return "/usr/lec/clss/lecClssMeetList";
	}
	
	// 강사 - 수업 - 급별회의록 등록&수정 화면
	@RequestMapping("/usr/lec/clss/lecClssMeetModify.do")
	public String lecClssMeetModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String week, String grade, String meetSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssMeetModify.do - 강사 -수업-급별회의록 등록&수정 화면");
		LOGGER.debug("week = " + week + ", grade = " + grade + ", meetSeq = " + meetSeq);
		request.getSession().setAttribute("lecMenuNo", "107");
		
		EgovMap semester = (EgovMap) request.getSession().getAttribute("semester");
		EgovMap lecSession = (EgovMap) request.getSession().getAttribute("lecSession");
		
		MeetLogVO meetLogVO = new MeetLogVO();
		
		EgovMap map = new EgovMap();
		map.put("week", week);
		map.put("grade", grade);
		map.put("meetSeq", meetSeq);
		map.put("semYear", semester.get("semYear"));
		map.put("semester", semester.get("semester"));
		map.put("prog", (String) lecSession.get("lectProg"));
		semester.put("lectProg", (String) lecSession.get("lectProg"));
		
		if(!EgovStringUtil.isEmpty(meetSeq)){
			meetLogVO = lecClssMeetDAO.selectLecClssMeetModify(map);
			
			List<MeetProfVO> meetProfList = lecClssMeetDAO.selectLecMeetProfList(map);
			meetLogVO.setMeetProfList(meetProfList);
		}else{
			meetLogVO.setWeek(week);
			meetLogVO.setGrade(grade);
			meetLogVO.setYear((String) semester.get("semYear"));
			meetLogVO.setSemester((String) semester.get("semester"));
			meetLogVO.setProg((String) lecSession.get("lectProg"));
		}
		
		model.addAttribute("meetLogVO", meetLogVO);
		
		List<EgovMap> lectList = lecClssMeetDAO.selectLecLectGradeList(map);
		model.addAttribute("lectList", lectList);
		
		List<EgovMap> timeList = cmmDAO.selectTimeList(semester);
		model.addAttribute("timeList", timeList);
		
		EgovMap weekMap = lecClssMeetDAO.selectLecMeetWeek(map);
		model.addAttribute("weekMap", weekMap);
		
		List<EgovMap> profList = lecClssMeetDAO.selectLecProfList(map);
		model.addAttribute("profList", profList);
		
		return "/usr/lec/clss/lecClssMeetModify";
	}
	
	// 강사 - 수업 - 급별회의록 등록&수정
	@RequestMapping("/usr/lec/clss/lecClssMeetUpdate.do")
	public String lecClssMeetUpdate(@ModelAttribute("meetLogVO") MeetLogVO meetLogVO, HttpSession session, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssMeetUpdate.do - 강사 -수업-급별회의록 등록&수정");
		LOGGER.debug("meetLogVO = " + meetLogVO.toString());
		String message = "";
		
		if(EgovStringUtil.isEmpty(meetLogVO.getMeetSeq())){
			lecClssMeetDAO.insertLecClssMeetLog(meetLogVO);
			
			for(MeetProfVO meetProfVO : meetLogVO.getMeetProfList()){
				meetProfVO.setMeetSeq(meetLogVO.getMeetSeq());
				lecClssMeetDAO.insertLecClssMeetProf(meetProfVO);
			}
			
			message = "등록이 완료되었습니다.";
		}else{
			lecClssMeetDAO.updateLecClssMeetLog(meetLogVO);
			
			for(MeetProfVO meetProfVO : meetLogVO.getMeetProfList()){
				meetProfVO.setMeetSeq(meetLogVO.getMeetSeq());
				if(EgovStringUtil.isEmpty(meetProfVO.getMprofSeq())){
					lecClssMeetDAO.insertLecClssMeetProf(meetProfVO);
				}else{
					lecClssMeetDAO.updateLecClssMeetProf(meetProfVO);
				}
			}
			
			message = "수정이 완료되었습니다.";
		}
		
		return redirectList(reda, message);
	}
	
	// 강사 - 수업 - 급별회의록 제출
	@RequestMapping("/usr/lec/clss/lecClssMeetLogSubmis.do")
	public View lecClssMeetLogSubmis(String meetSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssMeetUpdate.do - 강사 -수업-급별회의록 제출");
		LOGGER.debug("meetSeq = " + meetSeq);
		String message = "존재하지 않는 회의록입니다.";
		
		if(!EgovStringUtil.isEmpty(meetSeq)){
			lecClssMeetDAO.updateLecClssMeetLogSubmis(meetSeq);
			message = "제출이 완료되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}

	// 강사 - 수업 - 급별회의록 복사
	@RequestMapping("/usr/lec/clss/lecClssMeetProfCopy.do")
	public View lecClssMeetProfCopy(String grade, String lectSeq, String week, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssMeetProfCopy.do - 강사 -수업-급별회의록 복사");
		LOGGER.debug("grade = " + grade + ", lectSeq = " + lectSeq + ", week = " + week);
		String message = "이전 주 내용이 존재하지 않습니다.";
		
		EgovMap map = new EgovMap();
		map.put("grade", grade);
		map.put("lectSeq", lectSeq);
		map.put("week", week);
		
		List<EgovMap> meetProfList = lecClssMeetDAO.selectLecClssMeetProfCopy(map);
		model.addAttribute("resultList", meetProfList);
		
		if(meetProfList != null && meetProfList.size() != 0){
			message = "복사가 완료되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
}
