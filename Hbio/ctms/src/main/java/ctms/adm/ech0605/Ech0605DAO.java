package ctms.adm.ech0605;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rm1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0605DAO  extends EgovAbstractDAO {

	/* 이메일발송메시지(예문)관리 ****************************************************************************************************************************************************** */
	// 이메일발송메시지(예문)관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0605List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0605DAO.selectEch0605ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0605DAO.selectEch0605List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 이메일발송메시지(예문)관리 상세보기
	public Rm1010mVO selectEch0605View(Rm1010mVO rm1010mVO) {
		return (Rm1010mVO)select("Ech0605DAO.selectEch0605One", rm1010mVO); 
	}
		
	// 이메일발송메시지(예문)관리 삭제
	public void deleteEch0605(Rm1010mVO rm1010mVO) {
		delete("Ech0605DAO.deleteEch0605", rm1010mVO);
		
	}
	// 이메일발송메시지(예문)관리 등록
	public String insertEch0605(Rm1010mVO rm1010mVO) throws Exception {
		
		 return (String)insert("Ech0605DAO.insertEch0605", rm1010mVO); 
	}
	
	// 이메일발송메시지(예문)관리 수정 
	public void updateEch0605(Rm1010mVO rm1010mVO) throws Exception {
		update("Ech0605DAO.updateEch0605", rm1010mVO); 
	}
	
		
	// 이메일발송메시지(예문)관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0605Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0605DAO.selectEch0605Excel", searchVO);
	}
	
	
	/* 이메일발송메시지(예문)관리 ****************************************************************************************************************************************************** */
	
}
