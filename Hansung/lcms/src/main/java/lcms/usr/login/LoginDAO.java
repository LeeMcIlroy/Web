package lcms.usr.login;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class LoginDAO extends EgovAbstractDAO {
	
	// 사용자 로그인
	public UsrVO selectUsrLoginProc(UsrVO usrVO) throws Exception {
		return (UsrVO) select("LoginDAO.selectUsrLoginProc", usrVO);
	}
	
	// 사용자 최근 접속일시 수정
	public void updateLoginDateTime(UsrVO resultVO) throws Exception {
		update("LoginDAO.updateLoginDateTime", resultVO);
	}
	//결석경고 이력
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAbsWrnHstrList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("LoginDAO.selectAbsWrnHstrList", searchVO);
	}

	public void updateLoginFail(UsrVO resultVO) throws Exception {
		update("LoginDAO.updateLoginFail", resultVO);
	}
	
	//학생 학기 등록 여부 확인
	public String selectStudLectMapCheck(EgovMap map) {
		return (String) select("LoginDAO.selectStudLectMapCheck", map);
	}
	//결석경고 이력
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectLapList(CmmnSearchVO searchVO) {
		return (List<EgovMap>) list("LoginDAO.selectLapList", searchVO);
	}
	//학생 학기 등록 여부 확인
	public String selectchkLec(EgovMap map) {
		return (String) select("LoginDAO.selectchkLec", map);
	}
}
