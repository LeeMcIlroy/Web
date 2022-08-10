package lcms.adm.regist;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import lcms.valueObject.RefFeeVO;
import lcms.valueObject.RegFeeVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmRegistDAO extends EgovAbstractDAO {

	// 업무담당자 가상계좌발급 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmAccoList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmRegistDAO.selectAdmAccoListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmRegistDAO.selectAdmAccoList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 가상계좌 발금처리
	public void updateAdmAccoSave(String seq) throws Exception {
		update("AdmRegistDAO.updateAdmAccoSave", seq);
	}

	// 업무담당자 등록금고지 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmTuinotiList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmRegistDAO.selectAdmTuinotiListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmRegistDAO.selectAdmTuinotiList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 등록금고지 학생 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAjaxStdList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmRegistDAO.selectAdmAjaxStdList", searchVO);
	}

	// 업무담당자 등록금고지 신청자 조회
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAjaxEnterList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmRegistDAO.selectAdmAjaxEnterList", searchVO);
	}

	// 업무담당자 등록금고지 등록
	public void insertAdmTuinoti(RegFeeVO regFeeVO) throws Exception {
		insert("AdmRegistDAO.insertAdmTuinoti", regFeeVO);
	}

	// 업무담당자 등록금납부 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmTuipayList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmRegistDAO.selectAdmTuipayListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmRegistDAO.selectAdmTuipayList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 등록금남부 조회
	public RegFeeVO selectAdmTuipayModify(String regSeq) throws Exception {
		return (RegFeeVO) select("AdmRegistDAO.selectAdmTuipayModify", regSeq);
	}

	// 업무담당자 등록금납부 수정
	public void updateAdmTuipayUpdate(RegFeeVO regFeeVO) throws Exception {
		update("AdmRegistDAO.updateAdmTuipayUpdate", regFeeVO);
	}

	// 업무담당자 환불 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectAdmRefList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (int) select("AdmRegistDAO.selectAdmRefListCnt", searchVO);
		List<EgovMap> egovList = (List<EgovMap>) list("AdmRegistDAO.selectAdmRefList", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	// 업무담당자 환불 등록
	public void insertAdmRefUpdate(RefFeeVO refFeeVO) throws Exception {
		insert("AdmRegistDAO.insertAdmRefUpdate", refFeeVO);
	}

	// 업무담당자 환불 조회
	public RefFeeVO selectAdmRefModify(String refSeq) throws Exception {
		return (RefFeeVO) select("AdmRegistDAO.selectAdmRefModify", refSeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectTuinotiPopList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("AdmRegistDAO.selectTuinotiPopList", map);
	}

	// 업무담당자 등록금고지 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmTuinotiExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmRegistDAO.selectAdmTuinotiExcel", searchVO);
	}

	// 업무담당자 등록금납부 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmTuipayExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmRegistDAO.selectAdmTuipayExcel", searchVO);
	}

	public void updateAdmAccoSaveOne(String studentCode) throws Exception {
		update("AdmRegistDAO.updateAdmAccoSaveOne", studentCode);
	}

	public String selectAdmAccount(String studentCode) throws Exception {
		return (String) select("AdmRegistDAO.selectAdmAccount", studentCode);
	}

	public RegFeeVO selectAdmTuinotiModify(String regSeq) throws Exception {
		return (RegFeeVO) select("AdmRegistDAO.selectAdmTuinotiModify", regSeq);
	}

	public void updateAdmTuinoti(RegFeeVO regFeeVO) throws Exception {
		update("AdmRegistDAO.updateAdmTuinoti", regFeeVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmAccoExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmRegistDAO.selectAdmAccoExcel", searchVO);
	}

	public void updateAdmRefUpdate(RefFeeVO refFeeVO) throws Exception {
		update("AdmRegistDAO.updateAdmRefUpdate", refFeeVO);
	}

	public RegFeeVO selectAdmTuinotiEnter(String enterNum) throws Exception {
		return (RegFeeVO) select("AdmRegistDAO.selectAdmTuinotiEnter", enterNum);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAdmRefExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmRegistDAO.selectAdmRefExcel", searchVO);
	}

	public void insertAdmAccoEmr(String seq) throws Exception {
		insert("AdmRegistDAO.insertAdmAccoEmr", seq);
	}

	public void updateAdmTuipayBat(EgovMap paramMap) throws Exception {
		update("AdmRegistDAO.updateAdmTuipayBat", paramMap);
	}

}
