package lcms.usr.lec.clss;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.ClstmVO;
import lcms.valueObject.EnterVO;
import lcms.valueObject.LectureTimeTableVO;
import lcms.valueObject.SyllaWeekVO;
import lcms.valueObject.SyllabusVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecSyllabusDAO extends EgovAbstractDAO {

	//강의계획서조회
	public SyllabusVO selectLecSyll(String clssSeq) throws Exception {
		return (SyllabusVO)select("LecSyllabusDAO.selectLecSyll", clssSeq); 
	}
	//강의계획서 업로드 파일 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecSyllaFiles(String syllaSeq) throws Exception {
		return (List<EgovMap>)list("LecSyllabusDAO.selectLecSyllaFiles", syllaSeq); 
	}
	/*//강의계획서 주차별계획 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecSyllaWeek(String syllaweekSeq) throws Exception {
		return (List<EgovMap>)list("LecSyllabusDAO.selectLecSyllaWeek", syllaweekSeq); 
	}
	// 주차별 계획 등록
	@SuppressWarnings("unchecked")
	public List<EgovMap> insertlecWeek(SyllabusVO syllabusVO) throws Exception{
		return(List<EgovMap>)insert("LecSyllabusDAO.insertlecWeek", syllabusVO);
	}
	// 주차별 계획 수정
	public void updatelecWeek(SyllabusVO paramVO) throws Exception{
		update("LecSyllabusDAO.updatelecWeek", paramVO);
	}*/
	
	// 강사 - 수업 - 강의계획서 등록
	public String insertlecSyll(SyllabusVO syllabusVO) throws Exception {
		return (String) insert("LecSyllabusDAO.insertlecSyll", syllabusVO); 
	}
	// 강사 - 수업 - 강의계획서 수정
	public void updatelecSyll(SyllabusVO syllabusVO) throws Exception {
		update("LecSyllabusDAO.updatelecSyll", syllabusVO); 
	}

	// 강사 - 수업 - 강의계획서 등록
	public void insertlecWeekOne(SyllabusVO paramVO) throws Exception {
		insert("LecSyllabusDAO.insertlecWeekOne", paramVO); 
	}
	

	// 교육과정  > 강의개설 수업시간 선택
	@SuppressWarnings("unchecked")
	public List<LectureTimeTableVO> selectLectTimetables(String lectSeq) throws Exception  {
		return (List<LectureTimeTableVO>) list("LecSyllabusDAO.selectLectTimetables",lectSeq);
	}
	



}
