package lcms.usr.lec.com;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.UsrVO;

@Repository
public class LecComDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> LectList(UsrVO resultVO) {
		return (List<EgovMap>)list("LecComDAO.LectList", resultVO);
	}
	
	public EgovMap SelectLectMap(String selLectCode) {
		return (EgovMap) select("LecComDAO.selectLectMap", selLectCode);
	}

	public EgovMap selectSemeter() throws Exception {
		return (EgovMap) select("LecComDAO.selectSemeter");
	}

	public EgovMap selectLecSemeter(EgovMap lectMap) throws Exception {
		return (EgovMap) select("LecComDAO.selectLecSemeter", lectMap);
	}


}
