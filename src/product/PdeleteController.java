package product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ProductDAO;
import VO.ProductVO;
import common.SuperClass;
import utility.FlowParameters;

public class PdeleteController extends SuperClass{
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int productcode = Integer.parseInt( request.getParameter("productcode") ) ;
		ProductDAO pdao = new ProductDAO(); 
		
		ProductVO bean  = pdao.SelectDataByPk(productcode);
		
		FlowParameters parameters 
			= new FlowParameters(
					request.getParameter("pageNumber"),
					request.getParameter("pageSize"), 
					request.getParameter("mode"), 
					request.getParameter("keyword") ) ;
	
		System.out.println( parameters.toString() ); 
		
		ProductDAO dao = new ProductDAO();
		
		int cnt = -999999 ; 
		cnt = dao.DeleteData(productcode) ;
		
		new PlistController().doGet(request, response); 				
	}	
}
