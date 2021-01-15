package VO;

public class ProductVO {
    private int productcode;
    private String productname;
    private int productprice;
    private int stock;
    private int bloodcirculation;   // 혈액순환
    private int digestiveapparatus; // 소화기관
    private int skin;   // 피부
    private int eyes;   // 눈
    private int fatigue;    // 피로
    private int joint;  // 관절
    private int hair;   // 모발
    private int immunity;   // 면역
    private String images;

    public int getProductcode() {
        return productcode;
    }
    public void setProductcode(int productcode) {
        this.productcode = productcode;
    }
    public String getProductname() {
        return productname;
    }
    public void setProductname(String productname) {
        this.productname = productname;
    }
    public int getProductprice() {
        return productprice;
    }
    public void setProductprice(int productprice) {
        this.productprice = productprice;
    }
    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    public int getEyes() {
        return eyes;
    }
    public void setEyes(int eyes) {
        this.eyes = eyes;
    }
    public int getBloodCirculation() {
        return bloodcirculation;
    }
    public void setBloodCirculation(int bloodcirculation) {
        this.bloodcirculation = bloodcirculation;
    }
    public int getDigestiveapparatus() {
        return digestiveapparatus;
    }
    public void setDigestiveapparatus(int digestiveapparatus) {
        this.digestiveapparatus = digestiveapparatus;
    }
    public int getSkin() {
        return skin;
    }
    public void setSkin(int skin) {
        this.skin = skin;
    }
    public int getFatigue() {
        return fatigue;
    }
    public void setFatigue(int fatigue) {
        this.fatigue = fatigue;
    }
    public int getJoint() {
        return joint;
    }
    public void setJoint(int joint) {
        this.joint = joint;
    }
    public int getHair() {
        return hair;
    }
    public void setHair(int hair) {
        this.hair = hair;
    }
    public int getImmunity() {
        return immunity;
    }
    public void setImmunity(int immunity) {
        this.immunity = immunity;
    }
    public String getImages() {return images;}
    public void setImages(String images) {this.images = images;}
}
