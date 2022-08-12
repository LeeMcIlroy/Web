package ctms.adm.ech1002;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech1002DAO  extends EgovAbstractDAO {

	/* SMS팝업관리 ****************************************************************************************************************************************************** */
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch1002SendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech1002DAO.selectEch1002SendList", map);
	
	}
	/* SMS팝업관리 ****************************************************************************************************************************************************** */
	
}
