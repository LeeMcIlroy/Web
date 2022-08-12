package ctms.adm.ech0204;
 
import java.util.List;
 
import org.springframework.stereotype.Repository;

import ctms.valueObject.Cr1000mVO;
import ctms.valueObject.Cr2020mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO; 
import egovframework.rte.psl.dataaccess.EgovAbstractDAO; 
import egovframework.rte.psl.dataaccess.util.EgovMap; 
 
@Repository 
public class Ech0204DAO extends EgovAbstractDAO {
 
    @SuppressWarnings("unchecked")
    public CmmnListVO selectech0204List(CmmnSearchVO searchVO) throws Exception {
        int totalRecordCount = (Integer) select("ech0204.selectech0204ListCnt", searchVO);
        List<EgovMap> resultList = (List<EgovMap>) list("ech0204.selectech0204List", searchVO);
 
        return new CmmnListVO(totalRecordCount, resultList);
    }
    
    public Rs1000mVO selectech0204View(EgovMap paramMap) throws Exception {
        return (Rs1000mVO) select("ech0204.selectech0204View", paramMap);
    }
    
    public String insertech0204(Cr2020mVO cr2020mVO) throws Exception {
        return (String) insert("ech0204.insertech0204", cr2020mVO);
    }
     
    public void updateech0204(Rs1000mVO rs1000mVO) throws Exception {
        update("ech0204.updateech0204", rs1000mVO);
    }
     
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectech0204Excel(CmmnSearchVO searchVO) throws Exception {
        return (List<EgovMap>) list("ech0204.selectech0204Excel", searchVO);
    }

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0204TempList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0204.selectEch0204TempList", paramMap);
	}

	public String insertech0204eCRF(Cr1000mVO cr1000mVO) throws Exception {
		return (String) insert("ech0204.insertech0204eCRF", cr1000mVO);
	}

	public void deleteech0204eCRF(EgovMap paramMap) throws Exception {
		delete("ech0204.deleteech0204eCRF", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0204eCrfList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0204.selectEch0204eCrfList", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0204MemList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0204.selectEch0204MemList", paramMap);
	}

}