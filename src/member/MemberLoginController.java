package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MemberDAO;
import VO.MemberVO;
import common.IndexController;
import common.SuperClass;

public class MemberLoginController extends SuperClass{
	private String id ;
	private String password ;

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("ȸ�� �α��� ȣ���");
		super.doGet(request, response);
		super.GotoPage("/member/login.jsp");
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.id = request.getParameter("id");
		this.password = request.getParameter("password");

		System.out.println("id : " + request.getParameter("id"));
		System.out.println("password : " + request.getParameter("password"));

		if(!this.validate(request)) {
			String errmsg = "�α��� ����� �߸��Ǿ����ϴ�.";

			super.setErrorMessage(errmsg);
			this.doGet(request, response);
		}else {

			MemberDAO dao = new MemberDAO();
			try {
				MemberVO member = dao.selectMember(id,password);
				super.doPost(request, response);
				super.session.setAttribute("loginfo", member);
			} catch (NoSuchFieldException e) {
				String errmsg = "���̵� Ȥ�� ��й�ȣ�� �߸��Ǿ����ϴ�.";
				System.out.println(errmsg);
				super.setErrorMessage(errmsg);
				this.doGet(request, response);
			}

			new IndexController().doGet(request, response);
		}
	}
	
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true;	// �⺻ ���� true �Դϴ�. 
		// ���� ��ȿ�� �˻��� ������ ������ isCheck �� false �� �����մϴ�.
		
		if(this.id.length() < 4 || this.id.length()> 12) {
			request.setAttribute(super.PREFIX+"id", "���̵�� 4�ڸ� �̻� 10�ڸ� �����̾�� �մϴ�.");
			
			isCheck = false;
		}
		
		if(this.password.length() < 4 || this.password.length()> 15) {
			request.setAttribute(super.PREFIX+"passowrd", "��й�ȣ�� 4�ڸ� �̻� 10�ڸ� �����̾�� �մϴ�.");
			isCheck = false;
		}
		return isCheck;
	}
	

}
