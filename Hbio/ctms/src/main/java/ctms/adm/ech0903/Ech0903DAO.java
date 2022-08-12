package ctms.adm.ech0903;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs1020mVO;
import ctms.valueObject.Rs1030mVO;
import ctms.valueObject.Rs1040mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.RsUploadVO;
import ctms.valueObject.Cm4000mVO;
import ctms.valueObject.Cs1000mVO;
import ctms.valueObject.Cs1020mVO;
import ctms.valueObject.Cs2000mVO;
import ctms.valueObject.Cs2020mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0903DAO  extends EgovAbstractDAO {
	
	// 계약관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0903List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0903DAO.selectEch0903ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0903DAO.selectEch0903List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 계약관리 상세보기
	public Cs2000mVO selectEch0903View(Cs2000mVO cs2000mVO) throws Exception {
		return (Cs2000mVO) select("Ech0903DAO.selectEch0903View", cs2000mVO);
	}
	
	// 계약관리 등록
	public String insertEch0903(Cs2000mVO cs2000mVO) throws Exception {
		return (String) insert("Ech0903DAO.insertEch0903", cs2000mVO);
	}

	// 계약관리 수정
	public void updateEch0903(Cs2000mVO cs2000mVO) throws Exception {
		update("Ech0903DAO.updateEch0903", cs2000mVO);
	}

	// 계약관리 삭제
	public int deleteEch0903(Cs2000mVO cs2000mVO) {
		return (int) delete("Ech0903DAO.deleteEch0903", cs2000mVO);
	}
	
	// 계약관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0903Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0903DAO.selectEch0903Excel", searchVO);
	}
	
	//입금 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0903InList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0903DAO.selectEch0903InListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0903DAO.selectEch0903InList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//견적 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0903OpList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0903DAO.selectEch0903OpListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0903DAO.selectEch0903OpList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//계약 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0903CtrtList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0903DAO.selectEch0903CtrtListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0903DAO.selectEch0903CtrtList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//상담 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0903CsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0903DAO.selectEch0903CsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0903DAO.selectEch0903CsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//연구과제 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0903RsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0903DAO.selectEch0903RsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0903DAO.selectEch0903RsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 입금관리 확인
	public int selectEch0903InCnt(Cs2020mVO cs2020mVO) throws Exception {
		return (int) select("Ech0903DAO.selectEch0903InCnt", cs2020mVO);
	}
	
	// 견적관리 상세보기
	public Cs1020mVO selectEch0903OpView(Cs1020mVO cs1020mVO) throws Exception {
		return (Cs1020mVO) select("Ech0903DAO.selectEch0903OpView", cs1020mVO);
	}
	
	// 입금정보 확인 - 계약정보 일괄삭제 전
	public int selectEch0903AjaxCtrtDel(EgovMap map) throws Exception {
		return (int) select("Ech0903DAO.selectEch0903AjaxCtrtDel", map);
	}
	
	// 계약 정보 일괄 삭제
	public int deleteEch0903AjaxCtrtDel(EgovMap map) throws Exception {
		return delete("Ech0903DAO.deleteEch0903AjaxCtrtDel", map);
	}
	
}
