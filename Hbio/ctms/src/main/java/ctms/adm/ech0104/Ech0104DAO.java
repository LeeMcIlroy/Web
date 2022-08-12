package ctms.adm.ech0104;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Rs5020mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0104DAO  extends EgovAbstractDAO {

	/* IRB심의관리 ****************************************************************************************************************************************************** */
	// IRB심의관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0104List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0104DAO.selectEch0104ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0104DAO.selectEch0104List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
		
	}
	
	// 연구과제 상세보기
	public Rs1000mVO selectEch0104RsView(Rs1000mVO rs1000mVO) {
		return (Rs1000mVO)select("Ech0104DAO.selectEch0104RsView", rs1000mVO); 
	}
	
	// IRB심의관리 상세보기
	public Rs5000mVO selectEch0104View(Rs5000mVO rs5000mVO) {
		return (Rs5000mVO)select("Ech0104DAO.selectEch0104View", rs5000mVO); 
	}
	
	
	// IRB심의관리 삭제
	public void deleteEch0104(Rs5000mVO rs5000mVO) {
		delete("Ech0104DAO.deleteEch0104", rs5000mVO);
		
	}
	// IRB심의관리 등록
	public String insertEch0104(Rs5000mVO rs5000mVO) throws Exception {		
		 return (String)insert("Ech0104DAO.insertEch0104", rs5000mVO); 
	}
	
	// IRB심의관리 수정 
	public void updateEch0104(Rs5000mVO rs5000mVO) throws Exception {
		update("Ech0104DAO.updateEch0104", rs5000mVO); 
	}
	
	// IRB심의관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0104Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0104DAO.selectEch0104Excel", searchVO);
	}

	//보고서 이름 가져오기(IRB승인)
	@SuppressWarnings("unchecked")
	public List<Rs5020mVO> selectEch0104selectbox(EgovMap map){
		return (List<Rs5020mVO>) list ("Ech0104DAO.selectEch0104Rptname" ,map);
	} 
	
	//보고서 삭제(IRB승인)
	public void deleteReportTable(String rptNo) throws Exception {
		delete("Ech0104DAO.deleteEch0104rsreport", rptNo);
	}

	//보고서 조회(IRB승인)
	public Rs5020mVO selectReportOne(String rptNo){
		return (Rs5020mVO)select("Ech0104DAO.selectEch0104rptOne",rptNo);
	}
	
	//보고서 등록
	public String insertEch0104report(Rs5020mVO rs5020mVO) throws Exception {
		 return (String)insert("Ech0104DAO.insertEch0104rsreport", rs5020mVO); 
	}
	
	// 연구과제 승인처리  - 예정인 경우만 진행으로 설정  
	public void updateEch0104RvRs(Rs5000mVO rs5000mVO) throws Exception {
		update("Ech0104DAO.updateEch0104RvRs", rs5000mVO); 
	}
	
	// 연구과제 참여지사 진행처리  - 예정인 경우만 진행으로 설정  
	public void updateEch0104BrSt(Rs5000mVO rs5000mVO) throws Exception {
		update("Ech0104DAO.updateEch0104BrSt", rs5000mVO); 
	}
	
	// 연구과제 참여자 진행처리  - 예정인 경우만 진행으로 설정  
	public void updateEch0104EmpSt(Rs5000mVO rs5000mVO) throws Exception {
		update("Ech0104DAO.updateEch0104EmpSt", rs5000mVO); 
	}
	
	/* IRB심의관리 ****************************************************************************************************************************************************** */
	
}
