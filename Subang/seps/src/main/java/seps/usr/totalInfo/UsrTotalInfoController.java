package seps.usr.totalInfo;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import component.excel.ExcelUtil;
import component.util.ComStringUtil;
import component.util.DateTempletUtil;
import component.util.ComStringUtil.DataType;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import seps.valueObject.UserInfoVO;
import valueObject.CmmnSearchVO;

@Controller
public class UsrTotalInfoController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UsrTotalInfoController.class);
	
	@Autowired private UsrTotalInfoDAO dao;
	
	@Resource View jsonView;
	
	//사용자 기간별기상현황
	@RequestMapping("/usr/totalInfo/periodWeatherInfo.do")
	public String periodWeatherInfo(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/totalInfo/periodWeatherInfo.do - 사용자 기간별기상현황");
		if(session != null) session.setAttribute("leftMeneNo", "401");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 기간 초기화 set - start
		if(
			EgovStringUtil.isEmpty(searchVO.getStartDate()) && EgovStringUtil.isEmpty(searchVO.getEndDate()) 
			&& EgovStringUtil.isEmpty(searchVO.getStartTime()) && EgovStringUtil.isEmpty(searchVO.getEndTime())
		){
			searchVO.setStartDate(sdf.format(new Date()));
			searchVO.setEndDate(sdf.format(new Date()));
			searchVO.setStartTime("00");
			searchVO.setEndTime("23");
		}
		// 기간 초기화 set - end
		
		// 시간대별 기상현황 목록 select - start
		List<EgovMap> weatherStatusList = dao.selectWeatherStatusList(searchVO);

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
				
				EgovMap floodLevel = dao.selectFloodLevel(stdHourDate, preHourDate);
				if(floodLevel != null){
					e.put("floodLevel", floodLevel);
				}else{
					EgovMap floodLevel2 = dao.selectFloodLevel(stdHourDate, null);
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
		// 시간대별 기상현황 목록 select - end
		
		return "/usr/totalInfo/periodWeatherInfo";
	}
	
	// 시간대별 기상현황 엑셀다운로드
	@RequestMapping("/usr/totalInfo/periodWeatherInfoExcelDownload.do")
	public void periodWeatherInfoExcelDownload(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		LOGGER.info("/usr/totalInfo/periodWeatherInfoExcelDownload.do - 사용자 > 시간대별 기상현황 - 엑셀다운로드");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HHmm");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		// 시간대별 기상현황 목록 select - start
		List<EgovMap> weatherStatusList = dao.selectWeatherStatusList(searchVO);

		if(weatherStatusList.size() > 0){
			
			Calendar cal = Calendar.getInstance();
			
			// 서울, 의정부 강수량 | 수위 set - start
			Map<String, String> rainList = null;
			Map<String, String> wlList = null;
			
			// 누적 강수량
			float tot1Rain = 0;	// 서울
			float tot2Rain = 0;	// 의정부
			
			for(EgovMap e : weatherStatusList){
				
				// 단계 set - start
				String stdHourDate = e.get("dttm").toString();	// 기준시간
				
				Date tmpDate = sdf.parse(stdHourDate);
				// 엑셀표출용 날짜 셋팅
				e.put("dttm", sdf2.format(tmpDate));
				
				// 1시간 전
				cal.setTime(tmpDate);
				cal.add(Calendar.HOUR_OF_DAY, -1);
				cal.add(Calendar.MINUTE, 1);
				String preHourDate =  sdf.format(cal.getTime());	
				
				EgovMap floodLevel = dao.selectFloodLevel(stdHourDate, preHourDate);
				if(floodLevel != null){
					e.put("floodLevel", ComStringUtil.sepsReturnWeatherLevel(floodLevel.get("floodLevel").toString()));
				}else{
					EgovMap floodLevel2 = dao.selectFloodLevel(stdHourDate, null);
					e.put("floodLevel", ComStringUtil.sepsReturnWeatherLevel(floodLevel2.get("floodLevel").toString()));
				}
				// 단계 set - end
				
				// 강수량 set - start
				rainList = new HashMap<>();
				String[] arrRn1 = e.get("arrRn1").toString().split(",");
				for(String rn1 : arrRn1){
					rainList.put(rn1.split("=")[0], rn1.split("=")[1]);
				}
				e.put("rainList", rainList);

					// 누적 강수량 set - start
					tot1Rain += Float.parseFloat(rainList.get("1")==null? "0":rainList.get("1").toString());
					tot2Rain += Float.parseFloat(rainList.get("2")==null? "0":rainList.get("2").toString());
					
					e.put("tot1Rain", String.format("%.2f", tot1Rain));
					e.put("tot2Rain", String.format("%.2f", tot2Rain));
					// 누적 강수량 set - end
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
		// 시간대별 기상현황 목록 select - end
		
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("weatherStatusList", weatherStatusList);
		
		// 출력자 정보 set - start
		UserInfoVO sessionVO = (UserInfoVO) EgovUserDetailsHelper.getAuthenticatedUser();
		dataMap.put("printUser", sessionVO.getUserNm());
		// 출력자 정보 set - end
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "시간대별_기상현황", "weatherStatus", request, response);
	}
	
	
	//사용자 기간별수위정보 - 공단제공 데이터
	@RequestMapping("/usr/totalInfo/periodLevelInfo.do")
	public String periodLevelInfo(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/totalInfo/main.do - 사용자 기간별수위정보");
		LOGGER.debug("searchVO = {}", searchVO.toString());
		if(session != null) session.setAttribute("leftMeneNo", "402");
		
		// 대상 초기화 - start
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1("0000001");
		}
		// 대상 초기화 - end
		
		// 기간 초기화 - start
		if(EgovStringUtil.isEmpty(searchVO.getStartDate()) && EgovStringUtil.isEmpty(searchVO.getEndDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchVO.setStartDate(sdf.format(new Date()));
			searchVO.setEndDate(sdf.format(new Date()));
		}
		// 기간 초기화 - end
		
		// 수위 및 방류량 데이터 select - start
		List<EgovMap> waterLevelOrDamList = dao.selectWaterLevelOrDamList(searchVO);
		LOGGER.debug("\nwaterLevelOrDamList.size() = {}", waterLevelOrDamList.size());
			// 단계 set - start
			if(waterLevelOrDamList.size() > 0){
				for(EgovMap e : waterLevelOrDamList){
					int level = ComStringUtil.sepsReturnLevel(searchVO.getSearchCondition1(), (float) e.get("val"));
					e.put("level", level);
				}
			}
			// 단계 set - end
		
		model.addAttribute("waterLevelOrDamList", waterLevelOrDamList);
		// 수위 및 방류량 데이터 select - end
		
		// 그래프 단계 set - start
		Map<String, String> levelLines = null;
		for(DataType type : DataType.values()){
			if((searchVO.getSearchCondition1()).equals(type.getCode())){
				levelLines = new HashMap<>();
				if(!EgovStringUtil.isEmpty(type.getLevel3())) levelLines.put("level5", type.getLevel3());
				if(!EgovStringUtil.isEmpty(type.getLevel2())) levelLines.put("level4", type.getLevel2());
				if(!EgovStringUtil.isEmpty(type.getLevel2_2())) levelLines.put("level2_2", type.getLevel2_2());
				if(!EgovStringUtil.isEmpty(type.getLevel2_1())) levelLines.put("level2_1", type.getLevel2_1());
				if(!EgovStringUtil.isEmpty(type.getLevel1())) levelLines.put("level2", type.getLevel1());
						
				break;
			}
		}
		model.addAttribute("levelLines", levelLines);
		// 그래프 단계 set - end
		return "/usr/totalInfo/periodLevelInfo";
	}
	
	//사용자 기상정보
	@RequestMapping("/usr/totalInfo/weatherInfo.do")
	public String weatherInfo(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/totalInfo/weatherInfo.do - 사용자 기상정보");
		if(session != null) session.setAttribute("leftMeneNo", "403");
	 	String[] areaCode = new String[]{"1","2","3","4","5","6","7","8","9","10"};
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
		return "/usr/totalInfo/weatherInfo";
	}
	
	//사용자 수위정보 - 홍수통제소 데이터
	@RequestMapping("/usr/totalInfo/levelInfo.do")
	public String levelInfo(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.info("/usr/totalInfo/levelInfo.do - 사용자 수위정보");
		if(session != null) session.setAttribute("leftMeneNo", "404");
		return "/usr/totalInfo/levelInfo";
	}

	
	//사용자 조위정보
	@RequestMapping("/usr/totalInfo/tideInfo.do")
	public String tideInfo(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/totalInfo/tideInfo.do - 사용자 조위정보");
		LOGGER.debug("searchVO = {}", searchVO.toString());
		if(session != null) session.setAttribute("leftMeneNo", "405");
		
		// 인천관측소 set
		searchVO.setSearchCondition1("DT_001");
		
		// 날짜 초기화 set
		if(EgovStringUtil.isEmpty(searchVO.getSearchDate())){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			searchVO.setSearchDate(sdf.format(new Date()));
		}
		
		// 극치 조위 목록 select - start
		List<EgovMap> tideTphList = dao.selectTideTphList(searchVO);
		model.addAttribute("tideTphList", tideTphList);
		// 극치 조위 목록 select - end
		
		// 조위 목록 select - start
		List<EgovMap> tideList = dao.selectTideList(searchVO);
		model.addAttribute("tideList", tideList);
		// 조위 목록 select - end
		if(tideList.size() == 0){
			reda.addFlashAttribute("message", "데이터가 없습니다.");
			//return "redirect:/usr/dashboard/main.do";
		}
		
		return "/usr/totalInfo/tideInfo";
	}
	
}
