package hsDesign.usr.enter.admission;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import hsDesign.valueObject.AdmissionVO;

@Repository
public class AdmissionDAO extends EgovAbstractDAO{

	// 등록
	public void admissionInsert(AdmissionVO admissionVO){
		insert("AdmissionDAO.admissionInsert", admissionVO);
	}
	
}
