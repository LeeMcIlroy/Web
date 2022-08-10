package lcms.usr.lec.clss;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.MeetLogVO;
import lcms.valueObject.MeetProfVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LecClssMeetDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecClssMeetList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("LecClssMeetDAO.selectLecClssMeetList", searchVO);
	}

	public MeetLogVO selectLecClssMeetModify(EgovMap map) throws Exception {
		return (MeetLogVO) select("LecClssMeetDAO.selectLecClssMeetModify", map);
	}

	@SuppressWarnings("unchecked")
	public List<MeetProfVO> selectLecMeetProfList(EgovMap map) throws Exception {
		return (List<MeetProfVO>) list("LecClssMeetDAO.selectLecMeetProfList", map);
	}

	public EgovMap selectLecMeetWeek(EgovMap map) throws Exception {
		return (EgovMap) select("LecClssMeetDAO.selectLecMeetWeek", map);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecLectGradeList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("LecClssMeetDAO.selectLecLectGradeList", map);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecProfList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("LecClssMeetDAO.selectLecProfList", map);
	}

	public void insertLecClssMeetLog(MeetLogVO meetLogVO) throws Exception {
		insert("LecClssMeetDAO.insertLecClssMeetLog", meetLogVO);
	}

	public void insertLecClssMeetProf(MeetProfVO meetProfVO) throws Exception {
		insert("LecClssMeetDAO.insertLecClssMeetProf", meetProfVO);
	}

	public void updateLecClssMeetLog(MeetLogVO meetLogVO) throws Exception {
		update("LecClssMeetDAO.updateLecClssMeetLog", meetLogVO);
	}

	public void updateLecClssMeetProf(MeetProfVO meetProfVO) throws Exception {
		update("LecClssMeetDAO.updateLecClssMeetProf", meetProfVO);
	}

	public void updateLecClssMeetLogSubmis(String meetSeq) throws Exception {
		update("LecClssMeetDAO.updateLecClssMeetLogSubmis", meetSeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLecClssMeetProfCopy(EgovMap map) throws Exception {
		return (List<EgovMap>) list("LecClssMeetDAO.selectLecClssMeetProfCopy", map);
	}

}
