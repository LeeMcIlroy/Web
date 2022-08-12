package ctms.adm.ech0904;

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
public class Ech0904DAO  extends EgovAbstractDAO {
	
	// 입금관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0904List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0904DAO.selectEch0904ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0904DAO.selectEch0904List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 입금관리 상세보기
	public Cs2020mVO selectEch0904View(Cs2020mVO cs2020mVO) throws Exception {
		return (Cs2020mVO) select("Ech0904DAO.selectEch0904View", cs2020mVO);
	}
	
	// 입금관리 등록
	public String insertEch0904(Cs2020mVO cs2020mVO) throws Exception {
		return (String) insert("Ech0904DAO.insertEch0904", cs2020mVO);
	}

	// 입금관리 수정
	public void updateEch0904(Cs2020mVO cs2020mVO) throws Exception {
		update("Ech0904DAO.updateEch0904", cs2020mVO);
	}

	// 입금관리 삭제
	public int deleteEch0904(Cs2020mVO cs2020mVO) {
		return (int) delete("Ech0904DAO.deleteEch0904", cs2020mVO);
	}
	
	// 입금관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0904Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0904DAO.selectEch0904Excel", searchVO);
	}
	
	//견적 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0904OpList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0904DAO.selectEch0904OpListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0904DAO.selectEch0904OpList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//계약 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0904CtrtList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0904DAO.selectEch0904CtrtListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0904DAO.selectEch0904CtrtList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//상담 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0904CsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0904DAO.selectEch0904CsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0904DAO.selectEch0904CsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//연구과제 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0904RsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0904DAO.selectEch0904RsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0904DAO.selectEch0904RsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//입금정보 일괄등록 - 중복 목록 산출
	public List<EgovMap> selectEch0904DupInList(EgovMap map) {
		return (List<EgovMap>) list("Ech0904DAO.selectEch0904DupInList", map);
	}
	
	// 계약관리 상세보기
	public Cs2000mVO selectEch0904Ctrt(Cs2000mVO cs2000mVO) throws Exception {
		return (Cs2000mVO) select("Ech0904DAO.selectEch0904Ctrt", cs2000mVO);
	}
	
	// 계약관리 상세보기
	public Cs2000mVO selectEch0904Ctrt2(Cs2000mVO cs2000mVO) throws Exception {
		return (Cs2000mVO) select("Ech0904DAO.selectEch0904Ctrt2", cs2000mVO);
	}

	// 입금건수, 누적금액
	public Cs2020mVO selectEch0904InAmt(Cs2020mVO cs2020mVO) throws Exception {
		return (Cs2020mVO) select("Ech0904DAO.selectEch0904InAmt", cs2020mVO);
	}
	
	// 입금건수, 누적금액 - 현재 입금번호 제외
	public Cs2020mVO selectEch0904InAmt2(Cs2020mVO cs2020mVO) throws Exception {
		return (Cs2020mVO) select("Ech0904DAO.selectEch0904InAmt2", cs2020mVO);
	}
	
	// 계약정보의 누적입금액, 잔금 Update
	public void updateEch0904Ctrt(Cs2000mVO cs2000mVO) throws Exception {
		update("Ech0904DAO.updateEch0904Ctrt", cs2000mVO);
	}
	
	// 입금 정보 일괄 삭제
	public int deleteEch0904AjaxInDel(EgovMap map) throws Exception {
		return delete("Ech0904DAO.deleteEch0904AjaxInDel", map);
	}
	
}
