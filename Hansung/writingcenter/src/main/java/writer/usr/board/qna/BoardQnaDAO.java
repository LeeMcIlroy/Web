package writer.usr.board.qna;

import java.util.List;

import org.springframework.stereotype.Repository;

import writer.valueObject.QnaVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class BoardQnaDAO extends EgovAbstractDAO{
	/* 목록 */
	@SuppressWarnings("unchecked")
	public CmmnListVO selectBoardQnaList(CmmnSearchVO searchVO){
		int totalRecordCount=(int) select("BoardQnaDAO.selectBoardQnaListCnt", searchVO);
		List<EgovMap> egovList=(List<EgovMap>) list("BoardQnaDAO.selectBoardQnaList",searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	/* 등록 */
	public void insertBoardQnaOne(QnaVO qnaVO){
		insert("BoardQnaDAO.insertBoardQnaOne",qnaVO);
	}
	
	/* 조회 */
	public QnaVO selectBoardQnaOne(String qnaSeq){
		update("BoardQnaDAO.updateBoardQnaHitcountOne",qnaSeq);
		return (QnaVO) select("BoardQnaDAO.selectBoardQnaOne",qnaSeq);
	}
	
	/* 수정 */
	public void updateBoardQnaOne(QnaVO qnaVO){
		update("BoardQnaDAO.updateBoardQnaOne", qnaVO);
	}
	
	/* 삭제 */
	public void deleteBoardQnaOne(String qnaSeq){
		delete("BoardQnaDAO.deleteBoardQnaOne", qnaSeq);
	}
	

}
