package product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ProductDAO;
import VO.ProductVO;
import common.SuperClass;

public class PdeleteController extends SuperClass{
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int productcode = Integer.parseInt( request.getParameter("productcode") ) ;
		ProductDAO pdao = new ProductDAO(); 
		
		ProductVO bean  = pdao.SelectDataByPk(productcode);
		
		String gotopage = "" ; 
		if( bean != null){ //상세 보기로 이동			 
			request.setAttribute("bean", bean);
			gotopage = "/product/pdetail.jsp";		 
		}else{
			gotopage = "/product/plist.jsp";		 
		}		
		
		super.doGet(request, response);		 
		super.GotoPage( gotopage ); 	
	}
}