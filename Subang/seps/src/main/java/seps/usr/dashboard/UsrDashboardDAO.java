package seps.usr.dashboard;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import seps.cmmn.SepsCommonCode;
import seps.valueObject.AlarmBoardVO;
import seps.valueObject.FloodControlVO;
import seps.valueObject.SnsVO;
import valueObject.CmmnSearchVO;

@Repository
public class UsrDashboardDAO extends EgovAbstractDAO {
	
	//메인화면 수방단계 조회
	public EgovMap selectFloodControl(CmmnSearchVO searchVO) {
		return (EgovMap) select("UsrDashboardDAO.selectFloodControl", searchVO);
	}

	//메인화면 기간별 알람 조회
	@SuppressWarnings("unchecked")
	/*
	public CmmnListVO selectAlarmBoard(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("UsrDashboardDAO.selectAlarmBoardCnt", searchVO);
		if (totalRecordCount != 0) {
			List<EgovMap> resultList = (List<EgovMap>) list("UsrDashboardDAO.selectAlarmBoard", searchVO);
			return new CmmnListVO(totalRecordCount, resultList);
		}else{
			return new CmmnListVO(totalRecordCount, null);
		}
	}
	*/
	public List<EgovMap> selectAlarmBoard(CmmnSearchVO searchVO){
		// 특보코드조회 update - start
		alarmBoardSpecialNewsCodeUpdate(SepsCommonCode.SEOUL_AREA_CODE);	// 서울
		/**
		 * 추후 의정부 추가시
		 * alarmBoardSpecialNewsCodeUpdate(SepsCommonCode.UIJEONGBU_AREA_CODE);	// 의정부
		 */
		// 특보코드조회 update - end
		return (List<EgovMap>) list("UsrDashboardDAO.selectAlarmBoard", searchVO);
	}
	
	// 알람상황판 update (특보코드조회 관련)
	private void alarmBoardSpecialNewsCodeUpdate(String placeCode){
		AlarmBoardVO alarmBoardVO = (AlarmBoardVO) select("UsrDashboardDAO.selectAlarmBoardOne", placeCode);
		if(alarmBoardVO != null){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			Calendar cal = Calendar.getInstance();
			cal.setTime(new Date());
			cal.add(Calendar.DATE, -1);
			
			String preDttm = sdf.format(cal.getTime());
			if(preDttm.compareTo(alarmBoardVO.getUdtDttm()) > 0){
				Map<String, String> map = new HashMap<>();
				map.put("placeCode", placeCode);
				map.put("alarmYn", "N");
				update("UsrDashboardDAO.alarmBoardSpecialNewsCodeUpdate", map);
			}
		}
	}

	//수위 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWaterLevel(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("UsrDashboardDAO.selectWaterLevel", searchVO);
	}

	//관측위치별 수위 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWaterLevel2(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("UsrDashboardDAO.selectWaterLevel2", searchVO);
	}
	
	//기상정보 조회
	public EgovMap selectWeather(CmmnSearchVO searchVO){
		return (EgovMap) select("UsrDashboardDAO.selectWeather", searchVO);
	}
	
	//기상예보 조회
	public EgovMap selectWeatherTime(CmmnSearchVO searchVO) {
		return (EgovMap) select("UsrDashboardDAO.selectWeatherTime", searchVO);
	}
	
	//기상예보 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWeatherTimeList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("UsrDashboardDAO.selectWeatherTimeList", searchVO);
	}
	
	//기상예보 목록 6시간전 강수량
	public EgovMap selectWeatherFristTime(CmmnSearchVO searchVO) {
		return (EgovMap) select("UsrDashboardDAO.selectWeatherFristTime", searchVO);
	}
	

	//사용자 알림 조회
	public String selectUsrAlarm() {
		return (String) select("UsrDashboardDAO.selectUsrAlarm");
	}
	
	//사용자 알림 수정
	public void updateUsrAlarm(String title) {
		update("UsrDashboardDAO.updateUsrAlarm", title);
	}

	//수방근무현황 및 알림목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectSnsList() {
		return (List<EgovMap>) list("UsrDashboardDAO.selectSnsList");
	}
	
	//수방단계 등록
	public void insertFloodControl(FloodControlVO paramVO) {
		insert("UsrDashboardDAO.insertFloodControl", paramVO);
	}
	
	//댐 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectDamLevel(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("UsrDashboardDAO.selectDamLevel", searchVO);
	}

	//극치 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectTideTph(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("UsrDashboardDAO.selectTideTph", searchVO);
	}
	
	/****************************************************************** 그래프 data set ******************************************************************/
	
	// 인천 실측 데이터
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectTideGraphData(String obsCode){
		return (List<EgovMap>) list("UsrDashboardDAO.selectTideGraphData", obsCode);
	}
	
	// 수위 데이터
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWaterLevelGraphData(String wlobscd){
		return (List<EgovMap>) list("UsrDashboardDAO.selectWaterLevelGraphData", wlobscd);
	}
	
	// 강수량 데이터
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectRainGraphData(String shpId){
		return (List<EgovMap>) list("UsrDashboardDAO.selectRainGraphData", shpId);
	}
	
	// 방류량 데이터
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectDamGraphData(String dmobscd){
		return (List<EgovMap>) list("UsrDashboardDAO.selectDamGraphData", dmobscd);
	}

	//사용자 sns공유 및 수방근무현황 등록 
	public void insertSns(SnsVO paramVO) {
		insert("UsrDashboardDAO.insertSns", paramVO);
	}

	/************************************************************기후화면 조회****************************************************************************/
	//미세먼지, 초미세먼지 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWarnStatus() {
		return (List<EgovMap>) list("UsrDashboardDAO.selectWarnStatus");
	}

	//지수 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLifeStatus() {
		return (List<EgovMap>) list("UsrDashboardDAO.selectLifeStatus");
	}
	
	//중기예보 조회
	@SuppressWarnings("unchecked")
	public EgovMap selectMiddleStatus(){
		return (EgovMap) select("UsrDashboardDAO.selectMiddleStatus");
	}
	
}
