package ctms.adm.ech0201;
 
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
public class Ech0201DAO extends EgovAbstractDAO {
 
    @SuppressWarnings("unchecked")
    public CmmnListVO selectech0201List(CmmnSearchVO searchVO) throws Exception {
        int totalRecordCount = (Integer) select("ech0201.selectech0201ListCnt", searchVO);
        List<EgovMap> resultList = (List<EgovMap>) list("ech0201.selectech0201List", searchVO);
 
        return new CmmnListVO(totalRecordCount, resultList);
    }
    
    public Rs1000mVO selectech0201View(EgovMap paramMap) throws Exception {
        return (Rs1000mVO) select("ech0201.selectech0201View", paramMap);
    }
    
    public String insertech0201(Cr2020mVO cr2020mVO) throws Exception {
        return (String) insert("ech0201.insertech0201", cr2020mVO);
    }
     
    public void updateech0201(Rs1000mVO rs1000mVO) throws Exception {
        update("ech0201.updateech0201", rs1000mVO);
    }
     
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectech0201Excel(CmmnSearchVO searchVO) throws Exception {
        return (List<EgovMap>) list("ech0201.selectech0201Excel", searchVO);
    }

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0201TempList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0201.selectEch0201TempList", paramMap);
	}

	public String insertech0201eCRF(Cr1000mVO cr1000mVO) throws Exception {
		return (String) insert("ech0201.insertech0201eCRF", cr1000mVO);
	}

	public void deleteech0201eCRF(EgovMap paramMap) throws Exception {
		delete("ech0201.deleteech0201eCRF", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0201eCrfList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0201.selectEch0201eCrfList", paramMap);
	}

}