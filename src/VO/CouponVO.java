package VO;

import java.util.Date;

public class CouponVO {
    private String no;
    private String name;
    private int kind;
    private float discount;
    Date exp;

    public String getNo() { return no; }
    public void setNo(String no) { this.no = no;    }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getKind() { return kind; }
    public void setKind(int kind) { this.kind = kind; }
    public float getDiscount() { return discount; }
    public void setDiscount(float discount) { this.discount = discount; }
    public Date getExp() { return exp; }
    public void setExp(Date exp) { this.exp = exp; }
}
