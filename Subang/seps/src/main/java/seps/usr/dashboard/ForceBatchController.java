package seps.usr.dashboard;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import seps.batch.ScheduleAction;
import seps.cmmn.SepsCommonCode;
import seps.valueObject.AlarmBoardVO;
import seps.valueObject.AlarmVO;
import seps.valueObject.api.DustVO;
import seps.valueObject.api.SpecialNewsCodeVO;
import seps.valueObject.api.TideTphVO;
import seps.valueObject.api.TideVO;
import seps.valueObject.api.WaterLevelVO;

import component.util.ComStringUtil;

import egovframework.let.utl.fcc.service.EgovStringUtil;

@Controller
public class ForceBatchController extends CmmnForceBatchController{

	private static final Logger LOGGER = LoggerFactory.getLogger(ForceBatchController.class);
	
	// 지수
	@RequestMapping("/jisu.do")
	public String jisu() throws Exception {
		
		LOGGER.info("********************************************************WEATHER LIFE BATCH - start********************************************************************");
		
		ScheduleAction actionObj = new ScheduleAction();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
			String strNowDate = sdf.format(new Date());
			int nowMonth = Integer.parseInt(strNowDate.substring(4, 6));
			JSONObject result = null;
			
			if(nowMonth>=6 && nowMonth<=9){
				result = actionObj.retrun_weather_life("RetrieveLifeIndexService3/getDsplsLifeList", strNowDate); //불쾌지수
				weatherLifeInsert(result);
			}else if(nowMonth>=11 || nowMonth<=3){
				result = actionObj.retrun_weather_life("RetrieveLifeIndexService3/getWinterLifeList", strNowDate); // 동파가능지수
				weatherLifeInsert(result);
				result = actionObj.retrun_weather_life("RetrieveLifeIndexService3/getSensorytemLifeList", strNowDate); // 체감온도
				weatherLifeInsert(result);
			}else{
				LOGGER.debug("해당되는 기간이 아닙니다.");
			}
			
			
			if(nowMonth>=5 && nowMonth<=9){
				//더위체감 지수
				result = actionObj.retrun_weather_life("RetrieveLifeIndexService3/getSensoryHeatLifeList", strNowDate); 
				weatherLifeInsert(result);
			}
			
			// 자외선 지수 (연중) 
			result = actionObj.retrun_weather_life("RetrieveLifeIndexService3/getUltrvLifeList", strNowDate); 
			weatherLifeInsert(result);
			
			// 뇌졸중 지수 (연중)
			result = actionObj.retrun_weather_life("RetrieveWhoIndexService2/getBrainWhoList", strNowDate); 
			weatherLifeInsert(result);

			// 천식 지수 (연중) D01
			// 낮음 0, 보통 1, 높음 2, 매우높음 3
			result = actionObj.retrun_weather_life("RetrieveWhoIndexService2/getAsthmaWhoList", strNowDate); 
			weatherLifeInsert(result);

			// 식중독 지수 (연중) A01_2
			//위험 95이상, 경고 70~95 미만, 주의 35~70 미만, 관심 0~35 미만
			result = actionObj.retrun_weather_life("RetrieveLifeIndexService3/getFsnLifeList", strNowDate); 
			weatherLifeInsert(result);
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		LOGGER.info("********************************************************WEATHER LIFE BATCH - end********************************************************************");

		
		
		return "redirect:/usr/dashboard/main.do";
	}
	
	
	
