package hsDesign.usr.event;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import hsDesign.valueObject.EventVO;

@Repository
public class EventDAO extends EgovAbstractDAO {

	/***************************************** 행사 등록 신청 *****************************************/
	
	// 등록 - 신청
	public int insertEvent(EventVO eventVO) {
		int n = (int) select("EventDAO.selectEventOne", eventVO);
		if(n == 0) insert("EventDAO.insertEvent", eventVO);
		return n;
	}

	public String selectEventExpoChk(EventVO eventVO) {
		return (String) select("EventDAO.selectEventExpoChk", eventVO);
	}

	public int updateEventCancel(EventVO eventVO) {
		int n = (int) select("EventDAO.selectEventCancelOne", eventVO);
		if(n != 0) update("EventDAO.updateEventCancel", eventVO);
		return n;
	}

	public int selectEventOneCxlCnt(EventVO eventVO) {
		return (int) select("EventDAO.selectEventOneCxlCnt", eventVO);
	}
}
