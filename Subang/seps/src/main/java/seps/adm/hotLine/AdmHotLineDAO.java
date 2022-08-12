package seps.adm.hotLine;

import java.util.List;

import org.springframework.stereotype.Repository;

import seps.valueObject.HotLineVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class AdmHotLineDAO extends EgovAbstractDAO {

	//비상연락망 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectHotLineList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmHotLineDAO.selectAdmHotLineListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmHotLineDAO.selectAdmHotLineList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//비상연락망 기관 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectHotLineDeptList(){
		return (List<EgovMap>) list("AdmHotLineDAO.selectHotLineDeptList");
	}
	
	//비상연락망 조회
	public HotLineVO selectHotLineView(String hotLineId) {
		return (HotLineVO) select("AdmHotLineDAO.selectAdmHotLineView", hotLineId);
	}

	//비상연락망 등록
	public String insertHotLine(HotLineVO paramVO) {
		return (String) insert("AdmHotLineDAO.insertAdmHotLine", paramVO);
		
	}
	
	//비상연락망 수정
	public void updateHotLine(HotLineVO paramVO){
		update("AdmHotLineDAO.updateAdmHotLine", paramVO);
	}
	
	//비상연락망 삭제
	public void deleteHotLine(String hotLineId){
		delete("AdmHotLineDAO.deleteAdmHotLine", hotLineId);
	}
	
	//비상연락망 삭제
	public void deleteHotLineAll(){
		delete("AdmHotLineDAO.deleteAdmHotLineAll");
	}

}