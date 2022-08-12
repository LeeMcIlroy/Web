package valueObject;

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

	/** 검색 조건9 */
	private String searchCondition9 = "";
	public String getSearchCondition9() { return searchCondition9; }
	public void setSearchCondition9(String searchCondition9) { this.searchCondition9 = searchCondition9; }
	
	/** 검색 조건10 */
	private String searchCondition10 = "";
	public String getSearchCondition10() { return searchCondition10; }
	public void setSearchCondition10(String searchCondition10) { this.searchCondition10 = searchCondition10; }
	

	/** 검색 단어 */
	private String searchWord = "";
	public String getSearchWord() { return searchWord; }
	public void setSearchWord(String searchWord) { this.searchWord = searchWord; }

	/** returnColumnName */
	private String returnColumnName = "";
	public String getReturnColumnName() { return returnColumnName; }
	public void setReturnColumnName(String returnColumnName) { this.returnColumnName = returnColumnName; }

	/** 코드 */
	private String searchCode = "";
	public String getSearchCode() { return searchCode; }
	public void setSearchCode(String searchCode) { this.searchCode = searchCode; }

	/** 날짜 */
	private String startDate = "";
	private String endDate = "";
	public String getStartDate() { return startDate; }
	public void setStartDate(String startDate) { this.startDate = startDate; }
	public String getEndDate() { return endDate; }
	public void setEndDate(String endDate) { this.endDate = endDate; }
	
	private String startTime = "";
	private String endTime = "";
	public String getStartTime() { return startTime; }
	public void setStartTime(String startTime) { this.startTime = startTime; }
	public String getEndTime() { return endTime; }
	public void setEndTime(String endTime) { this.endTime = endTime; }

	private String searchDate = "";
	public String getSearchDate() { return searchDate; }
	public void setSearchDate(String searchDate) { this.searchDate = searchDate; }
	
	private String searchHour = "";
	public String getSearchHour() { return searchHour; }
	public void setSearchHour(String searchHour) { this.searchHour = searchHour; }

	/** 메세지 */
	private String message = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 10;

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
	@Override
	public String toString() {
		return "CmmnSearchVO [\nsearchType=" + searchType + "\nmenuType=" + menuType + "\nsearchCondition1="
				+ searchCondition1 + "\nsearchCondition2=" + searchCondition2 + "\nsearchCondition3=" + searchCondition3
				+ "\nsearchCondition4=" + searchCondition4 + "\nsearchCondition5=" + searchCondition5
				+ "\nsearchCondition6=" + searchCondition6 + "\nsearchCondition7=" + searchCondition7
				+ "\nsearchCondition8=" + searchCondition8 + "\nsearchCondition9=" + searchCondition9
				+ "\nsearchCondition10=" + searchCondition10 + "\nsearchWord=" + searchWord + "\nreturnColumnName="
				+ returnColumnName + "\nsearchCode=" + searchCode + "\nstartDate=" + startDate + "\nendDate=" + endDate
				+ "\nstartTime=" + startTime + "\nendTime=" + endTime + "\nsearchDate=" + searchDate + "\nsearchHour="
				+ searchHour + "\nmessage=" + message + "\npageIndex=" + pageIndex + "\nfirstIndex=" + firstIndex
				+ "\nlastIndex=" + lastIndex + "\nrecordCountPerPage=" + recordCountPerPage + "\n]";
	}
}