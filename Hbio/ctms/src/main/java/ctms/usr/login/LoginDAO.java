package ctms.usr.login;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import ctms.valueObject.Ct1000mVO;
import ctms.valueObject.Ct1060mVO;

@Repository
public class LoginDAO extends EgovAbstractDAO {
	
	// 사용자 로그인
	public Sb1000mVO selectUsrLoginProc(Sb1000mVO sb1000mVO) throws Exception {
		return (Sb1000mVO) select("LoginDAO.selectUsrLoginProc", sb1000mVO);
	}
	
	// 사용자 최근 접속일시 수정
	public void updateLoginDateTime(Sb1000mVO sb1000mVO) throws Exception {
		update("LoginDAO.updateLoginDateTime", sb1000mVO);
	}

	// 사용자 로그인 실패횟수 수정
	public void updateLoginFail(Sb1000mVO sb1000mVO) throws Exception {
		update("LoginDAO.updateLoginFail", sb1000mVO);
	}

	// 사용자 로그인 아이디 확인
	public String selectUsrLoginIdChk(Sb1000mVO sb1000mVO) throws Exception {
		return (String) select("LoginDAO.selectUsrLoginIdChk", sb1000mVO);
	}
	
	// 회원(연구대장자) 등록
	public String insertMember(Sb1000mVO sb1000mVO) throws Exception {		
		 return (String)insert("LoginDAO.insertMember", sb1000mVO); 
	}
	
	// 회원(연구대장자) 유형 추가
	public String insertMemberResearchCls(Sb1010mVO sb1010mVO) throws Exception {		
		 return (String)insert("LoginDAO.insertMemberResearchCls", sb1010mVO); 
	}
	
	// 이용약관, 개인정보처리방침 조회
	public Ct1000mVO selectRule(Ct1000mVO ct1000mVO) throws Exception {
		return (Ct1000mVO) select("LoginDAO.selectRule", ct1000mVO);
	}

	// 회원(연구대상자) 아이디 중복체크
	public int selectUserIdChk(EgovMap map) throws Exception {
		return (int) select("LoginDAO.selectUserIdChk", map);
	}

	// 핸드폰등록여부 확인
	public int selectUsrHpCnt(Sb1000mVO sb1000mVO) throws Exception {
		return (int) select("LoginDAO.selectUsrHpCnt", sb1000mVO);
	}
	
	// 인증번호 추가
	public String insertAuthCd(Ct1060mVO ct1060mVO) throws Exception {		
		 return (String)insert("LoginDAO.insertAuthCd", ct1060mVO); 
	}
	
	// 인증번호 조회
	public String selectAuthCd(Ct1060mVO ct1060mVO) throws Exception {
		return (String) select("LoginDAO.selectAuthCd", ct1060mVO);
	}
	
	//아이디 조회
	@SuppressWarnings("unchecked")	
	public List<EgovMap> selectIdList(CmmnSearchVO searchVO) throws Exception {
		List<EgovMap> resultList = (List<EgovMap>) list("LoginDAO.selectIdList", searchVO);
		//return new CmmnListVO(1, resultList);
		return (List<EgovMap>) list("LoginDAO.selectIdList", searchVO);
	}
	
	// 인증번호 상태변경 - 폐기
	public void updateAuthCdSt(Ct1060mVO ct1060mVO) throws Exception {
		update("LoginDAO.updateAuthCdSt", ct1060mVO);
	}
	
	// 핸드폰등록여부 확인
	public int selectUsrHpCntPw(Sb1000mVO sb1000mVO) throws Exception {
		return (int) select("LoginDAO.selectUsrHpCntPw", sb1000mVO);
	}
	
	// 회원 비밀번호 변경최근 접속일시 수정
	public void usrAjaxPasswordUpdate(Sb1000mVO sb1000mVO) throws Exception {
		update("LoginDAO.usrAjaxPasswordUpdate", sb1000mVO);
	}
	
	// 사용자 로그인 핸드폰번호 확인
	public String selectUsrLoginHpNoChk(Sb1000mVO sb1000mVO) throws Exception {
		return (String) select("LoginDAO.selectUsrLoginHpNoChk", sb1000mVO);
	}
	
	// 사용자 로그인(핸드폰번호)
	public Sb1000mVO selectUsrLoginProcHpNo(Sb1000mVO sb1000mVO) throws Exception {
		return (Sb1000mVO) select("LoginDAO.selectUsrLoginProcHpNo", sb1000mVO);
	}
	
	// mac address 등록여부 확인(핸드폰로그인 가능)
	public String selectLoginMacAddress(EgovMap map) throws Exception {
		return (String) select("LoginDAO.selectLoginMacAddress", map);
	}
	
	
	
}
