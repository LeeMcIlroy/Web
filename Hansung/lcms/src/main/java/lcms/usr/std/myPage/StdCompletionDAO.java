package lcms.usr.std.myPage;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class StdCompletionDAO extends EgovAbstractDAO {

	// 학생 수료현황 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStdCompletionList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("StdCompletionDAO.selectStdCompletionList", searchVO);
	}

}
