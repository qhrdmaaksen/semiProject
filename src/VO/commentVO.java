package VO;

public class commentVO {
	int seq_comment ; 
	int seq_index; 
	String id ; 
	String commentdate ; 
	String comment ;
	public int getSeq_comment() {
		return seq_comment;
	}
	public void setSeq_comment(int seq_comment) {
		this.seq_comment = seq_comment;
	}
	public int getSeq_index() {
		return seq_index;
	}
	public void setSeq_index(int seq_index) {
		this.seq_index = seq_index;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCommentdate() {
		return commentdate;
	}
	public void setCommentdate(String commentdate) {
		this.commentdate = commentdate;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	@Override
	public String toString() {
		return "commentVO [seq_comment=" + seq_comment + ", seq_index=" + seq_index + ", id=" + id + ", commentdate="
				+ commentdate + ", comment=" + comment + "]";
	}
	
	
	
	
	
}
