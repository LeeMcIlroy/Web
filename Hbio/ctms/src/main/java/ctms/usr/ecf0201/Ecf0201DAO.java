package ctms.usr.ecf0201;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ecf0201DAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcf0201List(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecf0201DAO.selectEcf0201List", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcf0201RsList(Sb1000mVO sessionVO) throws Exception {
		return (List<EgovMap>) list("Ecf0201DAO.selectEcf0201RsList", sessionVO);
	}

	public EgovMap selectEcf0201Map(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("Ecf0201DAO.selectEcf0201Map", searchVO);
	}

	public String selectEcf0201DuplChk(EgovMap paramMap) throws Exception {
		return (String) select("Ecf0201DAO.selectEcf0201DuplChk", paramMap);
	}

	public void insertEcf0201(EgovMap paramMap) throws Exception {
		insert("Ecf0201DAO.insertEcf0201", paramMap);
	}

	public void updateEcf0201(EgovMap paramMap) throws Exception {
		update("Ecf0201DAO.updateEcf0201", paramMap);
	}

	public void insertEcf0201Remk(EgovMap paramMap) throws Exception {
		insert("Ecf0201DAO.insertEcf0201Remk", paramMap);
	}

	public void updateEcf0201Remk(EgovMap paramMap) throws Exception {
		update("Ecf0201DAO.updateEcf0201Remk", paramMap);
	}

	public void updateEcf0201ChkCnt(EgovMap paramMap) throws Exception {
		update("Ecf0201DAO.updateEcf0201ChkCnt", paramMap);
	}
	
}
