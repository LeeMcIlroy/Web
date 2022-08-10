package lcms.usr.std.lecRoom;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class StdLecNoticeDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardList(String boardType) {
		return (List<EgovMap>)list("LoginDAO.selectBoardList", boardType);
	}

	//상세보기
	@SuppressWarnings("unchecked")
	public EgovMap selectstdnoticeOne(String lcnotiSeq) { 
		update("StdLecNoticeDAO.updateStdNotiHits", lcnotiSeq);//조회수증가
		return (EgovMap) select("StdLecNoticeDAO.selectstdnoticeOne",lcnotiSeq);
	}
	//리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectStdLecNoticeList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("StdLecNoticeDAO.selectStdLecNoticeListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("StdLecNoticeDAO.selectStdLecNoticeList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
}
