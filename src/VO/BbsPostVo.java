package VO;

import java.util.Date;

public class BbsPostVo {
	
	private int no ; // 글 번호 
	private String id ; 
	private String title;
	private String content ;
	private Date postdate ; 
	private int likenumber ; // 좋아요 수 
	private String image;
	




	@Override
	public String toString() {
		return "BbsPostVo [no=" + no + ", id=" + id + ", title=" + title + ", content=" + content + ", postdate="
				+ postdate + ", likenumber=" + likenumber + ", image=" + image + "]";
	}





	public int getNo() {
		return no;
	}





	public void setNo(int no) {
		this.no = no;
	}





	public String getId() {
		return id;
	}





	public void setId(String id) {
		this.id = id;
	}





	public String getTitle() {
		return title;
	}





	public void setTitle(String title) {
		this.title = title;
	}





	public String getContent() {
		return content;
	}





	public void setContent(String content) {
		this.content = content;
	}





	public Date getPostdate() {
		return postdate;
	}





	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}





	public int getLikenumber() {
		return likenumber;
	}





	public void setLikenumber(int likenumber) {
		this.likenumber = likenumber;
	}





	public String getImage() {
		return image;
	}





	public void setImage(String image) {
		this.image = image;
	}



	
	
	

}
