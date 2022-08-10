package lcms.adm.curr;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.ClstmVO;
import lcms.valueObject.CourVO;
import lcms.valueObject.CurrVO;
import lcms.valueObject.LectureTimeTableVO;
import lcms.valueObject.LectureVO;
import lcms.valueObject.ProgVO;
import lcms.valueObject.SemesterVO;
import lcms.valueObject.SurveyQuesVO;
import lcms.valueObject.SurveyVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmCurrDAO extends EgovAbstractDAO {
	
//	교육과정  > 학기 ************************************************************************************************************************************
	// 교육과정  > 학기 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO SemeList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmCurrDAO.SemeListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCurrDAO.SemeList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 교육과정  > 학기 추가
	public String addSeme(SemesterVO semesterVO) throws Exception {
		return (String) insert("AdmCurrDAO.addSeme", semesterVO);
	}

	// 교육과정  > 학기 수정
	public void editSeme(SemesterVO semesterVO) throws Exception {
		update("AdmCurrDAO.editSeme", semesterVO);
	}
	
	// 교육과정  > 학기 선택
	public EgovMap selectSemeOne(String sem_code) {
		return (EgovMap) select("AdmCurrDAO.selectSemeOne",sem_code);
	}

	// 학기 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmSemeExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmCurrDAO.selectAdmSemeExcel", searchVO);
	}

//	교육과정  > 교육과정 ************************************************************************************************************************************
	// 교육과정  > 교육과정 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO CurrList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmCurrDAO.CurrListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCurrDAO.CurrList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 교육과정  > 교육과정 추가
	public String addCurr(CurrVO currVO) throws Exception {
		return (String) insert("AdmCurrDAO.addCurr", currVO);
	}

	// 교육과정  > 교육과정 수정
	public void editCurr(CurrVO currVO) throws Exception {
		update("AdmCurrDAO.editCurr", currVO);
	}
	
	// 교육과정  > 교육과정 선택
	public EgovMap selectCurrOne(String currSeq) {
		return (EgovMap) select("AdmCurrDAO.selectCurrOne",currSeq);
	}	

//	교육과정  > 프로그램 ************************************************************************************************************************************
	// 교육과정  > 프로그램 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO ProgList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmCurrDAO.ProgListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCurrDAO.ProgList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 교육과정  > 프로그램 추가
	public String addProg(ProgVO progVO) throws Exception {
		return (String) insert("AdmCurrDAO.addProg", progVO);
	}

	// 교육과정  > 프로그램 수정
	public void editProg(ProgVO progVO) throws Exception {
		update("AdmCurrDAO.editProg", progVO);
	}
	
	// 교육과정  > 프로그램 선택
	public EgovMap selectProgOne(String progSeq) {
		return (EgovMap) select("AdmCurrDAO.selectProgOne",progSeq);
	}

//	교육과정  > 수업시간 ************************************************************************************************************************************
	// 교육과정  > 수업시간 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO ClstmList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmCurrDAO.ClstmListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCurrDAO.ClstmList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 교육과정  > 수업시간 추가
	public String addClstm(ClstmVO clstmVO) throws Exception {
		return (String) insert("AdmCurrDAO.addClstm", clstmVO);
	}

	// 교육과정  > 수업시간 수정
	public void editClstm(ClstmVO clstmVO) throws Exception {
		update("AdmCurrDAO.editClstm", clstmVO);
	}
	
	// 교육과정  > 수업시간 선택
	public ClstmVO selectClstmOne(String clstmSeq) {
		return (ClstmVO) select("AdmCurrDAO.selectClstmOne",clstmSeq);
	}

//	교육과정  > 교과목 ************************************************************************************************************************************
	// 교육과정  > 교과목 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO CourList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmCurrDAO.CourListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCurrDAO.CourList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 교육과정  > 교과목 추가
	public String addCour(CourVO courVO) throws Exception {
		return (String) insert("AdmCurrDAO.addCour", courVO);
	}

	// 교육과정  > 교과목 수정
	public void editCour(CourVO courVO) throws Exception {
		update("AdmCurrDAO.editCour", courVO);
	}
	
	// 교육과정  > 교과목 선택
	public EgovMap selectCourOne(String courSeq) {
		return (EgovMap) select("AdmCurrDAO.selectCourOne",courSeq);
	}
