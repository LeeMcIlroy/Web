package lcms.usr.lec.clss;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.AttachVO;
import lcms.valueObject.EvalVO;
import lcms.valueObject.LecClssNoticeVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecClssNoticeDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO LecClssNoticeList(LecClssNoticeVO lecClssNoticeVO) {
		int totalRecordCount = (Integer) select("LecClssNoticeDAO.LecClssNoticeListCnt", lecClssNoticeVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecClssNoticeDAO.LecClssNoticeList", lecClssNoticeVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	@SuppressWarnings("unchecked")
	public EgovMap selectLcnotiOne(String lcnotiSeq) { 
		update("LecClssNoticeDAO.updateLcnotiHits", lcnotiSeq);//조회수증가
		return (EgovMap) select("LecClssNoticeDAO.selectLcnotiOne",lcnotiSeq);
	}	
	
	@SuppressWarnings("unchecked")
	public String lecClssAddNoti(LecClssNoticeVO lecClssNoticeVO) throws Exception {
		return (String) insert("LecClssNoticeDAO.lecClssAddNoti", lecClssNoticeVO);
	}

	@SuppressWarnings("unchecked")
	public void lecClssEditNoti(LecClssNoticeVO lecClssNoticeVO) throws Exception {
		update("LecClssNoticeDAO.lecClssEditNoti", lecClssNoticeVO);
	}
	//강의공지 삭제
	public void deletelecNotice(String lcnotiSeq) {
		delete("LecClssNoticeDAO.deletelecNotice", lcnotiSeq); 
	}
	//강의공지 조회(modify)
	public LecClssNoticeVO selectlecClssNotice(String lcnotiSeq) throws Exception{
		return (LecClssNoticeVO) select("LecClssNoticeDAO.selectlecClssNotice", lcnotiSeq);
	}
	
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAttachListFiles(CmmnSearchVO searchVO) {
		List<EgovMap> resultList = (List<EgovMap>) list("LecClssNoticeDAO.selectAttachListFiles", searchVO);		
		return new CmmnListVO(0, resultList);
	}
}
