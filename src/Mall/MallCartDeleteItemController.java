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
		
		String gotopage = "" ;
		
		if (super.session.getAttribute("loginfo") == null) {			
			gotopage = "member/login.jsp";
			super.GotoPage(gotopage);
			
		} else {
			MyCartList mycart = (MyCartList)session.getAttribute("mycart") ;
			if ( mycart == null ) {
				mycart = new MyCartList() ;
			}
			
			int productcode = Integer.parseInt(request.getParameter("productcode")) ;			
			
			mycart.DeleteOrder(productcode); 
			session.setAttribute("mycart", mycart); 
			new MallCartListController().doGet(request, response); 
		}
	}

}






