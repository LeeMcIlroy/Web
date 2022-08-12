package seps.cmmn;

import java.util.List;

import org.springframework.stereotype.Repository;

import seps.valueObject.AuthVO;
import seps.valueObject.UserInfoVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository
public class LoginDAO extends EgovAbstractDAO {

	// 로그인
	@SuppressWarnings("unchecked")
	public UserInfoVO actionLogin(UserInfoVO userInfoVO){
		UserInfoVO returnVO = (UserInfoVO) select("LoginDAO.actionLogin", userInfoVO);
		if(returnVO != null){
			returnVO.setMenuList( (List<AuthVO>) list("LoginDAO.selectAuthList", returnVO) );
		}
		return  returnVO;
	}

	//최종로그인 시간 갱신
	public void updateUserLog(String userInfoId) {
		update("LoginDAO.updateUserLog", userInfoId);
	}
	
}
