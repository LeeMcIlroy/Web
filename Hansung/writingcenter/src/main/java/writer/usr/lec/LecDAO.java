package writer.usr.lec;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.ClassVO;
import writer.valueObject.ClsNoticeVO;
import writer.valueObject.HomeworkVO;
import writer.valueObject.SubjectVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class LecDAO extends EgovAbstractDAO {

	/************************************************** 반_교수 **************************************************/
	// 나의 강의실 목록
	@SuppressWarnings("unchecked")
	public List<ClassVO> selectMyLecClassList(CmmnSearchVO searchVO){
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, Object> map = new HashMap<>();
		map.put("searchVO", searchVO);
		map.put("userVO", userVO);
		return (List<ClassVO>) list("LecDAO.selectMyLecClassList", map);
	}
	
	// 반_교수 조회
	public ClassVO selectLecClassOne(String clsSeq){
		return (ClassVO) select("LecDAO.selectLecClassOne", clsSeq);
	}
	
	// 나의 강의실 조회
	public EgovMap selectMyLecClassOne(String clsSeq, String memCode){
		Map<String, String> map = new HashMap<>();
		map.put("memCode", memCode);
		map.put("clsSeq", clsSeq);
		return (EgovMap) select("LecDAO.selectMyLecClassOne", map);
	}
	// 나의 강의실 insert
	public void myLecClassInsert(String clsSeq){
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, String> map = new HashMap<>();
		map.put("memCode", userVO.get("memCode"));
		map.put("clsSeq", clsSeq);
		insert("LecDAO.myLecClassInsert", map);
	}
	
	// 나의 강의실 delete
	public void myLecClassDelete(String mySeq){
		delete("LecDAO.myLecClassDelete", mySeq);
	}
	
	/************************************************** 주제 **************************************************/
	// 조회_주제목록 (반_교수 선택)
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecSubjectList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("LecDAO.selectLecSubjectListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecDAO.selectLecSubjectList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 주제 조회
	public SubjectVO selectLecSubjectOne(String sbjtSeq){
		return (SubjectVO) select("LecDAO.selectLecSubjectOne", sbjtSeq);
	}

	// 주제 첨부파일 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecSbjtUpfileList(String sbjtSeq){
		return (List<EgovMap>) list("LecDAO.selectLecSbjtUpfileList", sbjtSeq);
	}
	
	/************************************************** 과제 **************************************************/
	// 과제 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecHomeworkList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("LecDAO.selectLecHomeworkListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecDAO.selectLecHomeworkList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 과제 첨부파일 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecHomeworkUpfileList(String hmwkSeq){
		return (List<EgovMap>) list("LecDAO.selectLecHomeworkUpfileList", hmwkSeq);
	}

	// 과제 조회
	public HomeworkVO selectLecHomeworkOne(String hmwkSeq){
		// 조회수 update
		update("LecDAO.lecHomeworkHitcountUpdate", hmwkSeq);
		return (HomeworkVO) select("LecDAO.selectLecHomeworkOne", hmwkSeq);
	}
	
	// 과제 첨부파일 조회
	public EgovMap selectLecHomeworkUpfileOne(String upSeq){
		return (EgovMap) select("LecDAO.selectLecHomeworkUpfileOne", upSeq);
	}
	
	// 과제 등록
	public String lecHomeworkInsert(HomeworkVO homeworkVO){
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		homeworkVO.setHmwkRegId(userVO.get("memCode"));
		homeworkVO.setHmwkRegName(userVO.get("memName"));
		return (String) insert("LecDAO.lecHomeworkInsert", homeworkVO);
	}
	
	// 과제 첨부파일 등록
	public void lecHomeworkUpfileInsert(FileInfoVO fileInfoVO, String hmwkSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("hmwkSeq", hmwkSeq);
		insert("LecDAO.lecHomeworkUpfileInsert", map);
	}

	// 과제 수정
	public void lecHomeworkUpdate(HomeworkVO homeworkVO){
		update("LecDAO.lecHomeworkUpdate", homeworkVO);
	}
	
	// 과제 첨삭완료확인 update
	public void lecHomeworkStatusUpdate(String hmwkSeq){
		update("LecDAO.lecHomeworkStatusUpdate", hmwkSeq);
	}
	
	// 과제 삭제
	public void lecHomeworkDelete(String hmwkSeq){
		delete("LecDAO.lecHomeworkDelete", hmwkSeq);
	}
	
	// 과제 첨부파일들 삭제
	public void lecHomeworkUpFilesDelete(List<String> upSeqList){
		delete("LecDAO.lecHomeworkUpFilesDelete", upSeqList);
	}
	
	// 과제 첨부파일 삭제
	public void lecHomeworkUpFileDelete(String upSeq){
		delete("LecDAO.lecHomeworkUpFileDelete", upSeq);
	}
	
	/************************************************** 우리반게시판 **************************************************/
	// 우리반게시판 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecBoardList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("LecDAO.selectLecBoardListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecDAO.selectLecBoardList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 우리반게시판 첨부파일 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecBoardUpfileList(String ntSeq){
		return (List<EgovMap>) list("LecDAO.selectLecBoardUpfileList", ntSeq);
	}
	
	// 우리반게시판 조회
	public ClsNoticeVO selectLecBoardOne(String ntSeq){
		// 조회수 update
		update("LecDAO.lecBoardHitcountUpdate", ntSeq);
		return (ClsNoticeVO) select("LecDAO.selectLecBoardOne", ntSeq);
	}
	
	// 우리반게시판 첨부파일 조회
	public EgovMap selectLecBoardUpfileOne(String upSeq){
		return (EgovMap) select("LecDAO.selectLecBoardUpfileOne", upSeq);
	}

	// 우리반게시판 등록
	public String lecBoardInsert(ClsNoticeVO clsNoticeVO){
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		clsNoticeVO.setRegId(userVO.get("memCode"));
		clsNoticeVO.setRegName(userVO.get("memName"));
		return (String) insert("LecDAO.lecBoardInsert", clsNoticeVO);
	}
	
	// 우리반게시판 첨부파일 등록
	public void lecBoardUpfileInsert(FileInfoVO fileInfoVO, String ntSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("ntSeq", ntSeq);
		insert("LecDAO.lecBoardUpfileInsert", map);
	}

	// 우리반게시판 수정
	public void lecBoardUpdate(ClsNoticeVO clsNoticeVO){
		update("LecDAO.lecBoardUpdate", clsNoticeVO);
	}
	
	// 우리반게시판 삭제
	public void lecBoardDelete(String ntSeq){
		delete("LecDAO.lecBoardDelete", ntSeq);
	}
	
	// 우리반게시판 첨부파일들 삭제
	public void lecBoardUpfilesDelete(List<String> upSeqList){
		delete("LecDAO.lecBoardUpfilesDelete", upSeqList);
	}
	
	// 우리반게시판 첨부파일 삭제
	public void lecBoardUpfileDelete(String upSeq){
		delete("LecDAO.lecBoardUpfileDelete", upSeq);
	}
}
