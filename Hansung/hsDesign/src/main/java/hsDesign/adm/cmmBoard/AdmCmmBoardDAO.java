package hsDesign.adm.cmmBoard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import component.file.FileInfoVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.AdminVO;
import hsDesign.valueObject.CBCommentVO;
import hsDesign.valueObject.CBUpfileVO;
import hsDesign.valueObject.CmmBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmCmmBoardDAO extends EgovAbstractDAO {

	/***************************************************** 글 *****************************************************/
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectCmmBoardList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmCmmBoardDAO.selectCmmBoardListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCmmBoardDAO.selectCmmBoardList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public CmmBoardVO selectCmmBoardOne(String cbSeq){
		return (CmmBoardVO) select("AdmCmmBoardDAO.selectCmmBoardOne", cbSeq);
	}
	
	// 등록
	public String cmmBoardInsert(CmmBoardVO cmmBoardVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		Map<String, Object> map = new HashMap<>();
		map.put("adminVO", adminVO);
		map.put("cmmBoardVO", cmmBoardVO);
		
		return (String) insert("AdmCmmBoardDAO.cmmBoardInsert", map);
	}
	
	// 수정
	public void cmmBoardUpdate(CmmBoardVO cmmBoardVO){
		update("AdmCmmBoardDAO.cmmBoardUpdate", cmmBoardVO);
	} 
	
	/************************jin 추가 불러오기*********************************************************************/
	public void cmmBoardContentReply(CmmBoardVO cmmBoardVO) {
		
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		Map<String, Object> map = new HashMap<>();
		map.put("adminVO", adminVO);
		map.put("cmmBoardVO", cmmBoardVO);
		
	   System.out.println("답변 왔음?="+cmmBoardVO.getCbContentReply());
	   System.out.println("게시판 번호는 ?="+cmmBoardVO.getCbSeq());
	   System.out.println("게시판 작성자 이름은 ?="+adminVO.getAdmName());
	 
	   update("AdmCmmBoardDAO.cmmBoardContentReply", map);
	}
	/************************jin 추가 불러오기*********************************************************************/
	
	// 삭제
	public void cmmBoardDelete(String cbSeq){
		delete("AdmCmmBoardDAO.cmmBoardDelete", cbSeq);
	}
	
	// 썸네일 관련 update
	public void cmmBoardThumbFileUpdate(FileInfoVO fileInfoVO, String cbSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("cbSeq", cbSeq);
		update("AdmCmmBoardDAO.cmmBoardThumbFileUpdate", map);
	}
	
	/***************************************************** 첨부파일 *****************************************************/
	// 목록
	@SuppressWarnings("unchecked")
/*
	public List<CBUpfileVO> selectCmmBoardUpfileList(String cbSeq){
		return (List<CBUpfileVO>) list("AdmCmmBoardDAO.selectCmmBoardUpfileList", cbSeq);
	}
*/
	public CmmnListVO selectCmmBoardUpfileList(String cbSeq){
		int totalRecordCount = (int) select("AdmCmmBoardDAO.selectCmmBoardUpfileListCnt", cbSeq);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCmmBoardDAO.selectCmmBoardUpfileList", cbSeq);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public CBUpfileVO selectCmmBoardUpfileOne(String cbupSeq){
		return (CBUpfileVO) select("AdmCmmBoardDAO.selectCmmBoardUpfileOne", cbupSeq);
	}
	
	// 등록
	public void cmmBoardUpfileInsert(FileInfoVO fileInfoVO, String cbSeq){
		Map<String, Object> map = new HashMap<>();
		map.put("fileInfoVO", fileInfoVO);
		map.put("cbSeq", cbSeq);
		insert("AdmCmmBoardDAO.cmmBoardUpfileInsert", map);
	}
	
	// 삭제
	public void cmmBoardUpfileDelete(String cbupSeq){
		delete("AdmCmmBoardDAO.cmmBoardUpfileDelete", cbupSeq);
	}
	
	/***************************************************** 댓글 *****************************************************/
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectCmmBoardCommentList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmCmmBoardDAO.selectCmmBoardCommentListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmCmmBoardDAO.selectCmmBoardCommentList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public CBCommentVO selectCmmBoardCommentOne(String cbcoSeq){
		return (CBCommentVO) select("AdmCmmBoardDAO.selectCmmBoardCommentOne", cbcoSeq);
	}
	
	// 등록: 관리자 정보 가져옴
	public String cmmBoardCommentInsert(CBCommentVO cbCommentVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		Map<String, Object> map = new HashMap<>();
		map.put("adminVO", adminVO);
		map.put("cbCommentVO", cbCommentVO);
		return (String) insert("AdmCmmBoardDAO.cmmBoardCommentInsert", map);
	}

	// 삭제
	public void cmmBoardCommentDelete(String cbcoSeq){
		delete("AdmCmmBoardDAO.cmmBoardCommentDelete", cbcoSeq);
	}
	
	/***************************************썸네일 불러오기*********************************************************************/

	public String selectShowOldImage(String oldSeq) {
		return (String) select("AdmCmmBoardDAO.selectShowOldImage", oldSeq);
	}
	
}
