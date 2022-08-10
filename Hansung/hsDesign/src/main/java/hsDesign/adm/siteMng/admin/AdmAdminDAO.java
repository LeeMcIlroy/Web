package hsDesign.adm.siteMng.admin;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmAdminDAO extends EgovAbstractDAO {

	//관리자관리 목록
	public CmmnListVO selectAdmAdminList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmAdminDAO.selectAdmAdminListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmAdminDAO.selectAdmAdminList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList); 
	}

	//관리자 조회
	public AdminVO selectAdmAdminOne(String bcSeq){
		return (AdminVO) select("AdmAdminDAO.selectAdmAdminOne", bcSeq);
	}
	
	
	//관리자 등록
	public void insertAdmAdmin(AdminVO paramVO) {
		insert("AdmAdminDAO.insertAdmAdmin", paramVO);
	}

	//시스템관리자 수정
	public void updateAdmSystemAdmin(AdminVO paramVO) {
		update("AdmAdminDAO.updateAdmSystemAdmin", paramVO);
	}
	
	//일반관리자 수정
	public void updateAdmNomalAdmin(AdminVO paramVO) {
		update("AdmAdminDAO.updateAdmNomalAdmin", paramVO);
	}

	//관리자 등록 - 중복확인
	public String selectAdmAdminIdCheck(AdminVO paramVO) {
		return (String) select("AdmAdminDAO.selectAdmAdminIdCheck", paramVO);
	}

	//관리자 등록 - 비밀번호 초기화
	public void updateAdmPwdClear(AdminVO paramVO) {
		update("AdmAdminDAO.updateAdmPwdClear", paramVO);
	}
}
