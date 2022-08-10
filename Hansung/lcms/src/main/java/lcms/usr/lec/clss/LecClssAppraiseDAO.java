package lcms.usr.lec.clss;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.EvalVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecClssAppraiseDAO extends EgovAbstractDAO {

	// 교사 수업 학생평가 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecClssAppraiseList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("LecClssAppraiseDAO.selectLecClssAppraiseList", searchVO);
	}

	// 교사 수업 학생평가 목록
	public EgovMap selectLecClssAppraiseStat(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("LecClssAppraiseDAO.selectLecClssAppraiseStat", searchVO);
	}
	
	// 교사 수업 학생평가 조회
	public EvalVO selectLecClssAppraiseView(String evalSeq) throws Exception {
		return (EvalVO) select("LecClssAppraiseDAO.selectLecClssAppraiseView", evalSeq);
	}

	// 교사 수업 학생평가 등록
	public void insertLecClssAppraise(EvalVO evalVO) throws Exception {
		insert("LecClssAppraiseDAO.insertLecClssAppraise", evalVO);
	}

	// 교사 수업 학생평가 수정
	public void updateLecClssAppraise(EvalVO evalVO) throws Exception {
		update("LecClssAppraiseDAO.updateLecClssAppraise", evalVO);
	}

	public EvalVO selectLecClssAppraiseOne(String evalSeq) throws Exception {
		return (EvalVO) select("LecClssAppraiseDAO.selectLecClssAppraiseOne", evalSeq);
	}

	// 교사 수업 학생평가 학생정보 조회
	public EvalVO selectLecClssMember(String memberCode) throws Exception {
		return (EvalVO) select("LecClssAppraiseDAO.selectLecClssMember", memberCode);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> lecClssAppraisePop(EgovMap map) throws Exception {
		return (List<EgovMap>) list("LecClssAppraiseDAO.lecClssAppraisePop", map);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> lecClssAppraisePre(String selLectCode) throws Exception {
		return (List<EgovMap>) list("LecClssAppraiseDAO.lecClssAppraisePre", selLectCode);
	}

}
