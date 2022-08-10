package lcms.usr.std.lecRoom;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class StdLecResultDAO extends EgovAbstractDAO {

	// 학생 출결 조회
	public EgovMap selectAttendView(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("StdLecResultDAO.selectAttendView", searchVO);
	}

	// 학생 성적 조회
	public EgovMap selectGradeView(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("StdLecResultDAO.selectGradeView", searchVO);
	}

}
