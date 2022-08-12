package ctms.adm.ech0501;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Cm4000mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.Rs5020mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0501DAO extends EgovAbstractDAO {

	//리스트조회
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0501List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("AdmEch0501DAO.selectAdmEch0501ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0501DAO.selectAdmEch0501List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	//상세보기(맵)
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0501selectOne(String rsNo){
	
		List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0501DAO.selectEch0501ViewOne", rsNo); 
		return resultList;
	}
	
	//상세보기(모델)
	@SuppressWarnings("unchecked")
	public List<Rs5020mVO> selectEch0501selectOneModel(EgovMap map){
	
		List<Rs5020mVO> resultList = (List<Rs5020mVO>) list("AdmEch0501DAO.selectEch0501selectOneModel", map); 
		return resultList;
	}
	
	
	//보고서 등록
	public String insertEch0501(Rs5000mVO rs5000mVO) throws Exception {
		
		 return (String)insert("AdmEch0501DAO.insertAdmEch0501", rs5000mVO); 
	}

	//보고서수정 
	public void updateEch0501(Rs5020mVO rs5020mVO ) throws Exception {
		update("AdmEch0501DAO.updateAdmEch0501", rs5020mVO); 
	}
	//보고서 RS5020M 등록
	public String insertEch0501report(Rs5020mVO rs5020mVO) throws Exception {
		
		 return (String)insert("AdmEch0501DAO.insertAdmEch0501rsreport", rs5020mVO); 
	}
	//보고서 이름 가져오기
	@SuppressWarnings("unchecked")
	public List<Rs5020mVO> selectEch0501selectbox(EgovMap map){
		
		return (List<Rs5020mVO>) list ("AdmEch0501DAO.selectEch0501rptname" ,map);
	} 
	// 보고서 삭제
	public void deleteReportTable(String rptNo) throws Exception {
		delete("AdmEch0501DAO.deleteAdmEch0501rsreport", rptNo);
	}
	//보고서 조회
	public Rs5020mVO selectReportOne(String rptNo){
		
		return (Rs5020mVO)select("AdmEch0501DAO.selectEch0501rptOne",rptNo);
	}
	//엑셀 
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmEch0501Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmEch0501DAO.selectEch0501Excel", searchVO);
	}

}
