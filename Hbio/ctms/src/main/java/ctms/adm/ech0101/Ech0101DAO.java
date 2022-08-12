package ctms.adm.ech0101;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs1020mVO;
import ctms.valueObject.Rs1030mVO;
import ctms.valueObject.Rs1040mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rs5000mVO;
import ctms.valueObject.RsUploadVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0101DAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0101List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0101DAO.selectEch0101ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0101DAO.selectEch0101List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	public Rs1000mVO selectEch0101View(Rs1000mVO rs1000mVO) throws Exception {
		return (Rs1000mVO) select("Ech0101DAO.selectEch0101View", rs1000mVO);
	}

	public String insertEch0101(Rs1000mVO rs1000mVO) throws Exception {
		return (String) insert("Ech0101DAO.insertEch0101", rs1000mVO);
	}

	public void updateEch0101(Rs1000mVO rs1000mVO) throws Exception {
		update("Ech0101DAO.updateEch0101", rs1000mVO);
	}

	//DEL_YN = "Y" 설정
	public void updateEch0101DelYn(EgovMap map) throws Exception {
		update("Ech0101DAO.updateEch0101DelYn", map);
	}
	
	public int deleteEch0101(Rs1000mVO rs1000mVO) throws Exception {
		return delete("Ech0101DAO.deleteEch0101", rs1000mVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0101Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0101DAO.selectEch0101Excel", searchVO);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0101JoinBranchList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountBranch = (Integer) select("Ech0101DAO.selectEch0101JoinBranchListCnt", searchVO);
		List<EgovMap> resultListBranch = (List<EgovMap>) list("Ech0101DAO.selectEch0101JoinBranchList", searchVO);
		
		return new CmmnListVO(totalRecordCountBranch, resultListBranch);
	}
	
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0101JoinEmpList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountEmp = (Integer) select("Ech0101DAO.selectEch0101JoinEmpListCnt", searchVO);
		List<EgovMap> resultListEmp = (List<EgovMap>) list("Ech0101DAO.selectEch0101JoinEmpList", searchVO);
		
		return new CmmnListVO(totalRecordCountEmp, resultListEmp);
	}
	
	// 참여지사관리 팝업
	public Rs1020mVO selectEch0101BrmgPop(Rs1020mVO rs1020mVO) {
		return (Rs1020mVO)select("Ech0101DAO.selectEch0101BrmgPop", rs1020mVO); 
	}

	// 참여지사관리 등록 Ajax
	public String insertEch0101AjaxSaveStep(EgovMap map) throws Exception {
		return (String)insert("Ech0101DAO.insertEch0101AjaxSaveStep", map);
	}
	
	// 참여지사관리 수정 Ajax
	public void updateEch0101AjaxSaveStep(EgovMap map) throws Exception {
		update("Ech0101DAO.updateEch0101AjaxSaveStep", map);
	}
	
	// 참여지사관리 상세보기
	public Rs1020mVO selectEch0101BrView(Rs1020mVO rs1020mVO) {
		return (Rs1020mVO)select("Ech0101DAO.selectEch0101BrView", rs1020mVO); 
	}
	// 참여지사  중복체크(일괄)
	public int selectEch0101AjaxBrmgChk(EgovMap map) {
		return (int) select("Ech0101DAO.selectEch0101AjaxBrmgChk", map);
	}
	// 참여지사  중복체크
		public int selectEch0101AjaxBrmgChkOne(EgovMap map) {
			return (int) select("Ech0101DAO.selectEch0101AjaxBrmgChkOne", map);
		}
	// 참여지사 미등록 연구과제리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0101BrmgInfo(EgovMap map) throws Exception {

		return (List<EgovMap>)list("Ech0101DAO.selectEch0101BrmgInfo", map);
	}
	// 참여지사 일괄 삭제
	public int updateEch0101AjaxSaveDel(EgovMap map) throws Exception {
		return delete("Ech0101DAO.updateEch0101AjaxSaveDel", map);
	}

	// 참여연구담당자 팝업
	public Rs1030mVO selectEch0101StmgPop(Rs1030mVO rs1030mVO) {
		return (Rs1030mVO)select("Ech0101DAO.selectEch0101StmgPop", rs1030mVO); 
	}
	
	// 참여연구담당자 등록 Ajax
	public String insertEch0101AjaxSaveStaff(EgovMap map) throws Exception {
		return (String)insert("Ech0101DAO.insertEch0101AjaxSaveStaff", map);
	}
	// 참여연구담당자 수정 Ajax
	public void updateEch0101AjaxSaveStaff(EgovMap map) throws Exception {
		update("Ech0101DAO.updateEch0101AjaxSaveStaff", map);
	}
	
	// 참여연구담당자 상세보기
	public Rs1030mVO selectEch0101StView(Rs1030mVO rs1030mVO) {
		return (Rs1030mVO)select("Ech0101DAO.selectEch0101StView", rs1030mVO); 
	}
	// 참여연구원  중복체크
	public int selectEch0101AjaxStmgChk(EgovMap map) {
		return (int) select("Ech0101DAO.selectEch0101AjaxStmgChk", map);
	}
	// 참여연구담당자 미등록 연구과제리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0101StmgInfo(EgovMap map) throws Exception {

		return (List<EgovMap>)list("Ech0101DAO.selectEch0101StmgInfo", map);
	}
	// 참여연구담당자 일괄 삭제
	public int updateEch0101AjaxSaveDelStaff(EgovMap map) throws Exception {
		return delete("Ech0101DAO.updateEch0101AjaxSaveDelStaff", map);
	}
	
	//연구코드중복 확인
	public int selectEch0101AjaxRsCdCheck(EgovMap map) {
		return (int) select("Ech0101DAO.selectEch0101AjaxRsCdCheck", map);
	}
	
	// DATA LOCK 설정 Ajax
	public void updateEch0101AjaxDataLock(EgovMap map) throws Exception {
		update("Ech0101DAO.updateEch0101AjaxDataLock", map);
	}
	
	// 시험물질 정보 등록
	public String insertEch0101Mtl(Rs1040mVO rs1040mVO) throws Exception {		
		 return (String)insert("Ech0101DAO.insertEch0101Mtl", rs1040mVO); 
	}
	
	// 시험물질 정보 상세보기
	public Rs1040mVO selectEch0101MtlView(Rs1040mVO rs1040mVO) {
		return (Rs1040mVO)select("Ech0101DAO.selectEch0101MtlView", rs1040mVO); 
	}
	
	// 시험물질 정보 등록 Ajax
	public String insertEch0101AjaxSaveMtl(EgovMap map) throws Exception {
		return (String)insert("Ech0101DAO.insertEch0101AjaxSaveMtl", map);
	}
	
	// 시험물질 정보 수정 Ajax
	public void updateEch0101AjaxSaveMtl(EgovMap map) throws Exception {
		update("Ech0101DAO.updateEch0101AjaxSaveMtl", map);
	}
	
	
	// 시험물질 정보 일괄 삭제
	public int updateEch0101AjaxSaveDelMtl(EgovMap map) throws Exception {
		return delete("Ech0101DAO.updateEch0101AjaxSaveDelMtl", map);
	}
	// 시험물질 정보 일괄 삭제 N/C
	public int updateEch0101AjaxSaveDelMtlNC(EgovMap map) throws Exception {
		return delete("Ech0101DAO.updateEch0101AjaxSaveDelMtlNC", map);
	}
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0101MtlList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountMtl = (Integer) select("Ech0101DAO.selectEch0101MtlListCnt", searchVO);
		List<EgovMap> resultListMtl = (List<EgovMap>) list("Ech0101DAO.selectEch0101MtlList", searchVO);
		
		return new CmmnListVO(totalRecordCountMtl, resultListMtl);
	}
	
	//시험물질 N/C 타입 리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0101MtlInfo(EgovMap map) throws Exception {

		return (List<EgovMap>)list("Ech0101DAO.selectEch0101MtlInfo", map);
	}
	//시험물질 mtlDsp 중복체크
	public int selectEch0101AjaxMtlDspChk(EgovMap map) {
		return (int) select("Ech0101DAO.selectEch0101AjaxMtlDspChk", map);
	}

	// IRB심의관리 등록
	public String insertEch0101Irb(Rs5000mVO rs5000mVO) throws Exception {		
		 return (String)insert("Ech0101DAO.insertEch0101Irb", rs5000mVO); 
	}
	
	// IRB심의관리 수정 
	public void updateEch0101Irb(Rs5000mVO rs5000mVO) throws Exception {
		update("Ech0101DAO.updateEch0101Irb", rs5000mVO); 
	}
	
	// IRB심의관리 상세보기
	public Rs5000mVO selectEch0101IrbView(Rs5000mVO rs5000mVO) {
		return (Rs5000mVO)select("Ech0101DAO.selectEch0101IrbView", rs5000mVO); 
	}
	
	// IRB심의관리 삭제
	public int updateEch0101AjaxDelIrb(EgovMap map) throws Exception {
		return delete("Ech0101DAO.updateEch0101AjaxDelIrb", map);
	}
	
	//IRB심의정보 중복 확인
	public int selectEch0101IrbCheck(EgovMap map) {
		return (int) select("Ech0101DAO.selectEch0101IrbCheck", map);
	}

	//연구과제 일괄등록 - 중복 연구코드 목록 산출
	public List<EgovMap> selectEch0101DupRsList(EgovMap map) {
		return (List<EgovMap>) list("Ech0101DAO.selectEch0101DupRsList", map);
	}
	
	//연구과제 일괄등록 - 연구과제 등ㅇ록
	public String insertEch0101RsUpload(RsUploadVO rsUploadVO) throws Exception {
		return (String) insert("Ech0101DAO.insertEch0101RsUpload", rsUploadVO);
	}

	//연구계획서 가져오기
	public Rs1010mVO selectEch0101AjaxRsCdCheck2(EgovMap map) {
		return (Rs1010mVO)select("Ech0101DAO.selectEch0101AjaxRsCdCheck2", map); 
	}	
	
	//연구계획서 가져오기
	public Rs1010mVO selectEch0101RsCdCheck3(EgovMap map) {
		return (Rs1010mVO)select("Ech0101DAO.selectEch0101RsCdCheck3", map); 
	}
	
	//연구코드로 연구차수정보 획득
	public Rs1000mVO selectEch0101ViewRsCd(Rs1000mVO rs1000mVO) throws Exception {
		return (Rs1000mVO) select("Ech0101DAO.selectEch0101ViewRsCd", rs1000mVO);
	}
	
	//연구코드로 업데이트
	public void updateEch0101RsCd(Rs1000mVO rs1000mVO) throws Exception {
		update("Ech0101DAO.updateEch0101RsCd", rs1000mVO);
	}
	
}
