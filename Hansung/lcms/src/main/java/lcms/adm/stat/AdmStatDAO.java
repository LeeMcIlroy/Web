package lcms.adm.stat;


import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmStatDAO extends EgovAbstractDAO {

	// 국적별 수강생 인원
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmNatiStatList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmStatDAO.selectAdmNatiStatList", searchVO);
	}

	// 성별별 수강생 인원
	public EgovMap selectAdmNatiStatTot(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("AdmStatDAO.selectAdmNatiStatTot", searchVO);
	}

	// 학생구분별 수강생 인원
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStdStatList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmStatDAO.selectAdmStdStatList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmComplStatList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmStatDAO.selectAdmComplStatList", searchVO);
	}
	
}
