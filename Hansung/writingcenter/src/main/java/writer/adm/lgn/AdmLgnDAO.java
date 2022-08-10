package writer.adm.lgn;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import writer.valueObject.AdminVO;
import writer.valueObject.MenuAthrVO;

@Repository
public class AdmLgnDAO extends EgovAbstractDAO {
	
	// 로그인
	@SuppressWarnings("unchecked")
	public AdminVO actionLogin(String memCode){
		AdminVO adminVO = (AdminVO) select("AdmLgnDAO.actionLogin", memCode);
		if (adminVO != null) {
			adminVO.setAthrList((List<MenuAthrVO>) list("AdmLgnDAO.selectMenuAthrList", adminVO.getMemSeq()));
		}
		return adminVO;
	}
	
	// sso 로그인
	public AdminVO actionSsoLogin(String profCode){
		return (AdminVO) select("AdmLgnDAO.actionSsoLogin", profCode);
	}

}
