package Mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SuperClass;
import shopping.MyCartList;

public class MallCartDeleteItemController extends SuperClass{
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);

			MyCartList mycart = (MyCartList)super.session.getAttribute("mycart") ;
			MyCartList Rmycart = (MyCartList)super.session.getAttribute("Rmycart") ;
			
			if (request.getParameter("qty") == null) {
				int productcode = Integer.parseInt(request.getParameter("productcode")) ;
				System.out.println(request.getParameter("months") + "/" + productcode);
				Rmycart.DeleteROrder(productcode);
				super.session.setAttribute("Rmycart", Rmycart);
				//super.session.setAttribute("mycart", mycart);
			} 
			if (request.getParameter("months") == null){
				int productcode = Integer.parseInt(request.getParameter("productcode")) ;
				System.out.println(request.getParameter("qty"));
				mycart.DeleteOrder(productcode); 
				super.session.setAttribute("mycart", mycart);
				//super.session.setAttribute("Rmycart", Rmycart);
			}
			
			new MallCartListController().doGet(request, response); 
	}
}






