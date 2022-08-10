package lcms.usr.lec.result;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.GradeVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecResultDAO extends EgovAbstractDAO {

	// 강사 성적 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO LecResultList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("LecResultDAO.LecResultListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecResultDAO.LecResultList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 강사 성적 조회
	public GradeVO selectLecResultView(GradeVO gradeVO) throws Exception {
		return (GradeVO) select("LecResultDAO.selectLecResultView", gradeVO);
	}

	// 강사 성적 등록
	public void insertLecResult(GradeVO gradeVO) throws Exception {
		insert("LecResultDAO.insertLecResult", gradeVO);
	}

	// 강사 성적 수정
	public void updateLecResult(GradeVO gradeVO) throws Exception {
		update("LecResultDAO.updateLecResult", gradeVO);
	}

	// 강사 성적 조회 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecResultViewList(GradeVO gradeVO) throws Exception {
		return (List<EgovMap>) list("LecResultDAO.selectLecResultViewList", gradeVO);
	}

	public String selectLecGradeYn(String selLectCode) throws Exception {
		return (String) select("LecResultDAO.selectLecGradeYn", selLectCode);
	}

	public void updateLecGradeYn(EgovMap map) throws Exception {
		update("LecResultDAO.updateLecGradeYn", map);
	}

}
