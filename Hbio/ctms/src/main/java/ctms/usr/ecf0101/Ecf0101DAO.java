package ctms.usr.ecf0101;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ecf0101DAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcf0101List(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecf0101DAO.selectEcf0101List", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcf0101RsList(Sb1000mVO sessionVO) throws Exception {
		return (List<EgovMap>) list("Ecf0101DAO.selectEcf0101RsList", sessionVO);
	}
	
}
