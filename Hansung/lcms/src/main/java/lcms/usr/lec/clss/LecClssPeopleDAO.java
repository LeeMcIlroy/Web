package lcms.usr.lec.clss;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.MemberVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecClssPeopleDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecClssPeopleList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("LecClssPeopleDAO.selectLecClssPeopleListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecClssPeopleDAO.selectLecClssPeopleList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecClssPeoplePrtList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("LecClssPeopleDAO.selectLecClssPeopleListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecClssPeopleDAO.selectLecClssPeoplePrtList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectPopWrnList(CmmnSearchVO searchVO) throws Exception {
		List<EgovMap> resultList = (List<EgovMap>) list("LecClssPeopleDAO.selectPopWrnList", searchVO);		
		return new CmmnListVO(0, resultList);
	}
	
	//교사 수업>수강인원>학생상세보기
	public MemberVO selectLecClssPeopleView(String memberSeq) throws Exception  {
		return (MemberVO) select("LecClssPeopleDAO.selectLecClssPeopleView", memberSeq);
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStudLectList(MemberVO memberVO) throws Exception {
		return (List<EgovMap>) list("LecClssPeopleDAO.selectStudLectList", memberVO);
	}
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStudRegiList(MemberVO memberVO) throws Exception {
		return (List<EgovMap>) list("LecClssPeopleDAO.selectStudRegiList", memberVO);
	}
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectGradeList(MemberVO memberVO) throws Exception {
		return (List<EgovMap>) list("LecClssPeopleDAO.selectGradeList", memberVO);
	}
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStudConsulList(MemberVO memberVO) throws Exception {
		return (List<EgovMap>) list("LecClssPeopleDAO.selectStudConsulList", memberVO);
	}
}
