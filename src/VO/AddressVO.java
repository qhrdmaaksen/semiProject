package VO;

public class AddressVO {

	int seq_add ; 
	String id ;
	String shippingname;
	String name;
	String address1;
	String address2;
	String phone;
	
	
	public int getSeq_add() {
		return seq_add;
	}
	public void setSeq_add(int seq_add) {
		this.seq_add = seq_add;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getShippingname() {
		return shippingname;
	}
	public void setShippingname(String shippingname) {
		this.shippingname = shippingname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@Override
	public String toString() {
		return "AddressVo [seq_add=" + seq_add + ", id=" + id + ", shippingname=" + shippingname + ", name=" + name
				+ ", address1=" + address1 + ", address2=" + address2 + ", phone=" + phone + "]";
	}
	
	
	
	
	
}
