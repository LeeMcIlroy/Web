package seps.batch;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.let.utl.fcc.service.EgovStringUtil;

public class ScheduleAction {
	/* private */ public static final Logger LOGGER = LoggerFactory.getLogger(ScheduleTask.class);
	
	/**
	 * 기상청 API key
	 */
//	/* private */ public static final String SECNDSRTPDFRCSTINFOSERVICE2_WEATHER_API_KEY = "mfskysh7Syfvno8IsjpF81WR0nFds%2BHxdrfSVeHZUHwj5AFqNnKKsO4e05lY%2BVQBVAiqGfN1aoPqKGGb8BrbjQ%3D%3D";	// 개발
//	/* private */ public static final String SECNDSRTPDFRCSTINFOSERVICE2_WEATHER_API_KEY = "En04C4UL9BH2keuKmHCFB%2FFKH8ziCMRjZVDqJIk3qIaBx8RmHMMZvkhbeC6fWlFwwCCcToRLd9u3w3dKUwcO%2Bw%3D%3D";	// 운영
//	/* private */ public static final String SECNDSRTPDFRCSTINFOSERVICE2_WEATHER_API_KEY = "%2BzMGoYXbG5e4hwIcsJCRrzDDO4Jp0NwWGe%2BCqve1ntuIGE%2FQXmh0SlQE5VKPSd9iHpqcKRzy70Y3IiuIIn5YUA%3D%3D";	// 운영
	/* private */ public static final String SECNDSRTPDFRCSTINFOSERVICE2_WEATHER_API_KEY = "IQOI9MqF8PpleNo7rvy%2F3OfxkgfCW6xBAczX91DqP3tw75XyjKVkw1E4NiuAKqtxpXXrarFfeyIYhmFqNTzDLg%3D%3D";	// 운영

	/**
	 * 기상특보 API key
	 */
//	/* private */ public static final String SECNDSRTPDFRCSTINFOSERVICE2_WEATHER_API_KEY = "mfskysh7Syfvno8IsjpF81WR0nFds%2BHxdrfSVeHZUHwj5AFqNnKKsO4e05lY%2BVQBVAiqGfN1aoPqKGGb8BrbjQ%3D%3D";	// 개발
//	/* private */ public static final String SECNDSRTPDFRCSTINFOSERVICE2_WEATHER_API_KEY = "En04C4UL9BH2keuKmHCFB%2FFKH8ziCMRjZVDqJIk3qIaBx8RmHMMZvkhbeC6fWlFwwCCcToRLd9u3w3dKUwcO%2Bw%3D%3D";	// 운영
	/* private */ public static final String WEATHER_SPECIALNEWS_API_KEY = "%2BzMGoYXbG5e4hwIcsJCRrzDDO4Jp0NwWGe%2BCqve1ntuIGE%2FQXmh0SlQE5VKPSd9iHpqcKRzy70Y3IiuIIn5YUA%3D%3D";	// 운영
//	/* private */ public static final String WEATHER_SPECIALNEWS_API_KEY = "IQOI9MqF8PpleNo7rvy%2F3OfxkgfCW6xBAczX91DqP3tw75XyjKVkw1E4NiuAKqtxpXXrarFfeyIYhmFqNTzDLg%3D%3D";	// 운영

	/**
	 * 바다누리 해양정보 서비스 API key
	 */
//	/* private */ public static final String OCEANGRID_TIDE_API_KEY = "2iey3jsdYoPLL2Db4Wh5qpC4eVwwz9y6bOBTPj2Qft0XImXkobWiDGZLvi2rePm1OYuz/BnakrZvVcSEtqLd7A==";	// 개발
	/* private */ public static final String OCEANGRID_TIDE_API_KEY = "uo0VQsviXZuyWoDJln/eAwNLBwOwlwOyBD50/DRXM2h4eAIqGZhDujbePXv9WZklrvVHTouRAoACxDW6GqnvA==";	// 운영
	
	/**
	 * 한강홍수통제소 API key
	 */
//	/* private */ public static final String WATER_LEVEL_API_KEY = "10E835B4-7BF9-45C3-ABC9-E1FA5B0D35DD";	// 개발
	/* private */ public static final String WATER_LEVEL_API_KEY = "E99979F9-923C-45AC-BE5B-A1CFF1608798";	// 운영
	
	/**
	 * 서울시 미세먼지, 초미세먼지 예경보 API key
	 */
	/* private */ public static final String PARTICLE_DUST_API_KEY = "6c4f4c6d4573687538364c454a7447";	// 개발
	
