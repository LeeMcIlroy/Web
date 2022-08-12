package ctms.adm.ech0502;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs5010mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0502DAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0502List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("AdmEch0502DAO.selectAdmEch0502ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0502DAO.selectAdmEch0502List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//보고서이력 상세보기
	public Rs5010mVO selectEch0502selectOne(int rptNo){
		
		return (Rs5010mVO)select("AdmEch0502DAO.selectEch0502ViewOne", rptNo); 
	}

	// 보고서이력 등록
	public int insertEch0502(Rs5010mVO rs5010mVO) throws Exception {
		
		 return (int)insert("AdmEch0502DAO.insertAdmEch0502", rs5010mVO); 
	}
	// 보고서이력 수정 
	public void updateEch0502(Rs5010mVO rs5010mVO) throws Exception {
		update("AdmEch0502DAO.updateAdmEch0502", rs5010mVO); 
	}
	// 보고서이력 삭제
	public int deleteEch0502(int rptNo) throws Exception {
		return(int) delete("AdmEch0502DAO.deleteAdmEch0502", rptNo); 
	}
	//엑셀파일
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmEch0502Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmEch0502DAO.selectAdmEch0502Excel", searchVO);
	}

}
