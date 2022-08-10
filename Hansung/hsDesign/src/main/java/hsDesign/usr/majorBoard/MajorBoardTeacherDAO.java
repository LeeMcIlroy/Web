package hsDesign.usr.majorBoard;

import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class MajorBoardTeacherDAO extends EgovAbstractDAO{
	// 목록
		@SuppressWarnings("unchecked")
		public CmmnListVO selectTeacherList(CmmnSearchVO searchVO){
			int totalRecordCount = (int) select("MajorBoardTeacherDAO.selectTeacherListCnt", searchVO);
			List<EgovMap> egovList = (List<EgovMap>) list("MajorBoardTeacherDAO.selectTeacherList", searchVO);
			
			return new CmmnListVO(totalRecordCount, egovList);
		}
		

}
