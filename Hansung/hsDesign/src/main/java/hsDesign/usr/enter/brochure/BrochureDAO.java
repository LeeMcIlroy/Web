package hsDesign.usr.enter.brochure;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import hsDesign.valueObject.BrochureVO;

@Repository
public class BrochureDAO extends EgovAbstractDAO{

	// 등록
	public void brochureInsert(BrochureVO brochureVO){
		insert("BrochureDAO.brochureInsert", brochureVO);
	}
	
}
