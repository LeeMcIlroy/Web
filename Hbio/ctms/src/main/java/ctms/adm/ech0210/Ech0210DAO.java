package ctms.adm.ech0210;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Cr2100mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0210DAO  extends EgovAbstractDAO {
	
	// CRF템플릿관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0210List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0210DAO.selectEch0210ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0210DAO.selectEch0210List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// CRF템플릿관리 상세보기
	public Cr2100mVO selectEch0210View(Cr2100mVO cr2100mVO) throws Exception {
		return (Cr2100mVO) select("Ech0210DAO.selectEch0210View", cr2100mVO);
	}
	
	// CRF템플릿관리 등록
	public String insertEch0210(Cr2100mVO cr2100mVO) throws Exception {
		return (String) insert("Ech0210DAO.insertEch0210", cr2100mVO);
	}

	// CRF템플릿관리 수정
	public void updateEch0210(Cr2100mVO cr2100mVO) throws Exception {
		update("Ech0210DAO.updateEch0210", cr2100mVO);
	}

	// CRF템플릿관리 삭제
	public int deleteEch0210(Cr2100mVO cr2100mVO) {
		return (int) delete("Ech0210DAO.deleteEch0210", cr2100mVO);
	}
	
	// CRF템플릿관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0210Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0210DAO.selectEch0210Excel", searchVO);
	}
	
	// CRF템플릿 일괄다운로드 대상 선별
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0210ListCrfTemp(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0210DAO.selectEch0210ListCrfTemp", searchVO);
	}
	
	// CRF템플릿관리 수정
	public void updateEch0210UpageCnt(Cr2100mVO cr2100mVO) throws Exception {
		update("Ech0210DAO.updateEch0210UpageCnt", cr2100mVO);
	}
	

}
