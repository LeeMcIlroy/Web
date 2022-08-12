package ctms.usr.ecf0501;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ecf0501DAO  extends EgovAbstractDAO {

	/* 피험자관리 ****************************************************************************************************************************************************** */

	// 피험자관리 상세보기
	public Sb1000mVO selectEcf0501View(Sb1000mVO sb1000mVO) {
		return (Sb1000mVO)select("Ecf0501DAO.selectEcf0501View", sb1000mVO); 
	}
		
	// 피험자관리 수정 
	public void updateEcf0501(Sb1000mVO sb1000mVO) throws Exception {
		update("Ecf0501DAO.updateEcf0501", sb1000mVO); 
	}
	
	// 연구대상자(피험자관리) 유형 상세보기
	public Sb1010mVO selectEcf0501ResearchCls(Sb1010mVO sb1010mVO) {
		return (Sb1010mVO)select("Ecf0501DAO.selectEcf0501ResearchCls", sb1010mVO); 
	}

	// 연구대상자(피험자관리) 유형 수정 
	public void updateEcf0501ResearchCls(Sb1010mVO sb1010mVO) throws Exception {
		update("Ecf0501DAO.updateEcf0501ResearchCls", sb1010mVO); 
	}
	
	// 사용자 프로필 조회
	public Sb1000mVO selectEcf0501Profile(EgovMap map) throws Exception {
		return (Sb1000mVO) select("Ecf0501DAO.selectEcf0501Profile", map);
	}
	
	
	// 연구대상자(회원) 비밀번호 변경
	public void ecf0501AjaxPasswordUpdate(Sb1000mVO sb1000mVO) throws Exception{
		update("Ecf0501DAO.ecf0501AjaxPasswordUpdate", sb1000mVO);
		
	}
	
	// 연구대상자(회원) 비밀번호 체크
	public int selectEcf0501AjaxUsrPwChk(Sb1000mVO sb1000mVO) throws Exception{
		return (int) select("Ecf0501DAO.selectEcf0501AjaxUsrPwChk", sb1000mVO);
	}
	
	/* 피험자관리 ****************************************************************************************************************************************************** */
	
}
