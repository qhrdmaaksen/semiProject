package Mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SuperClass;
import product.PlistController;
import shopping.MyCartList;



public class MallCartAddController extends SuperClass{
	int qty = 0 ;
	int months = 0 ;

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
			if (request.getParameter("qty") == null) {
				this.qty = 0 ;
			}else {
				this.qty = Integer.parseInt(request.getParameter("qty")) ; // 구매 수량
			}
			if (request.getParameter("months") == null) {
				months = 0 ;
			}else {
				months = Integer.parseInt(request.getParameter("months")) ; // 구매 수량
			}
			
			System.out.println(productcode + "/" + stock  + "/" + qty + "/" + months);
			
			if (stock < qty || stock < months) { // 재고 수량 초과
				String message = "재고 수량이 부족합니다." ;
				super.setErrorMessage(message);
				new PlistController().doGet(request, response);
				
			} else { // 판매에 문제 없슴
				MyCartList mycart = (MyCartList)super.session.getAttribute("mycart") ;
				MyCartList Rmycart = (MyCartList)super.session.getAttribute("Rmycart") ;
				
				
				if (mycart == null) {
					 mycart = new MyCartList() ;
				} else if(Rmycart == null){
					Rmycart = new MyCartList() ;
				}
				
				
				/*
				 * if (mycart == null && Rmycart == null) { mycart = new MyCartList() ; Rmycart
				 * = new MyCartList() ; }
				 */
				 
				if (this.qty == 0) {
					Rmycart.AddROrder(productcode, this.months); // 카트에 담기
					super.session.setAttribute("Rmycart", Rmycart);
				} else if (this.months == 0){
					mycart.AddOrder(productcode, this.qty); // 카트에 담기
					super.session.setAttribute("mycart", mycart);
				}
				//super.session.setAttribute("mycart", mycart);
				//super.session.setAttribute("Rmycart", Rmycart);
				
				System.out.println(this.qty + "/" + this.months);
				System.out.println("어떻게 나오나용"+Rmycart + "/" + mycart);
				// 장바구니 목록 페이지로 이동합니다.
				new MallCartListController().doGet(request, response) ;
			}
		}		
	}
}


