package hsDesign.usr.info.brodata;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class BroDataDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectBroDataList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("BroDataDAO.selectBroDataListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("BroDataDAO.selectBroDataList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
}
