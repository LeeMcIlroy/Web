package hsDesign.usr.transfer.transferReview;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class TransferReviewDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectTransferReviewList(CmmnSearchVO searchVO){
		if("01".equals(searchVO.getSearchType())){
			int totalRecordCount = (int) select("TransferReviewDAO.selectTransferReviewListCnt", searchVO);
			List<EgovMap> resultList = (List<EgovMap>) list("TransferReviewDAO.selectTransferReviewList", searchVO);
			return new CmmnListVO(totalRecordCount, resultList);
		}else{
			int totalRecordCount = (int) select("TransferReviewDAO.selectGraduateReviewListCnt", searchVO);
			List<EgovMap> resultList = (List<EgovMap>) list("TransferReviewDAO.selectGraduateReviewList", searchVO);
			return new CmmnListVO(totalRecordCount, resultList);
		}
	}
	
}
