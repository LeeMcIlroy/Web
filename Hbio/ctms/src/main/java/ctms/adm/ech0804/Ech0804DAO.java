package ctms.adm.ech0804;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1050mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0804DAO  extends EgovAbstractDAO {

	/* 작업로그 ****************************************************************************************************************************************************** */
	// 작업로그 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0804List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0804DAO.selectEch0804ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0804DAO.selectEch0804List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 작업로그 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0804Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0804DAO.selectEch0804Excel", searchVO);
	}
	
	/* 작업로그 ****************************************************************************************************************************************************** */
	
}
