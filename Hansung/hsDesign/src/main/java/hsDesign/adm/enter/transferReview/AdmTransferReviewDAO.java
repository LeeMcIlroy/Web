package hsDesign.adm.enter.transferReview;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.TransferReviewVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmTransferReviewDAO extends EgovAbstractDAO{
	
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectTransferReviewList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmTransferReviewDAO.selectTransferReviewListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmTransferReviewDAO.selectTransferReviewList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 등록
	public void insertTransferReviewOne(TransferReviewVO transferReviewVO) {
		insert("AdmTransferReviewDAO.insertTransferReviewOne", transferReviewVO);
	}
	
	// 전공목록
	public List<EgovMap> selectMajorList(){
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectMajorList");
	}
	
	// 조회
	public TransferReviewVO selectTransferReviewOne(String trSeq) {
		return (TransferReviewVO) select("AdmTransferReviewDAO.selectTransferReviewOne", trSeq);
	}
	
	// 수정
	public void updateTransferReviewOne(TransferReviewVO transferReviewVO) {
		update("AdmTransferReviewDAO.updateTransferReviewOne", transferReviewVO);	
	}
	
	// 삭제 
	public void deleteTransferReviewOne(String trSeq) {
		delete("AdmTransferReviewDAO.deleteTransferReviewOne", trSeq);
	}
}
