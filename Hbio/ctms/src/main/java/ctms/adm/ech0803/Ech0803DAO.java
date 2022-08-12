package ctms.adm.ech0803;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1050mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0803DAO  extends EgovAbstractDAO {

	/* 로그인접속관리 ****************************************************************************************************************************************************** */
	// 로그인접속 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0803List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0803DAO.selectEch0803ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0803DAO.selectEch0803List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 사용자관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0803Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0803DAO.selectEch0803Excel", searchVO);
	}
	
	/* 로그인접속관리 ****************************************************************************************************************************************************** */
	
}
