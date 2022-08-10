package hsDesign.adm.lgn;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import hsDesign.valueObject.AdminVO;

@Repository
public class AdmLgnDAO extends EgovAbstractDAO {

	public AdminVO selectAdmLgnOne(AdminVO adminVO) {
		return (AdminVO) select("AdmLgnDAO.selectAdmLgnOne", adminVO);
	}
}
