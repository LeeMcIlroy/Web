package ctms.adm.ech0902;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Cs1000mVO;
import ctms.valueObject.Cs1020mVO;
import ctms.valueObject.Cs2000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0902DAO  extends EgovAbstractDAO {
	
	// 견적관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0902List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0902DAO.selectEch0902ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0902DAO.selectEch0902List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 견적관리 상세보기
	public Cs1020mVO selectEch0902View(Cs1020mVO cs1020mVO) throws Exception {
		return (Cs1020mVO) select("Ech0902DAO.selectEch0902View", cs1020mVO);
	}
	
	// 견적관리 등록
	public String insertEch0902(Cs1020mVO cs1020mVO) throws Exception {
		return (String) insert("Ech0902DAO.insertEch0902", cs1020mVO);
	}

	// 견적관리 수정
	public void updateEch0902(Cs1020mVO cs1020mVO) throws Exception {
		update("Ech0902DAO.updateEch0902", cs1020mVO);
	}

	// 견적관리 삭제
	public int deleteEch0902(Cs1020mVO cs1020mVO) {
		return (int) delete("Ech0902DAO.deleteEch0902", cs1020mVO);
	}
	
	// 견적관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0902Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0902DAO.selectEch0902Excel", searchVO);
	}
	
	//견적 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0902OpList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0902DAO.selectEch0902OpListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0902DAO.selectEch0902OpList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//계약 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0902CtrtList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0902DAO.selectEch0902CtrtListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0902DAO.selectEch0902CtrtList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//상담 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0902CsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0902DAO.selectEch0902CsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0902DAO.selectEch0902CsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//연구과제 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0902RsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0902DAO.selectEch0902RsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0902DAO.selectEch0902RsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 계약정보 확인
	public int selectEch0902CtrtCnt(Cs2000mVO cs2000mVO) throws Exception {
		return (int) select("Ech0902DAO.selectEch0902CtrtCnt", cs2000mVO);
	}
	
	// 계약정보 확인 - 견적정보 일괄삭제 전
	public int selectEch0902AjaxOpDel(EgovMap map) throws Exception {
		return (int) select("Ech0902DAO.selectEch0902AjaxOpDel", map);
	}
	
	// 견적 정보 일괄 삭제
	public int deleteEch0902AjaxOpDel(EgovMap map) throws Exception {
		return delete("Ech0902DAO.deleteEch0902AjaxOpDel", map);
	}
}
