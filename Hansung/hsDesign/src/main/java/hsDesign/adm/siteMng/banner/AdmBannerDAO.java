package hsDesign.adm.siteMng.banner;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.BannerVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmBannerDAO extends EgovAbstractDAO {

	//배너관리 목록
	public CmmnListVO selectAdmBannerList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmBannerDAO.selectAdmBannerListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmBannerDAO.selectAdmBannerList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//배너 조회
	public BannerVO selectAdmBannerOne(String banSeq){
		return (BannerVO) select("AdmBannerDAO.selectAdmBannerOne", banSeq);
	}
	
	
	//배너 등록
	public String insertAdmBanner(BannerVO paramVO) {
		return (String) insert("AdmBannerDAO.insertAdmBanner", paramVO);
	}

	//배너 수정
	public void updateAdmBanner(BannerVO paramVO) {
		update("AdmBannerDAO.updateAdmBanner", paramVO);
	}

	//배너 이미지 수정
	public void updateAdmBannerImg(BannerVO paramVO) {
		update("AdmBannerDAO.updateAdmBannerImg", paramVO);
	}
	
	//배너 사용여부 수정
	public void updateAdmBannerUseYn(BannerVO paramVO){
		update("AdmBannerDAO.updateAdmBannerUseYn", paramVO);
	}
	
	//배너 사용여부 수정(표출개수 제한)
	public void updateAdmBannerSpYn(BannerVO paramVO) {
		select("AdmBannerDAO.updateAdmBannerSpYn", paramVO);
	}

	//배너 삭제
	public void deleteAdmBanner(BannerVO paramVO) {
		delete("AdmBannerDAO.deleteAdmBanner", paramVO);
	}

}
