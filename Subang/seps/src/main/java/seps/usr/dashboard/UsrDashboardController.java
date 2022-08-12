package seps.usr.dashboard;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import component.util.ComStringUtil;
import component.util.DateTempletUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import seps.batch.ScheduleTask;
import seps.cmmn.SepsCommonCode;
import seps.usr.totalInfo.UsrTotalInfoDAO;
import seps.valueObject.FloodControlVO;
import seps.valueObject.SnsVO;
import seps.valueObject.UserInfoVO;
import valueObject.CmmnSearchVO;

@Controller
public class UsrDashboardController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UsrDashboardController.class);
	
	@Resource View jsonView;
	@Autowired UsrDashboardDAO dao;
	@Autowired private UsrTotalInfoDAO usrTotalInfoDAO;
	
	//사용자 종합사용판
	@RequestMapping("/usr/dashboard/main.do")
	public String dashboardMain(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/dashboard/main.do - 사용자 종합상황판");
		if(session != null) session.setAttribute("leftMeneNo", "101");
		session.setAttribute("adminPage", "N");
		//공통데이터 호출
		model = commonData(searchVO, model);
		
		String[] timeArr = ScheduleTask.initDate();
		searchVO.setStartDate(timeArr[0]);
		searchVO.setEndDate(timeArr[1]);
		
		//수방근무현황 목록
		List<EgovMap> snsList = dao.selectSnsList();
		for (EgovMap egovMap : snsList) {
			if("FC".equals(egovMap.get("tType").toString())){
				egovMap.put("issueDate", egovMap.get("issueDate")+"("+DateTempletUtil.getDateDay(egovMap.get("issueDate").toString(), "-")+")");
				egovMap.put("content", ComStringUtil.sepsReturnWeatherLevel(egovMap.get("content").toString())+" "+egovMap.get("issueDate").toString()+" "+egovMap.get("issueTime").toString());
			}
		}
		model.addAttribute("snsList", snsList);
		
		// 월계1교 data - start
		setWaterLevelData(SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, "1", "wolgye", model);
		// 월계1교 data - end
		
		//월릉교
		setWaterLevelData(SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, "2", "wolleung", model);
		
		//중랑교
		setWaterLevelData(SepsCommonCode.JOONGRANG_WATER_LEVEL_CODE, "3", "joongrang", model);
		
		// 여의상류IC data - start
		setWaterLevelData(SepsCommonCode.YEOUI_WATER_LEVEL_CODE, "4", "yeoui", model);
		// 여의상류IC data - end
		
		// 한강대교 data - start
		setWaterLevelData(SepsCommonCode.HANGANG_WATER_LEVEL_CODE, "5", "hangang", model);
		// 한강대교 data - end
		
		
		// ========================= 시간대별 기상현황 추가 =======================================
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 기간 초기화 set - start
		searchVO.setStartDate(sdf.format(new Date()));
		searchVO.setEndDate(sdf.format(new Date()));
		searchVO.setStartTime("00");
		searchVO.setEndTime("23");
		// 기간 초기화 set - end
		
		// 시간대별 기상현황 목록 select - start
		List<EgovMap> weatherStatusList = usrTotalInfoDAO.selectWeatherStatusList(searchVO);

		if(weatherStatusList.size() > 0){
			
			sdf.applyPattern("yyyyMMdd HHmm");
			Calendar cal = Calendar.getInstance();
			
			
			// 서울, 의정부 강수량 | 수위 set - start
			Map<String, String> rainList = null;
			Map<String, String> wlList = null;
			for(EgovMap e : weatherStatusList){
				
				// 단계 set - start
				String stdHourDate = e.get("dttm").toString();	// 기준시간
				
				Date tmpDate = sdf.parse(stdHourDate);
				cal.setTime(tmpDate);
				cal.add(Calendar.HOUR_OF_DAY, -1);
				cal.add(Calendar.MINUTE, 1);
				
				String preHourDate =  sdf.format(cal.getTime());	// 1시간 전
				
				EgovMap floodLevel = usrTotalInfoDAO.selectFloodLevel(stdHourDate, preHourDate);
				if(floodLevel != null){
					e.put("floodLevel", floodLevel);
				}else{
					EgovMap floodLevel2 = usrTotalInfoDAO.selectFloodLevel(stdHourDate, null);
					e.put("floodLevel", floodLevel2);
				}
				// 단계 set - end
				
				// 강수량 set - start
				rainList = new HashMap<>();
				String[] arrRn1 = e.get("arrRn1").toString().split(",");
				for(String rn1 : arrRn1){
					rainList.put(rn1.split("=")[0], rn1.split("=")[1]);
				}
				e.put("rainList", rainList);
				// 강수량 set - end
				
				// 수위 set - start
				wlList = new HashMap<>();
				String[] arrWl = e.get("arrWl").toString().split(",");
				for(String wl : arrWl){
					wlList.put(wl.split("=")[0], wl.split("=")[1]);
				}
				e.put("wlList", wlList);
				// 수위 set - end
			}
			// 서울, 의정부 강수량 | 수위 set - end
		}
		
		model.addAttribute("weatherStatusList", weatherStatusList);
		
		// ========================= 시간대별 기상현황 끝 =======================================
		
		return "/usr/dashboard/main";
	}
	
	//사용자 기상상황판
	@RequestMapping("/usr/dashboard/main2.do")
	public String dashboardWeatherMain(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/dashboard/main.do - 사용자 기후경영");
		if(session != null) session.setAttribute("leftMeneNo", "701");
		session.setAttribute("adminPage", "N");
		//공통데이터 호출
		model = commonData(searchVO, model);
		
		String[] timeArr = ScheduleTask.initDate();
		searchVO.setStartDate(timeArr[0]);
		searchVO.setEndDate(timeArr[1]);
		
		//미세먼지, 초미세먼지 조회
		List<EgovMap> warnList = dao.selectWarnStatus();
		
		if(warnList.size() > 0){
			for (EgovMap warnMap : warnList) {
				String type = warnMap.get("pollutant").toString();
				 warnMap.put("applcDt", DateTempletUtil.getTempletDate4(warnMap));
				if(type.equals("pm10")){
					model.addAttribute("pm10VO", warnMap);
				}else{
					model.addAttribute("pm25VO", warnMap);
				}
			}
		}
		
		//지수 조회
		List<EgovMap> lifeList = dao.selectLifeStatus();
		if(lifeList.size() > 0){
			for(EgovMap lifeMap : lifeList){
				String type = lifeMap.get("code").toString();
				int value = Integer.parseInt(lifeMap.get("value").toString());
				lifeMap.put("baseDate", DateTempletUtil.getTempletDate5(lifeMap));
				if(type.equals("A07_1")){ //자외선
					if(value >=11){ //위험
						lifeMap.put("value", 5);
					}else if(value >= 8 && value <=10){ //매우높음
						lifeMap.put("value", 4);
					}else if(value >= 6 && value <=7){ //높음
						lifeMap.put("value", 3);
					}else if(value >=3 && value <=5){ //보통
						lifeMap.put("value", 2);
					}else { //낮음
						lifeMap.put("value", 1);
					}
					model.addAttribute("a07VO", lifeMap);
				}else if(type.equals("D02")){ //뇌졸중
					// 매우높음 3,높음 2,보통 1,낮음 0
					model.addAttribute("d02VO", lifeMap);
				}else if(type.equals("A06")){ //불쾌지수
				
					if(value >=80){ //매우높음
						lifeMap.put("value", 4);
					}else if(value >= 75 && value < 80){ //높음
						lifeMap.put("value", 3);
					}else if(value >= 68 && value < 75){ //보통
						lifeMap.put("value", 2);
					}else { //낮음
						lifeMap.put("value", 1);
					}
					
					model.addAttribute("a06VO", lifeMap);
					
				}else if(type.equals("A20")){ //더위체감지수
					if(value >=31){ //위험
						lifeMap.put("value", 5);
					}else if(value >= 28 && value < 31){ //매우높음
						lifeMap.put("value", 4);
					}else if(value >= 25 && value < 28){ //높음
						lifeMap.put("value", 3);
					}else if(value >= 21 && value < 25){ //보통
						lifeMap.put("value", 2);
					}else { //낮음
						lifeMap.put("value", 1);
					}
					
					model.addAttribute("a20VO", lifeMap);
					
				}else if(type.equals("A03")){//체감온도
					
					if(value < -45){ //매우높음]
						lifeMap.put("value", 4);
					}else if(value >= -45 && value < -25){ //높음
						lifeMap.put("value", 3);
					}else if(value >= -25 && value < -10){ //보통
						lifeMap.put("value", 2);
					}else { //낮음
						lifeMap.put("value", 1);
					}
					
				
					model.addAttribute("a03VO", lifeMap);
					
				}else if(type.equals("A08")){ //동파가능지수
					if(value == 100){ //매우높음
						lifeMap.put("value", 4);
					}else if(value == 75){ //높음
						lifeMap.put("value", 3);
					}else if(value == 50){ //보통
						lifeMap.put("value", 2);
					}else { //낮음
						lifeMap.put("value", 1);
					}
					
					
					model.addAttribute("a08VO", lifeMap);
				}else if(type.equals("D01")){ // 천식
					if(value >= 3) {// 매우높음
						lifeMap.put("value", 4);
					}else if(value >= 2){ // 높음
						lifeMap.put("value", 3);
					}else if(value >= 1){ // 보통
						lifeMap.put("value", 2);
					}else{// 낮음
						lifeMap.put("value", 1);
					}
					// 낮음 0, 보통 1, 높음 2, 매우높음 3
					model.addAttribute("d01VO", lifeMap);
				}else if(type.equals("A01_2")){ //식중독
					
					// 식중독 지수 (연중) A01_2
					//위험 95이상, 경고 70~95 미만, 주의 35~70 미만, 관심 0~35 미만
					if(value >= 95){ // 위험
						lifeMap.put("value", 4);
					}else if(value >= 70){ // 경고
						lifeMap.put("value", 3);
					}else if(value >= 35){ // 주의
						lifeMap.put("value", 2);
					}else { // 관심
						lifeMap.put("value", 1);
					}
					
					
					model.addAttribute("a012VO", lifeMap);
				}
				
				
			}
		}
		
		//중기예보 조회
		EgovMap middleMap = dao.selectMiddleStatus();
		if(middleMap != null){
			middleMap.put("wf3AmIcon", convertWeatherIcon(middleMap.get("wf3Am").toString()));
			middleMap.put("wf3PmIcon", convertWeatherIcon(middleMap.get("wf3Pm").toString()));
			middleMap.put("wf4AmIcon", convertWeatherIcon(middleMap.get("wf4Am").toString()));
			middleMap.put("wf4PmIcon", convertWeatherIcon(middleMap.get("wf4Pm").toString()));
			middleMap.put("wf5AmIcon", convertWeatherIcon(middleMap.get("wf5Am").toString()));
			middleMap.put("wf5PmIcon", convertWeatherIcon(middleMap.get("wf5Pm").toString()));
			middleMap.put("wf6AmIcon", convertWeatherIcon(middleMap.get("wf6Am").toString()));
			middleMap.put("wf6PmIcon", convertWeatherIcon(middleMap.get("wf6Pm").toString()));
			middleMap.put("wf7AmIcon", convertWeatherIcon(middleMap.get("wf7Am").toString()));
			middleMap.put("wf7PmIcon", convertWeatherIcon(middleMap.get("wf7Pm").toString()));
			model.addAttribute("middleVO", middleMap);
		}
		
		// ================== 동네예보 (마장동 조회) =====================================
		
		String[] areaCode = new String[]{"8"};
		//24시간 누적강수량
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date now = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		cal.add(Calendar.HOUR_OF_DAY, -24);
		String startDate = sdf.format(cal.getTime()).substring(0, 11)+"0";
		searchVO.setSearchCondition1(startDate);
		
		for (String code : areaCode) {
			searchVO.setSearchCode(code);
			EgovMap weatherMap = dao.selectWeather(searchVO);
			String[] tempDate = DateTempletUtil.getTempletDate(weatherMap);
			weatherMap.put("baseDate", tempDate[0]);
			weatherMap.put("baseTime", tempDate[1]);
			model.addAttribute("weather_"+code, weatherMap);
			
			List<EgovMap> weatherList = dao.selectWeatherTimeList(searchVO);
			
			int colspan = 0;
			String tempFcstDate = "";
			String fristTime = "";
			for (EgovMap egovMap : weatherList) {
				
				if(colspan == 0){
					colspan++;
					tempFcstDate = egovMap.get("fcstDate").toString();
					if( (Integer.parseInt(egovMap.get("fcstTime").toString())/100)%6 !=0 ){
						fristTime = egovMap.get("fcstDate").toString()+egovMap.get("fcstTime").toString();
					}
					model.addAttribute("day1_"+code, DateTempletUtil.getTempletDate2(egovMap));
				}else{
					if(tempFcstDate.equals(egovMap.get("fcstDate").toString()) || "0000".equals(egovMap.get("fcstTime").toString())){
						colspan++;
					}else{
						tempFcstDate = egovMap.get("fcstDate").toString();
						model.addAttribute("day2_"+code, DateTempletUtil.getTempletDate2(egovMap));
						break;
					}
				}
			}
			
			//가져온 예보목록 첫VO가 강수량이 없을때
			if(!EgovStringUtil.isEmpty(fristTime)){
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm") ;
				Date nDate = dateFormat.parse(fristTime);
				cal = Calendar.getInstance() ;
				cal.setTime(nDate);
				cal.add(Calendar.HOUR_OF_DAY, -3);
				searchVO.setStartDate(dateFormat.format(cal.getTime()));
				EgovMap fristTimeMap = dao.selectWeatherFristTime(searchVO);
				model.addAttribute("fristTimeMap_"+code, fristTimeMap);
			}
			
			model.addAttribute("colspan1_"+code, colspan);
			model.addAttribute("colspan2_"+code, 8-colspan);
			model.addAttribute("weatherList_"+code, weatherList);
		}
		
		// ================== 동네예보 (마장동 조회) 끝 =====================================
		
		
		return "/usr/dashboard/weatherMain";
	}
	
	// 사용자 종합상황판 새로고침
	@RequestMapping("/usr/dashboard/mainReloadAjax.do")
	public View mainReloadAjax(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/dashboard/mainReloadAjax.do - 사용자 > 종합상황판 ajax");
		CmmnSearchVO searchVO = new CmmnSearchVO();
		dashboardMain(searchVO, model, session, null);
		return jsonView;
	}

	//사용자 동부간선도로
	@RequestMapping("/usr/dashboard/dongbu.do")
	public String dashboardDongbu(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/dashboard/dongbu.do - 사용자 동부간선도로 상황판");
		if(session != null) session.setAttribute("leftMeneNo", "201");
		session.setAttribute("adminPage", "N");
		//공통데이터 호출
		model = commonData(searchVO, model);
		
		String[] timeArr = ScheduleTask.initDate();
		searchVO.setStartDate(timeArr[0]);
		searchVO.setEndDate(timeArr[1]);
		
		// 월계1교 data - start
		setWaterLevelData(SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, "1", "wolgye", model);
		// 월계1교 data - end
		
		//월릉교
		setWaterLevelData(SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, "2", "wolleung", model);
		
		//중랑교
		setWaterLevelData(SepsCommonCode.JOONGRANG_WATER_LEVEL_CODE, "3", "joongrang", model);
		
		// 신곡교 data - start
		setWaterLevelData(SepsCommonCode.SINGOK_WATER_LEVEL_CODE, "4", "singok", model);
		
			// 강수량 그래프 데이터 - start
			List<EgovMap> singokRainGraphData = dao.selectRainGraphData(SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_CODE);
			model.addAttribute("singokRainGraphData", singokRainGraphData);
			// 강수량 그래프 데이터 - end
		// 신곡교 data - end
		
		//24시간 누적강수량
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date now = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		cal.add(Calendar.HOUR_OF_DAY, -24);
		String startDate = sdf.format(cal.getTime()).substring(0, 11)+"0";
		searchVO.setStartDate(startDate);
		//신곡교 코드값
		searchVO.setSearchCode(SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_CODE);
		EgovMap weatherMap = dao.selectWeather(searchVO);
		String[] tempDate = DateTempletUtil.getTempletDate(weatherMap);
		weatherMap.put("baseDate", tempDate[0]);
		weatherMap.put("baseTime", tempDate[1]);
		
		model.addAttribute("singokWeather", weatherMap);
		
		
		//신곡동 기상예보
		List<EgovMap> weatherList = dao.selectWeatherTimeList(searchVO);
		
		int colspan = 0;
		String tempFcstDate = "";
		String fristTime = "";
		for (EgovMap egovMap : weatherList) {
			
			if(colspan == 0){
				colspan++;
				tempFcstDate = egovMap.get("fcstDate").toString();
				if( (Integer.parseInt(egovMap.get("fcstTime").toString())/100)%6 !=0 ){
					fristTime = egovMap.get("fcstDate").toString()+egovMap.get("fcstTime").toString();
				}
				model.addAttribute("day1", DateTempletUtil.getTempletDate2(egovMap));
			}else{
				if(tempFcstDate.equals(egovMap.get("fcstDate").toString()) || "0000".equals(egovMap.get("fcstTime").toString())){
					colspan++;
				}else{
					tempFcstDate = egovMap.get("fcstDate").toString();
					model.addAttribute("day2", DateTempletUtil.getTempletDate2(egovMap));
					break;
				}
			}
		}
		
		//가져온 예보목록 첫VO가 강수량이 없을때
		if(!EgovStringUtil.isEmpty(fristTime)){
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm") ;
			Date nDate = dateFormat.parse(fristTime);
			cal = Calendar.getInstance() ;
			cal.setTime(nDate);
			cal.add(Calendar.HOUR_OF_DAY, -3);
			searchVO.setStartDate(dateFormat.format(cal.getTime()));
			EgovMap fristTimeMap = dao.selectWeatherFristTime(searchVO);
			model.addAttribute("fristTimeMap", fristTimeMap);
		}
		
		model.addAttribute("colspan1", colspan);
		model.addAttribute("colspan2", 8-colspan);
		model.addAttribute("weatherList", weatherList);
		
		
		return "/usr/dashboard/dongbu";
	}

	// 사용자 동부간선도로 새로고침
	@RequestMapping("/usr/dashboard/dongbuReloadAjax.do")
	public View dongbuReloadAjax(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/dashboard/dongbuReloadAjax.do - 사용자 > 동부간선도로 ajax");
		CmmnSearchVO searchVO = new CmmnSearchVO();
		dashboardDongbu(searchVO, model, session, null);
		return jsonView;
	}
	
	
	//사용자 올림픽대로
	@RequestMapping("/usr/dashboard/olympic.do")
	public String dashboardOlympic(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/dashboard/olympic.do - 사용자 올림픽대로 상황판");
		if(session != null) session.setAttribute("leftMeneNo", "301");
		session.setAttribute("adminPage", "N");
		//공통데이터 호출
		model = commonData(searchVO, model);
		
		String[] timeArr = ScheduleTask.initDate();
		searchVO.setStartDate(timeArr[0]);
		searchVO.setEndDate(timeArr[1]);
		
		// 여의상류IC data - start
		setWaterLevelData(SepsCommonCode.YEOUI_WATER_LEVEL_CODE, "1", "yeoui", model);
		// 여의상류IC data - end

		// 한강대교 data - start
		setWaterLevelData(SepsCommonCode.HANGANG_WATER_LEVEL_CODE, "2", "hangang", model);
		// 한강대교 data - end
		
		// 청담대교
		setWaterLevelData(SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE, "3", "cheongdam", model);
		
		// 오금교 data - start
		setWaterLevelData(SepsCommonCode.OGEUM_WATER_LEVEL_CODE, "4", "ogeum", model);

		// 대곡 data - start
		setWaterLevelData(SepsCommonCode.DAEGOK_WATER_LEVEL_CODE, "5", "daegok", model);
		
		//인천앞바다 조위 실측  (인천관측소 set)
		List<EgovMap> tideGraphData = dao.selectTideGraphData("DT_001");
		model.addAttribute("tideGraphData", tideGraphData);
		
		
		/****************************************************************** 팔당댐 data - start ******************************************************************/
		//팔당댐 방류량 현지시간~1시간전
		searchVO.setSearchCode(SepsCommonCode.PALDANG_TOTOTF_CODE);
		List<EgovMap> wlList7 = dao.selectDamLevel(searchVO);
		for (EgovMap egovMap : wlList7) {
			Float tempWl = Float.parseFloat(egovMap.get("tototf").toString());
			
			// 수위 단계 확인
			egovMap.put("level", ComStringUtil.sepsReturnLevel(searchVO.getSearchCode(), tempWl));
			
			egovMap.put("baseTime", egovMap.get("baseTime").toString().subSequence(0, 2)+":"+egovMap.get("baseTime").toString().subSequence(2, 4));
		}
		model.addAttribute("wlList7", wlList7);
		
		// 방류랑 그래프 데이터 - start
		List<EgovMap> paldangDamGraphData = dao.selectDamGraphData(searchVO.getSearchCode());
		model.addAttribute("paldangDamGraphData", paldangDamGraphData);
		// 방류랑 그래프 데이터 - end
		/****************************************************************** 팔당댐 data - end ******************************************************************/
		
		//인천앞바다 조위정보 - 극치
		searchVO.setSearchCondition1("DT_001");
		searchVO.setStartDate(searchVO.getStartDate().substring(0,8));
		List<EgovMap> wlList8 = dao.selectTideTph(searchVO);
		for (EgovMap egovMap : wlList8) {
			egovMap.put("baseTime", egovMap.get("baseTime").toString().subSequence(0, 2)+":"+egovMap.get("baseTime").toString().subSequence(2, 4));
		}
		model.addAttribute("wlList8", wlList8);
		
		return "/usr/dashboard/olympic";
	}
	
	// 사용자 올림픽대로 새로고침
	@RequestMapping("/usr/dashboard/olympicReloadAjax.do")
	public View olympicReloadAjax(ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/dashboard/olympicReloadAjax.do - 사용자 > 올림픽대로 ajax");
		CmmnSearchVO searchVO = new CmmnSearchVO();
		dashboardOlympic(searchVO, model, session, null);
		return jsonView;
	}
	
	/**
	 * 수위 data set
	 * 	(list, graph)
	 * @param waterLevelCode	수위코드
	 * @param num				list 타입
	 * @param graphDataName		graph 타입
	 * @param model				set model
	 */
	private void setWaterLevelData(String waterLevelCode, String num, String graphDataName, ModelMap model){
		try{
			CmmnSearchVO searchVO = new CmmnSearchVO();
			
			// 수위 현재시간~1시간전
			searchVO.setSearchCode(waterLevelCode);
			List<EgovMap> wlList = dao.selectWaterLevel(searchVO);
			
			int index = 0;
			for (EgovMap egovMap : wlList) {
				
				// 마지막 갱신시간
				if(index==0){
					String[] lastTime = DateTempletUtil.getTempletDate(egovMap);
					model.addAttribute("wlTime"+num, lastTime[0].substring(0, 10)+" "+lastTime[1]);
				}
				index++;
				
				Float tempWl = Float.parseFloat(egovMap.get("wl").toString());
				
				// 수위 단계 확인
				egovMap.put("level", ComStringUtil.sepsReturnLevel(searchVO.getSearchCode(), tempWl));
				
				egovMap.put("baseTime", egovMap.get("baseTime").toString().subSequence(0, 2)+":"+egovMap.get("baseTime").toString().subSequence(2, 4));
			}
			model.addAttribute("wlList"+num, wlList);
			
			// 수위 그래프 데이터 - start
			List<EgovMap> waterLevelGraphData = dao.selectWaterLevelGraphData(searchVO.getSearchCode());
			model.addAttribute(graphDataName+"WaterLevelGraphData", waterLevelGraphData);
			// 수위 그래프 데이터 - end
			
		}catch (Exception e){
			LOGGER.warn("수위 데이터 set 중 에러 발생 ({})", e.getMessage());
		}
	}
	
	/***************************************************** 상황판 공통 ajax *****************************************************************/
	// 카카오톡 공유 등록
	@RequestMapping("/usr/dashboard/kakaoShareInsertAjax.do")
	public View kakaoShareInsertAjax(@RequestParam String kakaoTitle, @RequestParam String kakaoContent, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/dashboard/kakaoShareInsertAjax.do - 사용자 카카오톡 공유");
		LOGGER.debug("\nkakaoTitle = {}\nkakaoContent = {}", kakaoTitle, kakaoContent);
		
		UserInfoVO sessionVO = (UserInfoVO) EgovUserDetailsHelper.getAuthenticatedUser();
		SnsVO paramVO = new SnsVO();
		paramVO.setSnsType("K");
		paramVO.setSnsTitle(kakaoTitle);
		paramVO.setSnsContent(kakaoContent);
		paramVO.setRegNm(sessionVO.getUserNm());
		dao.insertSns(paramVO);
		return jsonView;
	}
	
	//사용자작성 메인알림 수정
	@RequestMapping("/usr/dashboard/mainAlarmSubmitAjax.do")
	public View mainAlarmSubmit(@RequestParam String mainAlarm, ModelMap model){
		LOGGER.info("/usr/dashboard/mainAlarmSubmitAjax.do - 사용자작성 메인알림 수정");
		LOGGER.debug("\nmainAlarm = {}", mainAlarm);
		dao.updateUsrAlarm(mainAlarm);
		model.addAttribute("text", mainAlarm);
		return jsonView;
	}
	
	//사용자작성 수방근무현황 등록
	@RequestMapping("/usr/dashboard/mainSnsSubmitAjax.do")
	public View mainSnsSubmit(@RequestParam String snsContent, ModelMap model, HttpServletRequest request){
		LOGGER.info("/usr/dashboard/mainAlarmSubmitAjax.do - 사용자작성 수방근무현황 등록");
		LOGGER.debug("\nsnsContent = {}", snsContent);
		UserInfoVO sessionVO = (UserInfoVO) EgovUserDetailsHelper.getAuthenticatedUser();
		SnsVO paramVO = new SnsVO();
		paramVO.setSnsType("D");
		paramVO.setSnsContent(snsContent);
		paramVO.setRegNm(sessionVO.getUserNm());
		paramVO.setSnsTitle("-");
		dao.insertSns(paramVO);
		return jsonView;
	}
	
	//사용자작성 수방근무현황 갱신
	@RequestMapping("/usr/dashboard/mainSnsReloadAjax.do")
	public View mainSnsReload(ModelMap model, HttpServletRequest request) throws Exception{
		LOGGER.info("/usr/dashboard/mainSnsReloadAjax.do - 사용자작성 수방근무현황 갱신");
		//수방근무현황 목록
		List<EgovMap> resultList = dao.selectSnsList();
		for(EgovMap egovMap : resultList){
			if("FC".equals(egovMap.get("tType").toString())){
				egovMap.put("issueDate", egovMap.get("issueDate")+"("+DateTempletUtil.getDateDay(egovMap.get("issueDate").toString(), "-")+")");
				egovMap.put("content", ComStringUtil.sepsReturnWeatherLevel(egovMap.get("content").toString())+" "+egovMap.get("issueDate").toString()+" "+egovMap.get("issueTime").toString());
			}
		}
		model.addAttribute("resultList", resultList);
		return jsonView;
	}
	
	//사용자작성 수방단계 설정
	@RequestMapping("/usr/dashboard/mainFloodControlSubmitAjax.do")
	public View floodControlSubmitAjax(String floodLevel, String issueDate, String issueTime, String situationType, ModelMap model, HttpServletRequest request) throws Exception{
		LOGGER.info("/usr/dashboard/mainFloodControlSubmitAjax.do - 사용자작성 수방단계 등록");
		LOGGER.debug("\nfloodLevel = {},\nissueDate = {}\nissueTime = {}", floodLevel, issueDate, issueTime);
		//수방단계 등록
		UserInfoVO sessionVO = (UserInfoVO) EgovUserDetailsHelper.getAuthenticatedUser();
		FloodControlVO paramVO = new FloodControlVO();
		paramVO.setFloodLevel(floodLevel);
		paramVO.setIssueDate(issueDate);
		paramVO.setIssueTime(issueTime);
		paramVO.setRegNm(sessionVO.getUserNm());
		paramVO.setSituationType(situationType);
		dao.insertFloodControl(paramVO);
		
		//수방단계
		EgovMap floodMap = dao.selectFloodControl(new CmmnSearchVO());
		switch (floodMap.get("floodLevel").toString()) {
			case "1":
				floodMap.put("floodContent", "1단계(주의)");
				break;
			case "2":
				floodMap.put("floodContent", "2단계(경계)");
				break;
			case "3":
				floodMap.put("floodContent", "3단계(심각)");
				break;
			case "4":
				floodMap.put("floodContent", "평시(관심)");
				break;
			case "5":
				floodMap.put("floodContent", "포트홀(예방)");
				break;
			case "6":
				floodMap.put("floodContent", "보강(주의)");
				break;
			default:
				floodMap.put("floodContent", "평시(관심)");
				break;
		}
		floodMap.put("issueDate", floodMap.get("issueDate")+"("+DateTempletUtil.getDateDay(floodMap.get("issueDate").toString(), "-")+")");
		model.addAttribute("floodMap", floodMap);
		return jsonView;
	}
	
	/***************************************************** 상황판 공통 ajax 끝*****************************************************************/
	
	
	// 상황판 공통 데이터
	public ModelMap commonData(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception{
		
		String[] timeArr = ScheduleTask.initDate();
		searchVO.setStartDate(timeArr[0]);
		searchVO.setEndDate(timeArr[1]);
		
		//수방단계
		EgovMap floodMap = dao.selectFloodControl(searchVO);
		switch (floodMap.get("floodLevel").toString()) {
			case "1":
				floodMap.put("floodContent", "1단계(주의)");
				break;
			case "2":
				floodMap.put("floodContent", "2단계(경계)");
				break;
			case "3":
				floodMap.put("floodContent", "3단계(심각)");
				break;
			case "4":
				floodMap.put("floodContent", "평시(관심)");
				break;
			case "5":
				floodMap.put("floodContent", "포트홀(예방)");
				break;
			case "6":
				floodMap.put("floodContent", "보강(주의)");
				break;
			default:
				floodMap.put("floodContent", "평시(관심)");
				break;
		}
		floodMap.put("issueDate", floodMap.get("issueDate")+"("+DateTempletUtil.getDateDay(floodMap.get("issueDate").toString(), "-")+")");
		model.addAttribute("floodMap", floodMap);
		
		//현재 기준 관측위치별 수위
		List<EgovMap> wlList3 = dao.selectWaterLevel2(searchVO);
		
		for (EgovMap egovMap : wlList3) {
			String placeCode = egovMap.get("wlobscd").toString();
			switch (placeCode) {
			case SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE:
				model.addAttribute("wolgye", egovMap.get("wl"));
				break;
			case SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE:
				model.addAttribute("wolleun", egovMap.get("wl"));
				break;
			case SepsCommonCode.YEOUI_WATER_LEVEL_CODE:
				model.addAttribute("yeoui", egovMap.get("wl"));
				break;
			case SepsCommonCode.SINGOK_WATER_LEVEL_CODE:
				model.addAttribute("singok", egovMap.get("wl"));
				break;
			case SepsCommonCode.HANGANG_WATER_LEVEL_CODE:
				model.addAttribute("hangang", egovMap.get("wl"));
				break;
			case SepsCommonCode.PALDANG_TOTOTF_CODE:
				model.addAttribute("paldang", egovMap.get("wl"));
				break;
			case SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE:
				model.addAttribute("cheongdam", egovMap.get("wl"));
				break;
			case SepsCommonCode.JOONGRANG_WATER_LEVEL_CODE:
				model.addAttribute("joongrang", egovMap.get("wl"));
				break;
			case SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_CODE:
				model.addAttribute("rain", egovMap.get("wl"));
				break;
			case SepsCommonCode.WOLGYE1_HACHEON_WATER_LEVEL_CODE:
				model.addAttribute("wolgye1Hacheon", egovMap.get("wl"));
				break;
			case SepsCommonCode.WOLLEUNG_HACHEON_WATER_LEVEL_CODE:
				model.addAttribute("wolleungHacheon", egovMap.get("wl"));
				break;
			case SepsCommonCode.JOONGRANG_HACHEON_WATER_LEVEL_CODE:
				model.addAttribute("joongrangHacheon", egovMap.get("wl"));
				break;
			default:
				break;
			}
		}
		
		//기상정보 조회 서울기준
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date now = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		cal.add(Calendar.HOUR_OF_DAY, -24);
		String startDate = sdf.format(cal.getTime()).substring(0, 11)+"0";
		searchVO.setStartDate(startDate);
		searchVO.setSearchCode(SepsCommonCode.SEOUL_JONGNO_WEATHER_CODE);
		EgovMap weatherMap = dao.selectWeather(searchVO);
		String temp[] = DateTempletUtil.getTempletDate(weatherMap);
		weatherMap.put("updateTime", temp[0]+" "+temp[1]);
		model.addAttribute("weatherMap", weatherMap);
		
		//기상예보 조회 서울기준
		EgovMap weatherMap2 = dao.selectWeatherTime(searchVO);
		weatherMap2.put("updateTime", weatherMap2.get("fcstTime").toString().substring(0,2));
		model.addAttribute("weatherMap2", weatherMap2);
		
		//사용자 작성알림
		String mainAlarm = dao.selectUsrAlarm();
		model.addAttribute("mainAlarm", mainAlarm);
		
		//기간별알람현황
		List<EgovMap> alarmList = dao.selectAlarmBoard(searchVO);
		if(alarmList.size() > 0){
			for(EgovMap e : alarmList){
				String[] tempDate = DateTempletUtil.getTempletDate(e);
				e.put("baseDate", tempDate[0]);
				e.put("baseTime", tempDate[1]);
				
				String tempContent = e.get("alarmContent").toString();
				if(tempContent.contains("강풍") || tempContent.contains("태풍")){ //1
					e.put("specialCode", 1);
				}else if(tempContent.contains("호우")){ //2
					e.put("specialCode", 2);
				}else if(tempContent.contains("한파")){ //3
					e.put("specialCode", 3);
				}else if(tempContent.contains("건조")){	//4
					e.put("specialCode", 4);
				}else if(tempContent.contains("대설")){  //5
					e.put("specialCode", 5);
				}else if(tempContent.contains("황사")){ //6
					e.put("specialCode", 6);
				}else if(tempContent.contains("폭염")){ //7
					e.put("specialCode", 7);
				}else if(tempContent.contains("안개")){ //8
					e.put("specialCode", 8);
				}else {
					e.put("specialCode", 0);
				}//안개 추가 필요
			}
			model.addAttribute("alarmList", alarmList);
		}
		
		return model;
	}

	
	// 카카오 공유하기 - 구분 내용가져오기
	@RequestMapping("/usr/dashboard/mainKakaoAjax.do")
	public View mainKakaoAjax(@RequestParam String kakaoTitleSel, ModelMap model) throws Exception {
		LOGGER.info("/usr/dashboard/mainKakaoAjax.do - 사용자 > 카카오 공유하기");
		LOGGER.debug("kakaoTitleSel = {}", kakaoTitleSel);
		
		CmmnSearchVO searchVO = new CmmnSearchVO();
		
		// 임시 데이터
		List<EgovMap> wlList3 = dao.selectWaterLevel2(searchVO);
		
		for (EgovMap egovMap : wlList3) {
			String placeCode = egovMap.get("wlobscd").toString();
			switch (placeCode) {
			case SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE:
				model.addAttribute("wolgye", egovMap.get("wl"));
				break;
			case SepsCommonCode.YEOUI_WATER_LEVEL_CODE:
				model.addAttribute("yeoui", egovMap.get("wl"));
				break;
			case SepsCommonCode.SINGOK_WATER_LEVEL_CODE:
				model.addAttribute("singok", egovMap.get("wl"));
				break;
			case SepsCommonCode.HANGANG_WATER_LEVEL_CODE:
				model.addAttribute("hangang", egovMap.get("wl"));
				break;
			case SepsCommonCode.PALDANG_TOTOTF_CODE:
				model.addAttribute("paldang", egovMap.get("wl"));
				break;
			case SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_CODE:
				model.addAttribute("rain", egovMap.get("wl"));
				break;
			case SepsCommonCode.WOLGYE1_HACHEON_WATER_LEVEL_CODE:
				model.addAttribute("wolgye1Hacheon", egovMap.get("wl"));
				break;
			case SepsCommonCode.WOLLEUNG_HACHEON_WATER_LEVEL_CODE:
				model.addAttribute("wolleungHacheon", egovMap.get("wl"));
				break;
			case SepsCommonCode.JOONGRANG_HACHEON_WATER_LEVEL_CODE:
				model.addAttribute("joongrangHacheon", egovMap.get("wl"));
				break;
			case SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE:
				model.addAttribute("cheongdam", egovMap.get("wl"));
			case SepsCommonCode.JOONGRANG_WATER_LEVEL_CODE:
				model.addAttribute("joongrang", egovMap.get("wl"));	
			default:
				break;
			}
		}
		return jsonView;
	}
	
	//중기예보 날짜 아이콘 변환
	public static String convertWeatherIcon(String paramStr){
		String result = "000";
		if(paramStr.equals("구름많음")){
			result = "004";
		}else if(paramStr.contains("비")){
			result = "010";
		}else if(paramStr.contains("눈")){
			result = "031";
		}
		return result;
	}
}
