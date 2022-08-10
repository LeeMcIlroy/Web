package writer.usr.wcGuide.bkCtlg;

import java.net.UnknownHostException;
import java.util.List;

import org.springframework.stereotype.Repository;

import writer.valueObject.BookcatalogVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class WcGuideBkCtlgDAO extends EgovAbstractDAO{

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectWcGuideBkCtlgList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("WcGuideBkCtlgDAO.selectWcGuideBkCtlgListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("WcGuideBkCtlgDAO.selectWcGuideBkCtlgList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public BookcatalogVO selectWcGuideBkCtlgOne(String ctlSeq) throws UnknownHostException{
		update("WcGuideTipsDAO.updateWcGuideBkCtlgHitcountOne",ctlSeq);
		return (BookcatalogVO) select("WcGuideBkCtlgDAO.selectWcGuideBkCtlgOne", ctlSeq);
	}
}
