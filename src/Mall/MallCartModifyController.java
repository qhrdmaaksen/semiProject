package Mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SuperClass;
import product.PlistController;
import shopping.MyCartList;



public class MallCartModifyController extends SuperClass{
	int qty = 0 ;
	int months = 0 ;

	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
		System.out.println("하하하");
		int productcode = Integer.parseInt(request.getParameter("productcode")) ;
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
		
		System.out.println(productcode + "/" + "/" + qty + "/" + months);
		
			MyCartList mycart = (MyCartList)super.session.getAttribute("mycart") ;
			MyCartList Rmycart = (MyCartList)super.session.getAttribute("Rmycart") ;
			
			if (mycart == null) {
				 mycart = new MyCartList() ;
			}

			if(Rmycart == null){
				Rmycart = new MyCartList() ;
			}
			
			if (this.qty == 0) {
				System.out.println("왜 또 갑자기?" + productcode + "/" + this.months);
				Rmycart.ModifyROrder(productcode, this.months); // 카트에 담기
				super.session.setAttribute("Rmycart", Rmycart);
			} else if (this.months == 0){
				System.out.println("여기엔 왜 왔지");
			}
			//super.session.setAttribute("mycart", mycart);
			//super.session.setAttribute("Rmycart", Rmycart);
			
			System.out.println(this.qty + "/" + this.months);
			System.out.println("어떻게 나오나용"+Rmycart + "/" + mycart);
			// 장바구니 목록 페이지로 이동합니다.
			new MallCartListController().doGet(request, response) ;
		
	}	
	
	}
		
	