package writer.adm.boardMng.qna;

import java.net.UnknownHostException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.QnaVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class AdmBoardMngQnaDAO extends EgovAbstractDAO {
	

	/* 목록 */
	@SuppressWarnings("unchecked")
	public CmmnListVO selectBoardMngQnaList(CmmnSearchVO searchVO){
		int totalRecordCount=(int) select("AdmBoardMngQnaDAO.selectBoardMngQnaListCnt", searchVO);
		List<EgovMap> egovList=(List<EgovMap>) list("AdmBoardMngQnaDAO.selectBoardMngQnaList",searchVO);
		
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	/* 보기 */
	public QnaVO selectBoardMngQnaOne(String qnaSeq){
		return (QnaVO) select("AdmBoardMngQnaDAO.selectBoardMngQnaOne",qnaSeq);
	}
	
	/* 답변 등록 */
	public void updateBoardMngQnaOne(QnaVO qnaVO){
		update("AdmBoardMngQnaDAO.updateBoardMngQnaOne", qnaVO);
	}
	
	/* 글 삭제 */
	public void deleteBoardMngQnaOne(String qnaSeq){
		delete("AdmBoardMngQnaDAO.deleteBoardMngQnaOne",qnaSeq);
	}
}