package seps.batch;

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
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import seps.cmmn.SepsCommonCode;
import seps.valueObject.AlarmBoardVO;
import seps.valueObject.AlarmVO;
import seps.valueObject.api.DamVO;
import seps.valueObject.api.DustVO;
import seps.valueObject.api.MyJsonComparartor;
import seps.valueObject.api.SpecialNewsCodeVO;
import seps.valueObject.api.TideTphVO;
import seps.valueObject.api.TideVO;
import seps.valueObject.api.WaterLevelVO;
import seps.valueObject.api.WeatherLifeVO;
import seps.valueObject.api.WeatherMiddleVO;
import seps.valueObject.api.WeatherTemperatureVO;
import seps.valueObject.api.WeatherVO;
import component.util.ComStringUtil;
import component.util.DateTempletUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;

@Component
public class ScheduleTask {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ScheduleTask.class);
	private static final int FORECASTGRIB_STD_TIME = 45;
	@Autowired private ScheduleDAO scheduleDAO;
	
	@Scheduled(cron="30 46 * * * *") 
	public void task_1(){
		LOGGER.info("********************************************************WEATHER BATCH - start********************************************************************");
		//서울 종로구
		weatherDataInsert(SepsCommonCode.SEOUL_JONGNO_WEATHER_X, SepsCommonCode.SEOUL_JONGNO_WEATHER_Y, SepsCommonCode.SEOUL_JONGNO_WEATHER_CODE);
		
		//초단기예보 조회
		weatherTimeDataInsert(SepsCommonCode.SEOUL_JONGNO_WEATHER_X, SepsCommonCode.SEOUL_JONGNO_WEATHER_Y, SepsCommonCode.SEOUL_JONGNO_WEATHER_CODE);
		
		//신곡교 의정부1동
		weatherDataInsert(SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_X, SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_Y, SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_CODE);
		
		//강서 화곡본동
		weatherDataInsert(SepsCommonCode.SEOUL_KANGSEO_HWAGOKBON_WEATHER_X, SepsCommonCode.SEOUL_KANGSEO_HWAGOKBON_WEATHER_Y, SepsCommonCode.SEOUL_KANGSEO_HWAGOKBON_WEATHER_CODE);
		
		//관악 신림동
		weatherDataInsert(SepsCommonCode.SEOUL_KWANAK_SINLIM_WEATHER_X, SepsCommonCode.SEOUL_KWANAK_SINLIM_WEATHER_Y, SepsCommonCode.SEOUL_KWANAK_SINLIM_WEATHER_CODE);
		
		//강동 고덕동
		weatherDataInsert(SepsCommonCode.SEOUL_KANGDONG_GODUK_WEATHER_X, SepsCommonCode.SEOUL_KANGDONG_GODUK_WEATHER_Y, SepsCommonCode.SEOUL_KANGDONG_GODUK_WEATHER_CODE);
		
		//마포 망원동
		weatherDataInsert(SepsCommonCode.SEOUL_MAFO_MANGWON_WEATHER_X, SepsCommonCode.SEOUL_MAFO_MANGWON_WEATHER_Y, SepsCommonCode.SEOUL_MAFO_MANGWON_WEATHER_CODE);

		
		//서울 노원구 월계1동
		weatherDataInsert(SepsCommonCode.SEOUL_NOWON_WOLGYE1_WEATHER_X, SepsCommonCode.SEOUL_NOWON_WOLGYE1_WEATHER_Y, SepsCommonCode.SEOUL_NOWON_WOLGYE1_WEATHER_CODE);

		//서울 성동구 마장동
		weatherDataInsert(SepsCommonCode.SEOUL_SEONGDONG_MAJANG_WEATHER_X, SepsCommonCode.SEOUL_SEONGDONG_MAJANG_WEATHER_Y, SepsCommonCode.SEOUL_SEONGDONG_MAJANG_WEATHER_CODE);

		//경기도 동두천시
		weatherDataInsert(SepsCommonCode.GYUNGGI_DONGDUCHEON_WEATHER_X, SepsCommonCode.GYUNGGI_DONGDUCHEON_WEATHER_Y, SepsCommonCode.GYUNGGI_DONGDUCHEON_WEATHER_CODE);

		//경기도 의정부
		weatherDataInsert(SepsCommonCode.GYUNGGI_UIJEONGBU_WEATHER_X, SepsCommonCode.GYUNGGI_UIJEONGBU_WEATHER_Y, SepsCommonCode.GYUNGGI_UIJEONGBU_WEATHER_CODE);
		
		LOGGER.info("********************************************************WEATHER BATCH - end********************************************************************");
	}

	@Scheduled(cron="0 15 2,5,8,11,14,17,20,23 * * *")
	//@Scheduled(cron="0 10/30 16,17,18,19,20,21,22,23,24 * * *") 
	//@Scheduled(cron="0 0/10 * * * *")
	//@Scheduled(cron="0 * * * * *")
	public void task_1_1(){
		LOGGER.info("********************************************************WEATHER SERIES BATCH - start********************************************************************");
		//서울 종로구

		weatherSeriesDataInsert(SepsCommonCode.SEOUL_JONGNO_WEATHER_X, SepsCommonCode.SEOUL_JONGNO_WEATHER_Y, SepsCommonCode.SEOUL_JONGNO_WEATHER_CODE);
		
		//신곡교 의정부1동
		weatherSeriesDataInsert(SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_X, SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_Y, SepsCommonCode.UIJEONGBU_SINGOK_WEATHER_CODE);
		
		//강서 화곡본동
		weatherSeriesDataInsert(SepsCommonCode.SEOUL_KANGSEO_HWAGOKBON_WEATHER_X, SepsCommonCode.SEOUL_KANGSEO_HWAGOKBON_WEATHER_Y, SepsCommonCode.SEOUL_KANGSEO_HWAGOKBON_WEATHER_CODE);
		
		//관악 신림동
		weatherSeriesDataInsert(SepsCommonCode.SEOUL_KWANAK_SINLIM_WEATHER_X, SepsCommonCode.SEOUL_KWANAK_SINLIM_WEATHER_Y, SepsCommonCode.SEOUL_KWANAK_SINLIM_WEATHER_CODE);
		
		//강동 고덕동
		weatherSeriesDataInsert(SepsCommonCode.SEOUL_KANGDONG_GODUK_WEATHER_X, SepsCommonCode.SEOUL_KANGDONG_GODUK_WEATHER_Y, SepsCommonCode.SEOUL_KANGDONG_GODUK_WEATHER_CODE);
		
		//마포 망원동
		weatherSeriesDataInsert(SepsCommonCode.SEOUL_MAFO_MANGWON_WEATHER_X, SepsCommonCode.SEOUL_MAFO_MANGWON_WEATHER_Y, SepsCommonCode.SEOUL_MAFO_MANGWON_WEATHER_CODE);
		
		
		//서울 노원구 월계1동
		weatherSeriesDataInsert(SepsCommonCode.SEOUL_NOWON_WOLGYE1_WEATHER_X, SepsCommonCode.SEOUL_NOWON_WOLGYE1_WEATHER_Y, SepsCommonCode.SEOUL_NOWON_WOLGYE1_WEATHER_CODE);

		//서울 성동구 마장동
		weatherSeriesDataInsert(SepsCommonCode.SEOUL_SEONGDONG_MAJANG_WEATHER_X, SepsCommonCode.SEOUL_SEONGDONG_MAJANG_WEATHER_Y, SepsCommonCode.SEOUL_SEONGDONG_MAJANG_WEATHER_CODE);

		//경기도 동두천시
		weatherSeriesDataInsert(SepsCommonCode.GYUNGGI_DONGDUCHEON_WEATHER_X, SepsCommonCode.GYUNGGI_DONGDUCHEON_WEATHER_Y, SepsCommonCode.GYUNGGI_DONGDUCHEON_WEATHER_CODE);

		//경기도 의정부
		weatherSeriesDataInsert(SepsCommonCode.GYUNGGI_UIJEONGBU_WEATHER_X, SepsCommonCode.GYUNGGI_UIJEONGBU_WEATHER_Y, SepsCommonCode.GYUNGGI_UIJEONGBU_WEATHER_CODE);
	
		LOGGER.info("********************************************************WEATHER SERIES BATCH - end********************************************************************");
	}
	
	@Scheduled(cron="0 25 * * * *")
	public void task_2(){
		LOGGER.info("********************************************************TIDE BATCH - start********************************************************************");
		ScheduleAction actionObj = new ScheduleAction();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		
		String strNowDate =sdf.format(cal.getTime());
		try {
			JSONObject result = (JSONObject) actionObj.return_tideCurPre(strNowDate).get("result");
			JSONArray jArray = (JSONArray) result.get("data");
			JSONObject paramJSON = (JSONObject) jArray.get(jArray.size()-1);
			
			String recordDate = paramJSON.get("record_time").toString().split(" ")[0].replaceAll("-", "");
			String recordTime = paramJSON.get("record_time").toString().split(" ")[1].replaceAll(":", "");
			
			TideVO paramVO = new TideVO();
			paramVO.setObscode("DT_001");
			paramVO.setBaseDate(recordDate);
			paramVO.setBaseTime(recordTime);
			paramVO.setPrvValue(paramJSON.get("pre_value").toString());
			paramVO.setRealValue(paramJSON.get("real_value").toString());
			
			scheduleDAO.tideRealPrevInsert(paramVO);
		} catch (Exception e) {
			LOGGER.debug("조위 실측&예측 배치 실패");
			LOGGER.debug(e.getMessage());
		}
		LOGGER.info("********************************************************TIDE BATCH - end********************************************************************");
	}
	
	@Scheduled(cron="0 0 0 * * *")
	public void task_3(){
		LOGGER.info("********************************************************TIDE TPH BATCH - start********************************************************************");
		ScheduleAction actionObj = new ScheduleAction();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, +3);
		
		String strNowDate =sdf.format(cal.getTime());
		try {
			
			JSONObject result = (JSONObject) actionObj.return_tideTphPre(strNowDate).get("result");
			JSONArray jArray = (JSONArray) result.get("data");
			
			for(int i=0; i<jArray.size(); i++){
				TideTphVO paramVO = new TideTphVO();
				JSONObject paramJson = (JSONObject) jArray.get(i);
				String recordDate = paramJson.get("tph_time").toString().split(" ")[0].replaceAll("-", "");
				String recordTime = paramJson.get("tph_time").toString().split(" ")[1].replaceAll(":", "").substring(0,4);
				paramVO.setObscode("DT_001");
				paramVO.setTphLevel(paramJson.get("tph_level").toString());
				paramVO.setHlCode(paramJson.get("hl_code").toString());
				paramVO.setBaseDate(recordDate);
				paramVO.setBaseTime(recordTime);
				scheduleDAO.tideTphInsert(paramVO);
			}
			
		} catch (Exception e) {
			LOGGER.debug("조위 극치 배치 실패");
			LOGGER.error(e.getMessage());
		}
		LOGGER.info("********************************************************TIDE TPH BATCH - end********************************************************************");
	}
	
	@Scheduled(cron="55 */5 * * * *")
	public void task_4(){
		LOGGER.info("********************************************************DAM BATCH - start********************************************************************");
		ScheduleAction actionObj = new ScheduleAction();
		
		try {
			String dateArray[] = initDate();
			JSONParser parser = new JSONParser();
			Object tempObj = parser.parse(actionObj.return_damLevel(dateArray[0], dateArray[1]).get("content").toString());
			JSONArray jsonArray = (JSONArray)tempObj;
			
			for (Object object : jsonArray) {
				JSONObject result = (JSONObject) object;
				
				DamVO paramVO = new DamVO();
				paramVO.setSwl(result.get("swl").toString());
				paramVO.setEcpc(result.get("ecpc").toString());
				paramVO.setTototf(result.get("tototf").toString());
				paramVO.setInf(result.get("inf").toString());
				paramVO.setSfw(result.get("sfw").toString());
				paramVO.setBaseDate(result.get("ymdhm").toString().substring(0, 8));
				paramVO.setBaseTime(result.get("ymdhm").toString().substring(8));
				if(!"-".equals(paramVO.getSwl()) && !"-".equals(paramVO.getEcpc()) && !"-".equals(paramVO.getTototf()) 
						&& !"-".equals(paramVO.getInf()) && !"-".equals(paramVO.getSfw())){
					int flag = scheduleDAO.damSelect(paramVO);
					if(flag == 0){
						insertAlarm("dam", Float.parseFloat(paramVO.getInf()), SepsCommonCode.PALDANG_TOTOTF_CODE, paramVO.getBaseDate(), paramVO.getBaseTime());
						scheduleDAO.damInsert(paramVO);
					}else{
						LOGGER.debug("등록된 데이터");
					}
				}
			}
			
		} catch (Exception e) {
			LOGGER.debug("댐 10분 방수량 배치 실패");
			LOGGER.debug(e.getMessage());
		}
		LOGGER.info("********************************************************DAM BATCH - end********************************************************************");
	}
	

	//수위 도달 정보 연계
	@Scheduled(cron="50 */5 * * * *")
	public void task_5(){
		LOGGER.info("********************************************************WATER LEVEL BATCH - start********************************************************************");
		ScheduleAction actionObj = new ScheduleAction();
		
		String[] searchArray = new String[]{
				SepsCommonCode.SINGOK_WATER_LEVEL_CODE, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, SepsCommonCode.CHEONGDAM_WATER_LEVEL_CODE
				, SepsCommonCode.OGEUM_WATER_LEVEL_CODE, SepsCommonCode.DAEGOK_WATER_LEVEL_CODE, SepsCommonCode.JINGWAN_WATER_LEVEL_CODE
				, SepsCommonCode.JOONGRANG_WATER_LEVEL_CODE
		}; 
		String dateArray[] = initDate();
		for(int i=0; i<searchArray.length; i++){
			try {
				JSONParser parser = new JSONParser();
				Object tempObj = parser.parse(actionObj.return_waterLevel(searchArray[i], dateArray[0], dateArray[1]).get("content").toString());
				JSONArray jsonArray = (JSONArray)tempObj;
				
				for (Object object : jsonArray) {
					JSONObject result = (JSONObject) object;
					
					WaterLevelVO paramVO = new WaterLevelVO();
					paramVO.setBaseDate(result.get("ymdhm").toString().substring(0, 8));
					paramVO.setBaseTime(result.get("ymdhm").toString().substring(8));
					paramVO.setWlobscd(result.get("wlobscd").toString());
					paramVO.setWl(result.get("wl").toString());
					paramVO.setFw(result.get("fw").toString());
					
					if(!"-".equals(paramVO.getWl()) && !EgovStringUtil.isEmpty(paramVO.getWl())){
						if("-".equals(paramVO.getFw()) || " ".equals(paramVO.getFw())|| EgovStringUtil.isEmpty(paramVO.getFw())){
							paramVO.setFw("");
						}
						
						int flag = scheduleDAO.waterLevelSelect(paramVO);
						
						if(flag == 0){
							insertAlarm("wl", Float.parseFloat(paramVO.getWl()), paramVO.getWlobscd(), paramVO.getBaseDate(), paramVO.getBaseTime());
							scheduleDAO.waterLevelInsert(paramVO);
						}else{
							LOGGER.debug("등록된 데이터");
						}
					}
				}
			} catch (Exception e) {
				LOGGER.debug(searchArray[i]+" 지점 수위 도달 10분 배치 실패");
				LOGGER.debug(e.getMessage());
			}
		}
		LOGGER.info("********************************************************WATER LEVEL BATCH - end********************************************************************");
	}
	
	//수위 도달 정보 연계-공단내부(월계1교, 여의상류)
	@Scheduled(cron="45 */5 * * * *")
	public void task_5_1(){
		LOGGER.info("********************************************************WATER LEVEL BATCH - start********************************************************************");
		
		String dateArray[] = initDate();
		try {
			
			// 월계1교 수위 데이터 - start
				// 월계1교 수위 데이터 조회 , 19.794
				List<WaterLevelVO> wolgye1WaterLevelList = sisulWaterLevelData("DISTANCE", dateArray, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE);
				// 월계1교 수위 데이터 조회
				
				// 월계1교 데이터 알람 확인
				if(wolgye1WaterLevelList.size() > 0){
					for(WaterLevelVO vo : wolgye1WaterLevelList){
						int flag = scheduleDAO.waterLevelSelect(vo);
						if(flag == 0){
							insertAlarm("wl", Float.parseFloat(vo.getWl()), vo.getWlobscd(), vo.getBaseDate(), vo.getBaseTime());
							scheduleDAO.waterLevelInsert(vo);
						}else{
							LOGGER.info("월계1교 등록된 데이터");
						}
					}
				}else{
					LOGGER.info("월계1교 수위데이터가 없습니다.");
				}
			// 월계1교 수위 데이터 - end
			
			// 여의상류 수위 데이터 - start 
				// 여의상류 수위 데이터 조회 , 5.37
				List<WaterLevelVO> yeouiWaterLevelList = sisulWaterLevelData("DISTANCE1", dateArray, SepsCommonCode.YEOUI_WATER_LEVEL_CODE);
				
				// 여의상류 데이터 알람 확인
				if(yeouiWaterLevelList.size() > 0){
					for(WaterLevelVO vo : yeouiWaterLevelList){
						int flag = scheduleDAO.waterLevelSelect(vo);
						
						if(flag == 0){
							insertAlarm("wl", Float.parseFloat(vo.getWl()), vo.getWlobscd(), vo.getBaseDate(), vo.getBaseTime());
							scheduleDAO.waterLevelInsert(vo);
						}else{
							LOGGER.info("여의상류 등록된 데이터");
						}
					}
				}else{
					LOGGER.info("여의상류 수위데이터가 없습니다.");
				}
			// 여의상류 수위 데이터 - end
			
			//월릉교 수위 데이터 - start
				// 월릉교 수위 데이터 조회 , 19.451
				List<WaterLevelVO> wolleungWaterLevelList = sisulWaterLevelData("BRIDGE03", dateArray, SepsCommonCode.WOLLEUNG_WATER_LEVEL_CODE);
				// 월릉교 수위 데이터 조회
				
				//월릉교 데이터 알람 확인
				if(wolleungWaterLevelList.size() > 0){
					for(WaterLevelVO vo : wolleungWaterLevelList){
						int flag = scheduleDAO.waterLevelSelect(vo);
						if(flag == 0){
							insertAlarm("wl", Float.parseFloat(vo.getWl()), vo.getWlobscd(), vo.getBaseDate(), vo.getBaseTime());
							scheduleDAO.waterLevelInsert(vo);
						}else{
							LOGGER.info("월릉교 등록된 데이터");
						}
					}
				}else{
					LOGGER.info("월릉교 수위데이터가 없습니다.");
				}
			// 월릉교 수위 데이터 - end
		} catch (Exception e) {
			LOGGER.debug("월계1교, 여의상류, 월릉교 지점 수위 도달 10분 배치 실패");
			LOGGER.debug(e.getMessage());
		} 
		LOGGER.info("********************************************************WATER LEVEL BATCH - end********************************************************************");
	}
	
	//하천범람 정보 연계-공단내부(월계1교, 월릉교 중랑교)
	@Scheduled(cron="55 */5 * * * *")
	public void task_5_2(){
		LOGGER.info("********************************************************RIVER LEVEL BATCH - start********************************************************************");
		
		String dateArray[] = initDate();
		try {
			// 월계1교 수위 데이터 조회
			List<WaterLevelVO> riverLevelList = sisulWaterLevelData2(dateArray);
			// 월계1교 수위 데이터 조회
			
			// 월계1교 데이터 알람 확인
			if(riverLevelList.size() > 0){
				for(WaterLevelVO vo : riverLevelList){
					int flag = scheduleDAO.waterLevelSelect(vo);
					if(flag == 0){
						insertAlarm("wl", Float.parseFloat(vo.getWl()), vo.getWlobscd(), vo.getBaseDate(), vo.getBaseTime());
						scheduleDAO.waterLevelInsert(vo);
					}else{
						LOGGER.info("하천범람 등록된 데이터");
					}
				}
			}else{
				LOGGER.info("하천범람 데이터가 없습니다.");
			}
		} catch (Exception e) {
			LOGGER.debug("하천범람 수위 도달 10분 배치 실패");
			LOGGER.debug(e.getMessage());
		} 
		LOGGER.info("********************************************************RIVER LEVEL BATCH - end********************************************************************");
	}
	
	
	//생활지수 조회
	//@Scheduled(cron="1 * * * * *")
	@Scheduled(cron="30 14 */3 * * *") 
	public void task_6_1(){
		LOGGER.info("********************************************************WEATHER LIFE BATCH - start********************************************************************");
		
		ScheduleAction actionObj = new ScheduleAction();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
			String strNowDate = sdf.format(new Date());
			int nowMonth = Integer.parseInt(strNowDate.substring(4, 6));
			JSONObject result = null;
			if(nowMonth>=6 && nowMonth<=9){
				result = actionObj.retrun_weather_life("getDiscomfortIdx", strNowDate); //불쾌지수
				System.out.println("불쾌지>>>>>>>>>>>>>수>>>>>>>>>>>"+result);
				weatherLifeInsert(result);
			}else if(nowMonth>=11 || nowMonth<=3){
				result = actionObj.retrun_weather_life("getFreezeIdx", strNowDate); // 동파가능지수
				System.out.println("동파가능지수>>>>>>>>>>>>>수>>>>>>>>>>>"+result);
				weatherLifeInsert(result);
				result = actionObj.retrun_weather_life("getWindChillIdx", strNowDate); // 체감온도
				System.out.println("체감온도>>>>>>>>>>>>>수>>>>>>>>>>>"+result);
				weatherLifeInsert(result);
			}else{
				LOGGER.debug("해당되는 기간이 아닙니다.");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		LOGGER.info("********************************************************WEATHER LIFE BATCH - end********************************************************************");
	} 

	//보건지수 조회
	@Scheduled(cron="30 16 6,18 * * *")
	public void task_6_2(){
		LOGGER.info("********************************************************WEATHER HEALTH BATCH - start********************************************************************");
		
		ScheduleAction actionObj = new ScheduleAction();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
			String strNowDate = sdf.format(new Date());
			int nowMonth = Integer.parseInt(strNowDate.substring(4, 6));
			JSONObject result = null;
		if(nowMonth>=5 && nowMonth<=9){
			// 더위체감 지수
				result = actionObj.retrun_weather_life("getHeatFeelingIdx", strNowDate); 
				System.out.println("더위체감>>>>>>>>>>>>>수>>>>>>>>>>>"+result);
				weatherLifeInsert(result);
			}
			// 식중독 지수 (연중) A01_2
			//위험 95이상, 경고 70~95 미만, 주의 35~70 미만, 관심 0~35 미만
			result = actionObj.retrun_weather_health("getFoodPoisoningIdx", strNowDate); 
			weatherLifeInsert(result);
			
			// 천식 폐질환 지수 (연중) D01
			// 낮음 0, 보통 1, 높음 2, 매우높음 3
			result = actionObj.retrun_weather_health("getAsthmaIdx", strNowDate); 
			weatherLifeInsert(result);
			
			// 자외선 지수 (연중) 
			result = actionObj.retrun_weather_life("getUVIdx", strNowDate); 
			weatherLifeInsert(result);
			
			// 뇌졸중 지수 (연중)
			result = actionObj.retrun_weather_health("getStrokeIdx", strNowDate); 
			weatherLifeInsert(result);



		} catch (Exception e) {
			e.printStackTrace();
		}
		LOGGER.info("********************************************************WEATHER HEALTH BATCH - end********************************************************************");
	}
	
	
	//중기예보 조회
	@Scheduled(cron="30 16 6,18 * * *") 
	public void task_7_1(){
		LOGGER.info("********************************************************WEATHER MIDDLE BATCH - start********************************************************************");
		
		ScheduleAction actionObj = new ScheduleAction();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String strNowDate = sdf.format(new Date());
			//중기예보
			JSONObject result = null;
			result = actionObj.return_weather_middle(strNowDate);
			weatherMiddleInsert(result, strNowDate);

			//중기기온
			result = null;
			result = actionObj.return_weather_temperature(strNowDate);
			weatherTemperatureInsert(result, strNowDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		LOGGER.info("********************************************************WEATHER MIDDLE BATCH - end********************************************************************");
	}

	/**
	 * 시설공단 내부 수위데이터 조회
	 * @param tableName		테이블명(DISTANCE=월계1교, DISTANCE1=여의상류)
	 * @param dateArray		날짜정보
	 * @param wlobscd		코드(SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE=월계1교, SepsCommonCode.YEOUI_WATER_LEVEL_CODE=여의상류)
	 * @param stdValue		기준값 , double stdValue
	 * @return
	 */
	private List<WaterLevelVO> sisulWaterLevelData(String tableName, String dateArray[], String wlobscd){
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
	 * 시설공단 내부 하천범람 조회
	 * @param tableName		테이블명(PumpM_RoadLevel_view)
	 * @param dateArray		날짜정보
	 * @param wlobscd		코드(01010006=월계1교, 01010007=월릉교, 01010009=중랑교)
	 * @param stdValue		기준값
	 * @return
	 */
	private List<WaterLevelVO> sisulWaterLevelData2( String dateArray[]){
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
			LOGGER.debug("하천범람 조회 실패 = PumpM_RoadLevel_view");
		} finally {
			closeDBObjects(rs, stmt, con);
		}
		
		return resultList;
	}
	
	
	/**
	 * 특보코드조회 schedule
	 */
	@Scheduled(cron="0 */10 * * * *")
	//@Scheduled(cron="1 * * * * *")
	public void task_6(){
		LOGGER.info("********************************************************SPECIAL NEWS CODE BATCH - start********************************************************************");
		
		ScheduleAction actionObj = new ScheduleAction();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String nowDate = sdf.format(new Date());
		
		try {
			JSONObject result = actionObj.retrun_specialNewsCodeRequest(nowDate, nowDate, SepsCommonCode.SEOUL_AREA_CODE, "2"); // 서울
			
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			String totalCount = ((JSONObject)((JSONObject) result.get("response")).get("body")).get("totalCount").toString();
			
			if("00".equals(resultCode) && Integer.parseInt(totalCount) > 0){
				
				JSONArray tmpArr = new JSONArray();
				
				if(Integer.parseInt(totalCount) == 1){
					JSONObject item = (JSONObject) ((JSONObject) ((JSONObject) ((JSONObject) result.get("response")).get("body")).get("items")).get("item");
					tmpArr.add(item);
				}else{
					JSONArray item = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) result.get("response")).get("body")).get("items")).get("item");
					// 데이터 역순 정렬 (API 데이터가 기간 desc로 정렬되어 있음) - start
					for(int i = item.size()-1; i >= 0; i--){
						JSONObject jsonObj = (JSONObject) item.get(i);
						tmpArr.add(jsonObj);
					}
					// 데이터 역순 정렬 (API 데이터가 기간 desc로 정렬되어 있음) - end
				}
				
				Iterator<JSONObject> itr = tmpArr.iterator();
				SpecialNewsCodeVO vo = null;
				while(itr.hasNext()){
					vo = new SpecialNewsCodeVO();
					JSONObject o = itr.next();
					Set<String> keySet = o.keySet();
					for(String key : keySet){
						String methodName = String.format("set%s", ComStringUtil.setFirstStringUpper(key));
						Method m = SpecialNewsCodeVO.class.getMethod(methodName, String.class);
						m.invoke(vo, o.get(key).toString());
					}
					
					// 알람 등록 - start
					AlarmBoardVO boardVO = new AlarmBoardVO();
					int resultCnt = scheduleDAO.selectSpecialNewsCodeCnt(vo);
					if(resultCnt == 0){
						// 특보코드조회 data insert - start
						scheduleDAO.specialNewsCodeInsert(vo);
						// 특보코드조회 data insert - end
						
						// 특보 정보 set - start
							// 내용
							String content = "";
							String warnVarName = "";
							switch(vo.getWarnVar()){ // 특보종류
								case "1" : warnVarName = "강풍"; break;	case "2" : warnVarName = "호우"; break; 		case "3" : warnVarName = "한파"; break;
								case "4" : warnVarName = "건조"; break;	case "5" : warnVarName = "폭풍해일"; break;	case "6" : warnVarName = "풍랑"; break;
								case "7" : warnVarName = "태풍"; break;	case "8" : warnVarName = "대설"; break;		case "9" : warnVarName = "황사"; break;
								case "12" : warnVarName = "폭염"; break;
							}
							String warnStressName = "";
							switch(vo.getWarnStress()){ // 특보강도
								case "0" : warnStressName = "주의보"; break;	case "1" : warnStressName = "경보"; break;
							}
							String commandName = "";
							switch(vo.getCommand()){ // 특보발표코드
								case "1" : commandName = "발표"; break;				case "2" : commandName = "해제"; break; 				case "3" : commandName = "연장"; break;
								case "4" : commandName = "대치에 의한 해제"; break;	case "5" : commandName = "대치에 의한 발표"; break;	case "6" : commandName = "정정"; break;
								case "7" : commandName = "변경발표"; break;	case "8" : commandName = "변경해제"; break;	
							}
							
							String cancelName = "";
							if(vo.getCancel().equals("1")) cancelName = "(취소)";
							
							content = String.format("[%s] %s%s %s%s", vo.getAreaName(), warnVarName, warnStressName, commandName, cancelName);
							
							// 발령일시
							String stdDttm = vo.getTmFc();
							
							String baseDate = stdDttm.substring(0, 8);
							String baseTime = stdDttm.substring(8, 12);
						// 특보 정보 set - end
						
						// 알람 insert - start
						AlarmVO alarmVO = new AlarmVO("NC", content, SepsCommonCode.SEOUL_AREA_CODE, baseDate, baseTime);
						String rsAlarmId = scheduleDAO.alarmInsert(alarmVO);
						// 알람 insert - end
						
						boardVO.setAlarmId(rsAlarmId);
						boardVO.setAlarmYn("Y");
						boardVO.setPlaceCode(SepsCommonCode.SEOUL_AREA_CODE);
						scheduleDAO.alarmBoardUpdate(boardVO);
					}
					
					// 알람 등록 - end
					
				}
			}
		} catch (Exception e) {
			LOGGER.error("특보코드조회 10분 배치 실패");
			LOGGER.error(e.getMessage());
		}
		LOGGER.info("********************************************************SPECIAL NEWS CODE BATCH - end********************************************************************");
	}
	
	/**
	 * 미세먼지, 초미세먼지 조회
	 */
	@Scheduled(cron="5 */10 * * * *")
	public void task_7(){
		LOGGER.info("********************************************************WARNING BATCH - start********************************************************************");
		
		warningDataInsert("MinuteParticleOfDust"); // 미세먼지
		warningDataInsert("UltrafineParticleOfDust"); // 초미세먼지
		
		// particleDustDataInsert("Ozone"); // 오존 - 

		LOGGER.info("********************************************************WARNING BATCH - end********************************************************************");
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
			
			JSONObject result = actionObj.return_SecndSrtpdFrcstInfoService2("getUltraSrtNcst", p1BaseDate, p1BaseTime, nx, ny, null);
			
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			if("00".equals(resultCode)){
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
System.out.println("return_SecndSrtpdFrcstInfoService2 >>>>> "+result);
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			System.out.println("날씨데이터 호출 >>>>> "+resultCode);			
			if("00".equals(resultCode)){
				JSONArray item = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) result.get("response")).get("body")).get("items")).get("item");
				 ArrayList<JSONObject> list = new ArrayList<>();
					System.out.println("날씨데이터 item >> >> >>>>> "+item);		
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
						System.out.println("날씨데이터 0 >> >> >>>>> "+o);		
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
					if(paramVO.getRN1().equals("강수없음")){
						paramVO.setRN1("0");

					}
					
					System.out.println(o.get("fcstValue").toString());
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
			String p1BaseTime = strNowDate.split(" ")[1]+"00";
			
			p1BaseTime = "1100";
			
			JSONObject result = actionObj.return_SecndSrtpdFrcstInfoService2("getVilageFcst", p1BaseDate, p1BaseTime, nx, ny, "999");
			System.out.println("result>>>>>>>>>" + result);
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			if("00".equals(resultCode)){
				JSONArray item = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) result.get("response")).get("body")).get("items")).get("item");
				System.out.println("item>>>>>>>>>" + item);
				List<WeatherVO> paramList = new ArrayList<WeatherVO>();
				WeatherVO paramVO = new WeatherVO();
				String fcstDate = "";
				String fcstTime = "";
				for(int i = 0; i < item.size(); i++){
					JSONObject o = (JSONObject) item.get(i);
					System.out.println("o>>>>>>>>>" + o);
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
	
	// 생활 & 보건지수 DB Insert
	public void weatherLifeInsert(JSONObject result){
		LOGGER.debug("****************************************************************************************************************************");
		LOGGER.debug("result = {}", result.toString());
		String returnCode = "";
		JSONObject response = (JSONObject) result.get("response");
		try{
			// Null 때문에 try 안으로 이동.
			returnCode = ((JSONObject) response.get("header")).get("resultCode").toString();
			if(returnCode.equals("00")){
				WeatherLifeVO resultVO = new WeatherLifeVO();
				JSONArray resultList = (JSONArray) ((JSONObject) ((JSONObject) response.get("body")).get("items")).get("item");
				
				for(Object resultObject : resultList){
					JSONObject resultModel = (JSONObject) resultObject;
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
			}
		}catch(Exception e){
			LOGGER.error(e.getMessage());
		}
		LOGGER.debug("****************************************************************************************************************************");
	}
	
	//중기예보 DB insert
	private void weatherMiddleInsert(JSONObject result, String strNowDate) {
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
			if(returnCode.equals("00")){
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
		private void weatherTemperatureInsert(JSONObject result, String strNowDate) {
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
				if(returnCode.equals("00")){
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
	
	/**
	 * 특보코드조회
	 * @param areaCode	지역코드
	 */
	public void specialNewsCodeInsert(String areaCode){
		LOGGER.debug("****************************************************************************************************************************");
		LOGGER.debug("areaCode = {}", areaCode);
		
		ScheduleAction actionObj = new ScheduleAction();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String nowDate = sdf.format(new Date());
		
		try {
			JSONObject result = actionObj.retrun_specialNewsCodeRequest(nowDate, nowDate, areaCode, "2");
			
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			String totalCount = ((JSONObject)((JSONObject) result.get("response")).get("body")).get("totalCount").toString();
			
			List<SpecialNewsCodeVO> resultList = new ArrayList<>();
			
			if("00".equals(resultCode) && Integer.parseInt(totalCount) > 0){
				JSONArray item = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) result.get("response")).get("body")).get("items")).get("item");
				
				Iterator<JSONObject> itr = item.iterator();
				SpecialNewsCodeVO vo = null;
				while(itr.hasNext()){
					vo = new SpecialNewsCodeVO();
					JSONObject o = itr.next();
					Set<String> keySet = o.keySet();
					for(String key : keySet){
						String methodName = String.format("set%s", ComStringUtil.setFirstStringUpper(key));
						Method m = SpecialNewsCodeVO.class.getMethod(methodName, String.class);
						m.invoke(vo, o.get(key).toString());
					}
					
					resultList.add(vo);
				}
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
		}
		LOGGER.debug("****************************************************************************************************************************");
	}

	/**
	 * 예경보 데이터 insert
	 */
	public void warningDataInsert(String service){
		LOGGER.debug("****************************************************************************************************************************");
		
		ScheduleAction actionObj = new ScheduleAction();
		
		try {
			JSONObject result = actionObj.return_warning_data(service);
			
			String resultCode = ((JSONObject)((JSONObject) result.get("ForecastWarning"+service+"Service")).get("RESULT")).get("CODE").toString();
			String totalCount = ((JSONObject) result.get("ForecastWarning"+service+"Service")).get("list_total_count").toString();
			
			if("INFO-000".equals(resultCode) && Integer.parseInt(totalCount) > 0){
				JSONArray item = (JSONArray) ((JSONObject) result.get("ForecastWarning"+service+"Service")).get("row");
				
				List<DustVO> paramList = new ArrayList<DustVO>();
				for(int i = 0; i < item.size(); i++){
					JSONObject o = (JSONObject) item.get(i);
					DustVO paramVO = new DustVO();
					
					paramVO.setApplcDt(o.get("APPLC_DT").toString());
					paramVO.setFaOn(o.get("FA_ON").toString());
					paramVO.setPollutant(o.get("POLLUTANT").toString());
					if("Ozone".equals(service)) paramVO.setMsrrgn(o.get("MSRRGN").toString());
					paramVO.setCaistep(o.get("CAISTEP").toString());
					paramVO.setAlarmCndt(o.get("ALARM_CNDT").toString());
					paramVO.setAlertstep(o.get("ALERTSTEP").toString());
					paramVO.setCndt1(o.get("CNDT1").toString());

					paramList.add(paramVO);
				}
			
				for (DustVO dustVO : paramList) {
					int cnt = scheduleDAO.warningSelect(dustVO);
					
					if(cnt == 0){
						scheduleDAO.warningInsert(dustVO);
						LOGGER.debug("미세먼지 등록");
						insertAlarm2(dustVO);
						
					}else{
						scheduleDAO.warningUpdate(dustVO);
						LOGGER.debug("미세먼지 수정");
					}
					
				}
			}
		} catch (Exception e) {
			LOGGER.error(e.getMessage());
			e.printStackTrace();
		}
		LOGGER.debug("****************************************************************************************************************************");
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
	
	private void insertAlarm(String type, float wl, String placeCode, String baseDate, String baseTime){
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
						if(wl >= (float)17.23){
//							String stx = "[동부] 월계1교 침수수위 도달(-0m)";
							//String stx = "[동부] 월계1교  침수도달, 청소(복구) 준비";
							String stx = "[동부] 월계1교  침수도달, 재난복구 준비";
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}else if(wl >= (float)16.23){
//							String stx = "[동부] 월계1교 2단계 통제수위 도달(-1.0m)";
							//String stx = "[동부] 월계1교  2차 교통통제 실시 (본선 16개소)";
							String stx = "[동부] 월계1교  2차(본선)통제 실시";
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}else if(wl >= (float)15.83){
//							String stx = "[동부] 월계1교 1단계 통제수위 도달(-1.4m)";
							//String stx = "[동부] 월계1교  1차 교통통제 실시 (램프 26개소, 본선2개소)";
							String stx = "[동부] 월계1교  1차(램프)통제 실시";
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}else if(wl >= (float)15.43){
//							String stx = "[동부] 월계1교 준비수위 도달(-1.8m)";
							String stx = "[동부] 월계1교  교통통제 준비";
							
							alarmId = scheduleDAO.alarmInsert(new AlarmVO("wl", stx, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, baseDate, baseTime));
						}else if(wl >= (float)14.43){
//							String stx = "[동부] 월계1교 관심수위 도달(-2.5m)";
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
	
	 /**
		 * 커넥션풀 생성 공통 method
		 * 18층 수위 시스템
		 * @return
		 */
		public static Connection createConn(){
			Connection con = null;
			try{ 
				Class.forName("com.mysql.jdbc.Driver"); //sep 150.50.68.44 /210.104.21.120:3306
				con = DriverManager.getConnection("jdbc:mysql://58.225.46.200:3306/smfmc", "seps", "seps!@#");
			}catch(ClassNotFoundException cnfe){ 
				LOGGER.info("com.mysql.jdbc.Driver를 찾을 수 없습니다."); 
			}catch(SQLException  sql){ 
				LOGGER.info("Connection 실패!" + sql.getMessage());
			}
			return con;
		}
		
		/**
		 * 커넥션풀 생성 공통 method
		 * 6층 하천범람
		 * @return
		 */
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
}