	/**
	 * 공공데이터포탈  중기예보 API_KEY
	 */
	/* private */ //public static final String LIFE_HEALTH_API_KEY = "5XiUf33HK6K5kfEKeo3hTvOPGER%2FgRcKgIqk28IF1fDHWU6JkhvPwFtEmHhSSWbdrg0R5vqL4HKpMn8rNZUFYg%3D%3D";//개발
	/* private */ public static final String WEATHER_MID_API_KEY = "%2BzMGoYXbG5e4hwIcsJCRrzDDO4Jp0NwWGe%2BCqve1ntuIGE%2FQXmh0SlQE5VKPSd9iHpqcKRzy70Y3IiuIIn5YUA%3D%3D";//개발
//	/* private */ public static final String WEATHER_MID_API_KEY = "IQOI9MqF8PpleNo7rvy%2F3OfxkgfCW6xBAczX91DqP3tw75XyjKVkw1E4NiuAKqtxpXXrarFfeyIYhmFqNTzDLg%3D%3D";	// 운영
									
	/**
	 * 공공데이터포탈 생활/보건지수, API_KEY
	 */
	/* private */ public static final String LIFE_HEALTH_API_KEY = "%2BzMGoYXbG5e4hwIcsJCRrzDDO4Jp0NwWGe%2BCqve1ntuIGE%2FQXmh0SlQE5VKPSd9iHpqcKRzy70Y3IiuIIn5YUA%3D%3D";//개발
//	/* private */ public static final String LIFE_HEALTH_API_KEY = "IQOI9MqF8PpleNo7rvy%2F3OfxkgfCW6xBAczX91DqP3tw75XyjKVkw1E4NiuAKqtxpXXrarFfeyIYhmFqNTzDLg%3D%3D";	// 운영

	
	
	// 초단기 url return
	public JSONObject return_SecndSrtpdFrcstInfoService2(String type, String baseDate, String baseTime, String nx, String ny, String numOfRows) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/"+type);
		sb.append("?serviceKey="+SECNDSRTPDFRCSTINFOSERVICE2_WEATHER_API_KEY);
		if(!EgovStringUtil.isEmpty(numOfRows)) sb.append("&numOfRows="+numOfRows);
		sb.append("&pageNo=1");
		sb.append("&dataType=JSON");
		sb.append("&base_date="+baseDate);
		sb.append("&base_time="+baseTime);
		sb.append("&nx="+nx);
		sb.append("&ny="+ny);
		
