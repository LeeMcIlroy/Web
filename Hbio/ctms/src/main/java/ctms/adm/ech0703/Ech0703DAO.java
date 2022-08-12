package ctms.adm.ech0703;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1020mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0703DAO  extends EgovAbstractDAO {

	/* 지사관리 ****************************************************************************************************************************************************** */
	// 지사관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0703List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0703DAO.selectEch0703ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0703DAO.selectEch0703List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 지사관리 상세보기
	public Ct1020mVO selectEch0703View(Ct1020mVO ct1020mVO) {
		return (Ct1020mVO)select("Ech0703DAO.selectEch0703View", ct1020mVO); 
	}
		
	// 지사관리 삭제
	public void deleteEch0703(Ct1020mVO ct1020mVO) {
		delete("Ech0703DAO.deleteEch0703", ct1020mVO);
		
	}
	// 지사관리 등록
	public String insertEch0703(Ct1020mVO ct1020mVO) throws Exception {
		
		 return (String)insert("Ech0703DAO.insertEch0703", ct1020mVO); 
	}
	
	// 지사관리 수정 
	public void updateEch0703(Ct1020mVO ct1020mVO) throws Exception {
		update("Ech0703DAO.updateEch0703", ct1020mVO); 
	}
			
	// 지사관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0703Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0703DAO.selectEch0703Excel", searchVO);
	}	
		
	// 지사삭제 제한 체크 - 연구과제, 구성원에 사용된 경우 삭제 불가
	@SuppressWarnings("unchecked")	
	public String selectBranchYn(String corpCd, String branchCd) throws Exception {
		EgovMap dataMap = new EgovMap();
		dataMap.put("corpCd", corpCd);
		dataMap.put("branchCd", branchCd);
		return (String) select("Ech0703DAO.selectBranchYn", dataMap);
	}
	
	/* 지사관리 ****************************************************************************************************************************************************** */
	
}
