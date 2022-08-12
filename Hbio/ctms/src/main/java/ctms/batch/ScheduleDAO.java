package ctms.batch;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class ScheduleDAO  extends EgovAbstractDAO {

	/* Batch ****************************************************************************************************************************************************** */
	
	//예약메일 조회
	@SuppressWarnings("unchecked")
	public CmmnListVO selectBatchMailList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("ScheduleDAO.selectBatchMailListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("ScheduleDAO.selectBatchMailList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//전송결과 갱신 900 전송대기 -> 100 전송완료
	public void updateBatchMailTsenCls(EgovMap map) throws Exception {
		update("ScheduleDAO.updateBatchMailTsenCls", map);
	}
	
	/* Batch ****************************************************************************************************************************************************** */
	
}
