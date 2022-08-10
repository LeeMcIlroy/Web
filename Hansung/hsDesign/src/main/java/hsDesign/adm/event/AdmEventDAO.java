package hsDesign.adm.event;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.EventVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmEventDAO extends EgovAbstractDAO{

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEventList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmEventDAO.selectEventListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmEventDAO.selectEventList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	public void updateAdmEventDepoYn(EventVO paramVO) {
		update("AdmEventDAO.updateAdmEventDepoYn", paramVO);
	}

	public void updateAdmEventRefundYn(EventVO paramVO) {
		update("AdmEventDAO.updateAdmEventRefundYn", paramVO);
	}

	public void deleteAdmEvent(EventVO paramVO) {
		delete("AdmEventDAO.deleteAdmEvent", paramVO);
	}

	@SuppressWarnings("unchecked")
	public List<String> selectEveNumList() {
		return (List<String>) list("AdmEventDAO.selectEveNumList");
	}

	public EventVO selectAdmEventOne(String eveSeq) {
		return (EventVO) select("AdmEventDAO.selectAdmEventOne", eveSeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEventExcelList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("AdmEventDAO.selectEventExcelList", searchVO);
	}
}
