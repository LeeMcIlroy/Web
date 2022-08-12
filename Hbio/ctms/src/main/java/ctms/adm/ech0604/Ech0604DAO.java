package ctms.adm.ech0604;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rm2010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0604DAO  extends EgovAbstractDAO {

	/* SMS발송메시지(예문)관리 ****************************************************************************************************************************************************** */
	// SMS발송메시지(예문)관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0604List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0604DAO.selectEch0604ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0604DAO.selectEch0604List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// SMS발송메시지(예문)관리 상세보기
	public Rm2010mVO selectEch0604View(Rm2010mVO rm2010mVO) {
		return (Rm2010mVO)select("Ech0604DAO.selectEch0604One", rm2010mVO); 
	}
		
	// SMS발송메시지(예문)관리 삭제
	public void deleteEch0604(Rm2010mVO rm2010mVO) {
		delete("Ech0604DAO.deleteEch0604", rm2010mVO);
		
	}
	// SMS발송메시지(예문)관리 등록
	public String insertEch0604(Rm2010mVO rm2010mVO) throws Exception {
		
		 return (String)insert("Ech0604DAO.insertEch0604", rm2010mVO); 
	}
	
	// SMS발송메시지(예문)관리 수정 
	public void updateEch0604(Rm2010mVO rm2010mVO) throws Exception {
		update("Ech0604DAO.updateEch0604", rm2010mVO); 
	}
	
		
	// SMS발송메시지(예문)관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0604Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0604DAO.selectEch0604Excel", searchVO);
	}
	
	
	/* SMS발송메시지(예문)관리 ****************************************************************************************************************************************************** */
	
}
