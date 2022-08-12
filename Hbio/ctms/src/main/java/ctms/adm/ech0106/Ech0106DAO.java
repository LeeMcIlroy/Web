package ctms.adm.ech0106;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs1020mVO;
import ctms.valueObject.Rs1030mVO;
import ctms.valueObject.Rs1040mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Rs3000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.RsUploadVO;
import ctms.valueObject.Cm4000mVO;
import ctms.valueObject.Cs1000mVO;
import ctms.valueObject.Cs1020mVO;
import ctms.valueObject.Rs3000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0106DAO  extends EgovAbstractDAO {
	
	// 시험제품관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0106List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0106DAO.selectEch0106ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0106DAO.selectEch0106List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 시험제품관리 상세보기
	public Rs3000mVO selectEch0106View(Rs3000mVO rs3000mVO) throws Exception {
		return (Rs3000mVO) select("Ech0106DAO.selectEch0106View", rs3000mVO);
	}
	
	// 시험제품관리 등록
	public String insertEch0106(Rs3000mVO rs3000mVO) throws Exception {
		return (String) insert("Ech0106DAO.insertEch0106", rs3000mVO);
	}

	// 시험제품관리 수정
	public void updateEch0106(Rs3000mVO rs3000mVO) throws Exception {
		update("Ech0106DAO.updateEch0106", rs3000mVO);
	}

	// 시험제품관리 삭제
	public void deleteEch0106(Rs3000mVO rs3000mVO) {
		delete("Ech0106DAO.deleteEch0106", rs3000mVO);
	}
	
	// 시험제품관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0106Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0106DAO.selectEch0106Excel", searchVO);
	}
	
	//견적 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0106OpList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0106DAO.selectEch0106OpListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0106DAO.selectEch0106OpList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//계약 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0106CtrtList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0106DAO.selectEch0106CtrtListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0106DAO.selectEch0106CtrtList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//상담 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0106CsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0106DAO.selectEch0106CsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0106DAO.selectEch0106CsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//연구과제 목록 
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0106RsList(EgovMap map) throws Exception {
		int totalRecordCount = (Integer) select("Ech0106DAO.selectEch0106RsListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0106DAO.selectEch0106RsList", map);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//시험제품 일괄등록 - 중복 목록 산출
	public List<EgovMap> selectEch0106DupItemList(EgovMap map) {
		return (List<EgovMap>) list("Ech0106DAO.selectEch0106DupItemList", map);
	}
	
	//연구코드 가져오기
	public Rs1000mVO selectEch0106AjaxRsCdCheck(EgovMap map) {
		return (Rs1000mVO)select("Ech0106DAO.selectEch0106AjaxRsCdCheck", map); 
	}	
	
	//연구코드 가져오기
	public Rs1000mVO selectEch0106AjaxRsCdCheck2(EgovMap map) {
		return (Rs1000mVO)select("Ech0106DAO.selectEch0106AjaxRsCdCheck2", map); 
	}
	
	// 시험제품 정보 일괄 삭제
	public int deleteEch0106AjaxItemDel(EgovMap map) throws Exception {
		return delete("Ech0106DAO.deleteEch0106AjaxItemDel", map);
	}
	
}
