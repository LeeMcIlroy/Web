package ctms.adm.ech0602;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rm1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0602DAO  extends EgovAbstractDAO {

	/* 이메일발송관리 ****************************************************************************************************************************************************** */
	// 이메일발송관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0602List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0602DAO.selectEch0602ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0602DAO.selectEch0602List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 이메일발송관리 상세보기
	public Rm1000mVO selectEch0602View(Rm1000mVO rm1000mVO) {
		return (Rm1000mVO)select("Ech0602DAO.selectEch0602View", rm1000mVO); 
	}
	
	
	// 이메일발송관리 삭제
	public void deleteEch0602(Rm1000mVO rm1000mVO) {
		delete("Ech0602DAO.deleteEch0602", rm1000mVO);
		
	}
	// 이메일발송관리 등록
	public String insertEch0602(Rm1000mVO rm1000mVO) throws Exception {		
		 return (String)insert("Ech0602DAO.insertEch0602", rm1000mVO); 
	}
	
	// 이메일발송관리 수정 
	public void updateEch0602(Rm1000mVO rm1000mVO) throws Exception {
		update("Ech0602DAO.updateEch0602", rm1000mVO); 
	}
			
	// 이메일발송관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0602Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0602DAO.selectEch0602Excel", searchVO);
	}	
	
	//이메일재발송 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch06020ResendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0602DAO.selectEch0602ResendlList", map);
	}
	
	/* 이메일발송관리 ****************************************************************************************************************************************************** */
	
}
