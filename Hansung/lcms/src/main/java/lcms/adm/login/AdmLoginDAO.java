package lcms.adm.login;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import lcms.valueObject.AdminVO;

@Repository
public class AdmLoginDAO extends EgovAbstractDAO {

	// 관리자 로그인
	public AdminVO selectAdmLoginProc(AdminVO adminVO) throws Exception {
		return (AdminVO) select("AdmLoginDAO.selectAdmLoginProc", adminVO);
	}

	// 관리자 최근 접속일시 수정
	public void updateAdmLoginDateTime(AdminVO resultVO) throws Exception {
		update("AdmLoginDAO.updateAdmLoginDateTime", resultVO);
	}

	public void updateAdmLoginFail(AdminVO resultVO) throws Exception {
		update("AdmLoginDAO.updateAdmLoginFail", resultVO);
	}

}
