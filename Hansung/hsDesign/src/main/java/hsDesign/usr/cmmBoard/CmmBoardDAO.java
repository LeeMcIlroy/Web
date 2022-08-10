package hsDesign.usr.cmmBoard;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.CBCommentVO;
import hsDesign.valueObject.CmmBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class CmmBoardDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectCmmBoardList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("CmmBoardDAO.selectCmmBoardListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("CmmBoardDAO.selectCmmBoardList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 등록
	public String insertCmmBoardOne(CmmBoardVO cmmBoardVO) {
		return (String) insert("CmmBoardDAO.insertCmmBoardOne", cmmBoardVO);
	}
	
	// 조회
	public CmmBoardVO selectCmmBoardOne(String cbSeq) {
		updateReadCntOne(cbSeq);
		return (CmmBoardVO) select("CmmBoardDAO.selectCmmBoardOne", cbSeq);
	}
	
	// 이전글 조회
	public CmmBoardVO selectCmmBoardPreOne(CmmBoardVO cmmBoardVO) {
		updateReadCntOne(cmmBoardVO.getCbSeq());
		return (CmmBoardVO) select("CmmBoardDAO.selectCmmBoardPreOne", cmmBoardVO);
	}
	
	// 삭제
	public void deleteCmmBoardOne(String cbSeq) {
		delete("CmmBoardDAO.deleteCmmBoardOne", cbSeq);
	}
	
	// 수정
	public void updateCmmBoardOne(CmmBoardVO cmmBoardVO) {
		update("CmmBoardDAO.updateCmmBoardOne", cmmBoardVO);
	}
	
	// 댓글 삭제(전체삭제)
	public void deleteCmmBoardCommentOne(String cbSeq) {
		delete("CmmBoardDAO.deleteCmmBoardCommentOne", cbSeq);
	}
		
	
	// 첨부파일 조회
	public List<EgovMap> selectCmmBoardUpfileList(String cbSeq){
		return (List<EgovMap>) list("CmmBoardDAO.selectCmmBoardUpfileList", cbSeq);
	}
	
	// 댓글 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectCmmBoardCommentList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("CmmBoardDAO.selectCmmBoardCommentListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("CmmBoardDAO.selectCmmBoardCommentList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 댓글 등록
	public void cmmBoardCommentInsert(CBCommentVO cbCommentVO) {
		insert("CmmBoardDAO.cmmBoardCommentInsert", cbCommentVO);
	}
	
	// 댓글 삭제
	public void cmmBoardCommentDelete(String cbcoSeq) {
		insert("CmmBoardDAO.cmmBoardCommentDelete", cbcoSeq);
	}
	
	// 댓글 수정
	public void cmmBoardCommentUpdate(CBCommentVO cbCommentVO) {
		update("CmmBoardDAO.cmmBoardCommentUpdate", cbCommentVO);
	}
	
	// 조회수 증가
	public void updateReadCntOne(String cbSeq) {
		update("CmmBoardDAO.updateReadCntOne", cbSeq);
	}
	
	
	// 비밀글 목록
	public List<CmmBoardVO> selectPasswordList() {
		return (List<CmmBoardVO>) list("CmmBoardDAO.selectPasswordList");
	}
	
	// 비밀글 암호화 입력
	public void updatePasswordList(CmmBoardVO cmmBoardVO) {
		update("CmmBoardDAO.updatePasswordList", cmmBoardVO);
	}
}
