package hsDesign.usr.general.exper;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import hsDesign.valueObject.ExperVO;

@Repository
public class ExperienceDAO extends EgovAbstractDAO {

	/***************************************** 진로체험 신청 *****************************************/
	// 등록 - 신청
	public String experAplyInsert(ExperVO experVO){
		return (String) insert("ExperienceDAO.experAplyInsert", experVO);
	}
	
	// 등록 - 과정
	public void experCourceInsert(Map<String, String> experCource){
		insert("ExperienceDAO.experCourceInsert", experCource);
	}
}
