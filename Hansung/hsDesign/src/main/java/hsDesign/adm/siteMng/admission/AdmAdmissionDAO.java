package hsDesign.adm.siteMng.admission;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmAdmissionDAO extends EgovAbstractDAO{

	// 목록
	public CmmnListVO selectAdmissionList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmAdmissionDAO.selectAdmissionListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmAdmissionDAO.selectAdmissionList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 삭제
	public void deleteAdmissionOne(String adSeq) {
		delete("AdmAdmissionDAO.deleteAdmissionOne", adSeq);
	}
}
