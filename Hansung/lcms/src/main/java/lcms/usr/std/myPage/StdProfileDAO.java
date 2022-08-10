package lcms.usr.std.myPage;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.UsrVO;

@Repository
public class StdProfileDAO extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectBoardList(String boardType) {
		return (List<EgovMap>)list("LoginDAO.selectBoardList", boardType);
	}
	
		// 학생 프로필 조회
		public UsrVO selectStdProfile(UsrVO usrVO) throws Exception {
			return (UsrVO) select("stdProfileDAO.selectStdProfile", usrVO);
		}
		
		// 학생 프로필 저장
		public void updateStdProfile(UsrVO usrVO) throws Exception{
			update("stdProfileDAO.updateStdProfile", usrVO);
		}
		
		
		// 학생 비밀번호 체크
		public int selectadmAjaxMemberPwChk(UsrVO usrVO) throws Exception{
			return (int) select("stdProfileDAO.selectadmAjaxMemberPwChk", usrVO);
		}

		// 학생 비밀번호 변경
		public void stdAjaxPasswordUpdate(UsrVO usrVO) throws Exception{
			update("stdProfileDAO.stdAjaxPasswordUpdate", usrVO);
			
		}

}
