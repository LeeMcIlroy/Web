package lcms.usr.std.myPage;

import java.util.List;

import lcms.valueObject.LectureTimeTableVO;
import lcms.valueObject.cmm.CmmnSearchVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class StdScheduleDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardList(String boardType) {
		return (List<EgovMap>)list("LoginDAO.selectBoardList", boardType);
	}
    
	//  개설된 과목 표시 리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> stdLectView(CmmnSearchVO searchVO) {
		List<EgovMap> resultList = (List<EgovMap>) list("StdScheduleDAO.stdLectView", searchVO);		
		return  resultList;
	}
    
	@SuppressWarnings("unchecked")
	public List<EgovMap> stdLectCodeList(EgovMap map) {
		List<EgovMap> resultList = (List<EgovMap>) list("StdScheduleDAO.stdLectCodeList", map);		
		return  resultList;
	}
	
	// 교육과정  > 강의개설 수업시간 선택
	@SuppressWarnings("unchecked")
	public List<LectureTimeTableVO> selectStdLectTimetables(EgovMap map) throws Exception  {
		return (List<LectureTimeTableVO>) list("StdScheduleDAO.selectStdLectTimetables",map);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStdLectSeq(EgovMap map) {
		return (List<EgovMap>) list("StdScheduleDAO.selectStdLectSeq", map);		
	
	}

	
	/*@SuppressWarnings("unchecked")
	public List<EgovMap> stdLectSeme() {
		List<EgovMap> resultSeme = (List<EgovMap>) list("StdScheduleDAO.stdLectSeme");
		return resultSeme;
	}
*/
	

}
