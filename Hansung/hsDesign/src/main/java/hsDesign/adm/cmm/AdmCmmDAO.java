package hsDesign.adm.cmm;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import hsDesign.valueObject.LogVO;

@Repository
public class AdmCmmDAO extends EgovAbstractDAO {

	/******************************************* LOG *******************************************/
	// 관리자 로그 등록
	public void admLogInsert(LogVO logVO){
		insert("AdmCmmDAO.admLogInsert", logVO);
	}
	
}
