package VO;

import java.util.Date;

public class PointVO {
    private int seq_point;
    private String id;
    private boolean plma;
    private int point;
    private Date po_date;
    private String po_subject;

    public int getSeq_point() { return seq_point; }
    public void setSeq_point(int seq_point) { this.seq_point = seq_point; }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public boolean isPlma() { return plma; }
    public void setPlma(boolean plma) { this.plma = plma; }
    public int getPoint() { return point; }
    public void setPoint(int point) { this.point = point; }
    public Date getPo_date() { return po_date; }
    public void setPo_date(Date po_date) { this.po_date = po_date; }
    public String getPo_subject() { return po_subject; }
    public void setPo_subject(String po_subject) { this.po_subject = po_subject; }
}