//	교육과정  > 강의개설 ************************************************************************************************************************************
	// 교육과정  > 강의개설 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO LectList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmCurrDAO.LectListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCurrDAO.LectList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 교육과정  > 강의개설 추가
	public String addLect(LectureVO lectureVO) throws Exception {
		return (String) insert("AdmCurrDAO.addLect", lectureVO);
	}

	// 교육과정  > 강의개설 수정
	public void editLect(LectureVO lectureVO) throws Exception {
		update("AdmCurrDAO.editLect", lectureVO);
	}
	
	// 교육과정  > 강의개설 선택
	public EgovMap selectLectOne(String lectSeq) throws Exception  {
		return (EgovMap) select("AdmCurrDAO.selectLectOne",lectSeq);
	}

	// 교육과정  > 수업시간 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO LectTimeTableList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmCurrDAO.LectTimeTableListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCurrDAO.LectTimeTableList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 교육과정  > 강의개설 수업시간 추가
	public void addLectTimetable(LectureTimeTableVO lectureTimeTableVO) throws Exception {
		insert("AdmCurrDAO.addLectTimetable", lectureTimeTableVO);
	}

	// 교육과정  > 강의개설 수업시간 수정
	public void editLectTimetable(LectureTimeTableVO lectureTimeTableVO) throws Exception {
		update("AdmCurrDAO.editLectTimetable", lectureTimeTableVO);
	}
	
	// 교육과정  > 강의개설 수업시간 선택
	@SuppressWarnings("unchecked")
	public List<LectureTimeTableVO> selectLectOneTimetables(String lectSeq) throws Exception  {
		return (List<LectureTimeTableVO>) list("AdmCurrDAO.selectLectTimetables",lectSeq);
	}

	// 교육과정 > 강의개설 리스트 > 검색조건3 / 교육과정
	@SuppressWarnings("unchecked")
	public CmmnListVO LectCurr(String currName) {
		List<EgovMap> LectCurr = (List<EgovMap>) list("AdmCurrDAO.LectCurr", currName);	
		return new CmmnListVO(0, LectCurr);
	}		
	// 교육과정 > 강의개설 리스트 > 교과목
	@SuppressWarnings("unchecked")
	public CmmnListVO TimeTable(String timetable) {
		List<EgovMap> TimeTable = (List<EgovMap>) list("AdmCurrDAO.TimeTable", timetable);	
		return new CmmnListVO(0, TimeTable);
	}
	// 교육과정 > 강의개설 리스트 > 교과목
	@SuppressWarnings("unchecked")
	public CmmnListVO LectCour(String courName) {
		List<EgovMap> LectCour = (List<EgovMap>) list("AdmCurrDAO.LectCour", courName);	
		return new CmmnListVO(0, LectCour);
	}
	// 교육과정 > 강의개설 리스트 > 프로그램
	@SuppressWarnings("unchecked")
	public CmmnListVO LectProg(String progName) {
		List<EgovMap> LectProg = (List<EgovMap>) list("AdmCurrDAO.LectProg", progName);
		return new CmmnListVO(0, LectProg);
	}
	// 교육과정 > 강의개설 리스트 > 년도/학기
	@SuppressWarnings("unchecked")
	public CmmnListVO LectSeme(String semCode) {
		List<EgovMap> LectSeme = (List<EgovMap>) list("AdmCurrDAO.LectSeme", semCode);
		return new CmmnListVO(0, LectSeme);
	}
	// 교육과정 > 강의개설 리스트 > 중복체크
	public String chkLect(LectureVO lectureVO) {
		return (String)select("AdmCurrDAO.chkLect",lectureVO);
	}
	// 교육과정 > 강의개설 리스트 > 담임교사
	@SuppressWarnings("unchecked")
	public CmmnListVO TeacherName(String teaName) {
		List<EgovMap> TeacherName = (List<EgovMap>) list("AdmCurrDAO.TeacherName", teaName);
		return new CmmnListVO(0, TeacherName);
	}
//	학기 - 년도에따른 학기
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxSelectBoxLectSem(EgovMap map) {
		return (List<EgovMap>) list("AdmCurrDAO.admAjaxSelectBoxLectSem",map);
	}
	//수업시간 삭제
	public void delLectTimetable(String lectTbSeq) {
		delete("AdmCurrDAO.deleteTimetable", lectTbSeq);			
	}

	// 강의개설 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmLectExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmCurrDAO.selectAdmLectExcel", searchVO);
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 업무담당자 수업만족도항목 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmStatisList(CmmnSearchVO searchVO) throws Exception {
		int totalCount = (int) select("AdmCurrDAO.selectAdmStatisListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCurrDAO.selectAdmStatisList", searchVO);
		return new CmmnListVO(totalCount, resultList);
	}

	// 업무담당자 수업만족도항목 등록
	public String insertAdmSatis(SurveyVO surveyVO) throws Exception {
		return (String) insert("AdmCurrDAO.insertAdmSatis", surveyVO);
	}

	// 업무담당자 수업만족도현황 조사항목 등록
	public void insertAdmSurveyQues(SurveyQuesVO surveyQuesVO) throws Exception {
		insert("AdmCurrDAO.insertAdmSurveyQues", surveyQuesVO);
	}

	// 업무담당자 수업만족도항목 수정
	public void updateAdmSatisUpdate(SurveyVO surveyVO) throws Exception {
		update("AdmCurrDAO.updateAdmSatisUpdate", surveyVO);
	}

	// 업무담당자 수업만족도현황 조사항목 수정
	public void updateAdmSurveyQues(SurveyQuesVO surveyQuesVO) throws Exception {
		update("AdmCurrDAO.updateAdmSurveyQues", surveyQuesVO);
	}

	// 업무담당자 수업만족도현황 조회
	public SurveyVO selectAdmSatisModify(String surveySeq) throws Exception {
		return (SurveyVO) select("AdmCurrDAO.selectAdmSatisModify", surveySeq);
	}

	// 업무담당자 수업만족도현황 조사항목 조회
	@SuppressWarnings("unchecked")
	public List<SurveyQuesVO> selectAdmSurveyQuesList(String surveySeq) throws Exception {
		return (List<SurveyQuesVO>) list("AdmCurrDAO.selectAdmSurveyQuesList", surveySeq);
	}

	public String selectSemeUseYn(String type) throws Exception {
		return (String) select("AdmCurrDAO.selectSemeUseYn", type);
	}
	

}
