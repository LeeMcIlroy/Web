package seps.batch;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import seps.valueObject.AlarmBoardVO;
import seps.valueObject.AlarmVO;
import seps.valueObject.api.DamVO;
import seps.valueObject.api.DustVO;
import seps.valueObject.api.SpecialNewsCodeVO;
import seps.valueObject.api.TideTphVO;
import seps.valueObject.api.TideVO;
import seps.valueObject.api.WaterLevelVO;
import seps.valueObject.api.WeatherLifeVO;
import seps.valueObject.api.WeatherMiddleVO;
import seps.valueObject.api.WeatherTemperatureVO;
import seps.valueObject.api.WeatherVO;

@Repository
public class ScheduleDAO extends EgovAbstractDAO {
	
	//기상정보 등록
	public void weatherInsert(WeatherVO paramVO) {
		insert("ScheduleDAO.weatherInsert", paramVO);
	}

	//조위정보 실측&예측 등록
	public void tideRealPrevInsert(TideVO paramVO){
		insert("ScheduleDAO.tideRealPrevInsert", paramVO);
	}
	
	//조위정보 극치예측 등록
	public void tideTphInsert(TideTphVO paramVO){
		insert("ScheduleDAO.tideTphInsert", paramVO);
	}

	//수위정보 등록
	public void waterLevelInsert(WaterLevelVO paramVO){
		insert("ScheduleDAO.waterLevelInsert", paramVO);
	}
	
	//팔당댐 방류랑 등록
	public void damInsert(DamVO paramVO){
		insert("ScheduleDAO.damInsert", paramVO);
	}

	//팔당댐 등록여부 확인
	public int damSelect(DamVO paramVO) {
		return (int) select("ScheduleDAO.damSelect", paramVO);
	}

	//수위 등록여부 확인
	public int waterLevelSelect(WaterLevelVO paramVO) {
		return (int) select("ScheduleDAO.waterLevelSelect", paramVO);
	}

	//수위알람 등록
	public String alarmInsert(AlarmVO paramVO) {
		return (String) insert("ScheduleDAO.alarmInsert", paramVO);
	}
	
	//알람상황판 업데이트
	public void alarmBoardUpdate(AlarmBoardVO paramVO){
		update("ScheduleDAO.alarmBoardUpdate", paramVO);
	}

	//동네예보 등록
	public void weatherSeriesInsert(WeatherVO paramVO) {
		insert("ScheduleDAO.weatherSeriesInsert", paramVO);
	}

	//동네예보 조회
	public int weatherSeriesSelect(WeatherVO paramVO) {
		return (int) select("ScheduleDAO.weatherSeriesSelect", paramVO);
	}
	
	//동네예보 업데이트
	public void weatherSeriesUpdate(WeatherVO paramVO) {
		update("ScheduleDAO.weatherSeriesUpdate", paramVO);
	}
	
	//초단기예보 등록
	public void weatherTimeInsert(WeatherVO paramVO) {
		insert("ScheduleDAO.weatherTimeInsert", paramVO);
	}
	
	//초단기예보 조회
	public int weatherTimeSelect(WeatherVO paramVO) {
		return (int) select("ScheduleDAO.weatherTimeSelect", paramVO);
		
	}
	//초단기예보 업데이트
	public void weatherTimeUpdate(WeatherVO paramVO) {
		update("ScheduleDAO.weatherTimeUpdate", paramVO);
	}
	
	// 특보코드조회 조회
	public int selectSpecialNewsCodeCnt(SpecialNewsCodeVO specialNewsCodeVO){
		return (int) select("ScheduleDAO.selectSpecialNewsCodeCnt", specialNewsCodeVO);
	}
	
	// 특보코드조회 등록
	public void specialNewsCodeInsert(SpecialNewsCodeVO specialNewsCodeVO){
		insert("ScheduleDAO.specialNewsCodeInsert", specialNewsCodeVO);
	}
	
	//미세먼지,초미세먼지 등록
	public void warningInsert(DustVO paramVO) {
		insert("ScheduleDAO.warningInsert", paramVO);
	}

	//미세먼지,초미세먼지 조회
	public int warningSelect(DustVO paramVO) {
		return (int) select("ScheduleDAO.warningSelect", paramVO);
	}
	
	//미세먼지,초미세먼지 업데이트
	public void warningUpdate(DustVO paramVO) {
		update("ScheduleDAO.warningUpdate", paramVO);
	}

	//생활&보건지수 등록
	public void weatherLifeInsert(WeatherLifeVO resultVO) {
		insert("ScheduleDAO.weatherLifeInsert", resultVO);
	}
	//생활&보건지수 조회
	public int weatherLifeSelect(WeatherLifeVO resultVO) {
		return (int) select("ScheduleDAO.weatherLifeSelect", resultVO);
	}

	//중기예보 조회
	public int weatherMiddleSelect(WeatherMiddleVO paramVO) {
		return (int) select("ScheduleDAO.weatherMiddleSelect", paramVO);
	}

	//중기예보 등록
	public void weatherMiddleInsert(WeatherMiddleVO paramVO) {
		insert("ScheduleDAO.weatherMiddleInsert", paramVO);
	}

	//중기기온 조회
	public int weatherTemperatureSelect(WeatherTemperatureVO paramVO) {
		return (int) select("ScheduleDAO.weatherTemperatureSelect", paramVO);
	}

	//중기기온 등록
	public void weatherTemperatureInsert(WeatherTemperatureVO paramVO) {
		insert("ScheduleDAO.weatherTemperatureInsert", paramVO);
	}
	
}
