package ctms.adm.ech0402;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1020mVO;
import ctms.valueObject.Rs1030mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0402DAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0402List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0402DAO.selectEch0402ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0402DAO.selectEch0402List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0402Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0402DAO.selectEch0402Excel", searchVO);
	}
	
	
}
