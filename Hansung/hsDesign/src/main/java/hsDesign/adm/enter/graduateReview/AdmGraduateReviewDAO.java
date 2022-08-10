package hsDesign.adm.enter.graduateReview;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.GraduateReviewVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmGraduateReviewDAO extends EgovAbstractDAO{
	
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectGraduateReviewList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmGraduateReviewDAO.selectGraduateReviewListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmGraduateReviewDAO.selectGraduateReviewList", searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	// 등록
	public void insertGraduateReviewOne(GraduateReviewVO GraduateReviewVO) {
		insert("AdmGraduateReviewDAO.insertGraduateReviewOne", GraduateReviewVO);
	}
	
	// 전공목록
	public List<EgovMap> selectMajorList(){
		return (List<EgovMap>) list("AdmMajorBoardDAO.selectMajorList");
	}
	
	// 조회
	public GraduateReviewVO selectGraduateReviewOne(String grSeq) {
		return (GraduateReviewVO) select("AdmGraduateReviewDAO.selectGraduateReviewOne", grSeq);
	}
	
	// 수정
	public void updateGraduateReviewOne(GraduateReviewVO GraduateReviewVO) {
		update("AdmGraduateReviewDAO.updateGraduateReviewOne", GraduateReviewVO);	
	}
	
	// 삭제 
	public void deleteGraduateReviewOne(String trSeq) {
		delete("AdmGraduateReviewDAO.deleteGraduateReviewOne", trSeq);
	}
}
