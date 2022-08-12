package seps.cmmn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import seps.valueObject.AuthVO;
import seps.valueObject.UserInfoVO;
import valueObject.FileVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Repository
public class CmmnDAO extends EgovAbstractDAO {
	
	//권한 목록 전체
	@SuppressWarnings("unchecked")
	public List<AuthVO> selectAuthList() {
		return (List<AuthVO>)  list("CmmnDAO.selectAuthList");
	}
	
	//유저 개별 권한 조회
	@SuppressWarnings("unchecked")
	public List<String> selectAuthListOne(String userInfoId) {
		return (List<String>)  list("CmmnDAO.selectAuthListOne", userInfoId);
	}
	
	//유저 권한 등록
	public void insertAuth(UserInfoVO paramVO){
		insert("CmmnDAO.insertAuth", paramVO);
	}
	
	//유저 권한 삭제
	public void deleteAuth(UserInfoVO paramVO){
		insert("CmmnDAO.deleteAuth", paramVO);
	}

	
	//첨부파일 조회용
	public EgovMap selectFileBoard(String boardType, String boardId){
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("boardType", boardType);
		paramMap.put("boardId", boardId);
		return (EgovMap) select("CmmnDAO.selectFileBoard", paramMap);
	}
	
	//첨부파일 다운로드용
	public EgovMap selectFile(String fileId){
		return (EgovMap) select("CmmnDAO.selectFile", fileId);
	}
	
	//첨부파일 등록
	public void insertFile(FileVO fileParamVO) {
		insert("CmmnDAO.insertFile", fileParamVO);
	}
	
	//첨부파일 삭제
	public void deletetFile(String attachFileId) {
		delete("CmmnDAO.deleteFile", attachFileId);
	}
	
	//첨부파일 삭제
	public void deleteFileAll(String boardType, String boardId){
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("boardType", boardType);
		paramMap.put("boardId", boardId);
		delete("CmmnDAO.deleteFile", paramMap);
	}
	
}