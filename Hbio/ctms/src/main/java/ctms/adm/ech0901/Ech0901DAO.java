package ctms.adm.ech0901;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Cs1000mVO;
import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0901DAO  extends EgovAbstractDAO {
	
	// 상담관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0901List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0901DAO.selectEch0901ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0901DAO.selectEch0901List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 상담관리 상세보기
	public Cs1000mVO selectEch0901View(Cs1000mVO cs1000mVO) throws Exception {
		return (Cs1000mVO) select("Ech0901DAO.selectEch0901View", cs1000mVO);
	}
	
	// 상담관리 등록
	public String insertEch0901(Cs1000mVO cs1000mVO) throws Exception {
		return (String) insert("Ech0901DAO.insertEch0901", cs1000mVO);
	}

	// 상담관리 수정
	public void updateEch0901(Cs1000mVO cs1000mVO) throws Exception {
		update("Ech0901DAO.updateEch0901", cs1000mVO);
	}
	
	// 상담관리 삭제
	public int deleteEch0901(Cs1000mVO cs1000mVO) {
		return (int) delete("Ech0901DAO.deleteEch0901", cs1000mVO);
	}
	
	// 상담관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0901Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0901DAO.selectEch0901Excel", searchVO);
	}
	
	//견적 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0901OpList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0901DAO.selectEch0901OpListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0901DAO.selectEch0901OpList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//계약 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0901CtrtList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0901DAO.selectEch0901CtrtListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0901DAO.selectEch0901CtrtList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//상담 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0901CsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0901DAO.selectEch0901CsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0901DAO.selectEch0901CsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//연구과제 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0901RsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0901DAO.selectEch0901RsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0901DAO.selectEch0901RsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 상담 정보 일괄 삭제
	public int deleteEch0901AjaxCsDel(EgovMap map) throws Exception {
		return delete("Ech0901DAO.deleteEch0901AjaxCsDel", map);
	}
	
	//상담정보 일괄등록 - 중복 목록 산출
	public List<EgovMap> selectEch0901DupCsList(EgovMap map) {
		return (List<EgovMap>) list("Ech0901DAO.selectEch0901DupCsList", map);
	}

	// 작업자 확인
	public Ct1030mVO selectEch0901EmpCheck(EgovMap map) throws Exception {
		return (Ct1030mVO) select("Ech0901DAO.selectEch0901EmpCheck", map);
	}
	
	// 상담 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0901AjaxCsList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0901DAO.selectEch0901AjaxCsList", map);
	}
	
	// 삭제대상 확인 - 상담정보 일괄삭제 전
	public int selectEch0901AjaxCsDel(EgovMap map) throws Exception {
		return (int) select("Ech0901DAO.selectEch0901AjaxCsDel", map);
	}
	
}
