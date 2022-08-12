package ctms.adm.ech0105;

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
public class Ech0105DAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0105List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0105DAO.selectEch0105ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0105DAO.selectEch0105List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	public Rs1000mVO selectEch0105View(Rs1000mVO rs1000mVO) throws Exception {
		return (Rs1000mVO) select("Ech0105DAO.selectEch0105View", rs1000mVO);
	}

	public String insertEch0105(Rs1000mVO rs1000mVO) throws Exception {
		return (String) insert("Ech0105DAO.insertEch0105", rs1000mVO);
	}

	public void updateEch0105(Rs1000mVO rs1000mVO) throws Exception {
		update("Ech0105DAO.updateEch0105", rs1000mVO);
	}

	//DEL_YN = "Y" 설정
	public void updateEch0105DelYn(EgovMap map) throws Exception {
		update("Ech0105DAO.updateEch0105DelYn", map);
	}
	
	public int deleteEch0105(Rs1000mVO rs1000mVO) throws Exception {
		return delete("Ech0105DAO.deleteEch0105", rs1000mVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0105Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0105DAO.selectEch0105Excel", searchVO);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0105JoinBranchList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountBranch = (Integer) select("Ech0105DAO.selectEch0105JoinBranchListCnt", searchVO);
		List<EgovMap> resultListBranch = (List<EgovMap>) list("Ech0105DAO.selectEch0105JoinBranchList", searchVO);
		
		return new CmmnListVO(totalRecordCountBranch, resultListBranch);
	}
	
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0105JoinEmpList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountEmp = (Integer) select("Ech0105DAO.selectEch0105JoinEmpListCnt", searchVO);
		List<EgovMap> resultListEmp = (List<EgovMap>) list("Ech0105DAO.selectEch0105JoinEmpList", searchVO);
		
		return new CmmnListVO(totalRecordCountEmp, resultListEmp);
	}
	
	// 참여지사관리 팝업
	public Rs1020mVO selectEch0105BrmgPop(Rs1020mVO rs1020mVO) {
		return (Rs1020mVO)select("Ech0105DAO.selectEch0105BrmgPop", rs1020mVO); 
	}

	// 참여지사관리 등록 Ajax
	public String insertEch0105AjaxSaveStep(EgovMap map) throws Exception {
		return (String)insert("Ech0105DAO.insertEch0105AjaxSaveStep", map);
	}
	
	// 참여지사관리 수정 Ajax
	public void updateEch0105AjaxSaveStep(EgovMap map) throws Exception {
		update("Ech0105DAO.updateEch0105AjaxSaveStep", map);
	}
	
	// 참여지사관리 상세보기
	public Rs1020mVO selectEch0105BrView(Rs1020mVO rs1020mVO) {
		return (Rs1020mVO)select("Ech0105DAO.selectEch0105BrView", rs1020mVO); 
	}
	
	// 참여지사 일괄 삭제
	public int updateEch0105AjaxSaveDel(EgovMap map) throws Exception {
		return delete("Ech0105DAO.updateEch0105AjaxSaveDel", map);
	}

	// 참여연구담당자 팝업
	public Rs1030mVO selectEch0105StmgPop(Rs1030mVO rs1030mVO) {
		return (Rs1030mVO)select("Ech0105DAO.selectEch0105StmgPop", rs1030mVO); 
	}

	// 참여연구담당자 등록 Ajax
	public String insertEch0105AjaxSaveStaff(EgovMap map) throws Exception {
		return (String)insert("Ech0105DAO.insertEch0105AjaxSaveStaff", map);
	}
	// 참여연구담당자 수정 Ajax
	public void updateEch0105AjaxSaveStaff(EgovMap map) throws Exception {
		update("Ech0105DAO.updateEch0105AjaxSaveStaff", map);
	}
	
	// 참여연구담당자 상세보기
	public Rs1030mVO selectEch0105StView(Rs1030mVO rs1030mVO) {
		return (Rs1030mVO)select("Ech0105DAO.selectEch0105StView", rs1030mVO); 
	}
	
	// 참여연구담당자 일괄 삭제
	public int updateEch0105AjaxSaveDelStaff(EgovMap map) throws Exception {
		return delete("Ech0105DAO.updateEch0105AjaxSaveDelStaff", map);
	}
	
	//연구코드중복 확인
	public int selectEch0105AjaxRsCdCheck(EgovMap map) {
		return (int) select("Ech0105DAO.selectEch0105AjaxRsCdCheck", map);
	}
	
	// DATA LOCK 설정 Ajax
	public void updateEch0105AjaxDataLock(EgovMap map) throws Exception {
		update("Ech0105DAO.updateEch0105AjaxDataLock", map);
	}
	
	// 시험물질 정보 등록
	public String insertEch0105Mtl(Rs1040mVO rs1040mVO) throws Exception {		
		 return (String)insert("Ech0105DAO.insertEch0105Mtl", rs1040mVO); 
	}
	
	// 시험물질 정보 상세보기
	public Rs1040mVO selectEch0105MtlView(Rs1040mVO rs1040mVO) {
		return (Rs1040mVO)select("Ech0105DAO.selectEch0105MtlView", rs1040mVO); 
	}
	
	// 시험물질 정보 등록 Ajax
	public String insertEch0105AjaxSaveMtl(EgovMap map) throws Exception {
		return (String)insert("Ech0105DAO.insertEch0105AjaxSaveMtl", map);
	}
	
	// 시험물질 정보 수정 Ajax
	public void updateEch0105AjaxSaveMtl(EgovMap map) throws Exception {
		update("Ech0105DAO.updateEch0105AjaxSaveMtl", map);
	}
	
	// 시험물질 정보 일괄 삭제
	public int updateEch0105AjaxSaveDelMtl(EgovMap map) throws Exception {
		return delete("Ech0105DAO.updateEch0105AjaxSaveDelMtl", map);
	}
	
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0105MtlList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountMtl = (Integer) select("Ech0105DAO.selectEch0105MtlListCnt", searchVO);
		List<EgovMap> resultListMtl = (List<EgovMap>) list("Ech0105DAO.selectEch0105MtlList", searchVO);
		
		return new CmmnListVO(totalRecordCountMtl, resultListMtl);
	}
	
	// IRB심의관리 등록
	public String insertEch0105Irb(Rs5000mVO rs5000mVO) throws Exception {		
		 return (String)insert("Ech0105DAO.insertEch0105Irb", rs5000mVO); 
	}
	
	// IRB심의관리 수정 
	public void updateEch0105Irb(Rs5000mVO rs5000mVO) throws Exception {
		update("Ech0105DAO.updateEch0105Irb", rs5000mVO); 
	}
	
	// IRB심의관리 상세보기
	public Rs5000mVO selectEch0105IrbView(Rs5000mVO rs5000mVO) {
		return (Rs5000mVO)select("Ech0105DAO.selectEch0105IrbView", rs5000mVO); 
	}
	
	// IRB심의관리 삭제
	public int updateEch0105AjaxDelIrb(EgovMap map) throws Exception {
		return delete("Ech0105DAO.updateEch0105AjaxDelIrb", map);
	}
	
	//IRB심의정보 중복 확인
	public int selectEch0105IrbCheck(EgovMap map) {
		return (int) select("Ech0105DAO.selectEch0105IrbCheck", map);
	}

	//연구과제 일괄등록 - 중복 연구코드 목록 산출
	public List<EgovMap> selectEch0105DupRsList(EgovMap map) {
		return (List<EgovMap>) list("Ech0105DAO.selectEch0105DupRsList", map);
	}
	
	//연구과제 일괄등록 - 연구과제 등록
	public String insertEch0105RsUpload(RsUploadVO rsUploadVO) throws Exception {
		return (String) insert("Ech0105DAO.insertEch0105RsUpload", rsUploadVO);
	}
	
	//연구차수 중복 확인
	public int selectEch0105RsCdCheck(EgovMap map) {
		return (int) select("Ech0105DAO.selectEch0105RsCdCheck", map);
	}	

	//연구차수 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0105RsList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountRs = (Integer) select("Ech0105DAO.selectEch0105RsListCnt", searchVO);
		List<EgovMap> resultListRs = (List<EgovMap>) list("Ech0105DAO.selectEch0105RsList", searchVO);
		
		return new CmmnListVO(totalRecordCountRs, resultListRs);
	}
	
	//Negative Control 시험물질 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0105MtlList2(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountMtl2 = (Integer) select("Ech0105DAO.selectEch0105MtlListCnt2", searchVO);
		List<EgovMap> resultListMtl2 = (List<EgovMap>) list("Ech0105DAO.selectEch0105MtlList2", searchVO);
		
		return new CmmnListVO(totalRecordCountMtl2, resultListMtl2);
	}
	
	// 참여지사 미등록 연구과제리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0105BrmgInfo(EgovMap map) throws Exception {
		return (List<EgovMap>)list("Ech0105DAO.selectEch0105BrmgInfo", map);
	}
	
	// 참여지사  중복체크(일괄)
	public int selectEch0105AjaxBrmgChk(EgovMap map) {
		return (int) select("Ech0105DAO.selectEch0105AjaxBrmgChk", map);
	}
	
	// 참여지사  중복체크
	public int selectEch0105AjaxBrmgChkOne(EgovMap map) {
		return (int) select("Ech0105DAO.selectEch0105AjaxBrmgChkOne", map);
	}
	
	//시험물질 N/C 타입 리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0105MtlInfo(EgovMap map) throws Exception {

		return (List<EgovMap>)list("Ech0105DAO.selectEch0105MtlInfo", map);
	}
	
	// 연구차수 DATA LOCK 설정 Ajax
	public void updateEch0105AjaxDataLockRsSeq(EgovMap map) throws Exception {
		update("Ech0105DAO.updateEch0105AjaxDataLockRsSeq", map);
	}
	
	// IRB승인 필요여부 재설정 'N'
	public void updateEch0105AjaxRsIrbsm(EgovMap map) throws Exception {
		update("Ech0105DAO.updateEch0105AjaxRsIrbsm", map);
	}
}
