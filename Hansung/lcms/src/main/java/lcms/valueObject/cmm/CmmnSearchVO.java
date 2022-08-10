package lcms.valueObject.cmm;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class CmmnSearchVO {

	/** 타입 */
	private String searchType = "";
	public String getSearchType() { return searchType; }
	public void setSearchType(String searchType) { this.searchType = searchType; }
	
	/** 메뉴 타입*/
	private String menuType = "";
	public String getMenuType() { return menuType; }
	public void setMenuType(String menuType) { this.menuType = menuType; }

	/** 검색 조건1 */
	private String searchCondition1 = "";
	public String getSearchCondition1() { return searchCondition1; }
	public void setSearchCondition1(String searchCondition1) { this.searchCondition1 = searchCondition1; }
	
	/** 검색 조건2 */
	private String searchCondition2 = "";
	public String getSearchCondition2() { return searchCondition2; }
	public void setSearchCondition2(String searchCondition2) { this.searchCondition2 = searchCondition2; }
	
	/** 검색 조건3 */
	private String searchCondition3 = "";
	public String getSearchCondition3() { return searchCondition3; }
	public void setSearchCondition3(String searchCondition3) { this.searchCondition3 = searchCondition3; }

	/** 검색 조건4 */
	private String searchCondition4 = "";
	public String getSearchCondition4() { return searchCondition4; }
	public void setSearchCondition4(String searchCondition4) { this.searchCondition4 = searchCondition4; }

	/** 검색 조건5 */
	private String searchCondition5 = "";
	public String getSearchCondition5() { return searchCondition5; }
	public void setSearchCondition5(String searchCondition5) { this.searchCondition5 = searchCondition5; }
	
	/** 검색 조건6 */
	private String searchCondition6 = "";
	public String getSearchCondition6() { return searchCondition6; }
	public void setSearchCondition6(String searchCondition6) { this.searchCondition6 = searchCondition6; }

	/** 검색 조건7 */
	private String searchCondition7 = "";
	public String getSearchCondition7() { return searchCondition7; }
	public void setSearchCondition7(String searchCondition7) { this.searchCondition7 = searchCondition7; }
	
	/** 검색 조건8 */
	private String searchCondition8 = "";
	public String getSearchCondition8() { return searchCondition8; }
	public void setSearchCondition8(String searchCondition8) { this.searchCondition8 = searchCondition8; }
	
	/** 검색 단어 */
	private String searchWord = "";
	public String getSearchWord() { return searchWord; }
	public void setSearchWord(String searchWord) { this.searchWord = searchWord; }

	/** 날짜 */
	private String startDate = "";
	private String endDate = "";
	public String getStartDate() { return startDate; }
	public void setStartDate(String startDate) { this.startDate = startDate; }
	public String getEndDate() { return endDate; }
	public void setEndDate(String endDate) { this.endDate = endDate; }
	
	private String searchDate = "";
	public String getSearchDate() { return searchDate; }
	public void setSearchDate(String searchDate) { this.searchDate = searchDate; }
	
	/** 접속ID */
	private String searchMemberCode = "";
	public String getSearchMemberCode() { return searchMemberCode; }
	public void setSearchMemberCode(String searchMemberCode) { this.searchMemberCode = searchMemberCode; }
	
	/** 강의 */
	private String searchLecture = "";
	public String getSearchLecture() { return searchLecture; }
	public void setSearchLecture(String searchLecture) { this.searchLecture = searchLecture; }

	private List<EgovMap> searchList = null;
	public List<EgovMap> getSearchList() { return searchList; }
	public void setSearchList(List<EgovMap> searchList) { this.searchList = searchList; }

	/** 메세지 */
	private String message = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 20;
	
	/* (교수,학생) 상단 공지 개수  시작  >> 20200312*/
	private int topNotiListCnt ;

	public int getTopNotiListCnt() {
		return topNotiListCnt;
	}
	public void setTopNotiListCnt(int topNotiListCnt) {
		this.topNotiListCnt = topNotiListCnt;
	}
	/* (교수,학생) 상단 공지 개수   끝  >> 20200312*/
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	
	/** 20200513 업무담당자 수업만족도(교사) double paging */
	/** 현재페이지 */
	private int pageIndex2 = 1;

	/** firstIndex */
	private int firstIndex2 = 1;

	/** lastIndex */
	private int lastIndex2 = 1;
	
	public int getPageIndex2() {
		return pageIndex2;
	}
	
	public void setPageIndex2(int pageIndex2) {
		this.pageIndex2 = pageIndex2;
	}
	
	public int getFirstIndex2() {
		return firstIndex2;
	}
	
	public void setFirstIndex2(int firstIndex2) {
		this.firstIndex2 = firstIndex2;
	}
	
	public int getLastIndex2() {
		return lastIndex2;
	}
	
	public void setLastIndex2(int lastIndex2) {
		this.lastIndex2 = lastIndex2;
	}
	
	@Override
	public String toString() {
		return "CmmnSearchVO [searchType=" + searchType + ", menuType=" + menuType + ", searchCondition1="
				+ searchCondition1 + ", searchCondition2=" + searchCondition2 + ", searchCondition3=" + searchCondition3
				+ ", searchCondition4=" + searchCondition4 + ", searchCondition5=" + searchCondition5
				+ ", searchCondition6=" + searchCondition6 + ", searchCondition7=" + searchCondition7
				+ ", searchCondition8=" + searchCondition8 + ", searchWord=" + searchWord + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", searchDate=" + searchDate + ", searchMemberCode=" + searchMemberCode
				+ ", searchLecture=" + searchLecture + ", message=" + message + ", pageIndex=" + pageIndex
				+ ", firstIndex=" + firstIndex + ", lastIndex=" + lastIndex + ", recordCountPerPage="
				+ recordCountPerPage + ", topNotiListCnt=" + topNotiListCnt + ", pageIndex2=" + pageIndex2
				+ ", firstIndex2=" + firstIndex2 + ", lastIndex2=" + lastIndex2 + "]";
	}
}