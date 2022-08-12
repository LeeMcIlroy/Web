package ctms.adm.ech0205;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Cr3200mVO;
import ctms.valueObject.Cr3210mVO;
import ctms.valueObject.Cr3240mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0205DAO  extends EgovAbstractDAO {

	/* 제품사용관리 ****************************************************************************************************************************************************** */
	// 제품사용관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0205List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0205DAO.selectEch0205ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0205DAO.selectEch0205List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
		
	}
	
	// 연구과제 상세보기
	public Rs1000mVO selectEch0205RsView(Rs1000mVO rs1000mVO) {
		return (Rs1000mVO)select("Ech0205DAO.selectEch0205RsView", rs1000mVO); 
	}
	
	// 제품사용관리 상세보기
	public Cr3200mVO selectEch0205View(Cr3200mVO cr3200mVO) {
		return (Cr3200mVO)select("Ech0205DAO.selectEch0205View", cr3200mVO); 
	}
	
	
	// 제품사용관리 삭제
	public void deleteEch0205(Cr3200mVO cr3200mVO) {
		delete("Ech0205DAO.deleteEch0205", cr3200mVO);
		
	}
	// 제품사용관리 등록
	public String insertEch0205(Cr3200mVO cr3200mVO) throws Exception {		
		 return (String)insert("Ech0205DAO.insertEch0205", cr3200mVO); 
	}
	
	// 제품사용관리 수정 
	public void updateEch0205(Cr3200mVO cr3200mVO) throws Exception {
		update("Ech0205DAO.updateEch0205", cr3200mVO); 
	}
	
	// 제품사용관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0205Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0205DAO.selectEch0205Excel", searchVO);
	}
	
	// 연구대상자 제품사용목록 
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0205ChkList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0205DAO.selectEch0205ChkListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0205DAO.selectEch0205ChkList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 연구대상자 제품사용 체크시작, 종료일자 일괄 수정
	public void updateEch0205AjaxSaveStep(EgovMap map) throws Exception {
		update("Ech0205DAO.updateEch0205AjaxSaveStep", map);
	}
	
	// 연구대상자 제품사용 초기 일괄 등록
	public void insertEch0205ItemUse(EgovMap map) throws Exception {
		update("Ech0205DAO.insertEch0205ItemUse", map);
	}

	// 연구대상별 제품사용결과 팝업  
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0205RsjUseList(EgovMap map) throws Exception{
		return (List<EgovMap>) list("Ech0205DAO.selectEch0205RsjUseList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0205Rsj(EgovMap map) throws Exception{
		return (List<EgovMap>) list("Ech0205DAO.selectEch0205Rsj", map);
	}
	
	// 연구대상자정보 및 제품사용환경
	@SuppressWarnings("unchecked")
	public Cr3210mVO selectEch0205Rsj(Cr3210mVO cr3210mVO) {
		return (Cr3210mVO)select("Ech0205DAO.selectEch0205Rsj", cr3210mVO); 
	}
	
	// 실사용체크 cnt
	public int selectEch0205ChkCnt(Cr3200mVO cr3200mVO) throws Exception {
		int totalRecordCount  = (int) select("Ech0205DAO.selectEch0205ChkCnt", cr3200mVO);
		return totalRecordCount;
	}
	
	// 실사용체크 cnt
	public int selectEch0205Cnt(Cr3200mVO cr3200mVO) throws Exception {
		int totalRecordCount  = (int) select("Ech0205DAO.selectEch0205Cnt", cr3200mVO);
		return totalRecordCount;
	}
	
	// 개인사용일정 삭제
	public void deleteEch0205Chk(Cr3200mVO cr3200mVO) {
		delete("Ech0205DAO.deleteEch0205Chk", cr3200mVO);
		
	}
	
	//팝업사용
	public EgovMap selectEch0205Map(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("Ech0205DAO.selectEch0205Map", searchVO);
	}
	
	//팝업사용2
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0205PopList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0205DAO.selectEch0205PopList", searchVO);
	}
	
	//사용일정 일괄 삭제 
	public int deleteEch0205AjaxChkDtDel(EgovMap map) throws Exception {
		return delete("Ech0205DAO.deleteEch0205AjaxChkDtDel", map);
	}
	
	// 사용일자 여부 cnt
	public int selectEch0205ChkDtCnt(Cr3240mVO cr3240mVO) throws Exception {
		int totalRecordCount  = (int) select("Ech0205DAO.selectEch0205ChkDtCnt", cr3240mVO);
		return totalRecordCount;
	}
	
	// 제품사용관리 등록
	public String insertEch0205ChkDt(Cr3240mVO cr3240mVO) throws Exception {		
		 return (String)insert("Ech0205DAO.insertEch0205ChkDt", cr3240mVO); 
	}
	
	// 연구대상자 실사용횟수 갱신 CR3240M -> CR3210M
	public void updateEch0205ChkCnt(Cr3210mVO cr3210mVO) throws Exception {
		update("Ech0205DAO.updateEch0205ChkCnt", cr3210mVO);
	}
	
	// 연구대상자 제품사용내역 상세보기
	public Cr3240mVO selectEch0205ChkmgView(Cr3240mVO cr3240mVO) {
		return (Cr3240mVO)select("Ech0205DAO.selectEch0205ChkmgView", cr3240mVO); 
	}
	
	// 연구대상자 사용내역 수정
	public void updateEch0205AjaxSaveChkmg(EgovMap map) throws Exception {
		update("Ech0205DAO.updateEch0205AjaxSaveChkmg", map);
	}
	
	// 연구대상자 품사용내역 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0205RsjUseExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0205DAO.selectEch0205RsjUseExcel", searchVO);
	}
	
	// 제품사용관리 등록
	public String insertEch0205AjaxSaveStep(EgovMap map) throws Exception {		
		 return (String)insert("Ech0205DAO.insertEch0205AjaxSaveStep", map); 
	}

	// 연구대상자 사용정보 등록 여부  cnt
	public int selectEch0205AjaxSaveStepCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ech0205DAO.selectEch0205AjaxSaveStepCnt", map);
		return totalRecordCount;
	}

	// 연구대상자 제품회수 일괄등록
	public void updateEch0205AjaxSaveStep3(EgovMap map) throws Exception {
		update("Ech0205DAO.updateEch0205AjaxSaveStep3", map);
	}
	
	// 연구대상자 제품사용정보 상세보기 
	public Cr3210mVO selectEch0205RsjUseView(Cr3210mVO cr3210mVO) {
		return (Cr3210mVO)select("Ech0205DAO.selectEch0205RsjUseView", cr3210mVO); 
	}

	// 연구대상자 제품사용관리 수정(아이템회수, 중지여부, 특이사항) 
	public void updateEch0205Rsjuse(Cr3210mVO cr3210mVO) throws Exception {
		update("Ech0205DAO.updateEch0205RsjUse", cr3210mVO); 
	}
	
	
	/* 제품사용관리 ****************************************************************************************************************************************************** */
	
}
