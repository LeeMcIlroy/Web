package ctms.adm.ecr0101;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Rs2010mVO;
import ctms.valueObject.RsUploadVO;
import ctms.valueObject.Cr3200mVO;
import ctms.valueObject.Cr3210mVO;
import ctms.valueObject.Cr3240mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ecr0101DAO  extends EgovAbstractDAO {

	/* CRF작성관리 ****************************************************************************************************************************************************** */
	// CRF작성관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEcr0101List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ecr0101DAO.selectEcr0101ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ecr0101DAO.selectEcr0101List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
		
	}
	
	// 연구과제 상세보기
	public Rs1010mVO selectEcr0101RsPlanView(Rs1010mVO rs1010mVO) {
		return (Rs1010mVO)select("Ecr0101DAO.selectEcr0101RsPlanView", rs1010mVO); 
	}
	
	// CRF작성관리 상세보기
	public Cr3200mVO selectEcr0101View(Cr3200mVO cr3200mVO) {
		return (Cr3200mVO)select("Ecr0101DAO.selectEcr0101View", cr3200mVO); 
	}
	
	
	// CRF작성관리 삭제
	public void deleteEcr0101(Cr3200mVO cr3200mVO) {
		delete("Ecr0101DAO.deleteEcr0101", cr3200mVO);
		
	}
	// CRF작성관리 등록
	public String insertEcr0101(Cr3200mVO cr3200mVO) throws Exception {		
		 return (String)insert("Ecr0101DAO.insertEcr0101", cr3200mVO); 
	}
	
	// CRF작성관리 수정 
	public void updateEcr0101(Cr3200mVO cr3200mVO) throws Exception {
		update("Ecr0101DAO.updateEcr0101", cr3200mVO); 
	}
	
	// CRF작성관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0101Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecr0101DAO.selectEcr0101Excel", searchVO);
	}
	
	// 연구대상자 제품사용목록 
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEcr0101ChkList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ecr0101DAO.selectEcr0101ChkListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ecr0101DAO.selectEcr0101ChkList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 연구대상자 제품사용 체크시작, 종료일자 일괄 수정
	public void updateEcr0101AjaxSaveStep(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101AjaxSaveStep", map);
	}
	
	// 연구대상자 제품사용 초기 일괄 등록
	public void insertEcr0101ItemUse(EgovMap map) throws Exception {
		update("Ecr0101DAO.insertEcr0101ItemUse", map);
	}

	// 연구대상별 작성 목록 
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0101RsjMkList(EgovMap map) throws Exception{
		return (List<EgovMap>) list("Ecr0101DAO.selectEcr0101RsjMkList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0101Rsj(EgovMap map) throws Exception{
		return (List<EgovMap>) list("Ecr0101DAO.selectEcr0101Rsj", map);
	}
	
	// 연구대상자정보 및 제품사용환경
	@SuppressWarnings("unchecked")
	public Rs2010mVO selectEcr0101Rsj(Rs2010mVO rs2010mVO) {
		return (Rs2010mVO)select("Ecr0101DAO.selectEcr0101Rsj", rs2010mVO); 
	}
	
	// 실사용체크 cnt
	public int selectEcr0101ChkCnt(Cr3200mVO cr3200mVO) throws Exception {
		int totalRecordCount  = (int) select("Ecr0101DAO.selectEcr0101ChkCnt", cr3200mVO);
		return totalRecordCount;
	}
	
	// 실사용체크 cnt
	public int selectEcr0101Cnt(Cr3200mVO cr3200mVO) throws Exception {
		int totalRecordCount  = (int) select("Ecr0101DAO.selectEcr0101Cnt", cr3200mVO);
		return totalRecordCount;
	}
	
	// 개인사용일정 삭제
	public void deleteEcr0101Chk(Cr3200mVO cr3200mVO) {
		delete("Ecr0101DAO.deleteEcr0101Chk", cr3200mVO);
		
	}
	
	//팝업사용
	public EgovMap selectEcr0101Map(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("Ecr0101DAO.selectEcr0101Map", searchVO);
	}
	
	//팝업사용2
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0101PopList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecr0101DAO.selectEcr0101PopList", searchVO);
	}
	
	//사용일정 일괄 삭제 
	public int deleteEcr0101AjaxChkDtDel(EgovMap map) throws Exception {
		return delete("Ecr0101DAO.deleteEcr0101AjaxChkDtDel", map);
	}
	
	// 사용일자 여부 cnt
	public int selectEcr0101ChkDtCnt(Cr3240mVO cr3240mVO) throws Exception {
		int totalRecordCount  = (int) select("Ecr0101DAO.selectEcr0101ChkDtCnt", cr3240mVO);
		return totalRecordCount;
	}
	
	// CRF작성관리 등록
	public String insertEcr0101ChkDt(Cr3240mVO cr3240mVO) throws Exception {		
		 return (String)insert("Ecr0101DAO.insertEcr0101ChkDt", cr3240mVO); 
	}
	
	// 연구대상자 실사용횟수 갱신 CR3240M -> CR3210M
	public void updateEcr0101ChkCnt(Cr3210mVO cr3210mVO) throws Exception {
		update("Ecr0101DAO.updateEcr0101ChkCnt", cr3210mVO);
	}
	
	// 연구대상자 제품사용내역 상세보기
	public Cr3240mVO selectEcr0101ChkmgView(Cr3240mVO cr3240mVO) {
		return (Cr3240mVO)select("Ecr0101DAO.selectEcr0101ChkmgView", cr3240mVO); 
	}
	
	// 연구대상자 사용내역 수정
	public void updateEcr0101AjaxSaveChkmg(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101AjaxSaveChkmg", map);
	}
	
	// 연구대상자 품사용내역 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0101RsjUseExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecr0101DAO.selectEcr0101RsjUseExcel", searchVO);
	}
	
	// CRF작성관리 등록
	public String insertEcr0101AjaxSaveStep(EgovMap map) throws Exception {		
		 return (String)insert("Ecr0101DAO.insertEcr0101AjaxSaveStep", map); 
	}

	// 연구대상자 사용정보 등록 여부  cnt
	public int selectEcr0101AjaxSaveStepCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ecr0101DAO.selectEcr0101AjaxSaveStepCnt", map);
		return totalRecordCount;
	}

	// 연구대상자 제품회수 일괄등록
	public void updateEcr0101AjaxSaveStep3(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101AjaxSaveStep3", map);
	}
	
	// 연구대상자 제품사용정보 상세보기 
	public Cr3210mVO selectEcr0101RsjUseView(Cr3210mVO cr3210mVO) {
		return (Cr3210mVO)select("Ecr0101DAO.selectEcr0101RsjUseView", cr3210mVO); 
	}

	// 연구대상자 CRF작성관리 수정(아이템회수, 중지여부, 특이사항) 
	public void updateEcr0101Rsjuse(Cr3210mVO cr3210mVO) throws Exception {
		update("Ecr0101DAO.updateEcr0101RsjUse", cr3210mVO); 
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0101eCrfList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ecr0101.selectEcr0101eCrfList", paramMap);
	}
	
	// CRF파일 일괄다운로드 대상 선별
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0101ListCrfFile(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecr0101DAO.selectEcr0101ListCrfFile", searchVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcr0101SendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ecr0101DAO.selectEcr0101SendList", map);
	
	}
	
	// 신규 연구대상자 선정 등록
	public String insertEcr0101Sub(Rs2000mVO rs2000mVO) throws Exception {		
		 return (String)insert("Ecr0101DAO.insertEcr0101Sub", rs2000mVO); 
	}
	
	// RsNo -> RsCd
	public String selectEcr0101RsNoRsCd(Rs2010mVO rs2010mVO) throws Exception {
		return (String) select("Ecr0101DAO.selectEcr0101RsNoRsCd", rs2010mVO);
	}
	
	// CRF작성관리 수정 
	public void updateEcr0101AjaxReqMkFin(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101AjaxReqMkFin", map); 
	}
	
	// CRF작성 cnt, 연구종료확인서 제외
	public int selectEcr0101MkCnt(EgovMap answMap) throws Exception {
		return (int) select("Ecr0101DAO.selectEcr0101MkCnt", answMap);
	}
	
	// 연구대상자 등록여부 확인
	public int selectEcr0101RsiCnt(EgovMap answMap) throws Exception {
		return (int) select("Ecr0101DAO.selectEcr0101RsiCnt", answMap);
	}
	
	// 초기상태 여부 확인
	public int selectEcr0101SetCnt(EgovMap answMap) throws Exception {
		return (int) select("Ecr0101DAO.selectEcr0101SetCnt", answMap);
	}
	
	// 연구과제 - 연구종료확인서 신청 단계로 설정 MK_CLS '1010'
	public void updateEcr0101RsReqMkFin(EgovMap answMap) throws Exception {
		update("Ecr0101DAO.updateEcr0101RsReqMkFin", answMap);
	}
	
	// 피험자 특이사항 설정 
	public void updateEcr0101AjaxSaveEtc(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101AjaxSaveEtc", map); 
	}
	
	// 연구대상자 일괄삭제
	public void deleteEcr0101AjaxDelRsiNo(EgovMap map) {
		delete("Ecr0101DAO.deleteEcr0101AjaxDelRsiNo", map);
	}
	
	// 연구차수 연구대상자 일괄삭제
	public void deleteEcr0101AjaxDelRsiNoSeq(EgovMap map) {
		delete("Ecr0101DAO.deleteEcr0101AjaxDelRsiNoSeq", map);
	}
	
	// 연구대상자 CRF 작성여부 확인
	public int selectEcr0101AjaxRsiMkCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ecr0101DAO.selectEcr0101AjaxRsiMkCnt", map);
		return totalRecordCount;
	}
	
	// 연구대상자 CRF템플릿 일괄삭제
	public void deleteEcr0101AjaxDelRsiNoTmpl(EgovMap map) {
		delete("Ecr0101DAO.deleteEcr0101AjaxDelRsiNoTmpl", map);
	}
	
	// 연구관리 연구대상자수 차감처리 
	public void updateEcr0101AjaxSaveScnt(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101AjaxSaveScnt", map); 
	}
	
	// 피험자 중도탈락정보  설정 
	public void updateEcr0101AjaxSaveDout(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101AjaxSaveDout", map); 
	}
	
	// 피험자 중도탈락정보  삭제 
	public void updateEcr0101AjaxDelDout(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101AjaxDelDout", map); 
	}
	
	// 연구종료확인서 설정체크 cnt
	public int selectEcr0101RsFinSetChkCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ecr0101DAO.selectEcr0101RsFinSetChkCnt", map);
		return totalRecordCount;
	}
	
	// 연구대상자 식별번호 중복 check
	public int selectEcr0101ChkRsiNoCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ecr0101DAO.selectEcr0101ChkRsiNoCnt", map);
		return totalRecordCount;
	}
	
	//설문응답 결과 삭제 
	public int deleteEcr0101ReMkDelAnsw(EgovMap map) throws Exception {
		return delete("Ecr0101DAO.deleteEcr0101ReMkDelAnsw", map);
	}
	
	//연구관리 CRF작성완료 재설정 MK_YN Y -> N 설정 
	public void updateEcr0101ReMkCrfRs(EgovMap map) throws Exception {
		update("Ecr0101DAO.updateEcr0101ReMkCrfRs", map); 
	}
	
	//작성한 CRF List(CT7000M)
	@SuppressWarnings("unchecked")
	public  List<Ct7000mVO> selectEcr0101SvyList(EgovMap map) {
		return (List<Ct7000mVO>) list("Ecr0101DAO.selectEcr0101SvyList", map);
	}
	
	// 연구계획서 일괄등록 연구대상자 중복 check
	@SuppressWarnings("unchecked")
	public  List<EgovMap> selectEcr0101DupRsjList(EgovMap map) {
		return (List<EgovMap>) list("Ecr0101DAO.selectEcr0101DupRsjList", map);
	}
	
	// 연구계획서 일괄등록 - 연구번호, 연구시작일자, 연구종료일자 확인
	public Rs1010mVO selectEcr0101RsNo(EgovMap map) throws Exception {
		return (Rs1010mVO) select("Ecr0101DAO.selectEcr0101RsNo", map);
	}
	
	//연구대상자 일괄등록 - 연구대상자 등록
	public String insertEcr0101RsjUpload(RsUploadVO rsUploadVO) throws Exception {
		return (String) insert("Ecr0101DAO.insertEcr0101RsjUpload", rsUploadVO);
	}
	
	/* CRF작성관리 ****************************************************************************************************************************************************** */
	
}
