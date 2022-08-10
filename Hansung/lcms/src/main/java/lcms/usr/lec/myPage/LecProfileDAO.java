package lcms.usr.lec.myPage;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.UsrVO;

@Repository
public class LecProfileDAO extends EgovAbstractDAO {

	// 교사 프로필 조회
	public UsrVO selectLecProfile(UsrVO usrVO) throws Exception {
		return (UsrVO) select("lecProfileDAO.selectLecProfile", usrVO);
	}
	
	// 교사 프로필 저장
	public void updateLecProfile(UsrVO usrVO) throws Exception{
		update("lecProfileDAO.updateLecProfile", usrVO);
	}
	
	// 교사 비밀번호 체크
	public int selectadmAjaxMemberPwChk(UsrVO usrVO) throws Exception{
		return (int) select("lecProfileDAO.selectadmAjaxMemberPwChk", usrVO);
	}
	
	// 교사 비밀번호 변경
	public void lecAjaxPasswordUpdate(UsrVO usrVO) throws Exception{
		update("lecProfileDAO.lecAjaxPasswordUpdate", usrVO);
		
	}
	
	// 교사 권한 조회ㅣ
	public EgovMap SelectLectMap(String selLectCode) {
		return (EgovMap) select("lecProfileDAO.SelectLectMap", selLectCode);
	}
	

}
