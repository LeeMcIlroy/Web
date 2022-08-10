package lcms.usr.std.lecRoom;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.LectureTimeTableVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.SyllabusVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class StdSyllabusDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardList(String boardType) {
		return (List<EgovMap>)list("LoginDAO.selectBoardList", boardType);
	}
	
	// 강의계획서 조회
	public SyllabusVO stdSelectLecSyll(String clssSeq) throws Exception {
		return (SyllabusVO)select("StdSyllabusDAO.stdSelectLecSyll", clssSeq); 
	}

	//강의계획서 업로드 파일 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> stdSelectSyllaFiles(String syllaSeq){
		return (List<EgovMap>)list("StdSyllabusDAO.stdSelectSyllaFiles", syllaSeq);
	}
	
	/*//강의계획서 주차별 계획 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> stdSelectSyllaWeek(String syllaweekSeq) throws Exception{
		return (List<EgovMap>)list("StdSyllabusDAO.stdSelectSyllaWeek", syllaweekSeq);
	}*/

	// 학생 강의계획서 시간표 조회
	@SuppressWarnings("unchecked")
	public List<LectureTimeTableVO> selectLectTimetables(String lectSeq) throws Exception  {
		return (List<LectureTimeTableVO>) list("StdSyllabusDAO.selectLectTimetables",lectSeq);
	}
	
	
	public MemberVO selectProf(String memberSeq) throws Exception {
		return (MemberVO)select("StdSyllabusDAO.selectProf", memberSeq); 
	}


}
