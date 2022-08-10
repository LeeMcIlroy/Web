package writer.adm.cmm;

import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.AdminVO;
import writer.valueObject.cmmn.CmmnCommentVO;
import writer.valueObject.cmmn.CmmnListVO;

@Repository
public class AdmCmmCmmtDAO extends EgovAbstractDAO {
	

	/*********************************************** 우리반게시판 ***********************************************/
	// 우리반게시판 댓글 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecBoardCommentList(String ntSeq, String pageCmmtIndex){
		Map<String, String> map = new HashMap<>();
		map.put("ntSeq", ntSeq);
		map.put("pageCmmtIndex", pageCmmtIndex);
		int totalRecordCount = (int) select("CmmCmmtDAO.selectLecBoardCommentListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("CmmCmmtDAO.selectLecBoardCommentList", map);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 우리반게시판 댓글 등록
	public void lecBoardCommentInsert(CmmnCommentVO commentVO){
		if(EgovUserDetailsHelper.isAuthenticatedAdmin()){
			AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			commentVO.setRegId(adminVO.getMemCode());
			commentVO.setRegName(adminVO.getMemName());
		}
		insert("CmmCmmtDAO.lecBoardCommentInsert", commentVO);
	}
	
	// 우리반게시판 댓글 삭제
	public void lecBoardCommentDelete(String cmtSeq) {
		delete("CmmCmmtDAO.lecBoardCommentDelete", cmtSeq);
	}
	
	/*********************************************** 과제 ***********************************************/
	// 과제 댓글 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecHomeworkCommentList(String hmwkSeq, String pageCmmtIndex){
		Map<String, String> map = new HashMap<>();
		map.put("hmwkSeq", hmwkSeq);
		map.put("pageCmmtIndex", pageCmmtIndex);
		int totalRecordCount = (int) select("CmmCmmtDAO.selectLecHomeworkCommentListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("CmmCmmtDAO.selectLecHomeworkCommentList", map);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 과제 댓글 등록
	public void lecHomeworkCommentInsert(CmmnCommentVO commentVO) {
		if(EgovUserDetailsHelper.isAuthenticatedAdmin()){
			AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			commentVO.setRegId(adminVO.getMemCode());
			commentVO.setRegName(adminVO.getMemName());
		}
		insert("CmmCmmtDAO.lecHomeworkCommentInsert", commentVO);
	}
	
	// 과제 댓글 삭제
	public void lecHomeworkCommentDelete(String cmtSeq) throws UnknownHostException{
		delete("CmmCmmtDAO.lecHomeworkCommentDelete", cmtSeq);
	}
	
	/*********************************************** 자유게시판 ***********************************************/
	// 자유게시판 댓글 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectBoardMngFreeCommentList(String brdSeq, String pageCmmtIndex){
		Map<String, String> map = new HashMap<>();
		map.put("brdSeq", brdSeq);
		map.put("pageCmmtIndex", pageCmmtIndex);
		int totalRecordCount = (int) select("CmmCmmtDAO.selectBoardMngFreeCommentListCnt", map);
		List<EgovMap> resultList = (List<EgovMap>) list("CmmCmmtDAO.selectBoardMngFreeCommentList", map);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 자유게시판 댓글 등록
	public void boardMngFreeCommentInsert(CmmnCommentVO commentVO) {
		if(EgovUserDetailsHelper.isAuthenticatedAdmin()){
			AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
			commentVO.setRegId(adminVO.getMemCode());
			commentVO.setRegName(adminVO.getMemName());
		}
		insert("CmmCmmtDAO.boardMngFreeCommentInsert", commentVO);
	}
	
	// 자유게시판 댓글 삭제
	public void boardMngFreeCommentDelete(String cmtSeq) throws UnknownHostException{
		delete("CmmCmmtDAO.boardMngFreeCommentDelete", cmtSeq);
	}
}
