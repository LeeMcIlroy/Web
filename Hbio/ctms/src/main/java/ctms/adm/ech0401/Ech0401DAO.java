package ctms.adm.ech0401;

import java.util.List;

import org.springframework.stereotype.Repository;

import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Cr3010mVO;
import ctms.valueObject.Cr3100mVO;
import ctms.valueObject.Cr3150mVO;
import ctms.valueObject.Cr3160mVO;
import ctms.valueObject.Cr3170mVO;
import ctms.valueObject.Cr3180mVO;
import ctms.valueObject.Cr3190mVO;
import ctms.valueObject.Cr3280mVO;
import ctms.valueObject.Cr3290mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class Ech0401DAO  extends EgovAbstractDAO {

	/* 시험결과추출 ****************************************************************************************************************************************************** */
	// 시험결과추출 목록
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0401List(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0401DAO.selectEch0401ListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0401DAO.selectEch0401List", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 연구과제 상세보기
	public Rs1000mVO selectEch0401View(Rs1000mVO rs1000mVO) {
		return (Rs1000mVO)select("Ech0401DAO.selectEch0401View", rs1000mVO); 
	}
		
	// 연구동의서관리 삭제
	public void deleteEch0401(Rs1000mVO rs1000mVO) {
		delete("Ech0401DAO.deleteEch0401", rs1000mVO);
		
	}
	// 연구동의서관리 등록
	public String insertEch0401(Rs1000mVO rs1000mVO) throws Exception {		
		 return (String)insert("Ech0401DAO.insertEch0401", rs1000mVO); 
	}
	
	// 연구동의서관리 수정 
	public void updateEch0401(Rs1000mVO rs1000mVO) throws Exception {
		update("Ech0401DAO.updateEch0401", rs1000mVO); 
	}
	 
	// 시험결과추출 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0401Excel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0401DAO.selectEch0401Excel", searchVO);
	}
	
	// 
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0401ResList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0401DAO.selectEch0401ResListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0401DAO.selectEch0401ResList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 피부자극 결과 목록 
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0401VlList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0401DAO.selectEch0401VlListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0401DAO.selectEch0401VlList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 리포트 목록 
	@SuppressWarnings("unchecked")	
	public CmmnListVO selectEch0401RptList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount = (Integer) select("Ech0401DAO.selectEch0401RptListCnt", searchVO);		                                         
		List<EgovMap> resultList = (List<EgovMap>) list("Ech0401DAO.selectEch0401RptList", searchVO);
		
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 피부자극결과 엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0401ExcelSkinStim(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0401DAO.selectEch0401ExcelSkinStim", searchVO);
	}
	
	
	// 연구대상자 피부자극결과 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3100mVO> selectEch0401RsiCodeBat(EgovMap map) throws Exception {
		return (List<Cr3100mVO>) list("Ech0401DAO.selectEch0401RsiCodeBat", map);
	}
	
	// 연구대상자 피부자극결과 일괄생성 대상 선별 - 음성대조군시험물질만 선별
	@SuppressWarnings("unchecked")
	public List<Cr3100mVO> selectEch0401RsiCodeBat2(EgovMap map) throws Exception {
		return (List<Cr3100mVO>) list("Ech0401DAO.selectEch0401RsiCodeBat2", map);
	}
	
	// 연구대상자 피부자극결과 일괄생성 대상 생성 
	public String insertEch0401AjaxSaveRst(Cr3150mVO cr3150mVO) throws Exception {
		return (String) insert("Ech0401DAO.insertEch0401AjaxSaveRst", cr3150mVO);
	}
	
	/*
	 * // 연구대상자 피부자극결과 일괄생성 대상 생성 h24 public String
	 * insertEch0401AjaxSaveRstH24(Cr3150mVO cr3150mVO) throws Exception { return
	 * (String) insert("Ech0102DAO.insertEch0401AjaxSaveRstH24", cr3150mVO); }
	 */
	
	// 연구대상자 피부자극결과 일괄삭제
	public int deleteEch0401Rst(EgovMap map) throws Exception {
		return delete("Ech0401DAO.deleteEch0401Rst", map);
	}
	
	// 연구대상자 특성결과 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3010mVO> selectEch0401SkinPropBat(EgovMap map) throws Exception {
		return (List<Cr3010mVO>) list("Ech0401DAO.selectEch0401SkinPropBat", map);
	}
	
	// 연구대상자 특성결과 일괄삭제
	public int deleteEch0401SkinProp(EgovMap map) throws Exception {
		return delete("Ech0401DAO.deleteEch0401SkinProp", map);
	}
	
	// 연구대상자 특성결과 일괄생성 
	public String insertEch0401AjaxSaveSkinProp(Cr3160mVO cr3160mVO) throws Exception {
		return (String) insert("Ech0401DAO.insertEch0401AjaxSaveSkinProp", cr3160mVO);
	}
	
	// 연구대상자 특성표제 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3010mVO> selectEch0401SkinPropBatTl(EgovMap map) throws Exception {
		return (List<Cr3010mVO>) list("Ech0401DAO.selectEch0401SkinPropBatTl", map);
	}
	
	// 연구대상자 특성표제 일괄삭제
	public int deleteEch0401SkinPropTl(EgovMap map) throws Exception {
		return delete("Ech0401DAO.deleteEch0401SkinPropTl", map);
	}
	
	// 연구대상자 특성표제 일괄생성 
	public String insertEch0401AjaxSaveSkinPropTl(Cr3170mVO cr3170mVO) throws Exception {
		return (String) insert("Ech0401DAO.insertEch0401AjaxSaveSkinPropTl", cr3170mVO);
	}
	
	// 연구대상자 일괄다운로드 대상 선별
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0401ListIcf(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0401DAO.selectEch0401ListIcf", searchVO);
	}
	
	// 연구대상자 특성  엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0401ExcelSkinProp(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0401DAO.selectEch0401ExcelSkinProp", searchVO);
	}
	
	// 연구대상자 사용성설문 결과 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3010mVO> selectEch0401CrfSvyBat11(EgovMap map) throws Exception {
		return (List<Cr3010mVO>) list("Ech0401DAO.selectEch0401CrfSvyBat11", map);
	}
	
	// 연구대상자 사용성설문 결과 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3010mVO> selectEch0401CrfSvyBat1(EgovMap map) throws Exception {
		return (List<Cr3010mVO>) list("Ech0401DAO.selectEch0401CrfSvyBat1", map);
	}
	
	// 연구대상자 사용성설문 결과 일괄삭제
	public int deleteEch0401CrfSvy1(EgovMap map) throws Exception {
		return delete("Ech0401DAO.deleteEch0401CrfSvy1", map);
	}
	
	// 연구대상자 사용성설문 표제 일괄삭제
	public int deleteEch0401CrfSvyTl1(EgovMap map) throws Exception {
		return delete("Ech0401DAO.deleteEch0401CrfSvyTl1", map);
	}
	
	// 연구대상자 사용성설문 표제 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3010mVO> selectEch0401CrfSvyBatTl1(EgovMap map) throws Exception {
		return (List<Cr3010mVO>) list("Ech0401DAO.selectEch0401CrfSvyBatTl1", map);
	}
	
	// 연구대상자 사용성설문 표제 일괄생성 
	public String insertEch0401AjaxSaveCrfSvyTl1(Cr3190mVO cr3190mVO) throws Exception {
		return (String) insert("Ech0401DAO.insertEch0401AjaxSaveCrfSvyTl1", cr3190mVO);
	}
	
	// 연구대상자 사용성설문 결과 일괄생성 
	public String insertEch0401AjaxSaveCrfSvy1(Cr3180mVO cr3180mVO) throws Exception {
		return (String) insert("Ech0401DAO.insertEch0401AjaxSaveCrfSvy1", cr3180mVO);
	}
	
	// 연구대상자 사용성설문  엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0401ExcelCrfSvy1(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0401DAO.selectEch0401ExcelCrfSvy1", searchVO);
	}
	
	// 연구대상자 효능설문 결과 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3010mVO> selectEch0401CrfSvyBat2(EgovMap map) throws Exception {
		return (List<Cr3010mVO>) list("Ech0401DAO.selectEch0401CrfSvyBat2", map);
	}
	
	// 연구대상자 효능설문 결과 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3010mVO> selectEch0401CrfSvyBat21(EgovMap map) throws Exception {
		return (List<Cr3010mVO>) list("Ech0401DAO.selectEch0401CrfSvyBat21", map);
	}
		
	// 연구대상자 효능설문 결과 일괄삭제
	public int deleteEch0401CrfSvy2(EgovMap map) throws Exception {
		return delete("Ech0401DAO.deleteEch0401CrfSvy2", map);
	}
	
	// 연구대상자 효능설문 표제 일괄삭제
	public int deleteEch0401CrfSvyTl2(EgovMap map) throws Exception {
		return delete("Ech0401DAO.deleteEch0401CrfSvyTl2", map);
	}
	
	// 연구대상자 효능설문 표제 일괄생성 대상 선별
	@SuppressWarnings("unchecked")
	public List<Cr3010mVO> selectEch0401CrfSvyBatTl2(EgovMap map) throws Exception {
		return (List<Cr3010mVO>) list("Ech0401DAO.selectEch0401CrfSvyBatTl2", map);
	}
	
	// 연구대상자 효능설문 표제 일괄생성 
	public String insertEch0401AjaxSaveCrfSvyTl2(Cr3290mVO cr3290mVO) throws Exception {
		return (String) insert("Ech0401DAO.insertEch0401AjaxSaveCrfSvyTl2", cr3290mVO);
	}
	
	// 연구대상자 효능설문 결과 일괄생성 
	public String insertEch0401AjaxSaveCrfSvy2(Cr3280mVO cr3280mVO) throws Exception {
		return (String) insert("Ech0401DAO.insertEch0401AjaxSaveCrfSvy2", cr3280mVO);
	}
	
	// 연구대상자 효능설문  엑셀다운로드
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0401ExcelCrfSvy2(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("Ech0401DAO.selectEch0401ExcelCrfSvy2", searchVO);
	}
	
	//연구차수 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectEch0401RsSeqList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCountRs = (Integer) select("Ech0401DAO.selectEch0401RsSeqListCnt", searchVO);
		List<EgovMap> resultListRs = (List<EgovMap>) list("Ech0401DAO.selectEch0401RsSeqList", searchVO);
		
		return new CmmnListVO(totalRecordCountRs, resultListRs);
	}
	
	// 연구차수 연구대상자 특성결과 일괄삭제
	public int deleteEch0401SkinPropRsSeq(EgovMap map) throws Exception {
		return delete("Ech0401DAO.deleteEch0401SkinPropRsSeq", map);
	}
	
	// 연구차수 연구대상자 특성결과 일괄생성 
	public String insertEch0401AjaxSaveSkinPropRsSeq(EgovMap map) throws Exception {
		return (String) insert("Ech0401DAO.insertEch0401AjaxSaveSkinPropRsSeq", map);
	}
	/* 시험결과추출 ****************************************************************************************************************************************************** */
	
}
