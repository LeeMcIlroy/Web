package ctms.adm.ech0207;
 
import java.util.List;
 
import org.springframework.stereotype.Repository;

import ctms.valueObject.Cr2110mVO;
import ctms.valueObject.Cr3100mVO;
import ctms.valueObject.Cr3110mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO; 
import egovframework.rte.psl.dataaccess.EgovAbstractDAO; 
import egovframework.rte.psl.dataaccess.util.EgovMap; 
 
@Repository 
public class Ech0207DAO extends EgovAbstractDAO {
	
    //피부자극결과 리스트
    @SuppressWarnings("unchecked")
    public CmmnListVO selectAdmEch0207List(CmmnSearchVO searchVO) throws Exception {
        int totalRecordCount = (Integer) select("AdmEch0207DAO.selectAdmEch0207ListCnt", searchVO);
        List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0207DAO.selectAdmEch0207List", searchVO);
 
        return new CmmnListVO(totalRecordCount, resultList);
    }
    //피부자극결과 상세
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectAdmEch0207View(String rsNo) throws Exception {
    	
    	List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0207DAO.selectAdmEch0207View", rsNo);
    	
    	return resultList;
    }
    //피부자극결과 상세보기에서 하나의 항목선택
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectAdmEch0207ViewOne(Cr3110mVO cr3110mVO) throws Exception {
    	List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0207DAO.selectAdmEch0207ViewOne", cr3110mVO);
    	
    	return resultList;
    }
    //피부자극결과 상세보기 피험자등록에 아무도없을경우
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectAdmEch0207ViewNoOne(String rsjNo) throws Exception {
    	List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0207DAO.selectAdmEch0207ViewNoOne", rsjNo);
    	
    	return resultList;
    }
    //초기값설정시 CR3110M 피험자등록
    public String insertAdmEch0207(String rsNo) throws Exception {
    	return (String) insert("AdmEch0207DAO.insertAdmEch0207",  rsNo);
    }
    //초기값설정시 CR3100M 피험자등록
    public String insertCR3100mAdmEch0207(String rsNo) throws Exception {
    	return (String) insert("AdmEch0207DAO.insertCR3100mAdmEch0207",  rsNo);
    }
    
    //피부자극결과테이블 CR3110M 에 등록되지않는 피험자 목록
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectAdmEch0207ViewUpdate(String rsNo) throws Exception {
    	List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0207DAO.selectAdmEch0207ViewUpdate", rsNo);
    	
    	return resultList;
    }
    //피부자극결과테이블 CR3100M 에 등록되지않는 피험자 목록
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectAdmEch0207ViewUpdateCR3100M(String rsNo) throws Exception {
    	List<EgovMap> resultList = (List<EgovMap>) list("AdmEch0207DAO.selectAdmEch0207ViewUpdateCR3100m", rsNo);
    	
    	return resultList;
    }
    //기존목록에 새로운 피험자 CR3110M 테이블에추가
    public String insertNewAdmEch0207(Cr3110mVO cr3110mVO) throws Exception {
    	return (String) insert("AdmEch0207DAO.insertNewAdmEch0207", cr3110mVO);
    }
    //기존목록에 새로운 피험자 CR3100M 테이블에추가
    public String insertNewCR3100mAdmEch0207(Cr3100mVO cr3100mVO) throws Exception {
    	return (String) insert("AdmEch0207DAO.insertCR3100mNewAdmEch0207", cr3100mVO);
    }
    // CR3110M 피부자극결과 상세보기의  피험자결과 수치 수정
    public void updateAdmEch0207(Cr3110mVO cr3110mVO) throws Exception {
        update("AdmEch0207DAO.updateAdmEch0207", cr3110mVO);
    }
    // CR3100M 피험자 상세보기의  자극 수치 수정
    public void updateCR3100mAdmEch0207(Cr3100mVO cr3100mVO) throws Exception {
        update("AdmEch0207DAO.updateCR3100mAdmEch0207", cr3100mVO);
    }
    
    //피험자 CR3110M 초기값설정 삭제
    public int deleteAdmEch0207(String rsNo ) throws Exception {
        return delete("AdmEch0207DAO.deleteAdmEch0207",rsNo );
    }
    //피험자 CR3100M 초기값설정 삭제
    public int deleteCR3100mAdmEch0207(String rsNo ) throws Exception {
        return delete("AdmEch0207DAO.deleteCR3100mAdmEch0207",rsNo );
    }
    //피부자극결과 엑셀
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectAdmEch0207Excel(CmmnSearchVO searchVO) throws Exception {
        return (List<EgovMap>) list("AdmEch0207DAO.selectEch0207Excel", searchVO);
    }
       
    
    //피부자극평가 결과 조회 연구 상세
    @SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0207RsSeqSsResultList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0207DAO.selectEch0207RsSeqSsResultList", map);
	}
    
    //피부자극결과 연구상세 수정
    public void updateEch0207RsSeqSsResult(Cr3100mVO cr3100mVO) throws Exception {
        update("Ech0207DAO.updateEch0207RsSeqSsResult", cr3100mVO);
    }
    
    //피부자극결과 연구상세 등록
    public String insertEch0207RsSeqSsResult(Cr3100mVO cr3100mVO) throws Exception {
    	return (String) insert("Ech0207DAO.insertEch0207RsSeqSsResult", cr3100mVO);
    }
    
    //피부자극결과 연구상세 조회
  	public Cr3100mVO selectEch0207RsSeqResult(EgovMap map) throws Exception {
  		return (Cr3100mVO) select("Ech0207DAO.selectEch0207RsSeqResult", map);		
  	}
  	
  	//피부자극결과 연구상세 확인 cnt
 	public int selectEch0207RsSeqResultChkCnt(EgovMap map) throws Exception {
 		return (int) select("Ech0207DAO.selectEch0207RsSeqResultChkCnt", map);		
 	}
 	
 	
  	
 	//피부자극평가 결과 조회 연구
    @SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0207RsSsResultList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0207DAO.selectEch0207RsSsResultList", map);
	}
 	
    //피부자극결과 연구상세 조회
  	public Cr3110mVO selectEch0207RsResult(EgovMap map) throws Exception {
  		return (Cr3110mVO) select("Ech0207DAO.selectEch0207RsResult", map);		
  	}
  	
  	//피부자극결과 연구 수정
    public void updateEch0207RsSsResult(Cr3110mVO cr3110mVO) throws Exception {
        update("Ech0207DAO.updateEch0207RsSsResult", cr3110mVO);
    }
  	
    //피부자극결과 연구 등록
    public String insertEch0207RsSsResult(Cr3110mVO cr3110mVO) throws Exception {
    	return (String) insert("Ech0207DAO.insertEch0207RsSsResult", cr3110mVO);
    }
    
    //피부자극결과 연구 확인 cnt
   	public int selectEch0207ResultChkCnt(EgovMap map) throws Exception {
   		return (int) select("Ech0207DAO.selectEch0207ResultChkCnt", map);		
   	}
   	
   	//피부자극결과 엑셀
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectEch0207ExcelResult(CmmnSearchVO searchVO) throws Exception {
        return (List<EgovMap>) list("Ech0207DAO.selectEch0207ExcelResult", searchVO);
    }
   	
   	
}