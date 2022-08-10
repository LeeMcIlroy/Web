package lcms.adm.oper;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.AdminVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmOperDAO extends EgovAbstractDAO {

	// 업무담당자 사용자 관리
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmAdminList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmOperDAO.selectAdmAdminListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmOperDAO.selectAdmAdminList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 사용자 조회
	public AdminVO selectAdmAdminView(String adminId) throws Exception {
		return (AdminVO) select("AdmOperDAO.selectAdmAdminView", adminId);
	}

	// 업무담당자 사용자 수정
	public void updateAdmin(AdminVO adminVO) throws Exception {
		update("AdmOperDAO.updateAdmin",adminVO);
	}

	// 업무담당자 사용자 등록
	public void insertAdmin(AdminVO adminVO) throws Exception {
		insert("AdmOperDAO.insertAdmin", adminVO);
	}

	// 업무담당자 사용자 아이디 중복체크
	public int selectAdmAdminIdChk(String adminId) throws Exception {
		return (int) select("AdmOperDAO.selectAdmAdminIdChk", adminId);
	}
	
	// 개인정보처리 로그 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmLogList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmOperDAO.selectAdmLogListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmOperDAO.selectAdmLogList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
		
	}
	
	// 관리자 프로필 조회
	public AdminVO selectAdmProfile(AdminVO adminVO) throws Exception {
		return (AdminVO) select("AdmOperDAO.selectAdmProfile", adminVO);
	}
	
	// 관리자 비밀번호 체크
	public int selectadmAjaxAdminPwChk(AdminVO adminVO) throws Exception{
		return (int) select("AdmOperDAO.selectadmAjaxAdminPwChk", adminVO);
	}
	
	// 관리자 비밀번호 변경
	public void admAjaxPasswordUpdate(AdminVO adminVO) throws Exception{
		update("AdmOperDAO.admAjaxPasswordUpdate", adminVO);
		
	}
	
	// 관리자 비밀번호 재설정
	public void updateAdmAjaxProfClearPw(AdminVO adminVO) throws Exception{
		update("AdmOperDAO.updateAdmAjaxProfClearPw", adminVO);
		 
	}


	// 개인정보처리(로그) 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmLogExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmOperDAO.selectAdmLogExcel", searchVO);
	}

	public void updateAdmAjaxClearLgnFail(String adminId) throws Exception {
		update("AdmOperDAO.updateAdmAjaxClearLgnFail", adminId);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmLoginLogList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmOperDAO.selectAdmLoginLogListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmOperDAO.selectAdmLoginLogList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmLoginLogExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmOperDAO.selectAdmLoginLogExcel", searchVO);
	}

}
