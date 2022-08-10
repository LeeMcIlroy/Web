package hsDesign.adm.siteMng.popup;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.PopupVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmPopupDAO extends EgovAbstractDAO {

	//팝업관리 목록
	public CmmnListVO selectAdmPopupList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmPopupDAO.selectAdmPopupListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmPopupDAO.selectAdmPopupList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//팝업 조회
	public PopupVO selectAdmPopupOne(String popSeq){
		return (PopupVO) select("AdmPopupDAO.selectAdmPopupOne", popSeq);
	}
	
	
	//팝업 등록
	public String insertAdmPopup(PopupVO paramVO) {
		return (String) insert("AdmPopupDAO.insertAdmPopup", paramVO);
	}

	//팝업 수정
	public void updateAdmPopup(PopupVO paramVO) {
		update("AdmPopupDAO.updateAdmPopup", paramVO);
	}

	//팝업 이미지 수정
	public void updateAdmPopupImg(PopupVO paramVO) {
		update("AdmPopupDAO.updateAdmPopupImg", paramVO);
	}
	
	//팝업 사용여부 수정
	public void updateAdmPopupUseYn(PopupVO paramVO){
		update("AdmPopupDAO.updateAdmPopupUseYn", paramVO);
	}

	//팝업 삭제
	public void deleteAdmPopup(PopupVO paramVO) {
		delete("AdmPopupDAO.deleteAdmPopup", paramVO);
	}
}
