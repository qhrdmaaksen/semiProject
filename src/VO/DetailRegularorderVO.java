package VO;

import java.util.Date;

public class DetailRegularorderVO {
	private int ordernumber ;
	private int productcode;
	private int qty;
	private int amount;
	private Date orderclosing;
	
	public int getOrdernumber() {
		return ordernumber;
	}
	public void setOrdernumber(int ordernumber) {
		this.ordernumber = ordernumber;
	}
	public int getProductcode() {
		return productcode;
	}
	public void setProductcode(int productcode) {
		this.productcode = productcode;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public Date getOrderclosing() {
		return orderclosing;
	}
	public void setOrderclosing(Date orderclosing) {
		this.orderclosing = orderclosing;
	}
	@Override
	public String toString() {
		return "DetailRegularorderVO [ordernumber=" + ordernumber + ", productcode=" + productcode + ", qty=" + qty
				+ ", amount=" + amount + ", orderclosing=" + orderclosing + "]";
	}
	
	
	
}
