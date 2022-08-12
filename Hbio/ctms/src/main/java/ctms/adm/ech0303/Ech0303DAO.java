package ctms.adm.ech0303;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0303DAO  extends EgovAbstractDAO {

	/* 피험자관리 ****************************************************************************************************************************************************** */
	// 예약일정리스트
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0303List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0303DAO.selectEch0303ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0303DAO.selectEch0303List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 피험자예약일정팝업
	@SuppressWarnings("unchecked")	
	public List<EgovMap> selectEch0303View(String resrDt) {
		
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0303DAO.selectEch0303View",resrDt);
    	
    	return resultList;
	
	}
	
}
