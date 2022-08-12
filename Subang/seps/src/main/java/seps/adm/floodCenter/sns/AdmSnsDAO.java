package seps.adm.floodCenter.sns;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;

@Repository
public class AdmSnsDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectSnsList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmSnsDAO.selectSnsListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmSnsDAO.selectSnsList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
}
