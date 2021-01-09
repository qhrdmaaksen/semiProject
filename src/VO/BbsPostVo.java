package VO;

public class BbsPostVo {
	
	int num ; // 글 번호 
	String id ; 
	String title;
	String content ;
	String postdate ; 
	int likenumber ; // 좋아요 수 
	String image;
	
	




	



	@Override
	public String toString() {
		return "BbsPostVo [num=" + num + ", id=" + id + ", title=" + title + ", content=" + content + ", postdate="
				+ postdate + ", likenumber=" + likenumber + ", image=" + image + "]";
	}



	public String getImage() {
		return image;
	}



	public void setImage(String image) {
		this.image = image;
	}

	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public int getLikenumber() {
		return likenumber;
	}
	public void setLikenumber(int likenumber) {
		this.likenumber = likenumber;
	}

}
