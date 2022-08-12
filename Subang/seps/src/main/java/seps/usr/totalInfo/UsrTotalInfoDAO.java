package seps.usr.totalInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import valueObject.CmmnSearchVO;

@Repository
public class UsrTotalInfoDAO extends EgovAbstractDAO {
	
	// 시간대별 기상현황 목록 가져오기
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWeatherStatusList(CmmnSearchVO searchVO){
		return (List<EgovMap>) list("UsrTotalInfoDAO.selectWeatherStatusList", searchVO);
	}
	
	// 단계조회
	public EgovMap selectFloodLevel(String stdHourDate, String preHourDate){
		Map<String, String> map = new HashMap<>();
		map.put("stdHourDate", stdHourDate);
		map.put("preHourDate", preHourDate);
		return (EgovMap) select("UsrTotalInfoDAO.selectFloodLevel", map);
	}
	
	// 강수량 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWeatherRainList(CmmnSearchVO searchVO){
		return (List<EgovMap>) list("UsrTotalInfoDAO.selectWeatherRainList", searchVO);
	}
	
	// 수위 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWaterLevelOrDamList(CmmnSearchVO searchVO){
		return (List<EgovMap>) list("UsrTotalInfoDAO.selectWaterLevelOrDamList", searchVO);
	}

	// 극치 조위 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectTideTphList(CmmnSearchVO searchVO){
		return (List<EgovMap>) list("UsrTotalInfoDAO.selectTideTphList", searchVO);
	}
	
	// 조위 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectTideList(CmmnSearchVO searchVO){
		return (List<EgovMap>) list("UsrTotalInfoDAO.selectTideList", searchVO);
	}
	
	//기상정보 조회
	public EgovMap selectWeather(CmmnSearchVO searchVO){
		return (EgovMap) select("UsrTotalInfoDAO.selectWeather", searchVO);
	}
	
	//기상예보 조회
	public EgovMap selectWeatherTime(CmmnSearchVO searchVO) {
		return (EgovMap) select("UsrTotalInfoDAO.selectWeatherTime", searchVO);
	}
	
	//기상예보 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectWeatherTimeList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("UsrTotalInfoDAO.selectWeatherTimeList", searchVO);
	}
	
	//기상예보 목록 6시간전 강수량
	public EgovMap selectWeatherFristTime(CmmnSearchVO searchVO) {
		return (EgovMap) select("UsrTotalInfoDAO.selectWeatherFristTime", searchVO);
	}
	
}
