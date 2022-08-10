 package lcms.adm.entran;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.EnterVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmEntranDAO extends EgovAbstractDAO {

	// 신입학 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmEntranList(CmmnSearchVO searchVO) throws Exception {
		int totalCount = (int) select("AdmEntranDAO.selectAdmEntranListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmEntranDAO.selectAdmEntranList", searchVO);
		return new CmmnListVO(totalCount, resultList);
	}

	// 신입학 조회
	public EnterVO selectAdmEntranModify(String enterSeq) throws Exception {
		return (EnterVO) select("AdmEntranDAO.selectAdmEntranModify", enterSeq);
	}

	// 신청이력 리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectRecoList(EnterVO enterVO) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectRecoList", enterVO);
	}

	// 신입학 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmEntranExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectAdmEntranExcel", searchVO);
	}
	
	// 신입학 일련번호
	public String selectAdmEntranTotCnt(EnterVO enterVO) throws Exception {
		return (String) select("AdmEntranDAO.selectAdmEntranTotCnt", enterVO);
	}

	// 신입학 등록
	public String insertAdmEntran(EnterVO enterVO) throws Exception {
		return (String) insert("AdmEntranDAO.insertAdmEntran", enterVO);
	}

	// 신입학 수정
	public void updateAdmEntran(EnterVO enterVO) throws Exception {
		update("AdmEntranDAO.updateAdmEntran", enterVO);
	}
	// 재등록 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmRegistList(CmmnSearchVO searchVO) throws Exception {
		int totalCount = (int) select("AdmEntranDAO.selectAdmRegistListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmEntranDAO.selectAdmRegistList", searchVO);
		return new CmmnListVO(totalCount, resultList);
	}
	// 재등록 조회
	public EnterVO selectAdmReistModify(String enterSeq) throws Exception {
		return (EnterVO) select("AdmEntranDAO.selectAdmReistModify", enterSeq);
	}
	// 재등록 일련번호
	public String selectAdmReistTotCnt(EnterVO enterVO) throws Exception {
		return (String) select("AdmEntranDAO.selectAdmReistTotCnt", enterVO);
	}
	// 재등록
	public String insertAdmRegist(EnterVO enterVO) throws Exception {
		return (String)insert("AdmEntranDAO.insertAdmRegist", enterVO);
	}

	// 재등록수정
	public void updateAdmRegist(EnterVO enterVO) throws Exception {
		update("AdmEntranDAO.updateAdmRegist", enterVO);
	}
	
	// 재등록 신청이력 리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectRegiRecoList(EnterVO enterVO) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectRegiRecoList", enterVO);
	}
	
