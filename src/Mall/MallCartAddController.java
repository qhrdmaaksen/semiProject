package Mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SuperClass;
import product.PlistController;
import shopping.MyCartList;



public class MallCartAddController extends SuperClass{


@Override
public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
	super.doPost(request, response);
	
	String gotopage = "" ;
	
	if (super.session.getAttribute("loginfo") == null) {
		// 로그인 하지 않았다면 로그인 페이지로 이동
		gotopage = "member/login.jsp" ;
		super.GotoPage(gotopage);
	} else { // 누군가 로그인 한 상태입니다.
		System.out.println("하하하");
		int productcode = Integer.parseInt(request.getParameter("productcode")) ;
		int stock = Integer.parseInt(request.getParameter("stock")) ; // 재고
		int qty = Integer.parseInt(request.getParameter("qty")) ; // 구매 수량
		
		System.out.println(productcode + "/" + stock  + "/" + qty);
		
		if (stock < qty) { // 재고 수량 초과
			String message = "재고 수량이 부족합니다." ;
			super.setErrorMessage(message);
			new PlistController().doGet(request, response);
			
		} else { // 판매에 문제 없슴
			MyCartList mycart = (MyCartList)super.session.getAttribute("mycart") ;
			if (mycart == null) { // 카트가 없으면
				mycart = new MyCartList() ; // 매장 입구에서 카트 준비
			}
			mycart.AddOrder(productcode, qty); // 카트에 담기
			super.session.setAttribute("mycart", mycart);
			
			// 장바구니 목록 페이지로 이동합니다.
			new MallCartListController().doGet(request, response) ;
		}
	}		
}
}


