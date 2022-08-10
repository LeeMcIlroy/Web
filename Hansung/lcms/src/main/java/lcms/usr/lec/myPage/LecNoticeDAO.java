package lcms.usr.lec.myPage;

import java.util.List;

import lcms.valueObject.NoticeVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class LecNoticeDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardList(String boardType) {
		return (List<EgovMap>)list("LoginDAO.selectBoardList", boardType);
	}
	// 20200312 LEC *******상단 공지사항********
			@SuppressWarnings("unchecked")
			public List<EgovMap> selectTopNotiList(CmmnSearchVO searchVO) {
				List<EgovMap> resultListTop = (List<EgovMap>) list("LecNoticeDAO.selectTopNotiList", searchVO);
				return resultListTop;
			}
			// 20200312 LEC *******상단 공지 CNT********
			public int selectTopNotiListCnt(CmmnSearchVO searchVO) {
				int totalCountTop = (int) select("LecNoticeDAO.selectTopNotiListCnt", searchVO);
				return totalCountTop;
			}
			
	    // 20200312 LEC 공지사항 리스트
		@SuppressWarnings("unchecked")
		public CmmnListVO selectLecNoticeList(CmmnSearchVO searchVO) {
			int totalCount = (int) select("LecNoticeDAO.selectLecNoticeListCnt", searchVO);
			List<EgovMap> resultList = (List<EgovMap>) list("LecNoticeDAO.selectLecNoticeList", searchVO);
			return new CmmnListVO(totalCount, resultList);
		}
		// 20200312 LEC공지사항 view
		public NoticeVO selectLecNoticeOne(String noti_seq) throws Exception {
			return  (NoticeVO) select("LecNoticeDAO.selectLecNoticeOne", noti_seq);
			
		}
		
		// 20200312 LEC공지사항 조회수
		public void updateLecNoticeHits(String noti_seq) {
			update("LecNoticeDAO.updateLecNoticeHits", noti_seq);
		}
	    

}
