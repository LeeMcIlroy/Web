package lcms.usr.lec.attnd;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.AbsentConsultVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecAbsCounselDAO extends EgovAbstractDAO {

	// 강사 결석자상담 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecAbsCounselList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("LecAbsCounselDAO.selectLecAbsCounselListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecAbsCounselDAO.selectLecAbsCounselList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	// 강사 결석자상담 수정화면 조회
	public AbsentConsultVO selectLecAbsCounselModify(String absentSeq) throws Exception {
		return (AbsentConsultVO) select("LecAbsCounselDAO.selectLecAbsCounselModify", absentSeq);
	}

	// 강사 결석자상담 등록화면 조회
	public AbsentConsultVO selectLecAbsCounselNew(EgovMap map) throws Exception {
		return (AbsentConsultVO) select("LecAbsCounselDAO.selectLecAbsCounselNew", map);
	}

	// 강사 결석자상담 등록
	public void insertLecAbsCounselSubmit(AbsentConsultVO absentConsultVO) throws Exception {
		insert("LecAbsCounselDAO.insertLecAbsCounselSubmit", absentConsultVO);
	}
	
	// 강사 결석자상담 수정
	public void updateLecAbsCounselSubmit(AbsentConsultVO absentConsultVO) throws Exception {
		update("LecAbsCounselDAO.updateLecAbsCounselSubmit", absentConsultVO);
	}

	//결석자 상담 엑셀 다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> lecAbsCounselExcel(CmmnSearchVO searchVO)  throws Exception {
		return (List<EgovMap>) list("LecAbsCounselDAO.lecAbsCounselExcel", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> lecAbsCounselLect(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("LecAbsCounselDAO.lecAbsCounselLect", searchVO);
	}

}
