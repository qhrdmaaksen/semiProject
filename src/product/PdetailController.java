package product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.PdetailDAO;
import DAO.ProductDAO;
import VO.ProductVO;
import common.SuperClass;

public class PdetailController extends SuperClass{
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PdetailDAO dao = new PdetailDAO(request) ; 
		GotoPage("/product/pdetail.jsp");
	}
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num = Integer.parseInt(request.getParameter("productcode"));
		
		ProductDAO pdao = new ProductDAO();
		
		ProductVO bean  = pdao.SelectDataByPk(num);
		
		String gotopage = ""; 
		if ( bean != null) {
			request.setAttribute("bean", bean);
			gotopage = "/product/pdetail.jsp" ;
		} else {
			gotopage = "/product/plist.jsp";
		}
		
		System.out.println("doGet 호출");
		super.doGet(request, response);
		super.GotoPage(gotopage);
	}
	
}
