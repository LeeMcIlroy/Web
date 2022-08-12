package ctms.adm.ech0212;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs2010mVO;
import ctms.valueObject.Cr3200mVO;
import ctms.valueObject.Cr3210mVO;
import ctms.valueObject.Cr3240mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0212DAO  extends EgovAbstractDAO {

	/* CRF작성관리 ****************************************************************************************************************************************************** */
	// CRF작성관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0212List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0212DAO.selectEch0212ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0212DAO.selectEch0212List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
		
	}
	
	// 연구과제 상세보기
	public Rs1010mVO selectEch0212RsPlanView(Rs1010mVO rs1010mVO) {
		return (Rs1010mVO)select("Ech0212DAO.selectEch0212RsPlanView", rs1010mVO); 
	}
	
	// CRF작성관리 상세보기
	public Cr3200mVO selectEch0212View(Cr3200mVO cr3200mVO) {
		return (Cr3200mVO)select("Ech0212DAO.selectEch0212View", cr3200mVO); 
	}
	
	
	// CRF작성관리 삭제
	public void deleteEch0212(Cr3200mVO cr3200mVO) {
		delete("Ech0212DAO.deleteEch0212", cr3200mVO);
		
	}
	// CRF작성관리 등록
	public String insertEch0212(Cr3200mVO cr3200mVO) throws Exception {		
		 return (String)insert("Ech0212DAO.insertEch0212", cr3200mVO); 
	}
	
	// CRF작성관리 수정 
	public void updateEch0212(Cr3200mVO cr3200mVO) throws Exception {
		update("Ech0212DAO.updateEch0212", cr3200mVO); 
	}
	
	// CRF작성관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0212Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0212DAO.selectEch0212Excel", searchVO);
	}
	
	// 연구대상자 제품사용목록 
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0212ChkList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0212DAO.selectEch0212ChkListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0212DAO.selectEch0212ChkList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 연구대상자 제품사용 체크시작, 종료일자 일괄 수정
	public void updateEch0212AjaxSaveStep(EgovMap map) throws Exception {
		update("Ech0212DAO.updateEch0212AjaxSaveStep", map);
	}
	
	// 연구대상자 제품사용 초기 일괄 등록
	public void insertEch0212ItemUse(EgovMap map) throws Exception {
		update("Ech0212DAO.insertEch0212ItemUse", map);
	}

	// 연구대상별 작성 목록 
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0212RsjMkList(EgovMap map) throws Exception{
		return (List<EgovMap>) list("Ech0212DAO.selectEch0212RsjMkList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0212Rsj(EgovMap map) throws Exception{
		return (List<EgovMap>) list("Ech0212DAO.selectEch0212Rsj", map);
	}
	
	// 연구대상자정보 및 제품사용환경
	@SuppressWarnings("unchecked")
	public Rs2010mVO selectEch0212Rsj(Rs2010mVO rs2010mVO) {
		return (Rs2010mVO)select("Ech0212DAO.selectEch0212Rsj", rs2010mVO); 
	}
	
	// 실사용체크 cnt
	public int selectEch0212ChkCnt(Cr3200mVO cr3200mVO) throws Exception {
		int totalRecordCount  = (int) select("Ech0212DAO.selectEch0212ChkCnt", cr3200mVO);
		return totalRecordCount;
	}
	
	// 실사용체크 cnt
	public int selectEch0212Cnt(Cr3200mVO cr3200mVO) throws Exception {
		int totalRecordCount  = (int) select("Ech0212DAO.selectEch0212Cnt", cr3200mVO);
		return totalRecordCount;
	}
	
	// 개인사용일정 삭제
	public void deleteEch0212Chk(Cr3200mVO cr3200mVO) {
		delete("Ech0212DAO.deleteEch0212Chk", cr3200mVO);
		
	}
	
	//팝업사용
	public EgovMap selectEch0212Map(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("Ech0212DAO.selectEch0212Map", searchVO);
	}
	
	//팝업사용2
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0212PopList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0212DAO.selectEch0212PopList", searchVO);
	}
	
	//사용일정 일괄 삭제 
	public int deleteEch0212AjaxChkDtDel(EgovMap map) throws Exception {
		return delete("Ech0212DAO.deleteEch0212AjaxChkDtDel", map);
	}
	
	// 사용일자 여부 cnt
	public int selectEch0212ChkDtCnt(Cr3240mVO cr3240mVO) throws Exception {
		int totalRecordCount  = (int) select("Ech0212DAO.selectEch0212ChkDtCnt", cr3240mVO);
		return totalRecordCount;
	}
	
	// CRF작성관리 등록
	public String insertEch0212ChkDt(Cr3240mVO cr3240mVO) throws Exception {		
		 return (String)insert("Ech0212DAO.insertEch0212ChkDt", cr3240mVO); 
	}
	
	// 연구대상자 실사용횟수 갱신 CR3240M -> CR3210M
	public void updateEch0212ChkCnt(Cr3210mVO cr3210mVO) throws Exception {
		update("Ech0212DAO.updateEch0212ChkCnt", cr3210mVO);
	}
	
	// 연구대상자 제품사용내역 상세보기
	public Cr3240mVO selectEch0212ChkmgView(Cr3240mVO cr3240mVO) {
		return (Cr3240mVO)select("Ech0212DAO.selectEch0212ChkmgView", cr3240mVO); 
	}
	
	// 연구대상자 사용내역 수정
	public void updateEch0212AjaxSaveChkmg(EgovMap map) throws Exception {
		update("Ech0212DAO.updateEch0212AjaxSaveChkmg", map);
	}
	
	// 연구대상자 품사용내역 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0212RsjUseExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0212DAO.selectEch0212RsjUseExcel", searchVO);
	}
	
	// CRF작성관리 등록
	public String insertEch0212AjaxSaveStep(EgovMap map) throws Exception {		
		 return (String)insert("Ech0212DAO.insertEch0212AjaxSaveStep", map); 
	}

	// 연구대상자 사용정보 등록 여부  cnt
	public int selectEch0212AjaxSaveStepCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ech0212DAO.selectEch0212AjaxSaveStepCnt", map);
		return totalRecordCount;
	}

	// 연구대상자 제품회수 일괄등록
	public void updateEch0212AjaxSaveStep3(EgovMap map) throws Exception {
		update("Ech0212DAO.updateEch0212AjaxSaveStep3", map);
	}
	
	// 연구대상자 제품사용정보 상세보기 
	public Cr3210mVO selectEch0212RsjUseView(Cr3210mVO cr3210mVO) {
		return (Cr3210mVO)select("Ech0212DAO.selectEch0212RsjUseView", cr3210mVO); 
	}

	// 연구대상자 CRF작성관리 수정(아이템회수, 중지여부, 특이사항) 
	public void updateEch0212Rsjuse(Cr3210mVO cr3210mVO) throws Exception {
		update("Ech0212DAO.updateEch0212RsjUse", cr3210mVO); 
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0212eCrfList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0212.selectEch0212eCrfList", paramMap);
	}
	
	// CRF파일 일괄다운로드 대상 선별
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0212ListCrfFile(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0212DAO.selectEch0212ListCrfFile", searchVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0212SendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0212DAO.selectEch0212SendList", map);
	
	}
	
	// CRF작성관리 삭제
	public void deleteEch0212AjaxCrfDel(EgovMap map) {
		delete("Ech0212DAO.deleteEch0212AjaxCrfDel", map);
		
	}
	
	
	
	/* CRF작성관리 ****************************************************************************************************************************************************** */
	
}
