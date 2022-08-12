package ctms.adm.ech0701;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0701DAO  extends EgovAbstractDAO {

	
	/* CTMS운영사관리 ****************************************************************************************************************************************************** */
	// CTMS운영사관리 상세보기
	public Ct1000mVO selectEch0701View(Ct1000mVO ct1000mVO) {
		return (Ct1000mVO)select("Ech0701DAO.selectEch0701View", ct1000mVO); 
	}
		
	// CTMS운영사관리 삭제
	public void deleteEch0701(Ct1000mVO ct1000mVO) {
		delete("Ech0701DAO.deleteEch0701", ct1000mVO);
	}

	// CTMS운영사관리 등록
	public String insertEch0701(Ct1000mVO ct1000mVO) throws Exception {
		 return (String)insert("Ech0701DAO.insertEch0701", ct1000mVO); 
	}
	
	// CTMS운영사관리 수정 
	public void updateEch0701(Ct1000mVO ct1000mVO) throws Exception {
		update("Ech0701DAO.updateEch0701", ct1000mVO); 
	}
	
	// CTMS운영사관리 일련번호
	public String selectEch0701Max(Ct1000mVO ct1000mVO) throws Exception {
		return (String) select("Ech0701DAO.selectEch0701Max", ct1000mVO);
	}
	
	/* CTMS운영사관리 ****************************************************************************************************************************************************** */

}
