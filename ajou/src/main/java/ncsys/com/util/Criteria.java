package ncsys.com.util;

public class Criteria {

	private int page = 1;  //현재페이지
	private int rows = 10; //출력되는 글 수

	private String searchType; //검색범위
	private String keyword; //검색키워드
	
	private String owner; // session id;
	
	
	
	public int getFirst() { //글가져올때 시작글번호
		int first = (this.page - 1) * this.rows; // 시작값 = 0
		return first;
	}
	
	public int getEnd() { //글가져올때 마지막글번호
		int end = getFirst() + this.rows; //마지막 글 번호 값은 = 처음글 번호 + 현재페이지 글 갯수
		return end;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) { //현재페이지 값이 1 이하일때 처리 
		if (page < 1) {
			this.page = 1;
		} else {
			this.page = page;
		}
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) throws Exception {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Criteria [crtPage=" + page + ", rowCnt=" + rows + ", searchType=" + searchType + ", keyword=" + keyword + "]";
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}
	
	
	
}
