package writer.usr.main;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.PopupVO;
import writer.valueObject.QestnarAskVO;
import writer.valueObject.QestnarPsnAnsVO;
import writer.valueObject.QestnarPsnVO;
import writer.valueObject.QestnarReplyVO;
import writer.valueObject.QestnarVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class MainDAO extends EgovAbstractDAO {
	
	// sso 로그인(교수, 연구원)
	public EgovMap actionSsoLogin(String profCode){
		return (EgovMap) select("MainDAO.actionSsoLogin", profCode);
	}
	
	// sso 로그인(학생)
	public EgovMap actionSsoLoginStudent(String studCode){
		return (EgovMap) select("MainDAO.actionSsoLoginStudent", studCode);
	}
	
	// 팝업 목록
	@SuppressWarnings("unchecked")
	public List<PopupVO> selectPopupList(){
		return (List<PopupVO>) list("MainDAO.selectPopupList");
	}
	
	// 팝업 조회
	public PopupVO selectPopupOne(String popSeq){
		return (PopupVO) select("MainDAO.selectPopupOne", popSeq);
	}
	
	// 공지사항 목록
	public List<EgovMap> selectNoticeList(CmmnSearchVO searchVO){
		return (List<EgovMap>) list("MainDAO.selectNoticeList", searchVO);
	}
	
	// 설문조사 기간조회
	public List<String> selectQestnarInfoDateOne(String today){
		return (List<String>) list("MainDAO.selectQestnarInfoDateOne", today);
	}
	
	// 설문조사 조회
	public QestnarVO selectQestnarInfoOne(String qstnrSeq){
		return (QestnarVO) select("MainDAO.selectQestnarInfoOne", qstnrSeq);
	}
	
	// 설문조사 질문조회
	public List<QestnarAskVO> selectQestnarAskOne(String qstnrSeq){
		return (List<QestnarAskVO>) list("AdmQestnarDAO.selectQestnarAskOne", qstnrSeq);
	}
	
	// 설문조사 답변조회
	public List<QestnarReplyVO> selectQestnarReplyOne(String qstnrSeq){
		return (List<QestnarReplyVO>) list("AdmQestnarDAO.selectQestnarReplyOne",  qstnrSeq);
	}
	
	// 설문조사 답변자 조회
	public String selectQestnarPsnOne(Map<String, String> map){
		return (String) select("MainDAO.selectQestnarPsnOne", map);
	}
	
	// 설문조사 답변등록
	public String insertQestnarPsnOne(QestnarPsnVO qestnarPsnVO){
		return (String) insert("MainDAO.insertQestnarPsnOne", qestnarPsnVO);
	}
	
	// 설문조사 답변내용 등록
	public void insertQestnarPsnAnsOne(QestnarPsnAnsVO qestnarPsnAnsVO){
		insert("MainDAO.insertQestnarPsnAnsOne", qestnarPsnAnsVO);
	}
	
	// 설문조사 답변 선택횟수 증가
	public void updateQestnarRepChoiceCount(Map<String, String> map){
		update("MainDAO.updateQestnarRepChoiceCount", map);
	}
	
	// 설문조사 응답자 증가
	public void updateQestnarRespCount(String qstnrSeq){
		update("MainDAO.updateQestnarRespCount", qstnrSeq);
	}

	/******************************************** 2017-07-25 추가 ********************************************/
	// 설문조사 답변 (주관식)
	public void insertQestnarAns(Map<String, String> params){
		insert("MainDAO.insertQestnarAns", params);
	}
	
}
