package writer.usr.cnslt;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.CnsltApplyVO;
import writer.valueObject.CnsltScheduleVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class CnsltDAO extends EgovAbstractDAO {

	/****************************************** 상담신청 ******************************************/
	// 상담일정 목록
	@SuppressWarnings("unchecked")
	public List<CnsltScheduleVO> selectCnsltScheduleList(String schYmd, String flag){
		Map<String, String> map = new HashMap<>();
		map.put("schYmd", schYmd);
		map.put("flag", flag);
		
		return (List<CnsltScheduleVO>) list("CnsltDAO.selectCnsltScheduleList", map);
	}
	
	// 상담일정 체크
	@SuppressWarnings("unchecked")
	public int selectCnsltScheduleCheck(String schSeq){
		return (int) select("CnsltDAO.selectCnsltScheduleCheck", schSeq);
	}
	
	// 상담 신청(재학생)
	public String cnsltRequestRegiInsert(CnsltApplyVO cnsltApplyVO){
		// 신청서 등록(TB_HSWC_CNSLT_APLY)
		String rsAplySeq = (String) insert("CnsltDAO.cnsltApplyInsert", cnsltApplyVO);
		
		// 재학생 답변 등록(TB_HSWC_CNSLT_REGI_ANS)
		Map<String, Object> map = new HashMap<>();
		map.put("cnsltApplyVO", cnsltApplyVO);
		map.put("aplySeq", rsAplySeq);
		insert("CnsltDAO.cnsltRegiAnswerInsert", map);
		
		// 공통 답변 등록(TB_HSWC_CNSLT_TOT_ANS)
		insert("CnsltDAO.cnsltTotAnswerInsert", map);
		return rsAplySeq;
	}
	
	// 상담 신청(외국인)
	public String cnsltRequestOverInsert(CnsltApplyVO cnsltApplyVO){
		// 신청서 등록(TB_HSWC_CNSLT_APLY)
		String rsAplySeq = (String) insert("CnsltDAO.cnsltApplyInsert", cnsltApplyVO);
		
		// 외국인 답변 등록(TB_HSWC_CNSLT_OVER_ANS)
		Map<String, Object> map = new HashMap<>();
		map.put("cnsltApplyVO", cnsltApplyVO);
		map.put("aplySeq", rsAplySeq);
		insert("CnsltDAO.cnsltOverAnswerInsert", map);
		
		// 공통 답변 등록(TB_HSWC_CNSLT_TOT_ANS)
		insert("CnsltDAO.cnsltTotAnswerInsert", map);
		return rsAplySeq;
	}
	
	// 상담신청 첨부파일 등록
	public void cnsltRequestUpfileInsert(FileInfoVO fileInfoVO, String aplySeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("aplySeq", aplySeq);
		insert("CnsltDAO.cnsltRequestUpfileInsert", map);
	}
	
	/****************************************** 마이페이지 ******************************************/
	// 상담 신청 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectCnsltRecordList(CmmnSearchVO searchVO){
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, Object> map = new HashMap<>();
		map.put("searchVO", searchVO);
		map.put("userVO", userVO);
		int totalRecordCount = (int) select("CnsltDAO.selectCnsltRecordListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("CnsltDAO.selectCnsltRecordList", map);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 상담 신청 취소 (삭제)
	public void deleteCnsltInfoOne(String aplySeq,  String aplyUsrType ){
		/**
		 * 2018-05-28 celldio 수정
		 * 	- 데이터 삭제에서 FLAG 값 변경으로 수정
		 * 	- TB_HSWC_CNSLT_APLY 테이블의 APLY_STATUS 수정
		 * 		- 4 : 상담취소 .... 추가 
		 * 
		 */
		update("CnsltDAO.updateCnsltCancel", aplySeq);
		
		/*
		delete("CnsltDAO.deleteCnsltAplyOne", aplySeq);
		delete("CnsltDAO.deleteCnsltCommonOne", aplySeq);
		if("REGI".equals(aplyUsrType)){
			delete("CnsltDAO.deleteCnsltRegiOne", aplySeq);
		}else if("OVER".equals(aplyUsrType)){
			delete("CnsltDAO.deleteCnsltOverOne", aplySeq);
		}
		*/
	}
	// 상담 첨부파일 목록
	public List<EgovMap> selectCnsltUpfileList(String aplySeq){
		return (List<EgovMap>) list("CnsltDAO.selectCnsltUpfileList", aplySeq);
	}
	
	// 상담 첨부파일 조회
	public EgovMap selectCnsltUpfileOne(String upSeq){
		return (EgovMap) select("CnsltDAO.selectCnsltUpfileList", upSeq);
	}
	
	
	// 상담 첨부파일 삭제
	public void deleteCnsltUpfileList(List<String> upSeqList){
		delete("CnsltDAO.deleteCnsltUpfileList", upSeqList);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectNewCnsltUpfileList() throws Exception {
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		Map<String, Object> map = new HashMap<>();
		map.put("userVO", userVO);
		return (List<EgovMap>) list("CnsltDAO.selectNewCnsltUpfileList", map);
	}
	
}
