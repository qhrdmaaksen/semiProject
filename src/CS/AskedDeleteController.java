package CS;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.AskedDAO;
import DAO.NoticeDAO;
import common.SuperClass;

public class AskedDeleteController extends SuperClass {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int seq_index = Integer.parseInt(request.getParameter("seq_index"));

		AskedDAO dao = new AskedDAO();

		int cnt = -999999;
		cnt = dao.DeleteData(seq_index);

		new NoticeListController().doGet(request, response);
	}
}
