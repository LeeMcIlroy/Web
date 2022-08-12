package seps.usr.floodCenter;

import java.util.List;

import org.springframework.stereotype.Repository;

import seps.valueObject.NoticeVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class UsrFloodCenterDAO extends EgovAbstractDAO {

	//공지사항 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectNoticeList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("UsrFloodCenterDAO.selectUsrNoticeListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("UsrFloodCenterDAO.selectUsrNoticeList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//공지사항 조회
	public NoticeVO selectNoticeView(String noticeId) {
		return (NoticeVO) select("UsrFloodCenterDAO.selectUsrNoticeView", noticeId);
	}

	//공지사항 등록
	public String insertNotice(NoticeVO paramVO) {
		return (String) insert("UsrFloodCenterDAO.insertUsrNotice", paramVO);
		
	}
	
	//공지사항 수정
	public void updateNotice(NoticeVO paramVO){
		update("UsrFloodCenterDAO.updateUsrNotice", paramVO);
	}
	
	//조회수 증가
	public void updateHitCnt(String noticeId){
		update("UsrFloodCenterDAO.updateHitCnt", noticeId);
	}
	
	//공지사항 삭제
	public void deleteNotice(String noticeId){
		delete("UsrFloodCenterDAO.deleteUsrNotice", noticeId);
	}
	
	//공지글 가져오기
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectNoticeList2() {
		return (List<EgovMap>) list("UsrFloodCenterDAO.selectUsrNoticeList2");
	}

	//기간별 알람현황
	@SuppressWarnings("unchecked")
	public CmmnListVO selectFloodAlarmList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("UsrFloodCenterDAO.selectUsrAlarmListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("UsrFloodCenterDAO.selectUsrAlarmList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

}