package hsDesign.adm.general.exper;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmExperienceDAO extends EgovAbstractDAO {

	/***************************************** 진로체험 신청 *****************************************/
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectExperAplyList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmExperienceDAO.selectExperAplyListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmExperienceDAO.selectExperAplyList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 삭제 - 신청
	public void experDelete(String exaSeq){
		delete("AdmExperienceDAO.experDelete", exaSeq);
		experCourceDelete(exaSeq);
	}
	
	// 삭제 - 과정
	private void experCourceDelete(String exaSeq){
		delete("AdmExperienceDAO.experCourceDelete", exaSeq);
	}
}
