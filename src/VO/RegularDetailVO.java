package VO;

import java.util.Date;

public class RegularDetailVO {
    private int ordernumber;
    private int productcode;
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
}
