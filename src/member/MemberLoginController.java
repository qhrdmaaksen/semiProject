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
<<<<<<< HEAD
		System.out.println("ȸ�� �α��� ȣ���");
=======
		System.out.println("회원 로그인 호출됨");
>>>>>>> d9c94c149643ff4082ee7e1bf2475582a8b34103
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
<<<<<<< HEAD
			String errmsg = "�α��� ����� �߸��Ǿ����ϴ�.";
=======
			String errmsg = "로그인 양식이 잘못되었습니다.";
>>>>>>> d9c94c149643ff4082ee7e1bf2475582a8b34103

			super.setErrorMessage(errmsg);
			this.doGet(request, response);
		}else {

			MemberDAO dao = new MemberDAO();
			try {
				MemberVO member = dao.selectMember(id,password);
				super.doPost(request, response);
				super.session.setAttribute("loginfo", member);
			} catch (NoSuchFieldException e) {
<<<<<<< HEAD
				String errmsg = "���̵� Ȥ�� ��й�ȣ�� �߸��Ǿ����ϴ�.";
=======
				String errmsg = "아이디 혹은 비밀번호가 잘못되었습니다.";
>>>>>>> d9c94c149643ff4082ee7e1bf2475582a8b34103
				System.out.println(errmsg);
				super.setErrorMessage(errmsg);
				this.doGet(request, response);
			}

			new IndexController().doGet(request, response);
		}
	}

	@Override
	public boolean validate(HttpServletRequest request) {
<<<<<<< HEAD
		boolean isCheck = true;	// �⺻ ���� true �Դϴ�. 
		// ���� ��ȿ�� �˻��� ������ ������ isCheck �� false �� �����մϴ�.
		
		if(this.id.length() < 4 || this.id.length()> 12) {
			request.setAttribute(super.PREFIX+"id", "���̵�� 4�ڸ� �̻� 10�ڸ� �����̾�� �մϴ�.");
			
			isCheck = false;
		}
		
		if(this.password.length() < 4 || this.password.length()> 15) {
			request.setAttribute(super.PREFIX+"passowrd", "��й�ȣ�� 4�ڸ� �̻� 10�ڸ� �����̾�� �մϴ�.");
=======
		boolean isCheck = true;	// 기본 값은 true 입니다.
		// 만일 유효성 검사의 문제가 있으면 isCheck 는 false 로 변경합니다.

		if(this.id.length() < 4 || this.id.length()> 10) {
			request.setAttribute(super.PREFIX+"id", "아이디는 4자리 이상 10자리 이하이어야 합니다.");

			isCheck = false;
		}

		if(this.password.length() < 4 || this.password.length()> 10) {
			request.setAttribute(super.PREFIX+"passowrd", "비밀번호는 4자리 이상 10자리 이하이어야 합니다.");
>>>>>>> d9c94c149643ff4082ee7e1bf2475582a8b34103
			isCheck = false;
		}
		return isCheck;
	}
}