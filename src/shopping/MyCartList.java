package shopping;

import java.util.HashMap;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.websocket.server.HandshakeRequest;

// 나의 카트를 관리해주는 클래스(카트 관리자)
public class MyCartList {
	// orderlists : 카트에 담은 정보를 저장하고 있는 맵 컬렉션
	// regulerlists : 카트에 담은 정기 상품 정보를 저장하고 있는 맵 컬렉션
	private Map<Integer, Integer> orderlists = null ;
	private Map<Integer, Integer> regulerlists = null ;
	
	public MyCartList() {
	
		this.orderlists = new HashMap<Integer, Integer>() ;
		this.regulerlists = new HashMap<Integer, Integer>() ;
		System.out.println(orderlists.isEmpty());
		System.out.println(regulerlists.isEmpty());
	}
	
	// 장바구니 내역을 모두 삭제합니다.
	// 주로 결재가 이루어질 때 사용이 됩니다.
	public void RemoveAllProductInfo() {
		this.orderlists.clear();
	}
	public void RemoveAllRProductInfo() {
		this.regulerlists.clear();
	}
	
	// 장바구니 내역 정보를 반환해줍니다.
	public Map<Integer, Integer> GetAllOrderLists(){
		return this.orderlists ;
	}

	public Map<Integer, Integer> GetAllROrderLists(){
		return this.regulerlists ;
	}
	
	// 장바구니 내역 정보를 수정합니다.
	public void EditOrder(int productcode, int qty) {
		// productcode는 수정될 상품 번호, stock은 수정할 수량
		this.AddOrder(productcode, qty);
	}
	public void EditROrder(int productcode, int months) {
		this.AddOrder(productcode, months);
	}
	// 장바구니에 들어 있는 해당 상품을 삭제합니다.
	public void DeleteOrder(int productcode) {
		// productcode는 삭제될 상품 번호
		this.orderlists.remove(productcode) ;
	}
	public void DeleteROrder(int productcode) {
		this.regulerlists.remove(productcode) ;
	}
	
	// 장바구니에 상품을 추가합니다.
	public void AddOrder(int productcode, int qty) {
		if (this.orderlists.containsKey(productcode)) { // 동일 상품이 이미 있는 경우
			int newqty = this.orderlists.get(productcode) + qty ; 
			this.orderlists.put(productcode, newqty);
			System.out.println("여기 실행??1");
		} else {
			this.orderlists.put(productcode, qty) ;
			System.out.println("여기 실행??2");
		}
	}
	public void AddROrder(int productcode, int months) {
		if (this.regulerlists.containsKey(productcode)) { // 동일 상품이 이미 있는 경우
			int newmonths = this.regulerlists.get(productcode) + months ; 
			System.out.println("여기 데이터 왔낭1");
			this.regulerlists.put(productcode, newmonths);
		} else {
			this.regulerlists.put(productcode, months) ;
			System.out.println("여기 데이터 왔낭2");
		}
	}
}