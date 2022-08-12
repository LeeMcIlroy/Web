package ctms.adm.ech0103;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rm2000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0103DAO  extends EgovAbstractDAO {

	/* 예약관리 ****************************************************************************************************************************************************** */
	// 예약관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0103List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0103DAO.selectEch0103ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0103DAO.selectEch0103List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
		
	}
	
	// 연구과제 상세보기
	//public Rs1000mVO selectEch0103RsView(Rs1000mVO rs1000mVO) {
		//return (Rs1000mVO)select("Ech0103DAO.selectEch0103RsView", rs1000mVO); 
	//}
	
	// 예약관리 상세보기
	public Rs4000mVO selectEch0103View(Rs4000mVO rs4000mVO) {
		return (Rs4000mVO)select("Ech0103DAO.selectEch0103View", rs4000mVO); 
	}
	
	
	// 예약관리 삭제
	public void deleteEch0103(Rs4000mVO rs4000mVO) {
		delete("Ech0103DAO.deleteEch0103", rs4000mVO);
		
	}
	// 예약관리 등록
	public String insertEch0103(Rs4000mVO rs4000mVO) throws Exception {		
		 return (String)insert("Ech0103DAO.insertEch0103", rs4000mVO); 
	}
	
	// 예약관리 수정 
	public void updateEch0103(Rs4000mVO rs4000mVO) throws Exception {
		update("Ech0103DAO.updateEch0103", rs4000mVO); 
	}
	
	// 예약관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0103Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0103DAO.selectEch0103Excel", searchVO);
	}

	// 예약관리 팝업
	public Rs4000mVO selectEch0103MtmgPop(Rs4000mVO rs4000mVO) {
		return (Rs4000mVO)select("Ech0103DAO.selectEch0103MtmgPop", rs4000mVO); 
	}

	// 예약관리 등록 Ajax
	public String insertEch1003AjaxSaveStep(EgovMap map) throws Exception {
		return (String)insert("Ech0103DAO.insertEch1003AjaxSaveStep", map);
	}
	
	// SMS 등록 Ajax
	public String insertEch1002AjaxSaveSms(EgovMap map) throws Exception {
		return (String)insert("Ech0103DAO.insertEch1002AjaxSaveSms", map);
	}
	
	// 예약관리 수정 
	public void updateEch1003AjaxSaveStep(EgovMap map) throws Exception {
		update("Ech0103DAO.updateEch1003AjaxSaveStep", map); 
	}
	
	//연구과제-연구대상자(피험자)별 예약 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0103MtList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("Ech0103DAO.selectEch0103MtList", paramMap);
	}
	
	//예약SMS 대상 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0103SendSmsMtList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0103DAO.selectEch0103SendSmsMtList", map);
	
	}
	
	// 예약SMS 피험자 이름
	public Rm2000mVO selectEch0103RsjDetail(Rm2000mVO rm2000mVO) {
		return (Rm2000mVO)select("Ech0103DAO.selectEch0103RsjDetail", rm2000mVO); 
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0103SendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0103DAO.selectEch0103SendList", map);
	
	}
	
	
	/* 예약관리 ****************************************************************************************************************************************************** */
	
}
