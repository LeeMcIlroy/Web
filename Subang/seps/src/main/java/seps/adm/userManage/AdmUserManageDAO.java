package seps.adm.userManage;

import java.util.List;

import org.springframework.stereotype.Repository;

import seps.valueObject.UserInfoVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class AdmUserManageDAO extends EgovAbstractDAO {

	//사용자관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectUserManageList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmUserManageDAO.selectAdmUserManageListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmUserManageDAO.selectAdmUserManageList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//사용자관리 조회
	public UserInfoVO selectUserManageView(String userInfoId) {
		return (UserInfoVO) select("AdmUserManageDAO.selectAdmUserManageView", userInfoId);
	}

	//사용자관리 등록
	public String insertUserManage(UserInfoVO paramVO) {
		return (String) insert("AdmUserManageDAO.insertAdmUserManage", paramVO);
		
	}
	
	//사용자관리 수정
	public void updateUserManage(UserInfoVO paramVO){
		update("AdmUserManageDAO.updateAdmUserManage", paramVO);
	}
	
	//사용자관리 삭제
	public void deleteUserManage(String userInfoId){
		delete("AdmUserManageDAO.deleteAdmUserManage", userInfoId);
	}

	//사용자관리 아이디 중복확인
	public String selectAdmUserManageIdCheck(String userId) {
		return (String) select("AdmUserManageDAO.selectAdmUserManageIdCheck", userId);
	}
	
}