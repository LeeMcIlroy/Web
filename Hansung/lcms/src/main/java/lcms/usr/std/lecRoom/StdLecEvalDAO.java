package lcms.usr.std.lecRoom;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.SurveyAnswVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class StdLecEvalDAO extends EgovAbstractDAO {

	// 학생 수업만족도 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectStdLecEvalList(CmmnSearchVO searchVO) throws Exception {
		int totalCount = (int) select("StdLecEvalDAO.selectStdLecEvalListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("StdLecEvalDAO.selectStdLecEvalList", searchVO);
		return new CmmnListVO(totalCount, resultList);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectProfList(String lectCode) throws Exception {
		return (List<EgovMap>) list("StdLecEvalDAO.selectProfList", lectCode);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLangList(EgovMap semester) throws Exception {
		return (List<EgovMap>) list("StdLecEvalDAO.selectLangList", semester);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStdLecEvalModify(String surveySeq) throws Exception {
		return (List<EgovMap>) list("StdLecEvalDAO.selectStdLecEvalModify", surveySeq);
	}

	public void insertstdLecEval(SurveyAnswVO paramVO) throws Exception {
		insert("StdLecEvalDAO.insertstdLecEval", paramVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStdLecEvalView(EgovMap map) throws Exception {
		return (List<EgovMap>) list("StdLecEvalDAO.selectStdLecEvalView", map);
	}

	public EgovMap selectStdLecEvalSurvey(String surveySeq) throws Exception {
		return (EgovMap) select("StdLecEvalDAO.selectStdLecEvalSurvey", surveySeq);
	}

}
