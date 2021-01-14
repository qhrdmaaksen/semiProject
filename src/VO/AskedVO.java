package VO;

public class AskedVO {
	private int seq_index ; //게시판 글 번호
	private String category ; //분류
	private String title ; //글 제목
	private String content ; //글 내용
	private String id ;//아이디
	@Override
	public String toString() {
		return "AskedVO [seq_index=" + seq_index + ", category=" + category + ", title=" + title + ", content="
				+ content + ", id=" + id + "]";
	}
	public int getSeq_index() {
		return seq_index;
	}
	public void setSeq_index(int seq_index) {
		this.seq_index = seq_index;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}
