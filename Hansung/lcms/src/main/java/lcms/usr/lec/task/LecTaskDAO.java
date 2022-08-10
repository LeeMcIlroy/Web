package lcms.usr.lec.task;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.SemesterVO;
import lcms.valueObject.TaskVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecTaskDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO LecTaskList(CmmnSearchVO searchVO) {
		int totalRecordCount = (Integer) select("LecTaskDAO.LecTaskListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecTaskDAO.LecTaskList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	public TaskVO selectTaskOne(String taskSeq) { 
		update("LecTaskDAO.updateTaskHits", taskSeq);//조회수증가
		return (TaskVO) select("LecTaskDAO.selectTaskOne",taskSeq);
	}	
	
	public String lecAddTask(TaskVO taskVO) throws Exception {
		return (String) insert("LecTaskDAO.lecAddTask", taskVO);
	}

	public void lecEditTask(TaskVO taskVO) throws Exception {
		update("LecTaskDAO.lecEditTask", taskVO);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectPresenList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("LecTaskDAO.selectPresenListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("LecTaskDAO.selectPresenList", searchVO);		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	public void updateLecTaskSubShow(String subSeq) throws Exception {
		update("LecTaskDAO.updateLecTaskSubShow", subSeq);
	}

	public String selectLecTaskSubDownDate(String subSeq) throws Exception {
		return (String) select("LecTaskDAO.selectLecTaskSubDownDate", subSeq);
	}

	// 강사 과제 학생 제출 cnt
	public int selectTaskSubCnt(String taskSeq) throws Exception {
		return (int) select("LecTaskDAO.selectTaskSubCnt", taskSeq);
	}

	// 강사 과제 삭제
	public void deleteTask(String taskSeq) throws Exception {
		delete("LecTaskDAO.deleteTask", taskSeq);
	}

	public void deleteTaskSub(String taskSeq) throws Exception {
		delete("LecTaskDAO.deleteTaskSub", taskSeq);
	}


}
