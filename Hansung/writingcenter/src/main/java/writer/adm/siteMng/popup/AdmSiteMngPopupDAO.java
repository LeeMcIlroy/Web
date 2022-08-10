package writer.adm.siteMng.popup;

import java.net.UnknownHostException;
import java.util.List;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.AdminVO;
import writer.valueObject.PopupVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class AdmSiteMngPopupDAO extends EgovAbstractDAO{
	
	/* 목록 출력 */
	@SuppressWarnings("unchecked")
	public CmmnListVO selectSiteMngPopupList(CmmnSearchVO searchVO) throws UnknownHostException{
		int totalRecordCount = (int) select("AdmSiteMngPopupDAO.selectSiteMngPopupListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmSiteMngPopupDAO.selectSiteMngPopupList",searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	/* 저장 */
	public void insertSiteMngPopupOne(PopupVO popupVO){
		AdminVO adminVO=(AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		popupVO.setRegId(adminVO.getMemCode());
		insert("AdmSiteMngPopupDAO.insertSiteMngPopupOne", popupVO);
		
	}
	
	/* 삭제 */
	public void deleteSiteMngPopupOne(String popSeq){
		delete("AdmSiteMngPopupDAO.deleteSiteMngPopupOne", popSeq);
	}
	
	/* 조회 */
	public PopupVO selectSiteMngPopupOne(String popSeq){
		return (PopupVO) select("AdmSiteMngPopupDAO.selectSiteMngPopupOne",popSeq);
	}
	
	/* 수정 */
	public void updateSiteMngPopupOne(PopupVO popupVO) throws UnknownHostException{
		update("AdmSiteMngPopupDAO.updateSiteMngPopupOne", popupVO);
	}
}
