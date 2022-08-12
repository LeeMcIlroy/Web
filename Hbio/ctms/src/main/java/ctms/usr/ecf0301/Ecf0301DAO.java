package ctms.usr.ecf0301;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ecf0301DAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcf0301List(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecf0301DAO.selectEcf0301List", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcf0301RsList(Sb1000mVO sessionVO) throws Exception {
		return (List<EgovMap>) list("Ecf0301DAO.selectEcf0301RsList", sessionVO);
	}
	
}
