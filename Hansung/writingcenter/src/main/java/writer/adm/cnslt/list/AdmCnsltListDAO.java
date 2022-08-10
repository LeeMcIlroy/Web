package writer.adm.cnslt.list;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.CnsltApplyVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmCnsltListDAO extends EgovAbstractDAO {
	
	// 상담신청 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectCnsltListList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmCnsltListDAO.selectCnsltListListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCnsltListDAO.selectCnsltListList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 상담신청 첨부파일 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCnsltListUpfileList(String aplySeq){
		return (List<EgovMap>) list("AdmCnsltListDAO.selectCnsltListUpfileList", aplySeq);
	}
	
	// 상담신청 조회
	public CnsltApplyVO selectCnsltListOne(String aplySeq) {
		return (CnsltApplyVO) select("AdmCnsltListDAO.selectCnsltListOne", aplySeq);
	}
	
	// 상담신청 답변 조회(공통)
	public CnsltApplyVO selectCnsltListTotOne(String aplySeq){
		return (CnsltApplyVO) select("AdmCnsltListDAO.selectCnsltListTotOne", aplySeq);
	}
	
	// 상담신청 답변 조회(재학생)
	public CnsltApplyVO selectCnsltListRegiOne(String aplySeq){
		return (CnsltApplyVO) select("AdmCnsltListDAO.selectCnsltListRegiOne", aplySeq);
	}
	
	// 상담신청 답변 조회(외국인)
	public CnsltApplyVO selectCnsltListOverOne(String aplySeq){
		return (CnsltApplyVO) select("AdmCnsltListDAO.selectCnsltListOverOne", aplySeq);
	}
	
	// 상담신청 첨부파일 조회
	public EgovMap selectCnsltListUpfileOne(String upSeq){
		return (EgovMap) select("AdmCnsltListDAO.selectCnsltListUpfileOne", upSeq);
	}
	
	// 상담신청 수정
	public void cnsltListUpdate(CnsltApplyVO cnsltApplyVO){
		update("AdmCnsltListDAO.cnsltListUpdate", cnsltApplyVO);
	}
	// 상담신청 삭제
	public void CnsltListDelete(String aplySeq) throws Exception {
		delete("AdmCnsltListDAO.cnsltListDelete", aplySeq);
	}
	
	/************************ 엑셀 다운로드 ************************/
	@SuppressWarnings("unchecked")
	public CmmnListVO selectExcelList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmCnsltListDAO.selectCnsltListListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCnsltListDAO.selectExcelList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	/**************************************** 2017-07-28 추가 ****************************************/
	// 상담 현황 조회
	public EgovMap selectCnsltListStatusOne(CmmnSearchVO searchVO){
		return (EgovMap) select("AdmCnsltListDAO.selectCnsltListStatusOne", searchVO);
	}

	public void cnsltRequestUpfileInsert(FileInfoVO fileInfoVO, String aplySeq) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("aplySeq", aplySeq);
		map.put("upType", "ANSW");
		insert("AdmCnsltListDAO.cnsltRequestUpfileInsert", map);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCnsltUpfileList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("AdmCnsltListDAO.selectCnsltUpfileList", map);
	}

	public void deleteCnsltUpfileList(EgovMap map) throws Exception {
		delete("AdmCnsltListDAO.deleteCnsltUpfileList", map);
	}
}
