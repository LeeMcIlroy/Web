package ctms.adm.ech0203;
 
import java.util.List;
 
import org.springframework.stereotype.Repository; 
 
import ctms.valueObject.Cr2030mVO;
import ctms.valueObject.Cr2040mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO; 
import egovframework.rte.psl.dataaccess.EgovAbstractDAO; 
import egovframework.rte.psl.dataaccess.util.EgovMap; 
 
@Repository 
public class Ech0203DAO extends EgovAbstractDAO {
 
    @SuppressWarnings("unchecked")
    public CmmnListVO selectech0203List(CmmnSearchVO searchVO) throws Exception {
        int totalRecordCount = (Integer) select("ech0203.selectech0203ListCnt", searchVO);
        List<EgovMap> resultList = (List<EgovMap>) list("ech0203.selectech0203List", searchVO);
 
        return new CmmnListVO(totalRecordCount, resultList);
    }
    
    public Cr2030mVO selectech0203View(EgovMap paramMap) throws Exception {
        return (Cr2030mVO) select("ech0203.selectech0203View", paramMap);
    }
    
    public String insertech0203(Cr2030mVO cr2030mVO) throws Exception {
        return (String) insert("ech0203.insertech0203", cr2030mVO);
    }
     
    public void updateech0203(Cr2030mVO cr2030mVO) throws Exception {
        update("ech0203.updateech0203", cr2030mVO);
    }
     
    public void deleteech0203(String quesNo) throws Exception {
        delete("ech0203.deleteech0203", quesNo);
    }
     
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectech0203Excel(CmmnSearchVO searchVO) throws Exception {
        return (List<EgovMap>) list("ech0203.selectech0203Excel", searchVO);
    }

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0203AnswList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0203.selectEch0203AnswList", paramMap);
	}

	public void insertech0203Answ(Cr2040mVO cr2040mVO) throws Exception {
		insert("ech0203.insertech0203Answ", cr2040mVO);
	}

	public void deleteech0203Answ(EgovMap paramMap) throws Exception {
		delete("ech0203.deleteech0203Answ", paramMap);
	}
	
	// 삭제 질문 CR2030M DEL_YN = 'Y' 설정
	public void updateEch0203DelYnQues(EgovMap paramMap) throws Exception {
        update("ech0203DAO.updateEch0203DelYnQues", paramMap);
    }
	
	// 삭제 답변항목 CR2040M DEL_YN = 'Y' 설정
	public void updateEch0203DelYnAnsw(EgovMap paramMap) throws Exception {
        update("ech0203DAO.updateEch0203DelYnAnsw", paramMap);
    }
}