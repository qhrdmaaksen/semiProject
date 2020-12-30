package VO;

import java.util.Date;

public class MemberVO {
	
	private String id ;
	private String password ;
	private String name ;
	private Date birth ;
	private String phone ;
	private String level ; //일반 유저는1, 운영자는 2
	private int point ;
	private String picture  ;
	
	public MemberVO() {}

	@Override
	public String toString() {
		return "Member [id=" + id + ", password=" + password + ", name=" + name + ", birth=" + birth + ", phone=" + phone
				+ ", level=" + level + ", point=" + point + ", picture=" + picture + "]";
	}

	public String getId() { return id; }
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
}
