package seps.usr.hotLine;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;

@Repository
public class UsrHotLineDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectHotLineList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("UsrHotLineDAO.selectHotLineListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("UsrHotLineDAO.selectHotLineList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//기관목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectHotlineDeptList(){
		return (List<EgovMap>) list("UsrHotLineDAO.selectHotLineDeptList");
	}
}
