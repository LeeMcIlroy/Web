package writer.adm.lec;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.AdminVO;
import writer.valueObject.ClsNoticeVO;
import writer.valueObject.HomeworkVO;
import writer.valueObject.SubjectVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmLecDAO extends EgovAbstractDAO {
	
	/************************************************** 주제 **************************************************/
	
	
	// 조회_주제목록 (반_교수 선택)
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecSubjectList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmLecDAO.selectLecSubjectListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmLecDAO.selectLecSubjectList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 주제 첨부파일 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecSbjtUpfileList(String sbjtSeq){
		return (List<EgovMap>) list("AdmLecDAO.selectLecSbjtUpfileList", sbjtSeq);
	}
	
	// 주제 조회
	public SubjectVO selectLecSubjectOne(String sbjtSeq){
		return (SubjectVO) select("AdmLecDAO.selectLecSubjectOne", sbjtSeq);
	}
	
	// 주제 첨부파일 조회
	public EgovMap selectLecSbjtUpfileOne(String upSeq){
		return (EgovMap) select("AdmLecDAO.selectLecSbjtUpfileOne", upSeq);
	}

	// 주제 등록
	public String lecSubjectInsert(SubjectVO subjectVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		subjectVO.setRegId(adminVO.getMemCode());
		subjectVO.setRegName(adminVO.getMemName());
		
		return (String) insert("AdmLecDAO.lecSubjectInsert", subjectVO);
	}
	
	// 주제 첨부파일 등록
	public void lecSubjectUpfileInsert(FileInfoVO fileInfoVO, String sbjtSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("sbjtSeq", sbjtSeq);
		
		
		insert("AdmLecDAO.lecSubjectUpfileInsert", map);
	}
	
	// 주제 수정
	public void lecSubjectUpdate(SubjectVO subjectVO){
		update("AdmLecDAO.lecSubjectUpdate", subjectVO);
	}
	
	// 주제 삭제
	public void lecSubjectDelete(String sbjtSeq){
		delete("AdmLecDAO.lecSubjectDelete", sbjtSeq);
	}
	
	// 주제 첨부파일 삭제
	public void lecSbjtUpfileDelete(List<String> upSeqList){
		delete("AdmLecDAO.lecSbjtUpfileDelete", upSeqList);
	}
	

	/************************************************** 과제 **************************************************/
	// 과제 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecHomeworkList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmLecDAO.selectLecHomeworkListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmLecDAO.selectLecHomeworkList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 과제 첨부파일 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecHomeworkUpfileList(String hmwkSeq){
		return (List<EgovMap>) list("AdmLecDAO.selectLecHomeworkUpfileList", hmwkSeq);
	}

	// 과제 조회
	public HomeworkVO selectLecHomeworkOne(String hmwkSeq, CmmnSearchVO searchVO){
		Map<String, Object> map = new HashMap<>();
		map.put("hmwkSeq", hmwkSeq);
		map.put("searchVO", searchVO);
		return (HomeworkVO) select("AdmLecDAO.selectLecHomeworkOne", map);
	}
	
	// 과제 첨부파일 조회
	public EgovMap selectLecHomeworkUpfileOne(String upSeq){
		return (EgovMap) select("AdmLecDAO.selectLecHomeworkUpfileOne", upSeq);
	}
	
	// 과제 첨부파일 등록
	public void lecHomeworkUpfileInsert(FileInfoVO fileInfoVO, String hmwkSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("hmwkSeq", hmwkSeq);
		insert("AdmLecDAO.lecHomeworkUpfileInsert", map);
	}

	// 과제 수정(첨삭지도)
	public void lecHomeworkUpdate(HomeworkVO homeworkVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		homeworkVO.setHmwkUpdtId(adminVO.getMemCode());
		homeworkVO.setHmwkUpdtName(adminVO.getMemName());
		
		update("AdmLecDAO.lecHomeworkUpdate", homeworkVO);
	}
	
	// 과제 상태 변경(첨삭진행중 > 첨삭완료)
	public void lecHomeworkStatusUpdate(String sbjtSeq){
		update("AdmLecDAO.lecHomeworkStatusUpdate", sbjtSeq);
	}
	
	// 과제 첨부파일 삭제
	public void lecHomeworkUpFileDelete(List<String> upSeqList){
		delete("AdmLecDAO.lecHomeworkUpFileDelete", upSeqList);
	}
	
	
	/************************************************** 우리반게시판 **************************************************/
	// 우리반게시판 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecBoardList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmLecDAO.selectLecBoardListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmLecDAO.selectLecBoardList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 우리반게시판 첨부파일 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecBoardUpfileList(String ntSeq){
		return (List<EgovMap>) list("AdmLecDAO.selectLecBoardUpfileList", ntSeq);
	}
	
	// 우리반게시판 조회
	public ClsNoticeVO selectLecBoardOne(String ntSeq){
		return (ClsNoticeVO) select("AdmLecDAO.selectLecBoardOne", ntSeq);
	}
	
	// 우리반게시판 첨부파일 조회
	public EgovMap selectLecBoardUpfileOne(String upSeq){
		return (EgovMap) select("AdmLecDAO.selectLecBoardUpfileOne", upSeq);
	}

	// 우리반게시판 등록
	public String lecBoardInsert(ClsNoticeVO clsNoticeVO) {
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		clsNoticeVO.setRegId(adminVO.getMemCode());
		clsNoticeVO.setRegName(adminVO.getMemName());
		
		return (String) insert("AdmLecDAO.lecBoardInsert", clsNoticeVO);
	}
	
	// 우리반게시판 첨부파일 등록
	public void lecBoardUpfileInsert(FileInfoVO fileInfoVO, String ntSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("ntSeq", ntSeq);
		insert("AdmLecDAO.lecBoardUpfileInsert", map);
	}

	// 우리반게시판 수정
	public void lecBoardUpdate(ClsNoticeVO clsNoticeVO) {
		update("AdmLecDAO.lecBoardUpdate", clsNoticeVO);
	}
	
	// 우리반게시판 삭제
	public void lecBoardDelete(String ntSeq) {
		delete("AdmLecDAO.lecBoardDelete", ntSeq);
	}
	
	// 우리반게시판 첨부파일 삭제
	public void lecBoardUpfileDelete(List<String> upSeqList){
		delete("AdmLecDAO.lecBoardUpfileDelete", upSeqList);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecHomeworkZipList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmLecDAO.selectLecHomeworkZipList", searchVO);
	}
}
