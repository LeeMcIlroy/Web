package lcms.usr.std.myPage;

import java.util.List;

import lcms.valueObject.EnterVO;
import lcms.valueObject.NoticeVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class StdNoticeDAO extends EgovAbstractDAO {
    
	
	// ???
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardList(String boardType) {
		return (List<EgovMap>)list("LoginDAO.selectBoardList", boardType);
	}
	// 20200312 STD *******상단 공지사항********
		@SuppressWarnings("unchecked")
		public List<EgovMap> selectTopNotiList(CmmnSearchVO searchVO) {
			List<EgovMap> resultListTop = (List<EgovMap>) list("StdNoticeDAO.selectTopNotiList", searchVO);
			return resultListTop;
		}
		// 20200312 STD *******상단 공지 CNT********
		public int selectTopNotiListCnt(CmmnSearchVO searchVO) {
			int totalCountTop = (int) select("StdNoticeDAO.selectTopNotiListCnt", searchVO);
			return totalCountTop;
		}
		
    // 20200311 STD 공지사항 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectStdNoticeList(CmmnSearchVO searchVO) {
		int totalCount = (int) select("StdNoticeDAO.selectStdNoticeListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("StdNoticeDAO.selectStdNoticeList", searchVO);
		return new CmmnListVO(totalCount, resultList);
	}
	// 20200311 std공지사항 view
	public NoticeVO selectStdNoticeOne(String noti_seq) throws Exception {
		return  (NoticeVO) select("StdNoticeDAO.selectStdNoticeOne", noti_seq);
		
	}
	
	// 20200311 std공지사항 조회수
	public void updateStdNoticeHits(String noti_seq) {
		update("StdNoticeDAO.updateStdNoticeHits", noti_seq);
	}
    
	

		
	}

