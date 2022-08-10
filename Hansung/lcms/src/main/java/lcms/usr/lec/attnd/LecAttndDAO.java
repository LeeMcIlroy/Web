package lcms.usr.lec.attnd;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.AttendVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecAttndDAO extends EgovAbstractDAO {

	// 교사 출결 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecAttndList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("LecAttndDAO.selectLecAttndListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecAttndDAO.selectLecAttndList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 교사 출결 수업시간 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLectTime(EgovMap lecSession) throws Exception {
		return (List<EgovMap>) list("LecAttndDAO.selectLectTime", lecSession);
	}

	// 교사 출결 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecAttndMemberView(EgovMap lecSession) throws Exception {
		return (List<EgovMap>) list("LecAttndDAO.selectLecAttndMemberView", lecSession);
	}

	// 교사 출결 수정
	public void updateLecAttnd(AttendVO resultVO) throws Exception {
		update("LecAttndDAO.updateLecAttnd", resultVO);
	}

	public void insertLecAttnd(AttendVO resultVO) throws Exception {
		insert("LecAttndDAO.insertLecAttnd", resultVO);
	}

	@SuppressWarnings("unchecked")
	public List<AttendVO> selectLecAttndView(EgovMap lecSession) throws Exception {
		return (List<AttendVO>) list("LecAttndDAO.selectLecAttndView", lecSession);
	}

	// 교사 출결 비고 조회
	public EgovMap selectLecAjaxAttndEtc(EgovMap paramMap) throws Exception {
		return (EgovMap) select("LecAttndDAO.selectLecAjaxAttndEtc", paramMap);
	}

	// 교사 출결 비고 수정
	public void updateLecAjaxAttndEtc(AttendVO resultVO) throws Exception {
		update("LecAttndDAO.updateLecAjaxAttndEtc", resultVO);
	}

	public void insertLecAjaxAttndEtc(AttendVO attendVO) throws Exception {
		insert("LecAttndDAO.insertLecAjaxAttndEtc", attendVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> lecAjaxAttndEtcList(String lectSeq) throws Exception {
		return (List<EgovMap>) list("LecAttndDAO.lecAjaxAttndEtcList", lectSeq);
	}

}
