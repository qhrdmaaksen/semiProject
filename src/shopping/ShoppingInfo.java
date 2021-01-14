package shopping;

public class ShoppingInfo {
	private int productcode ; // 상품 번호
	private String productname ; // 상품 이름
	private int qty ; // 구매 수량
	private int productprice ; // 단가
	private String images; // 상품 이미지 이름
	private int point ; // 적립할 포인트
	//private int amount ;
	
	public ShoppingInfo() {
	
	}

	@Override
	public String toString() {
		return "ShoppingInfo [productcode=" + productcode + ", productname=" + productname + ", qty=" + qty
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

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
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






