package ctms.adm.ech0202;
 
import java.util.List;
 
import org.springframework.stereotype.Repository; 
 
import ctms.valueObject.Cr2020mVO;
import ctms.valueObject.Cr2030mVO;
import ctms.valueObject.Cr2040mVO;
import ctms.valueObject.Cr2050mVO;
import ctms.valueObject.Cr2060mVO;
import ctms.valueObject.Cr2100mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO; 
import egovframework.rte.psl.dataaccess.EgovAbstractDAO; 
import egovframework.rte.psl.dataaccess.util.EgovMap; 
 
@Repository 
public class Ech0202DAO extends EgovAbstractDAO {
 
    @SuppressWarnings("unchecked")
    public CmmnListVO selectech0202List(CmmnSearchVO searchVO) throws Exception {
        int totalRecordCount = (Integer) select("ech0202.selectech0202ListCnt", searchVO);
        List<EgovMap> resultList = (List<EgovMap>) list("ech0202.selectech0202List", searchVO);
 
        return new CmmnListVO(totalRecordCount, resultList);
    }
    
    public Cr2020mVO selectech0202View(EgovMap paramMap) throws Exception {
        return (Cr2020mVO) select("ech0202.selectech0202View", paramMap);
    }
    
    public String insertech0202(Cr2020mVO cr2020mVO) throws Exception {
        return (String) insert("ech0202.insertech0202", cr2020mVO);
    }
     
    public void updateech0202(Cr2020mVO cr2020mVO) throws Exception {
        update("ech0202.updateech0202", cr2020mVO);
    }
     
    public void deleteech0202(String quesNo) throws Exception {
        delete("ech0202.deleteech0202", quesNo);
    }
     
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectech0202Excel(CmmnSearchVO searchVO) throws Exception {
        return (List<EgovMap>) list("ech0202.selectech0202Excel", searchVO);
    }

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0202QuesList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0202.selectEch0202QuesList", paramMap);
	}

	public String insertech0202Ques(Cr2050mVO cr2050mVO) throws Exception {
		return (String) insert("ech0202.insertech0202Ques", cr2050mVO);
	}

	public void deleteech0202Ques(EgovMap paramMap) throws Exception {
		delete("ech0202.deleteech0202Ques", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0202AnswList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0202.selectEch0202AnswList", paramMap);
	}

	public void insertech0202Answ(Cr2060mVO cr2060mVO) throws Exception {
		insert("ech0202.insertech0202Answ", cr2060mVO);
	}

	public void deleteech0202Answ(EgovMap paramMap) throws Exception {
		delete("ech0202.deleteech0202Answ", paramMap);
	}

	public String insertEch0202Copy(EgovMap paramMap) throws Exception {
		return (String) insert("ech0202.insertEch0202Copy", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCr2030mList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0202.selectCr2030mList", paramMap);
	}

	public Cr2030mVO ajaxSelectQues(EgovMap paramMap) throws Exception {
		return (Cr2030mVO) select("ech0202.ajaxSelectQues", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<Cr2040mVO> ajaxSelectAnswList(EgovMap paramMap) throws Exception {
		return (List<Cr2040mVO>) list("ech0202.ajaxSelectAnswList", paramMap);
	}
	
	//CRF templete 등록 CR2100M 
	public String insertEch0202CrfTemplete(Cr2100mVO cr2100mVO) throws Exception {
        return (String) insert("ech0202DAO.insertEch0202CrfTemplete", cr2100mVO);        
    }
	
	// CRF템플릿관리 수정
	public void updateEch0202CrfTemp(Cr2100mVO cr2100mVO) throws Exception {
		update("Ech0202DAO.updateEch0202CrfTemp", cr2100mVO);
	}
	
}