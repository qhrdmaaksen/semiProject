package VO;

public class PreviewVO {
	
	private int reviewno ;//리뷰 게시글 번호
	private int searchno ;
	private String content;//리뷰 글 내용
	private int grade ; //별점
	private String postdate ;//날짜 
	private String id ;//아이디
	
	
	
	@Override
	public String toString() {
		return "PreviewVO [reviewno=" + reviewno + ", searchno=" + searchno + ", content=" + content + ", grade="
				+ grade + ", postdate=" + postdate + ", id=" + id + "]";
	}
	public int getReviewno() {
		return reviewno;
	}
	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}
	public int getSearchno() {
		return searchno;
	}
	public void setSearchno(int searchno) {
		this.searchno = searchno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	} 
	
	
}
