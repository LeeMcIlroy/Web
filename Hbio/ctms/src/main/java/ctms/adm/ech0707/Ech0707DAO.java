package ctms.adm.ech0707;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Cm4000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0707DAO  extends EgovAbstractDAO {

	/* 공통코드분류관리 ****************************************************************************************************************************************************** */
	// 공통코드분류관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0707List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0707DAO.selectEch0707ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0707DAO.selectEch0707List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 공통코드분류관리 상세보기
	//public Cm4000mVO selectEch0707View(String notiVal) {
	//	return (Cm4000mVO)select("Ech0707DAO.selectEch0707View", notiVal); 
	//}
	
	public Cm4000mVO selectEch0707View(Cm4000mVO cm4000mVO) {
			return (Cm4000mVO)select("Ech0707DAO.selectEch0707View", cm4000mVO); 
		}
	
	// 공통코드분류관리 삭제
	public void deleteEch0707(Cm4000mVO cm4000mVO) {
		delete("Ech0707DAO.deleteEch0707", cm4000mVO);
		
	}
	// 공통코드분류관리 등록
	public String insertEch0707(Cm4000mVO cm4000mVO) throws Exception {
		
		 return (String)insert("Ech0707DAO.insertEch0707", cm4000mVO); 
	}
	
	// 공통코드분류관리 수정 
	public void updateEch0707(Cm4000mVO cm4000mVO) throws Exception {
		update("Ech0707DAO.updateEch0707", cm4000mVO); 
	}
	
		
	// 공통코드분류관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0707Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0707DAO.selectEch0707Excel", searchVO);
	}
	
	// 공통코드대분류 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0707ClsCat1(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0707DAO.selectEch0707ClsCat1", searchVO);
	}
	
	// 공통코드중분류 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0707ClsCat2(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0707DAO.selectEch0707ClsCat2", searchVO);
	}
	
	
	// 공통코드 - 대분류 연동해서 중분류 가져오기
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0707AjaxClsCat2(String cd) throws Exception {
		return (List<EgovMap>) list("Ech0707DAO.selectEch0707ClsCat2", cd);
	}
	
	
	
	/* 공통코드분류관리 ****************************************************************************************************************************************************** */
	
}
