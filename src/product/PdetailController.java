package product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.PdetailDao;
import common.SuperClass;

public class PdetailController extends SuperClass{
	
	public PdetailController() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PdetailDao dao = new PdetailDao(request) ; 
		GotoPage("/product/pdetail.jsp");
	}
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num = Integer.parseInt(request.getParameter("seq.index"));
		System.out.println("doGet 호출");
		super.doGet(request, response);
	}
	
}
