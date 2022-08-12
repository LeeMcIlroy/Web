package seps.adm.systemManage;

import java.util.List;

import org.springframework.stereotype.Repository;

import seps.valueObject.UserInfoVO;
import valueObject.CmmnListVO;
import valueObject.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class AdmSystemManageDAO extends EgovAbstractDAO {

	//관리자관리 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectSystemManageList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmSystemManageDAO.selectAdmSystemManageListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmSystemManageDAO.selectAdmSystemManageList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//관리자관리 조회
	public UserInfoVO selectSystemManageView(String userInfoId) {
		return (UserInfoVO) select("AdmSystemManageDAO.selectAdmSystemManageView", userInfoId);
	}

	//관리자관리 등록
	public String insertSystemManage(UserInfoVO paramVO) {
		return (String) insert("AdmSystemManageDAO.insertAdmSystemManage", paramVO);
		
	}
	
	//관리자관리 수정
	public void updateSystemManage(UserInfoVO paramVO){
		update("AdmSystemManageDAO.updateAdmSystemManage", paramVO);
	}
	
	//관리자관리 삭제
	public void deleteSystemManage(String userInfoId){
		delete("AdmSystemManageDAO.deleteAdmSystemManage", userInfoId);
	}

	//관리자관리 아이디 중복확인
	public String selectAdmSystemManageIdCheck(String userId) {
		return (String) select("AdmSystemManageDAO.selectAdmSystemManageIdCheck", userId);
	}
	
	// 데이터연계현황
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectApiStatusList(){
		return (List<EgovMap>) list("AdmSystemManageDAO.selectApiStatusList");
	}
}