	// 미세먼지, 초미세먼지 
	@RequestMapping("/warn.do")
	public String warn() throws Exception {
	
		LOGGER.debug("================== 테스트 컨트롤러 실행 ==================");
//		ScheduleTask task = new ScheduleTask();
//		task.task_7();
		
		// MinuteParticleOfDust, UltrafineParticleOfDust      
		String[] serviceArr = {"MinuteParticleOfDust","UltrafineParticleOfDust"};
		
		for(String service : serviceArr) {
			
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
		
		LOGGER.debug("================== 테스트 컨트롤러 종료 ==================");
		
		return "redirect:/usr/dashboard/main.do";
		
	}
	
	
	// 중기
	@RequestMapping("/middle.do")
	public String middle() throws Exception {
	
		LOGGER.debug("================== 테스트 컨트롤러 실행 ==================");
		
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

		
		
		LOGGER.debug("================== 테스트 컨트롤러 종료 ==================");
		
		return "redirect:/usr/dashboard/main.do";
		
	}
	
	// 인천 극치
	@RequestMapping("/incheon1.do")
	public String incheon1() throws Exception {
	
		LOGGER.debug("================== 테스트 컨트롤러 실행 ==================");
		
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
	
		
		
		LOGGER.debug("================== 테스트 컨트롤러 종료 ==================");
		
		return "redirect:/usr/dashboard/main.do";
		
	}
	
	// 인천 실측/예측 조위
	@RequestMapping("/incheon2.do")
	public String incheon2() throws Exception {
		LOGGER.debug("================== 테스트 컨트롤러 실행 ==================");
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
		
		LOGGER.debug("================== 테스트 컨트롤러 종료 ==================");
		
		return "redirect:/usr/dashboard/main.do";
	}
	
	// 초단기 실황/예보
	@RequestMapping("/chodangi.do")
	public String chodangi() throws Exception {

		LOGGER.info("******************************************************** WEATHER BATCH - start********************************************************************");
		
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
		
		LOGGER.info("******************************************************** WEATHER BATCH - end********************************************************************");
		
		LOGGER.debug("================== 테스트 컨트롤러 종료 ==================");
		
		
		return "redirect:/usr/dashboard/main.do";
	}
	
	// 동네 예보
	@RequestMapping("/yeebo.do")
	public String yeebo() throws Exception {
		
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

		
		return "redirect:/usr/dashboard/main.do";
	}
	
	// 특보코드
	@RequestMapping("/special.do")
	public String special() throws Exception {

		LOGGER.info("********************************************************SPECIAL NEWS CODE BATCH - start********************************************************************");
		
		ScheduleAction actionObj = new ScheduleAction();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String nowDate = sdf.format(new Date());
		
		try {
			JSONObject result = actionObj.retrun_specialNewsCodeRequest(nowDate, nowDate, SepsCommonCode.SEOUL_AREA_CODE, "2"); // 서울
			
			String resultCode = ((JSONObject)((JSONObject) result.get("response")).get("header")).get("resultCode").toString();
			String totalCount = ((JSONObject)((JSONObject) result.get("response")).get("body")).get("totalCount").toString();
			
			if("0000".equals(resultCode) && Integer.parseInt(totalCount) > 0){
				
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
							switch(vo.getWarnVar()){
								case "1" : warnVarName = "강풍"; break;	case "2" : warnVarName = "호우"; break; 		case "3" : warnVarName = "한파"; break;
								case "4" : warnVarName = "건조"; break;	case "5" : warnVarName = "폭풍해일"; break;	case "6" : warnVarName = "풍랑"; break;
								case "7" : warnVarName = "태풍"; break;	case "8" : warnVarName = "대설"; break;		case "9" : warnVarName = "황사"; break;
								case "12" : warnVarName = "폭염"; break;
							}
							String warnStressName = "";
							switch(vo.getWarnStress()){
								case "0" : warnStressName = "주의보"; break;	case "1" : warnStressName = "경보"; break;
							}
							String commandName = "";
							switch(vo.getCommand()){
								case "1" : commandName = "발표"; break;				case "2" : commandName = "해제"; break; 				case "3" : commandName = "연장"; break;
								case "4" : commandName = "대치에 의한 해제"; break;	case "5" : commandName = "대치에 의한 발표"; break;	case "6" : commandName = "정정"; break;
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
		
		return "redirect:/usr/dashboard/main.do";
	}

	@RequestMapping("/wl.do")
	public String wl() throws Exception {

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
					
					if(!"-".equals(paramVO.getWl()) && !"-".equals(paramVO.getFw()) && !EgovStringUtil.isEmpty(paramVO.getWl()) && !EgovStringUtil.isEmpty(paramVO.getFw())){
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
		
		
		return "redirect:/usr/dashboard/main.do";
	}

	@RequestMapping("/wl18.do")
	public String wl18() throws Exception {
LOGGER.info("********************************************************WATER LEVEL BATCH - start********************************************************************");
		
		String dateArray[] = initDate();
		try {
			
			// 월계1교 수위 데이터 - start
				// 월계1교 수위 데이터 조회
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
				// 여의상류 수위 데이터 조회
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
				// 월릉교 수위 데이터 조회
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
	
		return "redirect:/usr/dashboard/main.do";
	}
	
	
	@RequestMapping("/ha6.do")
	public String ha6() throws Exception {
		LOGGER.info("********************************************************하천 범람 RIVER LEVEL BATCH - start********************************************************************");
		
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
			LOGGER.error("하천범람 수위 도달 10분 배치 실패", e);
		} 
		LOGGER.info("********************************************************하천 범람 RIVER LEVEL BATCH - end********************************************************************");

		return "redirect:/usr/dashboard/main.do";
	}
	
	// 수위 강제 알람
	@RequestMapping("/wlAlarm.do")
	public String wlAlarm() throws Exception {

		insertAlarm("wl", (float)15.83, SepsCommonCode.WOLGYE1_WATER_LEVEL_CODE, "20190927", "1100");
		insertAlarm("wl", (float)2, SepsCommonCode.WOLLEUNG_HACHEON_WATER_LEVEL_CODE, "20190927", "1100");
		insertAlarm("wl", (float)6.49, SepsCommonCode.HANGANG_WATER_LEVEL_CODE, "20190927", "1100");
		insertAlarm("dam", (float)15200, SepsCommonCode.PALDANG_TOTOTF_CODE, "20190927", "1100");
		
		
		return "redirect:/usr/dashboard/main.do";
	}
	// 수위 강제 알람
	@RequestMapping("/warnAlaram.do")
	public String warnAlaram() throws Exception {
		
		// MinuteParticleOfDust, UltrafineParticleOfDust      
		String service = "MinuteParticleOfDust";
		String aDate = "201911220500";
		String fDate = "201911221100";
		String json = "{\"ForecastWarningMinuteParticleOfDustService\":{\"RESULT\":{\"MESSAGE\":\"정상 처리되었습니다\",\"CODE\":\"INFO-000\"},\"list_total_count\":2,\"row\":[{\"ALARM_CNDT\":\"\",\"POLLUTANT\":\"pm10\",\"CNDT1\":\"가. 민감군(어린이·노인·폐질환 및 심장질환자)은 실외활동 제한 및 실내생활 권고\r\n나. 일반인은 장시간 또는 무리한 실외활동을 줄임(특히, 눈이 아프거나, 기침 또는 목의 통증이 있는 경우 실외활동 자제)\r\n다. 부득이 외출 시 황사(보호)마스크 착용(폐기능 질환자는 의사와 충분한 상의 후 사용권고)\r\n라. 교통량이 많은 지역 이동 자제\r\n마. 유치원·초등학교 실외수업 자제\r\n바. 공공기관 운영 야외 체육시설 운영 제한\r\n사. 공원·체육시설·고궁·터미널·철도 및 지하철 등을 이용 하는 시민에게 과격한 실외활동 자제 홍보\r\n아. 그 밖에 시민건강 보호를 위해 필요한 사항\",\"CAISTEP\":\"산출불가\",\"APPLC_DT\":\""+aDate+"\",\"ALERTSTEP\":\"주의보\",\"FA_ON\":\"a\"},{\"ALARM_CNDT\":\"노인, 어린이의 심한 옥외활동 자제\n호흡기, 심혈관질환자 등의 옥외활동 자제\n차량운행 자제 및 배출업소의 조업시간 조정\n유치원, 초등학교의 실외수업 자제외출 등 실외활동\",\"POLLUTANT\":\"pm10\",\"CNDT1\":\"\",\"CAISTEP\":\"나쁨\",\"APPLC_DT\":\""+fDate+"\",\"ALERTSTEP\":\"\",\"FA_ON\":\"f\"}]}}";
		JSONParser jsonParser = new JSONParser();
		JSONObject result = (JSONObject) jsonParser.parse(json);
		
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
		return "redirect:/usr/dashboard/main2.do";
	}
}
