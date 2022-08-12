package ctms.adm.ech1005;

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
public class Ech1005DAO  extends EgovAbstractDAO {

	/* 팝업 ****************************************************************************************************************************************************** */
	
	// 구성원 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch1005StaffList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech1005DAO.selectEch1005StaffList", map);
	}
		
	// 고객사 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch1005VendorList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech1005DAO.selectEch1005VendorList", map);
	}
	
	// 견적 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch1005OpList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech1005DAO.selectEch1005OpList", map);
	}
	
	// 계약 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch1005CtrtList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech1005DAO.selectEch1005CtrtList", map);
	}
	
	// 연구 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch1005RsList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech1005DAO.selectEch1005RsList", map);
	}
	
	/* 팝업 ****************************************************************************************************************************************************** */
	
}
