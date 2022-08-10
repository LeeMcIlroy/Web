package lcms.cmm;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.AttachVO;
import lcms.valueObject.LogVO;

@Repository
public class CmmDAO extends EgovAbstractDAO {
	
	// 첨부파일 등록
	public void insertAttachFile(AttachVO attachVO) throws Exception {
		insert("CmmDAO.insertAttachFile", attachVO);
	}

	// 첨부파일 조회
	public AttachVO selectAttachOne(String fileId) throws Exception {
		return (AttachVO) select("CmmDAO.selectAttachOne", fileId);
	}
	
	// 첨부파일 리스트 조회
	@SuppressWarnings("unchecked")
	public List<AttachVO> selectAttachList(EgovMap map) throws Exception {
		return (List<AttachVO>) list("CmmDAO.selectAttachList", map);
	}
    
	// 게시판 첨부파일 개수
	public int selectAttachListCnt(String boardSeq) throws Exception {
		int totalRecordCount  = (int) select("CmmDAO.selectAttachListCnt", boardSeq);
		return totalRecordCount;
	}
	// 첨부파일 삭제
	public void deleteAttachFile(String attachSeq) throws Exception {
		delete("CmmDAO.deleteAttachFile", attachSeq);
	}
	
	// 연도 목록
	@SuppressWarnings("unchecked")
	public List<String> selectYearList() throws Exception{
		return (List<String>) list("CmmDAO.selectYearList");
	}
	
	// 학기 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectSemeList(String year) throws Exception{
		return (List<EgovMap>) list("CmmDAO.selectSemeList", year);
	}

	// 교육과정 목록
	@SuppressWarnings("unchecked")
	public List<String> selectCurrList() throws Exception{
		return (List<String>) list("CmmDAO.selectCurrList");
	}
	
	// 개설 학기 조회
	public EgovMap selectOpenSeme() throws Exception{
		return (EgovMap) select("CmmDAO.selectOpenSeme");
	}

	// 신청 학기 조회
	public EgovMap selectRegiSeme() throws Exception{
		return (EgovMap) select("CmmDAO.selectRegiSeme");
	}

	// 학기 조회
	public EgovMap selectLectSeme(String lectSeq) throws Exception{
		return (EgovMap) select("CmmDAO.selectLectSeme", lectSeq);
	}

	// 로그 등록
	public void insertAdmLog(LogVO logVO) throws Exception{
		insert("CmmDAO.insertAdmLog", logVO);
	}

	// 수업만족도 항목 조사유형 리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectQuesPhrList() throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectQuesPhrList");
	}

	// 학생 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStdList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectStdList", paramMap);
	}

	// 강의 강사 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectProfList(String lectSeq) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectProfList", lectSeq);
	}

	// 업무담당자 학생 목록 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStdList(String searchWord) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectAdmStdList", searchWord);
	}

	// 국적 목록
	@SuppressWarnings("unchecked")
	public List<String> selectNationList() throws Exception {
		return (List<String>) list("CmmDAO.selectNationList");
	}

	// 국적 등록
	public void insertCode(EgovMap map) throws Exception {
		insert("CmmDAO.insertCode", map);
	}

	//코드목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> cName(String purpose) throws Exception {
		return (List<EgovMap>) list("CmmDAO.codeList", purpose);
	}
	// 분반 등록
	public void insertDivi(String name) throws Exception {
		insert("CmmDAO.insertDivi", name);
	}
	/*2022-04-15 추가*/
	// 강의실 등록(공통코드로 관리)로변경
	public void insertClass(String name) throws Exception {
		insert("CmmDAO.insertClass", name);
	}
	
	// 급수 구하기
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectGradeList(String seme) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectGradeList", seme);
	}
	
	// 분반 구하기
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectDiviList(String grade) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectDiviList", grade);
	}

	// 프로그램 목록
	@SuppressWarnings("unchecked")
	public List<String> selectProgList() throws Exception {
		return (List<String>) list("CmmDAO.selectProgList");
	}

	@SuppressWarnings("unchecked")
	public List<String> selectCourList(String searchCondition4) throws Exception {
		return (List<String>) list("CmmDAO.selectCourList", searchCondition4);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCodeList(String purpose) throws Exception {
		return (List<EgovMap>) list("CmmDAO.codeList", purpose);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLectTimeList(String lectSeq) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectLectTimeList", lectSeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectTimeList(EgovMap lectSeme) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectTimeList", lectSeme);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAttendPopList(String lectSeq) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectAdmAttendPopList", lectSeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAttPopMemberList(String lectSeq) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectAdmAttPopMemberList", lectSeq);
	}

	public EgovMap selectAdmLecture(String lectSeq) throws Exception {
		return (EgovMap) select("CmmDAO.selectAdmLecture", lectSeq);
	}

	public EgovMap selectMeetLogPop(EgovMap paramMap) throws Exception {
		return (EgovMap) select("CmmDAO.selectMeetLogPop", paramMap);
	}

	public EgovMap selectMeetWeekPop(EgovMap meetLogMap) throws Exception {
		return (EgovMap) select("CmmDAO.selectMeetWeekPop", meetLogMap);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectMeetProfList(String meetSeq) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectMeetProfList", meetSeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectGradeLectList(EgovMap meetLogMap) throws Exception {
		return (List<EgovMap>) list("CmmDAO.selectGradeLectList", meetLogMap);
	}
	
	public void insertLoginLog(EgovMap map) throws Exception {
		insert("CmmDAO.insertLoginLog", map);
	}
}
