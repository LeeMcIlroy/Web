package lcms.usr.lec.clss;


import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.ConsultVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecClssCounselDAO extends EgovAbstractDAO {

	// 교사 상담통계 조회
	public EgovMap selectLecClssCounselStat(CmmnSearchVO searchVO) throws Exception {
		return (EgovMap) select("LecClssCounselDAO.selectLecClssCounselStat", searchVO);
	}
	
	// 교사 상담 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecClssCounselList(CmmnSearchVO searchVO) throws Exception {
		int totalCount = (int) select("LecClssCounselDAO.selectLecClssCounselListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecClssCounselDAO.selectLecClssCounselList", searchVO);
		return new CmmnListVO(totalCount, resultList);
	}

	// 교사 상담 수정 조회
	public ConsultVO selectLecClssCounselOne(String consultSeq) throws Exception {
		return (ConsultVO) select("LecClssCounselDAO.selectLecClssCounselOne", consultSeq);
	}

	// 교사 상담 등록
	public void insertLecClssCounsel(ConsultVO consultVO) throws Exception {
		insert("LecClssCounselDAO.insertLecClssCounsel", consultVO);
	}

	// 교사 상담 수정
	public void updateLecClssCounsel(ConsultVO consultVO) throws Exception {
		update("LecClssCounselDAO.updatetLecClssCounsel", consultVO);
	}

	// 교사 상담 조회
	public ConsultVO selectLecClssCounselView(String consultSeq) throws Exception {
		return (ConsultVO) select("LecClssCounselDAO.selectLecClssCounselView", consultSeq);
	}

	// 교사 상담 이력 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> lecClssCounselPop(EgovMap map) throws Exception {
		return (List<EgovMap>) list("LecClssCounselDAO.lecClssCounselPop", map);
	}

}
