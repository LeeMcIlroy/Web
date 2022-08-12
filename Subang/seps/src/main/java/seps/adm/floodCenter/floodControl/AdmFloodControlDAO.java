package seps.adm.floodCenter.floodControl;

import java.util.List;

import org.springframework.stereotype.Repository;

import seps.valueObject.FloodControlVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class AdmFloodControlDAO extends EgovAbstractDAO {

	//수방단계설정 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectFloodControlList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmFloodControlDAO.selectAdmFloodControlListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmFloodControlDAO.selectAdmFloodControlList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//수방단계설정 조회
	public FloodControlVO selectFloodControlView(String floodControlId) {
		return (FloodControlVO) select("AdmFloodControlDAO.selectAdmFloodControlView", floodControlId);
	}

	//수방단계설정 등록
	public String insertFloodControl(FloodControlVO paramVO) {
		return (String) insert("AdmFloodControlDAO.insertAdmFloodControl", paramVO);
		
	}
	
	//수방단계설정 수정
	public void updateFloodControl(FloodControlVO paramVO){
		update("AdmFloodControlDAO.updateAdmFloodControl", paramVO);
	}
	
	//수방단계설정 삭제
	public void deleteFloodControl(String floodControlId){
		delete("AdmFloodControlDAO.deleteAdmFloodControl", floodControlId);
	}

}