package lcms.cmm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;

@Controller
public class CmmController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmController.class);
	@Autowired private CmmDAO cmmDAO;
	@Resource View jsonView;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	// 공용 학기찾기
	@RequestMapping("/usr/cmm/ajaxSearchSeme.do")
	public View ajaxSearchSeme(String year,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/cmm/ajaxSearchSeme.do - 공용 학기찾기");
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(year);
		model.addAttribute("semeList", semeList);
		
		return jsonView;
	}
	
	// 공용 학생찾기
	@RequestMapping("/usr/lec/cmm/ajaxSearchStd.do")
	public View admSemeList(String searchWord, String searchType, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/cmm/ajaxSearchStd.do - 공용 학생찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");

		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("searchType", searchType);
		map.put("selLectCode", selLectCode);
		
		List<EgovMap> resultList = cmmDAO.selectStdList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}

	// 업무담당자 공용 학생찾기
	@RequestMapping("/qxsepmny/cmm/admAjaxSearchStd.do")
	public View admAjaxSearchStd(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/admAjaxSearchStd.do - 업무담당자 공용 학생찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		List<EgovMap> resultList = cmmDAO.selectAdmStdList(searchWord);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}

	// 업무담당자 교과목 찾기
	@RequestMapping("/qxsepmny/cmm/admAjaxSearchCour.do")
	public View admAjaxSearchCour(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/admAjaxSearchCour.do - 업무담당자 교과목 찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		List<String> resultList = cmmDAO.selectCourList(searchWord);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 출석부 팝업
	@RequestMapping("/qxsepmny/cmm/attendancePop.do")
	public String attendancePop(String lectSeq, HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/attendancePop.do - 출석부 팝업");
		LOGGER.debug("lectSeq = " + lectSeq.toString());
		
		EgovMap lectSeme = cmmDAO.selectLectSeme(lectSeq);
		
		EgovMap lecture = cmmDAO.selectAdmLecture(lectSeq);
		model.addAttribute("lecture", lecture);
		
		List<EgovMap> lectTimeList = cmmDAO.selectLectTimeList(lectSeq);
		model.addAttribute("lectTimeList", lectTimeList);
		
		lectSeme.put("lectProg", lecture.get("lectProg"));
		
		List<EgovMap> timeList = cmmDAO.selectTimeList(lectSeme);
		
		if("2020".equals(lectSeme.get("semYear")) && "3".equals(lectSeme.get("semester")) && "특별과정".equals(lectSeme.get("lectProg"))){
			EgovMap map = new EgovMap();
			
			map.put("clstmCode", "4");
			map.put("clstmName", "특별과정");
			
			timeList.add(map);
		}
		
		model.addAttribute("timeList", timeList);
		
		List<EgovMap> memberList = cmmDAO.selectAdmAttPopMemberList(lectSeq);
		model.addAttribute("memberList", memberList);
		
		List<EgovMap> attendList = cmmDAO.selectAdmAttendPopList(lectSeq);
		model.addAttribute("attendList", attendList);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startDate = new Date();
		Date endDate = new Date();
		
		if("정규과정".equals(lecture.get("lectProg"))){
			startDate = sdf.parse((String) lectSeme.get("enterRegiS"));
			endDate = sdf.parse((String) lectSeme.get("enterRegiE"));
		}else{
			startDate = sdf.parse((String) lecture.get("lectSdate"));
			endDate = sdf.parse((String) lecture.get("lectEdate"));
		}
		
		List<EgovMap> dates = new ArrayList<EgovMap>();
		List<String> weekOfMonth = new ArrayList<String>();
		Date currentDate = startDate;
		int before = 0;
		int bfMonth = 0;
		int cnt = 0;
		
		while (currentDate.compareTo(endDate) <= 0) {
			
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			
			if(before == 0){
				before = c.get(Calendar.WEEK_OF_MONTH);
				bfMonth = c.get(Calendar.MONTH)+1;
			}
			
			int weekNum = c.get(Calendar.DAY_OF_WEEK);
			for(EgovMap map : lectTimeList){
				if(String.valueOf(weekNum).equals(map.get("lectWeekNum"))){
					SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
					EgovMap dateMap = new EgovMap();
					dateMap.put("currDate", form.format(currentDate));
					dateMap.put("month", c.get(Calendar.MONTH)+1);
					dateMap.put("date", c.get(Calendar.DATE));
					dateMap.put("week", map.get("lectWeek"));
					dates.add(dateMap);
					cnt++;
				}
			}

			if(before != c.get(Calendar.WEEK_OF_MONTH) && cnt != 0){
				before = c.get(Calendar.WEEK_OF_MONTH);
				if(cnt == lectTimeList.size()){
					weekOfMonth.add(String.valueOf(cnt));
					cnt = 0;
				}
			}
			
			if(bfMonth != c.get(Calendar.MONTH)+1){
				bfMonth = c.get(Calendar.MONTH)+1;
			}
			
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
		}
		if(cnt != 0){
			weekOfMonth.add(String.valueOf(cnt));
		}
		model.addAttribute("dates", dates);
		model.addAttribute("weekOfMonth", weekOfMonth);
		
		return "/adm/cmm/attendancePop";
	}

	// 급별회의록 팝업
	@RequestMapping("/qxsepmny/cmm/meetLogPop.do")
	public String meetLogPop(String meetSeq, String prog, HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/meetLogPop.do - 급별회의록 팝업");
		LOGGER.debug("meetSeq = " + meetSeq + ", prog = " + prog);
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("meetSeq", meetSeq);
		paramMap.put("prog", prog);
		
		EgovMap meetLogMap = cmmDAO.selectMeetLogPop(paramMap);
		model.addAttribute("meetLogMap", meetLogMap);
		
		EgovMap semester = new EgovMap();
		semester.put("semYear", meetLogMap.get("year"));
		semester.put("semester", meetLogMap.get("semester"));
		semester.put("lectProg", prog);
		
		List<EgovMap> lectList = cmmDAO.selectGradeLectList(meetLogMap);
		model.addAttribute("lectList", lectList);
		
		List<EgovMap> timeList = cmmDAO.selectTimeList(semester);
		model.addAttribute("timeList", timeList);
		
		EgovMap meetWeek = cmmDAO.selectMeetWeekPop(meetLogMap);
		model.addAttribute("meetWeek", meetWeek);
		
		List<EgovMap> meetProfList = cmmDAO.selectMeetProfList(meetSeq);
		model.addAttribute("meetProfList", meetProfList);
		
		return "/adm/cmm/meetLogPop";
	}
	
}
