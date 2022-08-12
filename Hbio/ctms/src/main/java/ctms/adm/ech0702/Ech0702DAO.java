package ctms.adm.ech0702;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0702DAO  extends EgovAbstractDAO {

	/* 사용자관리 ****************************************************************************************************************************************************** */
	// 사용자관리 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0702List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0702DAO.selectEch0702ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0702DAO.selectEch0702List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 사용자관리 상세보기
	public Ct1030mVO selectEch0702View(Ct1030mVO ct1030mVO) {
		return (Ct1030mVO)select("Ech0702DAO.selectEch0702View", ct1030mVO); 
	}
	
	
	// 사용자관리 삭제
	public void deleteEch0702(Ct1030mVO ct1030mVO) {
		delete("Ech0702DAO.deleteEch0702", ct1030mVO);
		
	}
	// 사용자관리 등록
	public String insertEch0702(Ct1030mVO ct1030mVO) throws Exception {		
		 return (String)insert("Ech0702DAO.insertEch0702", ct1030mVO); 
	}
	
	// 사용자관리 수정 
	public void updateEch0702(Ct1030mVO ct1030mVO) throws Exception {
		update("Ech0702DAO.updateEch0702", ct1030mVO); 
	}
	
	// 사용자 일련번호
	public String selectEch0702Max(Ct1030mVO ct1030mVO) throws Exception {
		return (String) select("Ech0702DAO.selectEch0702Max", ct1030mVO);
	}
	
	// 사용자관리 목록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0702Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0702DAO.selectEch0702Excel", searchVO);
	}
	
	// 관리자 비밀번호 재설정
	public void updateEch0702AjaxProfClearPw(Ct1030mVO ct1030mVO) throws Exception{
		update("Ech0702DAO.updateEch0702AjaxProfClearPw", ct1030mVO);
		 
	}
	
	// 사용자로그인 횟수 초기화 
	public void updateEch0702AjaxClearLgnFail(EgovMap map) throws Exception {
		update("Ech0702DAO.updateEch0702AjaxClearLgnFail", map);
	}
	
	// 사용자 아이디 중복체크
	public int selectEch0702AdminIdChk(String adminId) throws Exception {
		return (int) select("Ech0702DAO.selectEch0702AdminIdChk", adminId);
	}
	
	// 사용자 프로필 조회
	public Ct1030mVO selectEch0702Profile(EgovMap map) throws Exception {
		return (Ct1030mVO) select("Ech0702DAO.selectEch0702Profile", map);
	}
	
	// 사용자 비밀번호 체크
	public int selectEch0702AjaxAdminPwChk(Ct1030mVO ct1030mVO) throws Exception{
		return (int) select("Ech0702DAO.selectEch0702AjaxAdminPwChk", ct1030mVO);
	}
	
	// 사용자 비밀번호 변경
	public void ech0702AjaxPasswordUpdate(Ct1030mVO ct1030mVO) throws Exception{
		update("Ech0702DAO.ech0702AjaxPasswordUpdate", ct1030mVO);
		
	}
	
	
	/* 사용자관리 ****************************************************************************************************************************************************** */
	
}
