package ctms.adm.ech0102;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rm2000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Rs4000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0102DAO  extends EgovAbstractDAO {

	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0102List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0102DAO.selectEch0102ListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0102DAO.selectEch0102List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}

	public Rs2000mVO selectEch0102View(Rs2000mVO rs2000mVO) throws Exception {
		return (Rs2000mVO) select("Ech0102DAO.selectEch0102View", rs2000mVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102SubList(Rs1000mVO resultVO) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102SubList", resultVO);
	}

	public String insertEch0102(Rs2000mVO rs2000mVO) throws Exception {
		return (String) insert("Ech0102DAO.insertEch0102", rs2000mVO);
	}

	public void updateEch0102(Rs2000mVO rs2000mVO) throws Exception {
		update("Ech0102DAO.updateEch0102", rs2000mVO);
	}

	public int deleteEch0102(Rs2000mVO rs2000mVO) throws Exception {
		return delete("Ech0102DAO.deleteEch0102", rs2000mVO);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102Excel", searchVO);
	}

	
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0102RsjList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0102DAO.selectEch0102RsjListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0102DAO.selectEch0102RsjList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 연구과제 상세보기
	public Rs1010mVO selectEch0102RsView(Rs1010mVO rs1010mVO) {
		return (Rs1010mVO)select("Ech0102DAO.selectEch0102RsView", rs1010mVO); 
	}
	
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0102RsjList2(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0102DAO.selectEch0102RsjListCnt2", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0102DAO.selectEch0102RsjList2", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 연구대상자 최종확정 일괄수정
	public void updateEch0102AjaxSaveCfm(EgovMap map) throws Exception {
		update("Ech0102DAO.updateEch0102AjaxSaveCfm", map);
	}
	
	// 연구대상자 1차선정 일괄수정
	public void updateEch0102AjaxSaveFirst(EgovMap map) throws Exception {
		update("Ech0102DAO.updateEch0102AjaxSaveFirst", map);
	}
	
	// 연구대상자 선정정보 삭제
	public int updateEch0102AjaxSaveDel(EgovMap map) throws Exception {
		return delete("Ech0102DAO.updateEch0102AjaxSaveDel", map);
	}
	
	// 연구대상자 식별번호 일괄 부여(대상자 선별)
	@SuppressWarnings("unchecked")
	public List<Rs2000mVO> selectEch0102RsiCodeBat(EgovMap map) throws Exception {
		return (List<Rs2000mVO>) list("Ech0102DAO.selectEch0102RsiCodeBat", map);
	}
	
	// 연구대상자 식별번호 획득
	public String selectEch0102RsiCodeCnt(Rs2000mVO rs2000mVO) throws Exception {
		return (String) select("Ech0102DAO.selectEch0102RsiCodeCnt", rs2000mVO);
	}
	
	// update 연구대상자 식별번호 
	public void updateEch0102RsiCode(Rs2000mVO rs2000mVO) throws Exception {
		update("Ech0102DAO.updateEch0102RsiCode", rs2000mVO);
	}
	
	//스크린예약 팝업 대상자 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102SendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102SendList", map);
	}
	
	// 스크린예약관리 등록 Ajax
	public String insertEch0102AjaxSaveScr(EgovMap map) throws Exception {
		return (String)insert("Ech0102DAO.insertEch0102AjaxSaveScr", map);
	}

	//연구과제-연구대상자(피험자)별 예약 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102MtScrList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102MtScrList", paramMap);
	}
	
	// 스크리닝 예약관리 상세보기
	public Rs4000mVO selectEch0102MtView(Rs4000mVO rs4000mVO) {
		return (Rs4000mVO)select("Ech0102DAO.selectEch0102MtView", rs4000mVO); 
	}

	//SMS예문 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102SmsList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102SmsList", map);
	}	

	//SMS발송 팝업 대상자 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102SmsSendList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102SmsSendList", map);
	}
	
	// SMS 등록 Ajax
	public String insertEch0102AjaxSaveSms(EgovMap map) throws Exception {
		return (String)insert("Ech0102DAO.insertEch0102AjaxSaveSms", map);
	}
	
	//SMS예문 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch1002SmsList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch1002SmsList", map);
	}
	
	
	//예약SMS 대상 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102SendSmsMtList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102SendSmsMtList", map);
	
	}
	
	// 예약SMS 피험자 이름
	public Rm2000mVO selectEch0102RsjDetail(Rm2000mVO rm2000mVO) {
		return (Rm2000mVO)select("Ech0102DAO.selectEch0102RsjDetail", rm2000mVO); 
	}
	
	//연구과제의 피험자수를 업데이트한다  RS1010M RS_SCNT
	public void updateEch0102RsScnt(EgovMap map) throws Exception {
		update("Ech0102DAO.updateEch0102RsScnt", map);
	}
	
	//연구과제의 피험자수를 업데이트한다  RS1000M RS_SCNT
	public void updateEch0102RsScnt2(EgovMap map) throws Exception {
		update("Ech0102DAO.updateEch0102RsScnt2", map);
	}

	// 연구대상자 스크리닝번호 일괄 부여(대상자 선별)
	@SuppressWarnings("unchecked")
	public List<Rs2000mVO> selectEch0102StNoBat(EgovMap map) throws Exception {
		return (List<Rs2000mVO>) list("Ech0102DAO.selectEch0102StNoBat", map);
	}

	// 연구대상자 스크리닝번호 획득
	public String selectEch0102StNoCnt(Rs2000mVO rs2000mVO) throws Exception {
		return (String) select("Ech0102DAO.selectEch0102StNoCnt", rs2000mVO);
	}

	// 연구대상자 스크리닝번호 갱신 
	public void updateEch0102StNo(Rs2000mVO rs2000mVO) throws Exception {
		update("Ech0102DAO.updateEch0102StNo", rs2000mVO);
	}
	
	// 피험자선정-스크리닝대상자엑셀 다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102ExcelScrList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102ExcelScrList", searchVO);
	}
	
	// 피험자선정-확정자명단 엑셀 다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0102ExcelCfmList(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0102DAO.selectEch0102ExcelCfmList", searchVO);
	}
	
	// 피험자선정 연구대상자 상세보기
	public Rs2000mVO selectEch0102RsjmgView(Rs2000mVO rs2000mVO) {
		return (Rs2000mVO)select("Ech0102DAO.selectEch0102RsjmgView", rs2000mVO); 
	}
	
	// 연구대상자정보 수정 
	public void updateEch0102AjaxSaveRsjmg(EgovMap map) throws Exception {
		update("Ech0102DAO.updateEch0102AjaxSaveRsjmg", map); 
	}
	
	//연구책임자 확인
	public int selectEch0102RsDrtCnt(EgovMap map) {
		return (int) select("Ech0102DAO.selectEch0102RsDrtCnt", map);
	}

	//연구차수 목록
	public List<Rs1000mVO> selectEch0102RsList(EgovMap map) {
		return (List<Rs1000mVO>) list("Ech0102DAO.selectEch0102RsList", map);
	}
	
	// 연구대상자 식별번호 획득
	public Rs2000mVO selectEch0102(Rs2000mVO rs2000mVO) throws Exception {
		return (Rs2000mVO) select("Ech0102DAO.selectEch0102", rs2000mVO);
	}
	
}
