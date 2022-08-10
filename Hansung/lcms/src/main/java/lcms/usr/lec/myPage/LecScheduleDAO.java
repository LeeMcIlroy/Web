package lcms.usr.lec.myPage;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecScheduleDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> SemeYearList(CmmnSearchVO searchVO) {
		List<EgovMap> resultList = (List<EgovMap>) list("LecScheduleDAO.SemeYearList", searchVO);		
		return resultList;
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> SemeList(CmmnSearchVO searchVO) {
		List<EgovMap> resultList = (List<EgovMap>) list("LecScheduleDAO.SemeList", searchVO);		
		return resultList;
	}
	
	// ***** 20200321  교사. 마이페이지. 강의시간표 리스트 *****
	@SuppressWarnings("unchecked")
	public CmmnListVO LectList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("LecScheduleDAO.LectListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecScheduleDAO.LectList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 교육과정 > 강의개설 리스트 > 년도/학기
	@SuppressWarnings("unchecked")
	public CmmnListVO LectSeme(String sem_code) {
		List<EgovMap> LectSeme = (List<EgovMap>) list("LecScheduleDAO.LectSeme", sem_code);
		return new CmmnListVO(0, LectSeme);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectScheList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("LecScheduleDAO.selectScheList", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectClssRoomList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("LecScheduleDAO.selectClssRoomList", searchVO);
	}

}
