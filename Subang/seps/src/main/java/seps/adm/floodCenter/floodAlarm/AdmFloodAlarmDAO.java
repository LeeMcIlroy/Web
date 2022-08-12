package seps.adm.floodCenter.floodAlarm;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;

@Repository
public class AdmFloodAlarmDAO extends EgovAbstractDAO {

	// 기간별알람현황 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectFloodAlarmList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmFloodAlarmDAO.selectFloodAlarmListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmFloodAlarmDAO.selectFloodAlarmList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//수방근무현황삭제 처리
	public void deleteAlarm(CmmnSearchVO searchVO) {
		delete("AdmFloodAlarmDAO.deleteAlarm", searchVO);
	}
	
	//수방단계삭제 처리
	public void deleteAlarm2(String searchCode) {
		delete("AdmFloodAlarmDAO.deleteAlarm2", searchCode);
	}
	
}