/*	// 관리자 재등록 학생 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAjaxStdRegiList(CmmnSearchVO searchVO) throws Exception{
		return (List<EgovMap>) list("AdmEntranDAO.selectAdmAjaxStdRegiList", searchVO);
	}*/

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAjaxStdRegiList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectAdmAjaxStdRegiList", map);
	}
	

	// 재등록 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmRegistExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectAdmRegistExcel", searchVO);
	}

	// 신입학 일괄 합격&불합격 처리
	public void updateAdmAjaxEntranBatch(EgovMap map) throws Exception {
		update("AdmEntranDAO.updateAdmAjaxEntranBatch", map);
	}
	
	// 신입학 비고 저장
	public void updateAdmAjaxSaveEtc(EgovMap map) throws Exception {
		update("AdmEntranDAO.updateAdmAjaxSaveEtc", map);
	}
	
	// 학생명단 리스트
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmEntranStdList(CmmnSearchVO searchVO) throws Exception {
		int totalCount = (int) select("AdmEntranDAO.selectAdmEntranStdListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmEntranDAO.selectAdmEntranStdList", searchVO);
		return new CmmnListVO(totalCount, resultList);
	}
	/*2022-06-01 추가 에이드정보기술 이형종  */
	
	//학번일괄부여 후 등록금고지테이블 학번업데이트
	public void updateAdmRegistMemberCode(EnterVO enterVO) throws Exception {
		update("AdmEntranDAO.updateAdmRegistMemberCode", enterVO);
	}
	
	/*끝 */

	// 학생명단 신청이력 리스트
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectStdRecoList(EnterVO enterVO) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectStdRecoList", enterVO);
	}
	
	// 학생명단 조회
	public EnterVO selectAdmStdModify(String enterSeq) throws Exception {
		return (EnterVO) select("AdmEntranDAO.selectAdmStdModify", enterSeq);
	}
	
	// 학생명단 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmStdListExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectAdmStdListExcel", searchVO);
	}

	// 업무담당자 신입학 합격자 리스트
	@SuppressWarnings("unchecked")
	public List<EnterVO> selectAdmEntranCodeBat(EgovMap paramMap) throws Exception {
		return (List<EnterVO>) list("AdmEntranDAO.selectAdmEntranCodeBat", paramMap);
	}

	// 업무담당자 신입학 일련번호
	public String selectAdmMCodeCnt(EnterVO enterVO) throws Exception {
		return (String) select("AdmEntranDAO.selectAdmMCodeCnt", enterVO);
	}

	public void insertAdmEntToMem(MemberVO memberVO) throws Exception {
		insert("AdmEntranDAO.insertAdmEntToMem", memberVO);
	}

	public void updateAdmEntranEnterCode(EnterVO enterVO) throws Exception {
		update("AdmEntranDAO.updateAdmEntranEnterCode", enterVO);
	}

	public void updateAdmAjaxSaveStep(EgovMap map) throws Exception {
		update("AdmEntranDAO.updateAdmAjaxSaveStep", map);
	}

	public String selectAdmReistOverYn(EnterVO enterVO) throws Exception {
		return (String) select("AdmEntranDAO.selectAdmReistOverYn", enterVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAjaxSelectStdList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectAdmAjaxSelectStdList", paramMap);
	}

	public void insertAdmAjaxSaveRereg(EgovMap paramMap) throws Exception {
		insert("AdmEntranDAO.insertAdmAjaxSaveRereg", paramMap);
	}

	public void updateAdmEntranAccountCode(EnterVO enterVO) throws Exception {
		update("AdmEntranDAO.updateAdmEntranAccountCode", enterVO);
	}

	public String selectAdmMemberDelYn(String enterCode) throws Exception {
		return (String) select("AdmEntranDAO.selectAdmMemberDelYn", enterCode);
	}

	public void deleteAdmMember(String enterCode) throws Exception {
		delete("AdmEntranDAO.deleteAdmMember", enterCode);
	}

	// 관리자 입학연기 목록 조회
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmDelayList(CmmnSearchVO searchVO) throws Exception {
		int totalCount = (int) select("AdmEntranDAO.selectAdmDelayListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmEntranDAO.selectAdmDelayList", searchVO);
		return new CmmnListVO(totalCount, resultList);
	}

	public EnterVO selectAdmDelayModify(String enterSeq) throws Exception {
		return (EnterVO) select("AdmEntranDAO.selectAdmDelayModify", enterSeq);
	}

	public EgovMap selectAdmRegistFee(String enterNum) throws Exception {
		return (EgovMap) select("AdmEntranDAO.selectAdmRegistFee", enterNum);
	}

	public void updateAdmDelayUpdate(EnterVO enterVO) throws Exception {
		update("AdmEntranDAO.updateAdmDelayUpdate", enterVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmDelayExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmEntranDAO.selectAdmDelayExcel", searchVO);
	}

	public void updateAdmAjaxSaveStepEnter(EgovMap map) throws Exception {
		update("AdmEntranDAO.updateAdmAjaxSaveStepEnter", map);
	}

	public void updateAdmEntranAccEmr(EnterVO enterVO) throws Exception {
		update("AdmEntranDAO.updateAdmEntranAccEmr", enterVO);
	}

	public String selectAdmEnroYn(EnterVO enterVO) throws Exception {
		return (String) select("AdmEntranDAO.selectAdmEnroYn", enterVO);
	}
	public void updateAdmEntranUseYn(EnterVO enterVO) throws Exception {
		update("AdmEntranDAO.updateUseYn", enterVO);
	}
	public void deleteAdmRereg(String enterSeq) throws Exception {
		delete("AdmEntranDAO.deleteAdmRereg", enterSeq);
	}

}
