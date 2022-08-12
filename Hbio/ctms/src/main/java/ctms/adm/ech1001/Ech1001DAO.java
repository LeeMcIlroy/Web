package ctms.adm.ech1001;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech1001DAO  extends EgovAbstractDAO {

	/* 피험자관리 ****************************************************************************************************************************************************** */
	// 피험자관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch1001List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech1001DAO.selectEch1001ListCnt", searchVO);	
		List<EgovMap> resultList = (List<EgovMap>) list("Ech1001DAO.selectEch1001List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
			
	// 연구대상자 식별번호 일괄 부여(대상자 선별)
	@SuppressWarnings("unchecked")
	public List<Sb1000mVO> selectEch1001RsiCodeBat(EgovMap map) throws Exception {
		return (List<Sb1000mVO>) list("Ech1001DAO.selectEch1001RsiCodeBat", map);
	}
	
	// 연구대상자 식별번호 획득
	public String selectEch1001RsiCodeCnt(Sb1000mVO sb1000mVO) throws Exception {
		return (String) select("Ech1001DAO.selectEch1001RsiCodeCnt", sb1000mVO);
	}
	
	// update 연구대상자 식별번호 
	public void updateEch0102RsiCode(Rs2000mVO rs2000mVO) throws Exception {
		update("Ech0102DAO.updateEch0102RsiCode", rs2000mVO);
	}
	
	// 연구대상자 선정 등록
	public String insertEch1001Sub(Rs2000mVO rs2000mVO) throws Exception {		
		 return (String)insert("Ech1001DAO.insertEch1001Sub", rs2000mVO); 
	}
	
	public Rs1010mVO selectEch1001RsView(Rs1010mVO rs1010mVO) throws Exception {
		return (Rs1010mVO) select("Ech1001DAO.selectEch1001RsView", rs1010mVO);
	}
	
	/* 피험자관리 ****************************************************************************************************************************************************** */
	
}
