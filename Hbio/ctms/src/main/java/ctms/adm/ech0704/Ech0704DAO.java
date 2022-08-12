package ctms.adm.ech0704;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1020mVO;
import ctms.valueObject.Ct2000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0704DAO  extends EgovAbstractDAO {

	/* 고객사관리 ****************************************************************************************************************************************************** */
	// 고객사관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0704List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0704DAO.selectEch0704ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0704DAO.selectEch0704List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 고객사관리 상세보기
	public Ct2000mVO selectEch0704View(Ct2000mVO ct2000mVO) {
		return (Ct2000mVO)select("Ech0704DAO.selectEch0704View", ct2000mVO); 
	}
	
	// 고객사관리 삭제
	public void deleteEch0704(Ct2000mVO ct2000mVO) {
		delete("Ech0704DAO.deleteEch0704", ct2000mVO);
		
	}
	// 고객사관리 등록
	public String insertEch0704(Ct2000mVO ct2000mVO) throws Exception {
		
		 return (String)insert("Ech0704DAO.insertEch0704", ct2000mVO); 
	}
	
	// 고객사관리 수정 
	public void updateEch0704(Ct2000mVO ct2000mVO) throws Exception {
		update("Ech0704DAO.updateEch0704", ct2000mVO); 
	}
	
	// 고객사관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0704Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0704DAO.selectEch0704Excel", searchVO);
	}
	
	// 공통코드 목록
	@SuppressWarnings("unchecked")	
	public List<EgovMap> selectCmmCdList(String corpCd, String cdCls) throws Exception {
		EgovMap dataMap = new EgovMap();
		dataMap.put("corpCd", corpCd);
		dataMap.put("cdCls", cdCls);
		return (List<EgovMap>) list("Ech0704DAO.selectCmmCdList", dataMap);
	}	
		
	// 고객사삭제 제한 체크 - 연구과제에 사용된 경우 삭제 불가
	@SuppressWarnings("unchecked")	
	public String selectVendYn(String corpCd, String vendNo) throws Exception {
		EgovMap dataMap = new EgovMap();
		dataMap.put("corpCd", corpCd);
		dataMap.put("vendNo", vendNo);
		return (String) select("Ech0704DAO.selectVendYn", dataMap);
	}
	
	
	/* 고객사관리 ****************************************************************************************************************************************************** */
	
}
