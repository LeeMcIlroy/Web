package writer.adm.wcGuide.bkCtlg;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.AdminVO;
import writer.valueObject.BookcatalogVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmWcGuideBkCtlgDAO extends EgovAbstractDAO {

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectWcGuideBkCtlgList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmWcGuideBkCtlgDAO.selectWcGuideBkCtlgListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmWcGuideBkCtlgDAO.selectWcGuideBkCtlgList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public BookcatalogVO selectWcGuideBkCtlgOne(String ctlSeq){
		return (BookcatalogVO) select("AdmWcGuideBkCtlgDAO.selectWcGuideBkCtlgOne", ctlSeq);
	}
	
	// 등록
	public void wcGuideBkCtlgInsert(BookcatalogVO bookcatalogVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		bookcatalogVO.setRegId(adminVO.getMemCode());
		bookcatalogVO.setRegName(adminVO.getMemName());
		
		insert("AdmWcGuideBkCtlgDAO.wcGuideBkCtlgInsert", bookcatalogVO);
	}
	
	// 수정
	public void wcGuideBkCtlgUpdate(BookcatalogVO bookcatalogVO){
		update("AdmWcGuideBkCtlgDAO.wcGuideBkCtlgUpdate", bookcatalogVO);
	}

	// 삭제
	public void wcGuideBkCtlgDelete(String ctlSeq){
		delete("AdmWcGuideBkCtlgDAO.wcGuideBkCtlgDelete", ctlSeq);
	}
	
}
