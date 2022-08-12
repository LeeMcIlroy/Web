package ctms.adm.ech0905;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct3000mVO;
import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0905DAO  extends EgovAbstractDAO {
	
	// 자산관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0905List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0905DAO.selectEch0905ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0905DAO.selectEch0905List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 자산관리 상세보기
	public Ct3000mVO selectEch0905View(Ct3000mVO ct3000mVO) throws Exception {
		return (Ct3000mVO) select("Ech0905DAO.selectEch0905View", ct3000mVO);
	}
	
	// 자산관리 등록
	public String insertEch0905(Ct3000mVO ct3000mVO) throws Exception {
		return (String) insert("Ech0905DAO.insertEch0905", ct3000mVO);
	}

	// 자산관리 수정
	public void updateEch0905(Ct3000mVO ct3000mVO) throws Exception {
		update("Ech0905DAO.updateEch0905", ct3000mVO);
	}

	// 자산관리 삭제
	public void deleteEch0905(Ct3000mVO ct3000mVO) {
		delete("Ech0905DAO.deleteEch0905", ct3000mVO);
	}
	
	// 자산관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0905Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0905DAO.selectEch0905Excel", searchVO);
	}
	
	// 자산 정보 일괄 삭제
	public int deleteEch0905AjaxAstDel(EgovMap map) throws Exception {
		return delete("Ech0905DAO.deleteEch0905AjaxAstDel", map);
	}
	
	//자산정보 일괄등록 - 중복 목록 산출
	public List<EgovMap> selectEch0905DupAstList(EgovMap map) {
		return (List<EgovMap>) list("Ech0905DAO.selectEch0905DupAstList", map);
	}

	// 작업자 확인
	public Ct1030mVO selectEch0905EmpCheck(EgovMap map) throws Exception {
		return (Ct1030mVO) select("Ech0905DAO.selectEch0905EmpCheck", map);
	}
	
	// 자산정보 일괄폐기
	public void updateEch0905AjaxSaveDisDt(EgovMap map) throws Exception {
		update("Ech0905DAO.updateEch0905AjaxSaveDisDt", map);
	}
	
	// 삭제대상 확인 - 자산 정보 일괄 삭제
	public int selectEch0905AjaxAstDel(EgovMap map) throws Exception {
		return (int) select("Ech0905DAO.selectEch0905AjaxAstDel", map);
	}
	
}
