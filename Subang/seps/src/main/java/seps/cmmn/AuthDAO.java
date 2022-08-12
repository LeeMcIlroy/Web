package seps.cmmn;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class AuthDAO extends EgovAbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectAuthList(){
		return (List<EgovMap>) list("CmmnDAO.selectAuthList");
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectAuthListOne(String userInfoId){
		return (List<String>) list("CmmnDAO.selectAuthListOne", userInfoId);
	}
	
}