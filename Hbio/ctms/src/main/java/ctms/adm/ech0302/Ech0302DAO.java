package ctms.adm.ech0302;

import java.util.List;

import org.springframework.stereotype.Repository;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0302DAO  extends EgovAbstractDAO {

	/* 피험자관리 ****************************************************************************************************************************************************** */
	// 피험자관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0302List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0302DAO.selectEch0302ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0302DAO.selectEch0302List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}

		
	// 연구과제 상세보기
	@SuppressWarnings("unchecked")	
	public List<EgovMap> selectEch0302View(String rsStdt) {
		
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0302DAO.selectEch0302View",rsStdt);
    	
    	return resultList;
	
	}
		
}
