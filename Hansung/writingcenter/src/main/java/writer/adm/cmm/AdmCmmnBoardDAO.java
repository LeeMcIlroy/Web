package writer.adm.cmm;

import java.net.UnknownHostException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.AdminVO;
import writer.valueObject.BoardVO;
import writer.valueObject.CntstApplyVO;
import writer.valueObject.ContestVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmCmmnBoardDAO extends EgovAbstractDAO {
	/**
	 * 게시판 공통
	 * 2017-02-02
	 * */
	
	/* 목록 */
	@SuppressWarnings("unchecked")
	public CmmnListVO selectCmmnBoardList(CmmnSearchVO searchVO){
		int totalRecordCount=(int) select("AdmCmmnBoardDAO.selectCmmnBoardListCnt", searchVO);
		List<EgovMap> egovList=(List<EgovMap>) list("AdmCmmnBoardDAO.selectCmmnBoardList",searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	/* 공지글 목록 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmnBoardNoticeList(String brdType){
		return (List<EgovMap>) list("AdmCmmnBoardDAO.selectCmmnBoardNoticeList", brdType);
	}
	
	/* 글쓰기 */
	public String insertCmmnBoardOne(BoardVO boardVO){
		AdminVO adminVO=(AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		boardVO.setRegId(adminVO.getMemCode());
		boardVO.setRegName(adminVO.getMemName());
		
		return (String) insert("AdmCmmnBoardDAO.insertCmmnBoardOne", boardVO);
	}
	
	/* 첨부파일 등록 */
	public void insertCmmnBoardUpfileOne(Map map){
		insert("AdmCmmnBoardDAO.insertCmmnBoardUpfileOne", map);
	}
	
	/* 조회 */
	public BoardVO selectCmmnBoardOne(String brdSeq){
		return (BoardVO) select("AdmCmmnBoardDAO.selectCmmnBoardOne",brdSeq);
	}
	
	/* 첨부파일 조회 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmnBoardUpfileList(String brdSeq){
		return (List<EgovMap>) list("AdmCmmnBoardDAO.selectCmmnBoardUpfileList", brdSeq);
	}
	
	/* 글 삭제 */
	public void deleteCmmnBoardOne(String brdSeq){
		delete("AdmCmmnBoardDAO.deleteCmmnBoardOne",brdSeq);
	}
	
	/* 첨부파일 삭제 */
	public void deleteCmmnBoardUpfileList(List<String> upSeqList){
		delete("AdmCmmnBoardDAO.deleteCmmnBoardUpfileList", upSeqList);
	}
	
	/* 글 수정 */
	public void updateCmmnBoardOne(BoardVO boardVO, String brdType){
		update("AdmCmmnBoardDAO.updateCmmnBoardOne",boardVO);
	}
	
	/* 삭제할 첨부파일 조회 */
	public EgovMap selectCmmnBoardUpfileOne(String upSeq){
		return (EgovMap) select("AdmCmmnBoardDAO.selectCmmnBoardUpfileOne",upSeq);
	}
	
	/******************* 글쓰기 && 프레젠테이션대회 대회관리 START *******************/
	
	// 글쓰기 && 프레젠테이션대회
	@SuppressWarnings("unchecked")
	public List<EgovMap> admBoardMngContestMng() {
		return (List<EgovMap>) list("AdmCmmnBoardDAO.admBoardMngContestMng");
	}
	
	/* 글쓰기 && 프레젠테이션대회 UPDATE */
	public void admBoardMngContestMngUpdate(ContestVO contestVO){
		update("AdmCmmnBoardDAO.updateCmmnBoardOne",contestVO);
	}

	@SuppressWarnings("unchecked")
	public CmmnListVO selectCmmnBoardAplyList(CmmnSearchVO searchVO) throws Exception {
		int totalRecordCount=(int) select("AdmCmmnBoardDAO.selectCmmnBoardAplyListCnt", searchVO);
		List<EgovMap> egovList=(List<EgovMap>) list("AdmCmmnBoardDAO.selectCmmnBoardAplyList",searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}

	public CntstApplyVO selectCmmnBoardAplyOne(String aplySeq) throws Exception {
		return (CntstApplyVO) select("AdmCmmnBoardDAO.selectCmmnBoardAplyOne", aplySeq);
	}

	public void selectCmmnBoardAplyDelete(String aplySeq) throws Exception {
		delete("AdmCmmnBoardDAO.selectCmmnBoardAplyDelete", aplySeq);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectCmmnBoardAplyExcel(CmmnSearchVO searchVO) throws Exception {
		return (List<EgovMap>) list("AdmCmmnBoardDAO.selectCmmnBoardAplyExcel", searchVO);
	}
	
	/******************* 글쓰기 && 프레젠테이션대회 대회관리 END *******************/

}
