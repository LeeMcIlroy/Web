package writer.usr.wcGuide.tips;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class WcGuideTipsDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectWcGuideTipsList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("WcGuideTipsDAO.selectWcGuideTipsListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("WcGuideTipsDAO.selectWcGuideTipsList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
}
