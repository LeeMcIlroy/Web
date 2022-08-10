package hsDesign.adm.majorBoard.teacher;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.TeacherVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmMajorBoardTeacherDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmTeacherList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmMajorBoardTeacherDAO.selectAdmTeacherListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmMajorBoardTeacherDAO.selectAdmTeacherList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 조회
	public TeacherVO selectAdmTeacherOne(String tcSeq) {
		return (TeacherVO) select("AdmMajorBoardTeacherDAO.selectAdmTeacherOne", tcSeq);
	}
	
	// 전공목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectMajorList(){
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectMajorList");
	}
	
	// 교강사 등록
	public String insertTeacherOne(TeacherVO teacherVO) {
		return (String) insert("AdmMajorBoardTeacherDAO.insertTeacherOne", teacherVO);
	}
	
	// 교강사 수정
	public void updateTeacherOne(TeacherVO teacherVO) {
		update("AdmMajorBoardTeacherDAO.updateTeacherOne", teacherVO);
	}
	
	/* 첨부파일 조회 */
	public EgovMap selectTeacherUpfileList(String tcSeq){
		return (EgovMap) select("AdmMajorBoardTeacherDAO.selectTeacherUpfileList", tcSeq);
	}
	
	// 교강사 첨부파일 등록
	public void insertTeacherUpfileOne(Map<String, Object> map) {
		insert("AdmMajorBoardTeacherDAO.insertTeacherUpfileOne", map);
	}
	
	/* 삭제할 첨부파일 조회 */
	public EgovMap selectTeacherUpfileOne(String tcupSeq){
		return (EgovMap) select("AdmMajorBoardTeacherDAO.selectTeacherUpfileOne",tcupSeq);
	}
	
	/* 교강사 첨부파일 삭제 */
	public void deleteTeacherUpfileList(List<String> upSeqList){
		delete("AdmMajorBoardTeacherDAO.deleteTeacherUpfileList", upSeqList);
	}
	
	/* 교강사 삭제*/
	public void deleteAdmTeacherOne(String tcSeq) {
		delete("AdmMajorBoardTeacherDAO.deleteAdmTeacherOne", tcSeq);
	}
	
	
}
