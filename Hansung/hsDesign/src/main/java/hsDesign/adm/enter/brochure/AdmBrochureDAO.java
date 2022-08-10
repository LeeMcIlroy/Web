package hsDesign.adm.enter.brochure;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmBrochureDAO extends EgovAbstractDAO{

	// 목록
	public CmmnListVO selectBrochureList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmBrochureDAO.selectBrochureListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmBrochureDAO.selectBrochureList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 삭제
	public void deleteBrochureOne(String brcSeq) {
		delete("AdmBrochureDAO.deleteBrochureOne", brcSeq);
	}
}
