package utility;

import oracle.sql.DATE;

import java.text.SimpleDateFormat;
import java.util.Date;

public class FlowParameters {
	// 페이징 처리 관련 변수들
	private String pageNumber ;
	private String pageSize ;

	// 필드 검색과 관련된 변수들
	private String mode = "" ;
	private String keyword = "" ;

	// 날짜 검색과 관련된 변수들
	private Date fromdate;
	private Date todate;

	public FlowParameters() { }

	public FlowParameters(String pageNumber, String pageSize, String mode, String keyword) {
		this.pageNumber = pageNumber ;
		this.pageSize = pageSize ;
		if ( mode == null || mode.equals("null") || mode.equals("") ) {
			mode = "all" ;
		}
		this.mode = mode ;
		if ( keyword == null || keyword.equals("null") || keyword.equals("")  || keyword.equals("all") ) {
			keyword = "" ;
		}
		this.keyword = keyword ;
	}

	public FlowParameters(String pageNumber, String pageSize, Date fromdate, Date todate, String mode){
		this.pageNumber = pageNumber;
		this.pageSize = pageSize;
		this.fromdate = fromdate;
		this.todate = todate;
		this.mode = mode;
	}

	public FlowParameters(String pageNumber, String pageSize, String mode) {
		this.pageNumber = pageNumber ;
		this.pageSize = pageSize ;
		if ( mode == null || mode.equals("null") || mode.equals("") ) {
			mode = "all" ;
		}
		this.mode = mode ;
		
	}

	@Override
	public String toString() {
		return "pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&mode=" + mode + "&keyword=" + keyword + "";
	}

	public String toStringPoint(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return "pageNumber=" + pageNumber + "&pageSize=" + pageSize + "&fromdate=" + sdf.format(fromdate) + "&todate=" + sdf.format(todate);
	}

	/*@Override
	public String toString() {
		return "pageNumber=" + pageNumber + "&pageSize="
				+ pageSize + "&mode=" + mode + "&keyword=" + keyword + "";
	}*/
	public String getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(String pageNumber) {
		this.pageNumber = pageNumber;
	}
	public String getPageSize() {
		return pageSize;
	}
	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
			this.mode = mode;
		}
	public Date getFromdate() { return fromdate; }
	public void setFromdate(Date fromdate) { this.fromdate = fromdate; }
	public Date getTodate() { return todate; }
	public void setTodate(Date todate) { this.todate = todate; }
	public String getKeyword() { return keyword; }
	public void setKeyword(String keyword){ this.keyword = keyword; }
}

