package ctms.adm.ech0206;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Cr3200mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs5020mVO;
import ctms.valueObject.Cr4000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0206DAO  extends EgovAbstractDAO {

	/* 연구동의서관리 ****************************************************************************************************************************************************** */
	// 연구동의서관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0206List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0206DAO.selectEch0206ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0206DAO.selectEch0206List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 연구동의서관리 상세보기
	public Rs1000mVO selectEch0206View(Rs1000mVO rs1000mVO) {
		return (Rs1000mVO)select("Ech0206DAO.selectEch0206View", rs1000mVO); 
	}
	
	// 연구동의서관리 삭제
	public void deleteEch0206(Cr4000mVO cr4000mVO) {
		delete("Ech0206DAO.deleteEch0206", cr4000mVO);
		
	}
	// 연구동의서관리 등록
	public String insertEch0206(Cr4000mVO cr4000mVO) throws Exception {		
		 return (String)insert("Ech0206DAO.insertEch0206", cr4000mVO); 
	}
	
	// 연구동의서관리 수정 
	public void updateEch0206(Cr4000mVO cr4000mVO) throws Exception {
		update("Ech0206DAO.updateEch0206", cr4000mVO); 
	}
	
	// 사용자 일련번호
	public String selectEch0206Max(Rs1000mVO rs1000mVO) throws Exception {
		return (String) select("Ech0206DAO.selectEch0206Max", rs1000mVO);
	}
	
	// 연구동의서관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0206Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0206DAO.selectEch0206Excel", searchVO);
	}
	
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0206IcfList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0206DAO.selectEch0206IcfListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0206DAO.selectEch0206IcfList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	
	// 동의서등록여부 확인 cnt
	public int selectEch0206ChkIcfCnt(Cr4000mVO cr4000mVO) throws Exception {
		int totalRecordCount  = (int) select("Ech0206DAO.selectEch0206ChkIcfCnt", cr4000mVO);
		return totalRecordCount;
	}
	
	//보고서 이름 가져오기(동의서)
	@SuppressWarnings("unchecked")
	public List<Rs5020mVO> selectEch0206selectbox(EgovMap map){
		return (List<Rs5020mVO>) list ("Ech0206DAO.selectEch0206Rptname" ,map);
	} 
	
	//보고서 삭제(동의서)
	public void deleteReportTable(String rptNo) throws Exception {
		delete("Ech0206DAO.deleteEch0206rsreport", rptNo);
	}

	//보고서 조회(동의서)
	public Rs5020mVO selectReportOne(String rptNo){
		return (Rs5020mVO)select("Ech0206DAO.selectEch0206rptOne",rptNo);
	}
	
	//보고서 등록(동의서)
	public String insertEch0206report(Rs5020mVO rs5020mVO) throws Exception {
		 return (String)insert("Ech0206DAO.insertEch0206rsreport", rs5020mVO); 
	}
	
	//연구동의서상세보기
	public Cr4000mVO selectEch0206IcfView(Cr4000mVO cr4000mVO){
		return (Cr4000mVO)select("Ech0206DAO.selectEch0206IcfView",cr4000mVO);
	}
	
	//연구동의서 팝업정보
	public Cr4000mVO selectEch0206ViewInfo(Cr4000mVO cr4000mVO){
		return (Cr4000mVO)select("Ech0206DAO.selectEch0206ViewInfo",cr4000mVO);
	}
	
	/* 연구동의서관리 ****************************************************************************************************************************************************** */
	
}
