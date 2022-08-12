package ctms.adm.ech0708;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Cm4010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0708DAO  extends EgovAbstractDAO {

	/* 공통코드관리 ****************************************************************************************************************************************************** */
	// 공통코드관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0708List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0708DAO.selectEch0708ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0708DAO.selectEch0708List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 공통코드관리 상세보기
	public Cm4010mVO selectEch0708One(String notiVal) {
		return (Cm4010mVO)select("Ech0708DAO.selectEch0708One", notiVal); 
	}
	
	
	// 공통코드관리 삭제
	public void deleteEch0708(Cm4010mVO cm4010mVO) {
		delete("Ech0708DAO.deleteEch0708", cm4010mVO);
		
	}
	// 공통코드관리 등록
	public String insertEch0708(Cm4010mVO cm4010mVO) throws Exception {
		
		 return (String)insert("Ech0708DAO.insertEch0708", cm4010mVO); 
	}
	
	// 공통코드관리 수정 
	public void updateEch0708(Cm4010mVO cm4010mVO) throws Exception {
		update("Ech0708DAO.updateEch0708", cm4010mVO); 
	}
	
		
	// 공통코드관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0708Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0708DAO.selectEch0708Excel", searchVO);
	}
	
	
	/* 공통코드관리 ****************************************************************************************************************************************************** */
	
}
