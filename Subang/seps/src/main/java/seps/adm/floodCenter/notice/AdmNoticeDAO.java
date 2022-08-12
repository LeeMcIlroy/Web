package seps.adm.floodCenter.notice;

import java.util.List;

import org.springframework.stereotype.Repository;

import seps.valueObject.NoticeVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class AdmNoticeDAO extends EgovAbstractDAO {

	//공지사항설정 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectNoticeList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmNoticeDAO.selectAdmNoticeListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmNoticeDAO.selectAdmNoticeList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 공지사항 공지글 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectNoticeList2(){
		return (List<EgovMap>) list("AdmNoticeDAO.selectNoticeList2");
	}

	//공지사항설정 조회
	public NoticeVO selectNoticeView(String noticeId) {
		return (NoticeVO) select("AdmNoticeDAO.selectAdmNoticeView", noticeId);
	}

	//공지사항설정 등록
	public String insertNotice(NoticeVO paramVO) {
		return (String) insert("AdmNoticeDAO.insertAdmNotice", paramVO);
		
	}
	
	//공지사항설정 수정
	public void updateNotice(NoticeVO paramVO){
		update("AdmNoticeDAO.updateAdmNotice", paramVO);
	}
	
	//공지사항설정 삭제
	public void deleteNotice(String noticeId){
		delete("AdmNoticeDAO.deleteAdmNotice", noticeId);
	}

}