		LOGGER.debug("weather call URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		
		LOGGER.debug("weather result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		
		return jsonOb;
	}
	
	// 조위 실측&예측 url return
	public JSONObject return_tideCurPre(String baseDate) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://www.khoa.go.kr/oceangrid/grid/api/tideCurPre/search.do");
		sb.append("?Date="+baseDate);
		sb.append("&ServiceKey="+OCEANGRID_TIDE_API_KEY);
		sb.append("&ObsCode=DT_0001");
		sb.append("&ResultType=json");
		
		LOGGER.debug("tide call URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		
		LOGGER.debug("tide result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		
		return jsonOb;
	}
	
	// 조위 극치 url return
	public JSONObject return_tideTphPre(String baseDate) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://www.khoa.go.kr/oceangrid/grid/api/tideObsPreTab/search.do");
		sb.append("?Date="+baseDate);
		sb.append("&ServiceKey="+OCEANGRID_TIDE_API_KEY);
		sb.append("&ObsCode=DT_0001");
		sb.append("&ResultType=json");
		
		LOGGER.debug("tide call URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		
		LOGGER.debug("tide result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		
		return jsonOb;
	}
	
	// 댐 url return
	public JSONObject return_damLevel(String startDate, String endDate) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://api.hrfco.go.kr/"+WATER_LEVEL_API_KEY+"/dam/list/10M/1017310/"+startDate+"/"+endDate+".json");
		
		LOGGER.debug("dam call URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		
		LOGGER.debug("dam result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		
		return jsonOb;
	}
	
	// 수위 url return
	public JSONObject return_waterLevel(String wlobscd, String startDate, String endDate) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://api.hrfco.go.kr/"+WATER_LEVEL_API_KEY+"/waterlevel/list/10M/"+wlobscd+"/"+startDate+"/"+endDate+".json");
		
		LOGGER.debug("water call URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		
		LOGGER.debug("water result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		
		return jsonOb;
	}
	
	/**
	 * 기상 특보코드조회
	 * @param startDate		발표시각(from) - 20180620
	 * @param endDate		발표시각(to) - 20180620
	 * @param areaCode		특보구역코드	- L1010100(서울), L1011700(의정부)
	 * @param warningType	특보종류	- 1(강풍), 2(호우), 3(한파), 4(건조), 5(폭풍해일), 6(풍랑), 7(태풍), 8(대설), 9(황사), 12(폭염)
	 * @return
	 * @throws Exception
	 */
	public JSONObject retrun_specialNewsCodeRequest(String startDate, String endDate, String areaCode, String warningType) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://apis.data.go.kr/1360000/WthrWrnInfoService/getPwnCd");
		sb.append("&fromTmFc="+startDate);
		sb.append("&toTmFc="+endDate);
		sb.append("&areaCode="+areaCode);
		sb.append("&warningType="+warningType);
		sb.append("&numOfRows=20");
		sb.append("&dataType=JSON");
		sb.append("&ServiceKey="+WEATHER_SPECIALNEWS_API_KEY);
		
		LOGGER.debug("weather spcrws cal URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		LOGGER.debug("****************************************************************************************************************************");
		
		return jsonOb;
	}
	
	// 미세먼지, 초미세먼지 url return
	public JSONObject return_warning_data(String service) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://openAPI.seoul.go.kr:8088"); /*URL*/
        sb.append("/"+PARTICLE_DUST_API_KEY); /*인증키*/
        sb.append("/json"); /*요청파일타입*/
        sb.append("/ForecastWarning"+service+"Service"); /*서비스명*/
        sb.append("/1"); /*요청시작위치*/
        sb.append("/10"); /*요청종료위치*/
		
		LOGGER.debug(service+" call URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		
		LOGGER.debug("ParticleDust result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		
		return jsonOb;
	}

	//생활 지수 등록
	public JSONObject retrun_weather_life(String service, String strNowDate) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://apis.data.go.kr/1360000/LivingWthrIdxService/"+service);
		sb.append("?serviceKey="+LIFE_HEALTH_API_KEY);
		sb.append("&pageNo=1");
		sb.append("&numOfRows=10");
		sb.append("&dataType=JSON");
		sb.append("&areaNo=1100000000");
		sb.append("&time="+strNowDate);
		
		LOGGER.debug(service+" call URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		
		LOGGER.debug("weatherLife result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		return jsonOb;
		
	}

	
	
	//보건지수 등록
	public JSONObject retrun_weather_health(String service, String strNowDate) throws Exception {
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://apis.data.go.kr/1360000/HealthWthrIdxService/"+service);
		sb.append("?serviceKey="+LIFE_HEALTH_API_KEY);
		sb.append("&pageNo=1");
		sb.append("&numOfRows=10");
		sb.append("&dataType=JSON");
		sb.append("&areaNo=1100000000");
		sb.append("&time="+strNowDate);
		
		LOGGER.debug(service+" call URL = {}", sb.toString());
		
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		
		LOGGER.debug("weatherHealth result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		return jsonOb;
		
	}
	
	
	
	//중기예보 등록
	public JSONObject return_weather_middle(String strNowDate) throws Exception{
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst");
		sb.append("?serviceKey="+WEATHER_MID_API_KEY);
		sb.append("&dateType=JSON");
		sb.append("&regId=11B00000");
		sb.append("&tmFc="+strNowDate+"0600");
		sb.append("&numOfRows=10");
		sb.append("&pageNo=1");
		
		LOGGER.debug("getMiddleLandWeathe call URL = {}", sb.toString());
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		LOGGER.debug("weatherMiddle result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		return jsonOb;
	}
	
	//중기기온 등록
	public JSONObject return_weather_temperature(String strNowDate) throws Exception{
		LOGGER.debug("****************************************************************************************************************************");
		StringBuilder sb = new StringBuilder();
		sb.append("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa");
		sb.append("?serviceKey="+WEATHER_MID_API_KEY);
		sb.append("&regId=11B10101");
		sb.append("&dataType=JSON");
		sb.append("&tmFc="+strNowDate+"0600");
		sb.append("&numOfRows=10");
		sb.append("&pageNo=1");
		
		LOGGER.debug("getMiddleLandWeathe call URL = {}", sb.toString());
		URL url = new URL(sb.toString());
		
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "text/xml");
		urlConn.connect();
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonOb = (JSONObject) jsonParser.parse(urlInput);
		LOGGER.debug("weatherMiddle result = {}", jsonOb.toString());
		LOGGER.debug("****************************************************************************************************************************");
		return jsonOb;
	}
}
