package lcms.usr.std.myPage;

import java.util.List;

import lcms.valueObject.DormVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class StdDormitoryDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardList(String boardType) {
		return (List<EgovMap>)list("LoginDAO.selectBoardList", boardType);
	}
	 // **************************** 20200312 STD기숙사 ****************************

@SuppressWarnings("unchecked")
public CmmnListVO selectStdDormList(CmmnSearchVO searchVO) throws Exception {
	int totalRecordCount = (int) select("StdDormitoryDAO.selectStdDormListCnt", searchVO);
	List<EgovMap> egovList = (List<EgovMap>) list("StdDormitoryDAO.selectStdDormList", searchVO);
	return new CmmnListVO(totalRecordCount, egovList);
}

/*public void insertStdDormView(DormVO dormVO) {
	insert("StdDormitoryDAO.insertStdDormView", dormVO);
	
}
//기숙사 현재거주 리스트 한개 조회 (상세화면)
	public DormVO selectStdDormListOne(String memCode) {
		
		return  (DormVO) select("StdDormitoryDAO.selectStdDormListOne",memCode);
	}

	public int selectStdDormOneCnt(String memberCode) {
		int viewGubunCnt = (int) select("StdDormitoryDAO.selectStdDormOneCnt", memberCode);
		return viewGubunCnt;
	}*/

}
