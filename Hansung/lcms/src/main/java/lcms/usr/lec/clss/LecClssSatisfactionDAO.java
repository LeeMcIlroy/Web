package lcms.usr.lec.clss;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecClssSatisfactionDAO extends EgovAbstractDAO {

	// 교사 수업만족도 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecClssSatisfaction(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("LecClssSatisfactionDAO.selectLecClssSatisfaction", searchVO);
	}

	// 교사 수업만족도 통계 조회
	public EgovMap selectLecClssStatis(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("LecClssSatisfactionDAO.selectLecClssStatis", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecClssSatisfactionView(EgovMap map) throws Exception {
		return (List<EgovMap>) list("LecClssSatisfactionDAO.selectLecClssSatisfactionView", map);
	}
	
	public EgovMap selectSatisView(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("LecClssSatisfactionDAO.selectSatisView", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectSatisScoreList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("LecClssSatisfactionDAO.selectSatisScoreList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectSatisQuesList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("LecClssSatisfactionDAO.selectSatisQuesList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStatisTxtList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("LecClssSatisfactionDAO.selectStatisTxtList", searchVO);
	}

}
