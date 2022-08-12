package ctms.adm.ech0301;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0301DAO  extends EgovAbstractDAO {

	/* 피험자관리 ****************************************************************************************************************************************************** */
	// 피험자관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0301List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0301DAO.selectEch0301ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0301DAO.selectEch0301List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 피험자관리 상세보기
	public Sb1000mVO selectEch0301View(Sb1000mVO sb1000mVO) {
		return (Sb1000mVO)select("Ech0301DAO.selectEch0301View", sb1000mVO); 
	}
		
	// 피험자관리 삭제
	public void deleteEch0301(Sb1000mVO sb1000mVO) {
		delete("Ech0301DAO.deleteEch0301", sb1000mVO);
		
	}
	// 피험자관리 등록
	public String insertEch0301(Sb1000mVO sb1000mVO) throws Exception {		
		 return (String)insert("Ech0301DAO.insertEch0301", sb1000mVO); 
	}
	
	// 피험자관리 수정 
	public void updateEch0301(Sb1000mVO sb1000mVO) throws Exception {
		update("Ech0301DAO.updateEch0301", sb1000mVO); 
	}
	
	// 피험자관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0301Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0301DAO.selectEch0301Excel", searchVO);
	}
	
	// 연구대상자(피험자관리) 유형 상세보기
	public Sb1010mVO selectEch0301ResearchCls(Sb1010mVO sb1010mVO) {
		return (Sb1010mVO)select("Ech0301DAO.selectEch0301ResearchCls", sb1010mVO); 
	}
	// 연구대상자(피험자관리) 유형 추가
	public String insertEch0301ResearchCls(Sb1010mVO sb1010mVO) throws Exception {		
		 return (String)insert("Ech0301DAO.insertEch0301ResearchCls", sb1010mVO); 
	}
	// 연구대상자(피험자관리) 유형 수정 
	public void updateEch0301ResearchCls(Sb1010mVO sb1010mVO) throws Exception {
		update("Ech0301DAO.updateEch0301ResearchCls", sb1010mVO); 
	}
	// 연구대상자(피험자관리) 유형 삭제 
	public void deleteEch0301ResearchCls(Sb1010mVO sb1010mVO) throws Exception {
		update("Ech0301DAO.deleteEch0301ResearchCls", sb1010mVO); 
	}	
	
	// 연구대상자 예약 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0301MtList(Sb1000mVO sb1000mVO) throws Exception {
		return (List<EgovMap>) list("Ech0301DAO.selectEch0301MtList", sb1000mVO);
	}
	
	// 연구대상자참여 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0301JnList(Sb1000mVO sb1000mVO) throws Exception {
		return (List<EgovMap>) list("Ech0301DAO.selectEch0301JnList", sb1000mVO);
	}

	// 연구대상자 - 관리자확인일자 일괄등록
	public void updateEch0301AjaxSaveCfmDt(EgovMap map) throws Exception {
		update("Ech0301DAO.updateEch0301AjaxSaveCfmDt", map);
	}
	
	// 연구대상자 비밀번호 재설정
	public void updateEch0301AjaxProfClearPw(Sb1000mVO sb1000mVO) throws Exception{
		update("Ech0301DAO.updateEch0301AjaxProfClearPw", sb1000mVO);
		 
	}
	
	// 사용자로그인 횟수 초기화 
	public void updateEch0301AjaxClearLgnFail(EgovMap map) throws Exception {
		update("Ech0301DAO.updateEch0301AjaxClearLgnFail", map);
	}
	
	// 연구대상자 아이디일괄 등록
	public void updateEch0301AjaxSaveFirst(Sb1000mVO sb1000mVO) throws Exception {
		update("Ech0301DAO.updateEch0301AjaxSaveFirst", sb1000mVO);
	}
	
	public String selectEch0301GetId(EgovMap map) throws Exception {
		return (String) select("Ech0301DAO.selectEch0301GetId", map);	
	}
	
	//연구대상자의 연구 참여여부 확인 - 삭제불가 처리
	public int select0301ChkDelCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ech0301DAO.select0301ChkDelCnt", map);
		return totalRecordCount;
	}
	
	//SMS발송대상자
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0301SendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0301DAO.selectEch0301SendList", map);
	}	
	
	// 연구과제 상세보기 (연구코드)
	public Rs1000mVO selectEch0301RsView(Rs1000mVO rs1000mVO) {
		return (Rs1000mVO)select("Ech0301DAO.selectEch0301RsView", rs1000mVO); 
	}
		
	//연구대상자 피험자선정여부 확인
	public int selectEch0301RsjCnt(EgovMap map) {
		return (int) select("Ech0301DAO.selectEch0301RsjCnt", map);
	}
	
	// 연구대상자 선정 등록
	public String insertEch0301Sub(Rs2000mVO rs2000mVO) throws Exception {		
		 return (String)insert("Ech0301DAO.insertEch0301Sub", rs2000mVO); 
	}
	
	// 연구대상자 정보등록단계 수정 
	public void updateEch0301RegLv(Sb1000mVO sb1000mVO) throws Exception {
		update("Ech0301DAO.updateEch0301RegLv", sb1000mVO); 
	}
	
	//핸드폰번호 중복 확인
	public int selectEch0301AjaxHpNoCheck(EgovMap map) {
		return (int) select("Ech0301DAO.selectEch0301AjaxHpNoCheck", map);
	}

	/* 피험자관리 ****************************************************************************************************************************************************** */
	
		
	
}
