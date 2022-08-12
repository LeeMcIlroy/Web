package ctms.usr.ecf0401;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ecf0401DAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEcf0401List(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ecf0401DAO.selectEcf0401List", searchVO);
	}

	public Sb1000mVO selectEcf0401RsiCode(EgovMap map) throws Exception {
		return (Sb1000mVO) select("Ecf0401DAO.selectEcf0401RsiCode", map);
	}

	public Rs1000mVO selectEcf0401RsView(Rs1000mVO rs1000mVO) throws Exception {
		return (Rs1000mVO) select("Ecf0401DAO.selectEcf0401RsView", rs1000mVO);
	}

	public void insertEcf0401Sub(Rs2000mVO rs2000mVO) throws Exception {
		insert("Ecf0401DAO.insertEcf0401Sub", rs2000mVO);
	}
	
}
