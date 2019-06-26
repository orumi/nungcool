package tems.com.common;

public class Criteria {

	private int crtPage = 1; //현재페이지
	private int rowCnt = 15; //출력되는 글 수

	private String searchType; //검색범위
	private String keyword; //검색키워드
	
	public int getFirst() { //글가져올때 시작글번호
		int first = (this.crtPage - 1) * this.rowCnt; // 시작값 = 0
		return first;
	}
	
	public int getEnd() { //글가져올때 마지막글번호
		int end = getFirst() + this.rowCnt; //마지막 글 번호 값은 = 처음글 번호 + 현재페이지 글 갯수
		return end;
	}

	public int getCrtPage() {
		return crtPage;
	}

	public void setCrtPage(int crtPage) { //현재페이지 값이 1 이하일때 처리 
		if (crtPage < 1) {
			this.crtPage = 1;
		} else {
			this.crtPage = crtPage;
		}
	}

	public int getRowCnt() {
		return rowCnt;
	}

	public void setRowCnt(int rowCnt) {
		this.rowCnt = rowCnt;
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

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Criteria [crtPage=" + crtPage + ", rowCnt=" + rowCnt + ", searchType=" + searchType + ", keyword=" + keyword + "]";
	}

}
