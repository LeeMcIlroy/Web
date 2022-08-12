package seps.usr.dashboard;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Wrapper;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import seps.batch.ScheduleAction;
import seps.batch.ScheduleDAO;
import seps.cmmn.SepsCommonCode;
import seps.valueObject.AlarmBoardVO;
import seps.valueObject.AlarmVO;
import seps.valueObject.api.DustVO;
import seps.valueObject.api.MyJsonComparartor;
import seps.valueObject.api.WaterLevelVO;
import seps.valueObject.api.WeatherLifeVO;
import seps.valueObject.api.WeatherMiddleVO;
import seps.valueObject.api.WeatherTemperatureVO;
import seps.valueObject.api.WeatherVO;
import component.util.DateTempletUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;

@Controller
public class CmmnForceBatchController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ForceBatchController.class);
	private static final int FORECASTGRIB_STD_TIME = 45;
	@Autowired protected ScheduleDAO scheduleDAO;
	
	// 생활 & 보건지수 DB Insert
	public void weatherLifeInsert(JSONObject result){
		LOGGER.debug("****************************************************************************************************************************");
		LOGGER.debug("result = {}", result.toString());
		String returnCode = "";
		JSONObject response = (JSONObject) result.get("Response");
		try{
			
			returnCode = ((JSONObject) response.get("header")).get("returnCode").toString();
			
			if(returnCode.equals("00")){
				WeatherLifeVO resultVO = new WeatherLifeVO();
				JSONObject resultModel = (JSONObject) ((JSONObject) response.get("body")).get("indexModel");
				resultVO.setCode(resultModel.get("code").toString());
				resultVO.setBaseDate(resultModel.get("date").toString());
				if(    resultModel.get("code").equals("A07_1") 	// 자외선
					|| resultModel.get("code").equals("D02")	// 뇌졸증
					|| resultModel.get("code").equals("D01") // 천식폐질환
					|| resultModel.get("code").equals("A01_2") // 식중독
				){
					String value = resultModel.get("today").toString();
					if(value == null || "".equals(value)) {
						value = "0";
					}
					resultVO.setValue(value);
				}else{
					String value = resultModel.get("h3").toString();
					if(value == null || "".equals(value)) {
						value = "0";
					}
					resultVO.setValue(resultModel.get("h3").toString());
				}
				LOGGER.debug(resultVO.toString());
				int cnt = scheduleDAO.weatherLifeSelect(resultVO);
				if(cnt == 0){
					scheduleDAO.weatherLifeInsert(resultVO);
				}else{
					LOGGER.debug("이미 등록된 기상지수 입니다.");
				}
			}
		}catch(Exception e){
			LOGGER.error(e.getMessage());
		}
		LOGGER.debug("****************************************************************************************************************************");
	}
	
	//중기예보 DB insert
	public void weatherMiddleInsert(JSONObject result, String strNowDate) {
		LOGGER.debug("****************************************************************************************************************************");
		LOGGER.debug("strNowDate = {}, result = {}", strNowDate, result.toString());
		String returnCode = "";
		JSONObject response = (JSONObject) result.get("response");
		returnCode = ((JSONObject) response.get("header")).get("resultCode").toString();
		String[] dayNames = new String[5];
		try {
			//예보 날짜 생성
			for(int i=0; i<5; i++){
					String dayName = DateTempletUtil.getTimeAddMonth(strNowDate, i+3);
					dayNames[i] = DateTempletUtil.getTempletDate3(dayName) ;
			}
			//예보데이터 파싱
			if(returnCode.equals("0000")){
				WeatherMiddleVO paramVO = new WeatherMiddleVO();
				JSONObject resultItem =(JSONObject) ((JSONObject) ((JSONObject) response.get("body")).get("items")).get("item");
				paramVO.setBaseDate(strNowDate);
				paramVO.setDate3(dayNames[0]); //3일후
				paramVO.setDate4(dayNames[1]); //4일후
				paramVO.setDate5(dayNames[2]); //5일후
				paramVO.setDate6(dayNames[3]); //6일후
				paramVO.setDate7(dayNames[4]); //7일후
				paramVO.setWf3Am(resultItem.get("wf3Am").toString());
				paramVO.setWf3Pm(resultItem.get("wf3Pm").toString());
				paramVO.setRnSt3Am(resultItem.get("rnSt3Am").toString());
				paramVO.setRnSt3Pm(resultItem.get("rnSt3Pm").toString());
				paramVO.setWf4Am(resultItem.get("wf4Am").toString());
				paramVO.setWf4Pm(resultItem.get("wf4Pm").toString());
				paramVO.setRnSt4Am(resultItem.get("rnSt4Am").toString());
				paramVO.setRnSt4Pm(resultItem.get("rnSt4Pm").toString());
				paramVO.setWf5Am(resultItem.get("wf5Am").toString());
				paramVO.setWf5Pm(resultItem.get("wf5Pm").toString());
				paramVO.setRnSt5Am(resultItem.get("rnSt5Am").toString());
				paramVO.setRnSt5Pm(resultItem.get("rnSt5Pm").toString());
				paramVO.setWf6Am(resultItem.get("wf6Am").toString());
				paramVO.setWf6Pm(resultItem.get("wf6Pm").toString());
				paramVO.setRnSt6Am(resultItem.get("rnSt6Am").toString());
				paramVO.setRnSt6Pm(resultItem.get("rnSt6Pm").toString());
				paramVO.setWf7Am(resultItem.get("wf7Am").toString());
				paramVO.setWf7Pm(resultItem.get("wf7Pm").toString());
				paramVO.setRnSt7Am(resultItem.get("rnSt7Am").toString());
				paramVO.setRnSt7Pm(resultItem.get("rnSt7Pm").toString());
				
				int cnt = scheduleDAO.weatherMiddleSelect(paramVO);
				if(cnt == 0){
					scheduleDAO.weatherMiddleInsert(paramVO);
				}else{
					LOGGER.debug("이미 등록된 중기예보 입니다.");
				}
			}
			
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		LOGGER.debug("****************************************************************************************************************************");
	}
			
	//중기예보 DB insert
	public void weatherTemperatureInsert(JSONObject result, String strNowDate) {
		LOGGER.debug("****************************************************************************************************************************");
		LOGGER.debug("strNowDate = {}, result = {}", strNowDate, result.toString());
		String returnCode = "";
		JSONObject response = (JSONObject) result.get("response");
		returnCode = ((JSONObject) response.get("header")).get("resultCode").toString();
		String[] dayNames = new String[5];
		try {
			//예보 날짜 생성
			for(int i=0; i<5; i++){
					String dayName = DateTempletUtil.getTimeAddMonth(strNowDate, i+3);
					dayNames[i] = DateTempletUtil.getTempletDate3(dayName) ;
			}
			//예보데이터 파싱
			if(returnCode.equals("0000")){
				WeatherTemperatureVO paramVO = new WeatherTemperatureVO();
				JSONObject resultItem =(JSONObject) ((JSONObject) ((JSONObject) response.get("body")).get("items")).get("item");
				paramVO.setBaseDate(strNowDate);
				paramVO.setTaMin3(resultItem.get("taMin3").toString());
				paramVO.setTaMax3(resultItem.get("taMax3").toString());
				paramVO.setTaMin4(resultItem.get("taMin4").toString());
				paramVO.setTaMax4(resultItem.get("taMax4").toString());
				paramVO.setTaMin5(resultItem.get("taMin5").toString());
				paramVO.setTaMax5(resultItem.get("taMax5").toString());
				paramVO.setTaMin6(resultItem.get("taMin6").toString());
				paramVO.setTaMax6(resultItem.get("taMax6").toString());
				paramVO.setTaMin7(resultItem.get("taMin7").toString());
				paramVO.setTaMax7(resultItem.get("taMax7").toString());					
				int cnt = scheduleDAO.weatherTemperatureSelect(paramVO);
				if(cnt == 0){
					scheduleDAO.weatherTemperatureInsert(paramVO);
				}else{
					LOGGER.debug("이미 등록된 중기기온 입니다.");
				}
			}
			
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		LOGGER.debug("****************************************************************************************************************************");
	}
	
	// 날씨 데이터 insert
	public void weatherDataInsert(String nx, String ny, String shpId){
		LOGGER.debug("****************************************************************************************************************************");
		LOGGER.debug("nx = {}, ny = {}, shpId = {}", nx, ny, shpId);
		
		ScheduleAction actionObj = new ScheduleAction();
		
		try{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HHmm");
			String strNowDate = sdf.format(new Date());
			String baseMinute = strNowDate.split(" ")[1].substring(2, 4);
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.set(Calendar.MINUTE, FORECASTGRIB_STD_TIME);
			
			String updateDate = "";
			if(Integer.parseInt(baseMinute) < FORECASTGRIB_STD_TIME){
				// 45분보다 작으면 1시간 전 45분으로
				cal.add(Calendar.HOUR, -1);
			}
			
			updateDate = sdf.format(cal.getTime());
			LOGGER.debug("updateDate = "+updateDate);
			
			String p1BaseDate = updateDate.split(" ")[0];
			String p1BaseTime = updateDate.split(" ")[1];
			
			JSONObject result = actionObj.return_SecndSrtpdFrcstInfoService2("ForecastGrib", p1BaseDate, p1BaseTime, nx, ny, null);
			
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			if("0000".equals(resultCode)){
				JSONArray item = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) result.get("response")).get("body")).get("items")).get("item");
				
				WeatherVO paramVO = new WeatherVO();
				
				for(int i = 0; i < item.size(); i++){
					JSONObject o = (JSONObject) item.get(i);
					String methodName = "set"+o.get("category").toString();
					Method m = WeatherVO.class.getMethod(methodName, String.class);
					m.invoke(paramVO, o.get("obsrValue").toString());
					
					if(i == 0){
						paramVO.setBaseDate(o.get("baseDate").toString());
						paramVO.setBaseTime(o.get("baseTime").toString());
					}
				}
				
				paramVO.setShpId(shpId);
				
				scheduleDAO.weatherInsert(paramVO);
				
				LOGGER.debug("paramVO.toString() = "+paramVO.toString());
			}else{
				LOGGER.warn("!!!!!!!!!!!!!!!!!!!!!!!!!날씨 데이터가 정상적이지 않습니다!!!!!!!!!!!!!!!!!!!!!!!!!");
			}
			LOGGER.debug("****************************************************************************************************************************");
		}catch(Exception e){
			LOGGER.error(e.getMessage());
		}
	}
	
	// 초단기 예보 데이터 insert
	public void weatherTimeDataInsert(String nx, String ny, String shpId){
		LOGGER.debug("****************************************************************************************************************************");
		LOGGER.debug("nx = {}, ny = {}, shpId = {}", nx, ny, shpId);
		
		ScheduleAction actionObj = new ScheduleAction();
		
		try{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HHmm");
			String strNowDate = sdf.format(new Date());
			String baseMinute = strNowDate.split(" ")[1].substring(2, 4);
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.set(Calendar.MINUTE, FORECASTGRIB_STD_TIME);
			
			String updateDate = "";
			if(Integer.parseInt(baseMinute) < FORECASTGRIB_STD_TIME){
				// 45분보다 작으면 1시간 전 45분으로
				cal.add(Calendar.HOUR, -1);
			}
			
			updateDate = sdf.format(cal.getTime());
			
			String p1BaseDate = updateDate.split(" ")[0];
			String p1BaseTime = updateDate.split(" ")[1].substring(0,2)+"30";			
			
			JSONObject result = actionObj.return_SecndSrtpdFrcstInfoService2("getUltraSrtFcst", p1BaseDate, p1BaseTime, nx, ny, "999");
			
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			if("0000".equals(resultCode)){
				JSONArray item = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) result.get("response")).get("body")).get("items")).get("item");
				 ArrayList<JSONObject> list = new ArrayList<>();

			        for (int i = 0; i < item.size(); i++) {
			            list.add((JSONObject) item.get(i));
			        }
			        Collections.sort(list, new MyJsonComparartor());
					
					List<WeatherVO> paramList = new ArrayList<WeatherVO>();
					WeatherVO paramVO = new WeatherVO();
					String fcstDate = "";
					String fcstTime = "";
					int i = 0;
					 for (JSONObject obj : list) {
						JSONObject o = (JSONObject) obj;
						
						if( i++ == 0){
							fcstDate = o.get("fcstDate").toString();
							fcstTime = o.get("fcstTime").toString();
						}else{
							if( !fcstDate.equals(o.get("fcstDate").toString()) || !fcstTime.equals(o.get("fcstTime").toString()) ){
								paramList.add(paramVO);
								paramVO = new WeatherVO();
								fcstDate = o.get("fcstDate").toString();
								fcstTime = o.get("fcstTime").toString();
							}
						}
					
					String methodName = "set"+o.get("category").toString();
					Method m = WeatherVO.class.getMethod(methodName, String.class);
					m.invoke(paramVO, o.get("fcstValue").toString());
					paramVO.setBaseDate(o.get("baseDate").toString());
					paramVO.setBaseTime(o.get("baseTime").toString());
					paramVO.setFcstDate(fcstDate);
					paramVO.setFcstTime(fcstTime);
					paramVO.setShpId(shpId);
					
					if(i==item.size()){
						paramList.add(paramVO);
					}
				}
				
				for (WeatherVO weatherVO : paramList) {
					int cnt = scheduleDAO.weatherTimeSelect(weatherVO);
					if(cnt == 0){
						scheduleDAO.weatherTimeInsert(weatherVO);
					}else{
						scheduleDAO.weatherTimeUpdate(weatherVO);
					}
				}
				
				
				LOGGER.debug("paramVO.toString() = "+paramVO.toString());
			}else{
				LOGGER.warn("!!!!!!!!!!!!!!!!!!!!!!!!!날씨 데이터가 정상적이지 않습니다!!!!!!!!!!!!!!!!!!!!!!!!!");
			}
			LOGGER.debug("****************************************************************************************************************************");
		}catch(Exception e){
			LOGGER.error(e.getMessage());
		}
	}
	
	
	// 동네 예보 데이터 insert
	public void weatherSeriesDataInsert(String nx, String ny, String shpId){
		LOGGER.debug("****************************************************************************************************************************");
		LOGGER.debug("nx = {}, ny = {}, shpId = {}", nx, ny, shpId);
		
		ScheduleAction actionObj = new ScheduleAction();
		
		try{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd HH");
			String strNowDate = sdf.format(new Date());
			
			LOGGER.debug("strNowDate = "+strNowDate);
			
			String p1BaseDate = strNowDate.split(" ")[0];
			String p1BaseTime = strNowDate.split(" ")[1];
			
			int[] timeArr = {2, 5, 8, 11, 14, 17, 20, 23};
			int targetTime = Integer.parseInt(p1BaseTime);

			int diff1 = 24;
			
			for(int time : timeArr) {
				if(targetTime == time) {
					p1BaseTime = (10 > time  ? "0" + time : time)  + "00";
					break;
				}else if (targetTime > time) {
					int diff2 = targetTime - time;
					
					if(diff1 > diff2) {
						diff1 = diff2;
						p1BaseTime = (10 > time  ? "0" + time : time)  + "00";
					}
				}
			}
			
			
			JSONObject result = actionObj.return_SecndSrtpdFrcstInfoService2("getVilageFcst", p1BaseDate, p1BaseTime, nx, ny, "999");
			
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			if("0000".equals(resultCode)){
				JSONArray item = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) result.get("response")).get("body")).get("items")).get("item");
				
				List<WeatherVO> paramList = new ArrayList<WeatherVO>();
				WeatherVO paramVO = new WeatherVO();
				String fcstDate = "";
				String fcstTime = "";
				for(int i = 0; i < item.size(); i++){
					JSONObject o = (JSONObject) item.get(i);
					
					if( i == 0){
						fcstDate = o.get("fcstDate").toString();
						fcstTime = o.get("fcstTime").toString();
					}else{
						if( !fcstDate.equals(o.get("fcstDate").toString()) || !fcstTime.equals(o.get("fcstTime").toString()) ){
							paramList.add(paramVO);
							paramVO = new WeatherVO();
							fcstDate = o.get("fcstDate").toString();
							fcstTime = o.get("fcstTime").toString();
						}
					}
					
					String methodName = "set"+o.get("category").toString();
					Method m = WeatherVO.class.getMethod(methodName, String.class);
					m.invoke(paramVO, o.get("fcstValue").toString());
					paramVO.setBaseDate(o.get("baseDate").toString());
					paramVO.setBaseTime(o.get("baseTime").toString());
					paramVO.setFcstDate(fcstDate);
					paramVO.setFcstTime(fcstTime);
					paramVO.setShpId(shpId);

					if(i==item.size()){
						paramList.add(paramVO);
					}
				}
			
				for (WeatherVO weatherVO : paramList) {
					int cnt = scheduleDAO.weatherSeriesSelect(weatherVO);
					if(cnt == 0){
						scheduleDAO.weatherSeriesInsert(weatherVO);
					}else{
						scheduleDAO.weatherSeriesUpdate(weatherVO);
					}
				}
				
				
				LOGGER.debug("paramVO.toString() = "+paramVO.toString());
			}else{
				LOGGER.warn("!!!!!!!!!!!!!!!!!!!!!!!!!날씨 데이터가 정상적이지 않습니다!!!!!!!!!!!!!!!!!!!!!!!!!");
			}
			LOGGER.debug("****************************************************************************************************************************");
		}catch(Exception e){
			LOGGER.error(e.getMessage());
		}
	}
	
	public void insertAlarm(String type, float wl, String placeCode, String baseDate, String baseTime){
		AlarmBoardVO boardVO = new AlarmBoardVO();
		String alarmId = "";
		String alarmYn = "Y";
		if ("dam".equals(type)) {
			if(wl >= 25000){
				//팔당댐
				String stx = "[동부] 중량교 ~ 월계1교 침수예상";
				alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.PALDANG_TOTOTF_CODE, baseDate, baseTime));
			}else if(wl >= 15200){
				//팔당댐
				String stx = "[올림픽] 한강철교하부 침수예상";
				alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.PALDANG_TOTOTF_CODE, baseDate, baseTime));
			}else if(wl >= 13000){
				//팔당댐
				String stx = "[동부] 성동교 ~ 중량교 침수예상";
				alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.PALDANG_TOTOTF_CODE, baseDate, baseTime));
			}else if(wl >= 12800){
				//팔당댐
				String stx = "[올림픽] 여의상류~하류IC 침수예상";
				alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.PALDANG_TOTOTF_CODE, baseDate, baseTime));
			}else if(wl >= 12500){
				//팔당댐
				String stx = "[올림픽] 여의교주변 침수예상";
				alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.PALDANG_TOTOTF_CODE, baseDate, baseTime));
			}else if(wl >= 12000){
				//팔당댐
				String stx = "[동부] 용비교 ~ 성동교 침수예상";
				alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.PALDANG_TOTOTF_CODE, baseDate, baseTime));
			}else if(wl >= 10500){
				//팔당댐
				String stx = "[올림픽] 여의상류IC 침수예상";
				alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.PALDANG_TOTOTF_CODE, baseDate, baseTime));
			}else{
				alarmId = null;
				alarmYn = "N";
			}
		}else if("wl".equals(type)){ // [동부] ㅌㅌ천 하천범람 도달 통제준비 (-1.8m)
			switch (placeCode) {
				case SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE:
					//월릉교
				/*	if(wl >= (float)16.08){
						String stx = "[동부] 월릉교 침수수위 도달(-0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)15.08){
						String stx = "[동부] 월릉교 2단계 통제수위 도달(-1.0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)14.68){
						String stx = "[동부] 월릉교 1단계 통제수위 도달(-1.4m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)14.28){
						String stx = "[동부] 월릉교 준비수위 도달(-1.8m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}*/
					if(wl >= (float)16.08){
						//String stx = "[동부] 월릉교 침수수위 도달(-0m)";
						String stx = "[동부] 월릉교 침수도달, 재난복구 준비";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)15.08){
						//String stx = "[동부] 월릉교 2단계 통제수위 도달(-1.0m)";
						String stx = "[동부] 월릉교 2차(본선)통제 실시";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)14.83){
						//String stx = "[동부] 월릉교 1단계 통제수위 도달(-1.4m)";
						String stx = "[동부] 월릉교 1차(램프)통제 실시";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)14.58){
						//String stx = "[동부] 월릉교 준비수위 도달(-1.8m)";
						String stx = "[동부] 월릉교 교통통제 준비";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)13.58){
						//String stx = "[동부] 월릉교 관심수위 도달(-2.5m)";
						String stx = "[동부] 월릉교 중랑천 수위 예의주시";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else{
						alarmId = null;
						alarmYn = "N";
					}
				break;
				case SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE:
						//월계1교
					/*	if(wl >= (float)17.23){
//							String stx = "[동부] 월계1교 침수수위 도달(-0m)";
							String stx = "[동부] 월계1교  침수도달, 청소(복구) 준비";
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}else if(wl >= (float)16.23){
//							String stx = "[동부] 월계1교 2단계 통제수위 도달(-1.0m)";
							String stx = "[동부] 월계1교  2차 교통통제 실시 (본선 16개소)";
							
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}else if(wl >= (float)15.83){
//							String stx = "[동부] 월계1교 1단계 통제수위 도달(-1.4m)";
							String stx = "[동부] 월계1교  1차 교통통제 실시 (램프 26개소, 본선2개소)";
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}else if(wl >= (float)15.43){
//							String stx = "[동부] 월계1교 준비수위 도달(-1.8m)";
							String stx = "[동부] 월계1교  교통통제 준비";
							
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}else if(wl >= (float)14.73){
//							String stx = "[동부] 월계1교 관심수위 도달(-2.5m)";
							String stx = "[동부] 월계1교  중랑천 수위 예의주시";
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}*/
					if(wl >= (float)17.23){
//						String stx = "[동부] 월계1교 침수수위 도달(-0m)";
						//String stx = "[동부] 월계1교  침수도달, 청소(복구) 준비";
						String stx = "[동부] 월계1교  침수도달, 재난복구 준비";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)16.23){
//						String stx = "[동부] 월계1교 2단계 통제수위 도달(-1.0m)";
						//String stx = "[동부] 월계1교  2차 교통통제 실시 (본선 16개소)";
						String stx = "[동부] 월계1교  2차(본선)통제 실시";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)15.83){
//						String stx = "[동부] 월계1교 1단계 통제수위 도달(-1.4m)";
						//String stx = "[동부] 월계1교  1차 교통통제 실시 (램프 26개소, 본선2개소)";
						String stx = "[동부] 월계1교  1차(램프)통제 실시";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)15.43){
//						String stx = "[동부] 월계1교 준비수위 도달(-1.8m)";
						String stx = "[동부] 월계1교  교통통제 준비";
						
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)14.43){
//						String stx = "[동부] 월계1교 관심수위 도달(-2.5m)";
						String stx = "[동부] 월계1교  중랑천 수위 예의주시";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
					}else{
						alarmId = null;
						alarmYn = "N";
						}
					break;
				case SepsCommonCode.YEOUI_WATER_LEVEL_CODE:
					//여의상류
					if(wl >= 5.4){
						//String stx = "[올림픽] 여의상류IC 침수수위 도달(-0m)";
						String stx = "[올림픽] 도로 통제, 재난복구 준비";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.YEOUI_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)4.4){
						//String stx = "[올림픽] 여의상류IC 위험수위 도달(-1.0m)";
						String stx = "[올림픽] 도로 통제";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.YEOUI_WATER_LEVEL_CODE, baseDate, baseTime));
					}/*else if(wl >= (float)-1.2){
						String stx = "[올림픽] 여의상류IC 경고수위 도달(-1.2m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.YEOUI_WATER_LEVEL_CODE, baseDate, baseTime));
					}*/else if(wl >= (float)3.9){
						//String stx = "[올림픽] 여의상류IC 준비수위 도달(-1.5m)";
						String stx = "[올림픽] 도로 통제 준비";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.YEOUI_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)3.4){
						//String stx = "[올림픽] 여의상류IC 관심수위 도달(-2.0m)";
						String stx = "[올림픽] 여의도 샛강 수위 예의주시";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.YEOUI_WATER_LEVEL_CODE, baseDate, baseTime));
					}else{
						alarmId = null;
						alarmYn = "N";
					}
					break;
				case SepsCommonCode.SINGOK_WATER_LEVEL_CODE:
					//신곡교
					if(wl >= (float)3){
						String stx = "[동부] 신곡교 통제수위 도달"; // 190918 - 월계1교 => 신곡교로 문구 수정. (월계1교 지역명으로 적혀 있었음)
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.SINGOK_WATER_LEVEL_CODE, baseDate, baseTime));
					}else{
						alarmId = null;
						alarmYn = "N";
					}
					break;
				case SepsCommonCode.HANGANG_WATER_LEVEL_CODE:
					//한강대교
					if(wl >= (float)8.03){
						String stx = "[올림픽] 한강철교하부 침수수위 도달(-0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)7.49){
						String stx = "[동부] 용비교 ~ 성동교 침수수위 도달(-0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)7.33){
						String stx = "[강변] 한강철교하부 침수수위 도달(-0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)7.03){
						String stx = "[올림픽] 한강철교하부 통제수위 도달(-1.0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)6.53){
						String stx = "[올림픽] 여의교주변 침수수위 도달(-0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)6.49){
						String stx = "[동부] 용비교 ~ 성동교 통제수위 도달(-1.0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)6.3){
						String stx = "[강변] 한강철교하부 통제수위 도달(-1.0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)5.99){
						String stx = "[동부] 용비교 ~ 성동교 준비수위 도달(-1.5m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)5.8){
						String stx = "[강변] 한강철교하부 준비수위 도달(-1.5m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)5.75){
						String stx = "[올림픽] 여의하류IC 침수수위 도달(-0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)5.5){
						String stx = "[올림픽] 여의교 통제수위 도달(-1.0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)5.4){
						String stx = "[올림픽] 여의상류IC 침수수위 도달(-0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)5){
						String stx = "[올림픽] 여의교 준비수위 도달(-1.5m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)4.75){
						String stx = "[올림픽] 여의하류IC 통제수위 도달(-1.0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)4.4){
						String stx = "[올림픽] 여의상류IC 통제수위 도달(-1.0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)4.25){
						String stx = "[올림픽] 여의하류IC 준비수위 도달(-1.5m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)3.9){
						String stx = "[올림픽] 여의상류IC 준비수위 도달(-1.5m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, baseDate, baseTime));
					}else{
						alarmId = null;
						alarmYn = "N";
					}

					break;
				case SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE:
					//청담대교
					if(wl >= (float)9.1){
						String stx = "[동부] 용비교 ~ 성동교 침수수위 도달(-0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)8.1){
						String stx = "[동부] 용비교 ~ 성동교 통제수위 도달(-1.0m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE, baseDate, baseTime));
					}else if(wl >= (float)7.6){
						String stx = "[동부] 용비교 ~ 성동교 준비수위 도달(-1.5m)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE, baseDate, baseTime));
					}else{
						alarmId = null;
						alarmYn = "N";
					}
					break;
				
				// 하천 범람 관련 알람 로직.
				case SepsCommonCode.WOLGYE1_HACHEON_WATER_LEVEL_CODE:	
					
					if(wl == 2 || wl == 0){
						String stx = "월계1 하천 범람에 -1.8m 도달(교통통제준비)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_HACHEON_WATER_LEVEL_CODE, baseDate, baseTime));
					}else {
						alarmId = null;
						alarmYn = "N";
					}
					
					break;
				case SepsCommonCode.WOLLEUNG_HACHEON_WATER_LEVEL_CODE:	
					
					if(wl == 2 || wl == 0){
						String stx = "월릉 하천 범람에 -1.8m 도달(교통통제준비)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLLEUNG_HACHEON_WATER_LEVEL_CODE, baseDate, baseTime));
					}else {
						alarmId = null;
						alarmYn = "N";
					}
					
					break;
				case SepsCommonCode.JOONGRANG_HACHEON_WATER_LEVEL_CODE:	
					
					if(wl == 2 || wl == 0){
						String stx = "중랑 하천 범람에 -1.8m 도달(교통통제준비)";
						alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.JOONGRANG_HACHEON_WATER_LEVEL_CODE, baseDate, baseTime));
					}else {
						alarmId = null;
						alarmYn = "N";
					}
					
					break;
				default:
					break;
			}
		}else{
			//기상관련 
		}
		boardVO.setAlarmId(alarmId);
		boardVO.setAlarmYn(alarmYn);
		boardVO.setPlaceCode(placeCode);
		scheduleDAO.alarmBoardUpdate(boardVO);
	}
	
	public static String[] initDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		Date now = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
		cal.add(Calendar.MINUTE, -60);
		String startDate = sdf.format(cal.getTime()).substring(0, 11)+"0"; // 1시간전
		cal.setTime(now);
		cal.add(Calendar.MINUTE, -10);
		String endDate = sdf.format(cal.getTime()).substring(0, 11)+"0"; // 10분전
		cal.setTime(now);
		String endDate2 = sdf.format(cal.getTime()).substring(0, 11)+"0"; // 현재시간
		return new String[]{startDate, endDate, endDate2};
	}
	
	
	public void insertAlarm2(DustVO dustVO){
		// 191014 미세/초미세먼지 경보 발생시, 메인알림에 추가.
		// 191121 미세/초미세먼지 경보 발생시, 로직 수정
		// f: 예보
		// a: 경보
		String baseDate = dustVO.getApplcDt().substring(0, 8);
		String baseTime = dustVO.getApplcDt().substring(8);
		
		AlarmBoardVO boardVO = new AlarmBoardVO();
		String alarmId = null;
		String alarmYn = "";
		
		String pollutant = dustVO.getPollutant(); // 미세먼지 종류 : (미세/초미세)
		String faOn = dustVO.getFaOn(); // 예보 / 경보
		String code = ""; // 미세먼지 / 초미세먼지 알람 코드 구분값 : A000001, A000002
		String stx = ""; // 알림 문자열

		String alertStep = dustVO.getAlertstep();
		
		if("pm10".equals(pollutant)) {
			code = SepsCommonCode.MINUTE_PARTICLE_OF_DUST_CODE;
			stx = "미세먼지 " + alertStep + " 발령";
		}else if("pm25".equals(pollutant)) {
			code = SepsCommonCode.ULTRA_FINE_PARTICLE_OF_DUST_CODE;
			stx = "초미세먼지 "+ alertStep +" 발령";
		}
		
		if("a".equals(faOn)) {
			alarmYn = "Y";
			alarmId = scheduleDAO.alarmInsert(new AlarmVO("fa", stx, code, baseDate, baseTime));
			boardVO.setAlarmId(alarmId);
			boardVO.setAlarmYn(alarmYn);
			boardVO.setPlaceCode(code);
			scheduleDAO.alarmBoardUpdate(boardVO);
		}else if("f".equals(faOn)){
			alarmYn = "N";
			
			// 미사용 조건용 변수 (미세먼지 데이터에 안 오니까 사용함.)
			dustVO.setMsrrgn("check");
			// 같은 일시에, 경보, 주의보가 있으면, 해제 안함.
			dustVO.setFaOn("a");
			
			int cnt = scheduleDAO.warningSelect(dustVO);
			
			// 예보일시와 같거나 이후의 경보일시가 미존재하면, 해당 미세먼지/초미세먼지에 대한 알람 종료.
			if(cnt == 0) {
				boardVO.setAlarmId(alarmId);
				boardVO.setAlarmYn(alarmYn);
				boardVO.setPlaceCode(code);
				scheduleDAO.alarmBoardUpdate(boardVO);
			}
			
		}
	}
	

	 /**
	 * 커넥션풀 생성 공통 method
	 * 18층 수위 시스템
	 * @return
	 */
	public static Connection createConn(){
		Connection con = null;
		try{ 
			Class.forName("com.mysql.jdbc.Driver"); //sep 150.50.68.44  210.104.21.120:3306
			con = DriverManager.getConnection("jdbc:mysql://58.255.46.200:3306/smfmc", "seps", "seps!@#");
		}catch(ClassNotFoundException cnfe){ 
			LOGGER.info("com.mysql.jdbc.Driver를 찾을 수 없습니다."); 
		}catch(SQLException  sql){ 
			LOGGER.info("Connection 실패!" + sql.getMessage());
		}
		return con;
	}
	
	
	/**
	 * JDBC 관련 resource 객체 close 처리
	 * @param objects
	 */
	public static void closeDBObjects(Wrapper ... objects) {
		for (Object object : objects) {
			if (object != null) {
				if (object instanceof ResultSet) {
					try {
						((ResultSet)object).close();
					} catch (Exception ignore) {
						LOGGER.info("Occurred Exception to close resource is ingored!!");
					}
				} else if (object instanceof Statement) {
					try {
						((Statement)object).close();
					} catch (Exception ignore) {
						LOGGER.info("Occurred Exception to close resource is ingored!!");
					}
				} else if (object instanceof Connection) {
					try {
						((Connection)object).close();
					} catch (Exception ignore) {
						LOGGER.info("Occurred Exception to close resource is ingored!!");
					}
				} else {
					throw new IllegalArgumentException("Wrapper type is not found : " + object.toString());
				}
			}
		}
	}
	
	public List<WaterLevelVO> sisulWaterLevelData(String tableName, String dateArray[], String wlobscd){
		List<WaterLevelVO> resultList = new ArrayList<WaterLevelVO>();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null; 
		WaterLevelVO paramVO = null;
		
		try {
			con = createConn();
			stmt = con.createStatement();
			
			// 시설공단 수위 level 조회
			String sql = "SELECT DATE_FORMAT(TIME, '%Y%m%d%H%i') as ymdhm, LEVEL AS wl FROM "+tableName+" WHERE DATE_FORMAT(TIME, '%Y%m%d%H%i') BETWEEN '"+dateArray[0]+"' AND '"+dateArray[2]+"'";
			rs = stmt.executeQuery(sql);
			if(rs !=null){
				while (rs.next()) {
					
					paramVO = new WaterLevelVO();
					
					paramVO.setBaseDate(rs.getString("ymdhm").toString().substring(0, 8));
					paramVO.setBaseTime(rs.getString("ymdhm").toString().substring(8));
					paramVO.setWlobscd(wlobscd);
					paramVO.setWl((rs.getFloat("wl"))+"");
					paramVO.setFw("0");
					
					resultList.add(paramVO);
				}
				LOGGER.info("수위데이터 조회 성공 = {}", tableName);
			}
		} catch (SQLException e) {
			LOGGER.debug("수위데이터 조회 실패 = {}", tableName);
		} finally {
			closeDBObjects(rs, stmt, con);
		}
		
		return resultList;
	}
	
	/**
	 * 커넥션풀 생성 공통 method
	 * 6층 하천범람
	 * @return
	 */
	
	public List<WaterLevelVO> sisulWaterLevelData2( String dateArray[]){
		List<WaterLevelVO> resultList = new ArrayList<WaterLevelVO>();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null; 
		WaterLevelVO paramVO = null;
		
		try {	
			con = createConn2();
			stmt = con.createStatement();
			
			// 시설공단 수위 level 조회
			String sql = "SELECT * FROM PumpM_RoadLevel_view";
			rs = stmt.executeQuery(sql);
			if(rs !=null){
				while (rs.next()) {
					
					paramVO = new WaterLevelVO();
					
					paramVO.setBaseDate(dateArray[2].substring(0,8));
					paramVO.setBaseTime(dateArray[2].substring(8));
					
					String tempId = rs.getString("ID");
					
					if(!EgovStringUtil.isEmpty(tempId)){
						switch (tempId) {
						case "01010006":
							paramVO.setWlobscd("0000004"); //월계
							break;
						case "01010007":
							paramVO.setWlobscd("0000005"); //월릉
							break;
						case "01010009":
							paramVO.setWlobscd("0000006"); //중랑
							break;
						default:
							paramVO.setWlobscd("0000004"); //월계
							break;
						}
					}
					
					paramVO.setWl(rs.getInt("RoadLevel")+"");
					paramVO.setFw("0");
					
					resultList.add(paramVO);
				}
				LOGGER.info("하천범람 조회 성공 = PumpM_RoadLevel_view");
			}
		} catch (SQLException e) {
			LOGGER.error("하천범람 조회 실패 = PumpM_RoadLevel_view", e);
		} finally {
			closeDBObjects(rs, stmt, con);
		}
		
		return resultList;
	}
	
	public static Connection createConn2(){
		Connection con = null;
		try{ 
			Class.forName("com.mysql.jdbc.Driver"); // 150.50.76.11
			con = DriverManager.getConnection("jdbc:mysql://210.104.21.121:3306/subwaysi_db", "RoadLevel", "road123!");
		}catch(ClassNotFoundException cnfe){ 
			LOGGER.info("com.mysql.jdbc.Driver를 찾을 수 없습니다."); 
		}catch(SQLException  sql){ 
			LOGGER.info("Connection 실패!" + sql.getMessage());
		}
		return con;
	}
	
}
