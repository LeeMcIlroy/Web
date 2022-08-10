package lcms.adm.student;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.AttachVO;
import lcms.valueObject.FuncVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmStudentDAO extends EgovAbstractDAO {
	
	//학생 > 학생현황 조회
	public MemberVO selectStudMember(String memberSeq) throws Exception{
		return (MemberVO) select("AdmStudentDAO.selectStudMember", memberSeq);
	}
	
	//학생 > 학생현황 수정
	public void updateStudent(MemberVO memberVO) throws Exception{
		update("AdmStudentDAO.updateStudent", memberVO);
	}
	
	//학생 > 학생현황 등록
	public String insertStudent(MemberVO memberVO)  throws Exception {
		return (String)insert("AdmStudentDAO.insertStudent",memberVO);
	}
	
	//학생 > 학생현황 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO StudList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmStudentDAO.StudListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmStudentDAO.StudList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	
	//학번중복확인
	public int selectAdmAjaxStudCheck(String memberCode) {
		return (int) select("AdmStudentDAO.selectAdmAjaxStudCheck", memberCode);
	}
	
	//학생삭제
	public void deleteStudent(String memberSeq) {
		delete("AdmStudentDAO.deleteStudent", memberSeq); 
	}
	
	//비밀번호 초기화
	public void updateAdmAjaxStudClearPw(MemberVO memberVO) {
		update("AdmStudentDAO.updateAdmAjaxStudClearPw", memberVO);		
	}
	
	//학번구할때 cnt
	public String selectAdmMemTotCnt(MemberVO memberVO) {
		return (String) select("AdmStudentDAO.selectAdmMemTotCnt", memberVO);
	}	

	// 학생현황 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStatusExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmStudentDAO.selectAdmStatusExcel", searchVO);
	}	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//학생 > 학적변동 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO FuncList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmStudentDAO.FuncListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmStudentDAO.FuncList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//학생 > 학적변동 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO FuncList2(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("AdmStudentDAO.FuncList2Cnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmStudentDAO.FuncList2", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//학생 > 학적변동 조회/학생기본사항
	public MemberVO selectMemberOne(String memberSeq) throws Exception{
		return (MemberVO) select("AdmStudentDAO.selectMemberOne", memberSeq);
	}
	
	//학생 > 학적변동 조회/학적변동
	public FuncVO selectFuncList(String funcSeq) throws Exception{
		return (FuncVO) select("AdmStudentDAO.selectFuncList", funcSeq);
	}
	
	//학생 > 학적변동 등록
	public String insertFunc(MemberVO funcVO)  throws Exception {
		return (String)insert("AdmStudentDAO.insertFunc",funcVO);
	}
	
	//학생 > 멤버 학적 수정
	public void updateFuncState(MemberVO memberVO) throws Exception{
		update("AdmStudentDAO.updateFuncState", memberVO);
	}
	
	//학적삭제
	public void deleteFunc(String memberSeq) {
		delete("AdmStudentDAO.deleteFunc", memberSeq); 
	}
	
	//학적파일삭제
	public void deleteFuncFile(String funcSeq) {
		delete("AdmStudentDAO.deleteFuncFile", funcSeq); 
	}
	
	//멤버리스느
	@SuppressWarnings("unchecked")
	public CmmnListVO memberList(CmmnSearchVO searchVO) {
		List<EgovMap> memberList = (List<EgovMap>) list("AdmStudentDAO.memberList", searchVO);
		return new CmmnListVO(0, memberList);
	}
	
	// 첨부파일 리스트 조회
	@SuppressWarnings("unchecked")
	public List<AttachVO> selectAttachList(String boardSeq) throws Exception {
		return (List<AttachVO>) list("AdmStudentDAO.selectAttachList", boardSeq);
	}
	
//	학적 리스트 조회
	@SuppressWarnings("unchecked")	
	public List<FuncVO> selectAdmFuncList(String memberSeq) throws Exception {
		return (List<FuncVO>) list("AdmStudentDAO.selectAdmFuncList", memberSeq);
	}
	
	//학생 > 학적변동 조회/학적변동
	public String funcSeq(String memberSeq) throws Exception{
		return (String) select("AdmStudentDAO.funcSeq", memberSeq);
	}
	
	// 학적변동 학생리스트 검색
	@SuppressWarnings("unchecked")
	public List<EgovMap> admAjaxStudSearch(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmStudentDAO.admAjaxStudSearch", searchVO);
	}
	
	// 학생현황 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmFuncExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmStudentDAO.selectAdmFuncExcel", searchVO);
	}
	
	// 학적변동 학생 마지막 Seq
	public String selectAdmFuncMaxSeq(String memberSeq) throws Exception {
		return (String) select("AdmStudentDAO.selectAdmFuncMaxSeq", memberSeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStudLectList(MemberVO memberVO) throws Exception {
		return (List<EgovMap>) list("AdmStudentDAO.selectStudLectList", memberVO);
	}

	public void updateStudentImg(MemberVO memberVO) throws Exception {
		update("AdmStudentDAO.updateStudentImg", memberVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStudRegiList(MemberVO memberVO) throws Exception {
		return (List<EgovMap>) list("AdmStudentDAO.selectStudRegiList", memberVO);
	}
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectGradeList(MemberVO memberVO) throws Exception {
		return (List<EgovMap>) list("AdmStudentDAO.selectGradeList", memberVO);
	}
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStudConsulList(MemberVO memberVO) throws Exception {
		return (List<EgovMap>) list("AdmStudentDAO.selectStudConsulList", memberVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> clearList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmStudentDAO.clearList", searchVO);
	}

	public void clearUpdate(EgovMap clear) throws Exception {
		update("AdmStudentDAO.clearUpdate", clear);
	}

	public void updateLoginFailClear(String memberCode) throws Exception {
		update("AdmStudentDAO.updateLoginFailClear", memberCode);
	}
}
