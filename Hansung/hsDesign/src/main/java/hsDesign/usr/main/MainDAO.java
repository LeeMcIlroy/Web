package hsDesign.usr.main;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.PopupVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class MainDAO extends EgovAbstractDAO {

	// 팝업 목록
	@SuppressWarnings("unchecked")
	public List<PopupVO> selectPopupList(){
		return (List<PopupVO>) list("MainDAO.selectPopupList");
	}
	
	// 팝업 조회
	public PopupVO selectPopupOne(String popSeq){
		return (PopupVO) select("MainDAO.selectPopupOne", popSeq);
	}
	
	// 배너 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBannerList(){
		return (List<EgovMap>) list("MainDAO.selectBannerList");
	}
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBannerList(String banType){
		return (List<EgovMap>) list("MainDAO.selectBannerList", banType);
	}
	
	
	// 전체 검색
	public CmmnListVO selectSearchList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("MainDAO.selectSearchListCnt",searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("MainDAO.selectSearchList",searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
}
