package tems.com.common;

public class PageMaker {

	private int totCnt; //전체글 수

	private int startPage; //시작되는 페이지 버튼 번호
	private int pageBtnCnt = 10; //페이징 버튼 갯수	
	private int endPage; //끝나는 페이지 버튼 번호
	private boolean prev; //이전버튼 활성화 여부
	private boolean next; //다음버튼 활성화 여부

	private Criteria cri; //현재페이지위치(crtPage), 출력되는글수(rowCnt), 검색조건(serchType), 검색키워드(keyword)

	public PageMaker(Criteria cri, int totCnt) {
		this.cri = cri;
		this.totCnt = totCnt;
		calcData();
	}

	private void calcData() {
		endPage = (int) (Math.ceil(cri.getCrtPage() / (double) pageBtnCnt)) * pageBtnCnt;
		startPage = endPage - (pageBtnCnt - 1);

		if (endPage * cri.getRowCnt() < totCnt) {
			next = true;
		} else {
			endPage = (int) (Math.ceil(totCnt / (double) cri.getRowCnt()));
		}

		if (startPage != 1) {
			prev = true;
		}
	}

	public int getTotCnt() {
		return totCnt;
	}

	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getPageBtnCnt() {
		return pageBtnCnt;
	}

	public void setPageBtnCnt(int pageBtnCnt) {
		this.pageBtnCnt = pageBtnCnt;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	@Override
	public String toString() {
		return "PageMaker [totCnt=" + totCnt + ", startPage=" + startPage + ", pageBtnCnt=" + pageBtnCnt + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next + ", cri="
				+ cri + "]";
	}

}
