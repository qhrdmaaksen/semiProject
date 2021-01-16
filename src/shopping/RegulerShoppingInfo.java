package shopping;

public class RegulerShoppingInfo {
	private int productcode ; // 상품 번호
	private String productname ; // 상품 이름
	private int months ; // 정기 구독 신청 개월 수
	private int productprice ; // 단가
	private String images; // 상품 이미지 이름
	private int point ; // 적립할 포인트 추후에 시스템 변경 시 혹시 몰라서
	//private int amount ;
	
	public RegulerShoppingInfo() {
	
	}

	@Override
	public String toString() {
		return "RegulerShoppingInfo [productcode=" + productcode + ", productname=" + productname + ", months=" + months
				+ ", productprice=" + productprice + ", images=" + images + ", point=" + point + "]";
	}

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

	public int getMonths() {
		return months;
	}

	public void setMonths(int months) {
		this.months = months;
	}

	public int getProductprice() {
		return productprice;
	}

	public void setProductprice(int productprice) {
		this.productprice = productprice;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	
	
}






