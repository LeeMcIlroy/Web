package lcms.usr.std.lecRoom;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.TaskSubVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class StdLecTaskDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO LecTaskList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("StdTaskDAO.LecTaskListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("StdTaskDAO.LecTaskList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	public EgovMap selectStdTaskOne(TaskSubVO taskSubVO) { 
		update("LecTaskDAO.updateTaskHits", taskSubVO.getTaskSeq());//조회수증가
		return (EgovMap) select("StdTaskDAO.selectStdTaskOne",taskSubVO);
	}
	
	@SuppressWarnings("unchecked")
	public CmmnListVO lecStdTaskList(CmmnSearchVO searchVO) { 
		int totalRecordCount = (Integer) select("StdTaskDAO.LecStdTaskListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("StdTaskDAO.LecStdTaskList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	public String insertTaskSub(TaskSubVO taskSubVO) throws Exception {
		return (String) insert("StdTaskDAO.insertTaskSub", taskSubVO);
	}

	public void updateStdTaskLookDate(String subSeq) throws Exception {
		update("StdTaskDAO.updateStdTaskLookDate", subSeq);
	}

	public String insertStdTaskLookDate(TaskSubVO taskSubVO) throws Exception {
		return (String) insert("StdTaskDAO.insertStdTaskLookDate", taskSubVO);
	}

	public void updateTaskSub(TaskSubVO taskSubVO) throws Exception {
		update("StdTaskDAO.updateTaskSub", taskSubVO);
	}

}
