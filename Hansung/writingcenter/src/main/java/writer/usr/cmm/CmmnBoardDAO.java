package writer.usr.cmm;

import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import writer.valueObject.BoardVO;
import writer.valueObject.CntstApplyVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class CmmnBoardDAO extends EgovAbstractDAO{

	/**
	 * 게시판 공통
	 * 2017-02-02
	 * */
	
	/* 목록 */
	@SuppressWarnings("unchecked")
	public CmmnListVO selectCmmnBoardList(CmmnSearchVO searchVO){
		int totalRecordCount=(int) select("CmmnBoardDAO.selectCmmnBoardListCnt", searchVO);
		List<EgovMap> egovList=(List<EgovMap>) list("CmmnBoardDAO.selectCmmnBoardList",searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	/* 공지글 목록 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmnBoardNoticeList(String brdType){
		return (List<EgovMap>) list("CmmnBoardDAO.selectCmmnBoardNoticeList", brdType);
	}
	
	/* 조회 */
	public BoardVO selectCmmnBoardOne(String brdSeq) throws UnknownHostException{
		update("CmmnBoardDAO.updateHitcountOne", brdSeq);
		return (BoardVO) select("CmmnBoardDAO.selectCmmnBoardOne",brdSeq);
	}
	
	/* 첨부파일 조회 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmnBoardUpfileList(String brdSeq) throws UnknownHostException{
		return (List<EgovMap>) list("CmmnBoardDAO.selectCmmnBoardUpfileList", brdSeq);
	}
	
	/* 첨부파일 등록 */
	public void insertCmmnBoardUpfileOne(Map<String, Object> map){
		insert("CmmnBoardDAO.insertCmmnBoardUpfileOne", map);
	}
	
	/* 첨부파일들 삭제 */
	public void deleteCmmnBoardUpfileList(List<String> upSeqList){
		delete("CmmnBoardDAO.deleteCmmnBoardUpfileList", upSeqList);
	}
	
	/* 첨부파일 삭제 */
	public void deleteCmmnboardUpfileOne(String upSeq){
		delete("CmmnBoardDAO.deleteCmmnboardUpfileOne", upSeq);
	}
	
	/* 삭제할 첨부파일 조회 */
	public EgovMap selectCmmnBoardUpfileOne(String upSeq){
		return (EgovMap) select("CmmnBoardDAO.selectCmmnBoardUpfileOne",upSeq);
	}
	
	/* 글쓰기 */
	@SuppressWarnings("unchecked")
	public String insertCmmnBoardOne(BoardVO boardVO){
		Map<String, String> userVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		boardVO.setRegId(userVO.get("memCode"));
		boardVO.setRegName(userVO.get("memName"));
		
		return (String) insert("CmmnBoardDAO.insertCmmnBoardOne", boardVO);
	}
	
	/* 글 삭제 */
	public void deleteCmmnBoardOne(String brdSeq){
		delete("CmmnBoardDAO.deleteCmmnBoardOne",brdSeq);
	}
	
	/* 글 수정 */
	public void updateCmmnBoardOne(BoardVO boardVO){
		update("CmmnBoardDAO.updateCmmnBoardOne",boardVO);
	}

	public EgovMap selectContestBoardOne(String param) throws Exception {
		return (EgovMap) select("CmmnBoardDAO.selectContestBoardOne", param);
	}

	public void insertContestBoard(CntstApplyVO cntstApplyVO) throws Exception {
		insert("CmmnBoardDAO.insertContestBoard", cntstApplyVO);
	}

	public void updateContestBoardCancel(String aplySeq) throws Exception {
		update("CmmnBoardDAO.updateContestBoardCancel", aplySeq);
	}

	public CntstApplyVO selectCntstApplyOne(Map<String, String> usrVO) throws Exception {
		return (CntstApplyVO) select("CmmnBoardDAO.selectCntstApplyOne", usrVO);
	}
	
}
