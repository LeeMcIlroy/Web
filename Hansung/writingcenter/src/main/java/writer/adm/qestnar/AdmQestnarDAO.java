package writer.adm.qestnar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.ClassVO;
import writer.valueObject.QestnarAskVO;
import writer.valueObject.QestnarReplyVO;
import writer.valueObject.QestnarVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmQestnarDAO extends EgovAbstractDAO {
	
	// 설문조사 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectQestnarInfoList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmQestnarDAO.selectQestnarInfoListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmQestnarDAO.selectQestnarInfoList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 설문조사_기본 등록
	public String insertQestnarInfoOne(QestnarVO qestnarVO){
		return (String) insert("AdmQestnarDAO.insertQestnarInfoOne", qestnarVO);
	}
	
	public void insertQestnarAskOne(QestnarAskVO qestnarAskVO){
		insert("AdmQestnarDAO.insertQestnarAskOne", qestnarAskVO);
	}
	
	public void insertQestnarReplyOne(QestnarReplyVO qestnarReplyVO){
		insert("AdmQestnarDAO.insertQestnarReplyOne", qestnarReplyVO);
	}
	
	//설문조사_답변자 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectQestnarAnswererList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmQestnarDAO.selectQestnarAnswererListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmQestnarDAO.selectQestnarAnswererList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	//수강교실 목록
	@SuppressWarnings("unchecked")
	public List<ClassVO> selectClassList(CmmnSearchVO searchVO){
		return (List<ClassVO>) list("AdmQestnarDAO.selectClassList", searchVO);
	}
	
	//설문조사 삭제
	public void deleteQstnrInfoOne(String qstnrSeq){
		delete("AdmQestnarDAO.deleteQestnarInfoOne",qstnrSeq);
	}
	
	public void deleteQstnrAskOne(String qstnrSeq){
		delete("AdmQestnarDAO.deleteQestnarAskOne",qstnrSeq);
	}
	
	public void deleteQstnrReplyOne(String qstnrSeq){
		delete("AdmQestnarDAO.deleteQestnarReplyOne",qstnrSeq);
	}
	
	//설문조사 조회
	public QestnarVO selectQestnarInfoOne(String qstnrSeq){
		return (QestnarVO) select("AdmQestnarDAO.selectQestnarInfoOne", qstnrSeq);
	}
	
	@SuppressWarnings("unchecked")
	public List<QestnarAskVO> selectQestnarAskOne(String qstnrSeq){
		return (List<QestnarAskVO>) list("AdmQestnarDAO.selectQestnarAskOne", qstnrSeq);
	}
	
	@SuppressWarnings("unchecked")
	public List<QestnarReplyVO> selectQestnarReplyOne(String qstnrSeq){
		return (List<QestnarReplyVO>) list("AdmQestnarDAO.selectQestnarReplyOne",  qstnrSeq);
	}
	
	//답변자 cnt
	public int selectQestnarAnswererListCnt(CmmnSearchVO searchVO){
		return (int) select("AdmQestnarDAO.selectQestnarAnswererListCnt", searchVO);
	}
	
	//설문조사_기본수정
	public void updateQestnarInfoOne(QestnarVO qestnarVO ){
		update("AdmQestnarDAO.updateQestnarInfoOne", qestnarVO);
	}
	
	/******************************************** 2017-07-25 추가 ********************************************/	
	// 설문조사 주관식 답변 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectSubAnswerList(String qstnrSeq, String askNo){
		Map<String, String> map = new HashMap<>();
		map.put("qstnrSeq", qstnrSeq);
		map.put("askNo", askNo);
		return (List<EgovMap>) list("AdmQestnarDAO.selectSubAnswerList", map);
	}
}
