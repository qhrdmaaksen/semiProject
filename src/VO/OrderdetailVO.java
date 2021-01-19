package VO;

public class OrderdetailVO {
	int ordernumber ; 
	int productcode; 
	int qty ; 
	int amount ;
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
	@Override
	public String toString() {
		return "OrderdetailVO [ordernumber=" + ordernumber + ", productcode=" + productcode + ", qty=" + qty
				+ ", amount=" + amount + "]";
	}
}
