package common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.PreviewDAO;

public class PreviewController extends SuperClass{
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get 호출");
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PreviewDAO dao = new PreviewDAO(request);
		int result = dao.addReview();
		if(result <=0) {
			System.out.println("Review DB 입력 실패");
		}else {
			System.out.println("Review DB 입력 성공");
		} 
		
		doProcess(request, response);
		GotoPage("/product/pdetail.jsp");
	}

}
