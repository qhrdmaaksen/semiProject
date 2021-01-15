package product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.NoticeDAO;
import DAO.PreviewDAO;
import DAO.ProductDAO;
import common.SuperClass;

public class PreviewDeleteController extends SuperClass {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("PreviewDeleteController doGet !! ");
		int seq_review = Integer.parseInt(request.getParameter("seq_review"));

		PreviewDAO dao = new PreviewDAO();

		int cnt = -999999;
		cnt = dao.DeleteData(seq_review);

		response.sendRedirect("/SemiProject/dodamdodam?command=pdetail&productcode="+request.getParameter("seq_review"));
	}
}
