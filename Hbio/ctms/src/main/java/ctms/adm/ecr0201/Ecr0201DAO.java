package ctms.adm.ecr0201;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Rs2010mVO;
import ctms.valueObject.Cr3200mVO;
import ctms.valueObject.Cr3210mVO;
import ctms.valueObject.Cr3240mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ecr0201DAO  extends EgovAbstractDAO {

	/* CRF작성관리 ****************************************************************************************************************************************************** */
	// CRF작성관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEcr0201List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ecr0201DAO.selectEcr0201ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ecr0201DAO.selectEcr0201List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
		
	}
	
	// 연구과제 상세보기
	public Rs1010mVO selectEcr0201RsPlanView(Rs1010mVO rs1010mVO) {
		return (Rs1010mVO)select("Ecr0201DAO.selectEcr0201RsPlanView", rs1010mVO); 
	}
	
	// CRF작성관리 상세보기
	public Cr3200mVO selectEcr0201View(Cr3200mVO cr3200mVO) {
		return (Cr3200mVO)select("Ecr0201DAO.selectEcr0201View", cr3200mVO); 
	}
	
	
	// CRF작성관리 삭제
	public void deleteEcr0201(Cr3200mVO cr3200mVO) {
		delete("Ecr0201DAO.deleteEcr0201", cr3200mVO);
		
	}
	// CRF작성관리 등록
	public String insertEcr0201(Cr3200mVO cr3200mVO) throws Exception {		
		 return (String)insert("Ecr0201DAO.insertEcr0201", cr3200mVO); 
	}
	
	// CRF작성관리 수정 
	public void updateEcr0201(Cr3200mVO cr3200mVO) throws Exception {
		update("Ecr0201DAO.updateEcr0201", cr3200mVO); 
	}
	
	// CRF작성관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0201Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecr0201DAO.selectEcr0201Excel", searchVO);
	}
	
	// 연구대상자 제품사용목록 
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEcr0201ChkList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ecr0201DAO.selectEcr0201ChkListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ecr0201DAO.selectEcr0201ChkList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 연구대상자 제품사용 체크시작, 종료일자 일괄 수정
	public void updateEcr0201AjaxSaveStep(EgovMap map) throws Exception {
		update("Ecr0201DAO.updateEcr0201AjaxSaveStep", map);
	}
	
	// 연구대상자 제품사용 초기 일괄 등록
	public void insertEcr0201ItemUse(EgovMap map) throws Exception {
		update("Ecr0201DAO.insertEcr0201ItemUse", map);
	}

	// 연구대상별 작성 목록 
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0201RsjMkList(EgovMap map) throws Exception{
		return (List<EgovMap>) list("Ecr0201DAO.selectEcr0201RsjMkList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0201Rsj(EgovMap map) throws Exception{
		return (List<EgovMap>) list("Ecr0201DAO.selectEcr0201Rsj", map);
	}
	
	// 연구대상자정보 및 제품사용환경
	@SuppressWarnings("unchecked")
	public Rs2010mVO selectEcr0201Rsj(Rs2010mVO rs2010mVO) {
		return (Rs2010mVO)select("Ecr0201DAO.selectEcr0201Rsj", rs2010mVO); 
	}
	
	// 실사용체크 cnt
	public int selectEcr0201ChkCnt(Cr3200mVO cr3200mVO) throws Exception {
		int totalRecordCount  = (int) select("Ecr0201DAO.selectEcr0201ChkCnt", cr3200mVO);
		return totalRecordCount;
	}
	
	// 실사용체크 cnt
	public int selectEcr0201Cnt(Cr3200mVO cr3200mVO) throws Exception {
		int totalRecordCount  = (int) select("Ecr0201DAO.selectEcr0201Cnt", cr3200mVO);
		return totalRecordCount;
	}
	
	// 개인사용일정 삭제
	public void deleteEcr0201Chk(Cr3200mVO cr3200mVO) {
		delete("Ecr0201DAO.deleteEcr0201Chk", cr3200mVO);
		
	}
	
	//팝업사용
	public EgovMap selectEcr0201Map(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("Ecr0201DAO.selectEcr0201Map", searchVO);
	}
	
	//팝업사용2
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0201PopList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecr0201DAO.selectEcr0201PopList", searchVO);
	}
	
	//사용일정 일괄 삭제 
	public int deleteEcr0201AjaxChkDtDel(EgovMap map) throws Exception {
		return delete("Ecr0201DAO.deleteEcr0201AjaxChkDtDel", map);
	}
	
	// 사용일자 여부 cnt
	public int selectEcr0201ChkDtCnt(Cr3240mVO cr3240mVO) throws Exception {
		int totalRecordCount  = (int) select("Ecr0201DAO.selectEcr0201ChkDtCnt", cr3240mVO);
		return totalRecordCount;
	}
	
	// CRF작성관리 등록
	public String insertEcr0201ChkDt(Cr3240mVO cr3240mVO) throws Exception {		
		 return (String)insert("Ecr0201DAO.insertEcr0201ChkDt", cr3240mVO); 
	}
	
	// 연구대상자 실사용횟수 갱신 CR3240M -> CR3210M
	public void updateEcr0201ChkCnt(Cr3210mVO cr3210mVO) throws Exception {
		update("Ecr0201DAO.updateEcr0201ChkCnt", cr3210mVO);
	}
	
	// 연구대상자 제품사용내역 상세보기
	public Cr3240mVO selectEcr0201ChkmgView(Cr3240mVO cr3240mVO) {
		return (Cr3240mVO)select("Ecr0201DAO.selectEcr0201ChkmgView", cr3240mVO); 
	}
	
	// 연구대상자 사용내역 수정
	public void updateEcr0201AjaxSaveChkmg(EgovMap map) throws Exception {
		update("Ecr0201DAO.updateEcr0201AjaxSaveChkmg", map);
	}
	
	// 연구대상자 품사용내역 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0201RsjUseExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecr0201DAO.selectEcr0201RsjUseExcel", searchVO);
	}
	
	// CRF작성관리 등록
	public String insertEcr0201AjaxSaveStep(EgovMap map) throws Exception {		
		 return (String)insert("Ecr0201DAO.insertEcr0201AjaxSaveStep", map); 
	}

	// 연구대상자 사용정보 등록 여부  cnt
	public int selectEcr0201AjaxSaveStepCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ecr0201DAO.selectEcr0201AjaxSaveStepCnt", map);
		return totalRecordCount;
	}

	// 연구대상자 제품회수 일괄등록
	public void updateEcr0201AjaxSaveStep3(EgovMap map) throws Exception {
		update("Ecr0201DAO.updateEcr0201AjaxSaveStep3", map);
	}
	
	// 연구대상자 제품사용정보 상세보기 
	public Cr3210mVO selectEcr0201RsjUseView(Cr3210mVO cr3210mVO) {
		return (Cr3210mVO)select("Ecr0201DAO.selectEcr0201RsjUseView", cr3210mVO); 
	}

	// 연구대상자 CRF작성관리 수정(아이템회수, 중지여부, 특이사항) 
	public void updateEcr0201Rsjuse(Cr3210mVO cr3210mVO) throws Exception {
		update("Ecr0201DAO.updateEcr0201RsjUse", cr3210mVO); 
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0201eCrfList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ecr0201.selectEcr0201eCrfList", paramMap);
	}
	
	// CRF파일 일괄다운로드 대상 선별
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0201ListCrfFile(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecr0201DAO.selectEcr0201ListCrfFile", searchVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0201SendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ecr0201DAO.selectEcr0201SendList", map);
	
	}
	
	// 신규 연구대상자 선정 등록
	public String insertEcr0201Sub(Rs2000mVO rs2000mVO) throws Exception {		
		 return (String)insert("Ecr0201DAO.insertEcr0201Sub", rs2000mVO); 
	}
	
	// RsNo -> RsCd
	public String selectEcr0201RsNoRsCd(Rs2010mVO rs2010mVO) throws Exception {
		return (String) select("Ecr0201DAO.selectEcr0201RsNoRsCd", rs2010mVO);
	}
	
	// CRF 재작성 설정 MK_YN Y -> N 설정 
	public void updateEcr0201ReMkCrf(EgovMap map) throws Exception {
		update("Ecr0201DAO.updateEcr0201ReMkCrf", map); 
	}
	
	//연구관리 CRF작성완료 재설정 MK_YN Y -> N 설정 
	public void updateEcr0201ReMkCrfRs(EgovMap map) throws Exception {
		update("Ecr0201DAO.updateEcr0201ReMkCrfRs", map); 
	}
	
	//CRF 재작성 첨부파일 삭제 
	public int deleteEcr0201ReMkCrfAttach(EgovMap map) throws Exception {
		return delete("Ecr0201DAO.deleteEcr0201ReMkCrfAttach", map);
	}
	
	// 승인요청 반려 
	public void updateEcr0201AjaxReject(EgovMap map) throws Exception {
		update("Ecr0201DAO.updateEcr0201AjaxReject", map); 
	}
	
	/* CRF작성관리 ****************************************************************************************************************************************************** */
	
}
