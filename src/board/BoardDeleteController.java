package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.BoardDAO;
import common.SuperClass;

public class BoardDeleteController extends SuperClass {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int no = Integer.parseInt(request.getParameter("no"));
		
		BoardDAO dao = new BoardDAO();
		
		int cnt = -99999;
		cnt = dao.DeleteData(no);
		
		new BoardListController().doGet(request, response);
		
		
		super.doGet(request, response);
		

	}
	
	
	
}
