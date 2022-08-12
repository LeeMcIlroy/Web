package ctms.adm.ech0603;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rm2000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0603DAO  extends EgovAbstractDAO {

	/* SMS발송내역관리 ****************************************************************************************************************************************************** */
	// SMS발송내역관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0603List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0603DAO.selectEch0603ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0603DAO.selectEch0603List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// SMS발송내역관리 상세보기
	public Rm2000mVO selectEch0603View(Rm2000mVO rm2000mVO) {
		return (Rm2000mVO)select("Ech0603DAO.selectEch0603View", rm2000mVO); 
	}
	
	
	// SMS발송내역관리 삭제
	public void deleteEch0603(Rm2000mVO rm2000mVO) {
		delete("Ech0603DAO.deleteEch0603", rm2000mVO);
		
	}
	// SMS발송내역관리 등록
	public String insertEch0603(Rm2000mVO rm2000mVO) throws Exception {
		
		 return (String)insert("Ech0603DAO.insertEch0603", rm2000mVO); 
	}
	
	// SMS발송내역관리 수정 
	public void updateEch0603(Rm2000mVO rm2000mVO) throws Exception {
		update("Ech0603DAO.updateEch0603", rm2000mVO); 
	}
	
		
	// SMS발송내역관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0603Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0603DAO.selectEch0603Excel", searchVO);
	}
	
	
	/* SMS발송내역관리 ****************************************************************************************************************************************************** */
	
}
