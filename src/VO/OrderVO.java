package VO;

import java.util.Date;

public class OrderVO {
	
	private int ordernumber;
	private String id;
	private int seq_add;
	private int seq_pay;
	private int shippingstatus;
	private String invoice;
	private Date orderdate;
	
	public OrderVO() {
	}

	@Override
	public String toString() {
		return "OrderVO [ordernumber=" + ordernumber + ", id=" + id + ", seq_add=" + seq_add + ", seq_pay=" + seq_pay
				+ ", shippingstatus=" + shippingstatus + ", invoice=" + invoice + ", orderdate=" + orderdate + "]";
	}

	public int getOrdernumber() {
		return ordernumber;
	}

	public void setOrdernumber(int ordernumber) {
		this.ordernumber = ordernumber;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getSeq_add() {
		return seq_add;
	}

	public void setSeq_add(int seq_add) {
		this.seq_add = seq_add;
	}

	public int getSeq_pay() {
		return seq_pay;
	}

	public void setSeq_pay(int seq_pay) {
		this.seq_pay = seq_pay;
	}


	public int getShippingstatus() {
		return shippingstatus;
	}

	public void setShippingstatus(int shippingstatus) {
		this.shippingstatus = shippingstatus;
	}

	public String getInvoice() {
		return invoice;
	}

	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}
	
	
	
	
	
	
	
	
}
