package ctms.adm.ech0801;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1040mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0801DAO  extends EgovAbstractDAO {

	/* 로그인접속관리 ****************************************************************************************************************************************************** */
	// 로그인접속 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0801List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0801DAO.selectEch0801ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0801DAO.selectEch0801List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 사용자관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0801Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0801DAO.selectEch0801Excel", searchVO);
	}
	
	/* 로그인접속관리 ****************************************************************************************************************************************************** */
	
}
