package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MemberDao;
import VO.MemberVO;
import common.SuperClass;

public class MemberLoginController extends SuperClass{
	private String id ; 
	private String  password ;
	
	
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("회원 로그인 호출됨");
		super.doGet(request, response);
		String gotopage = "/member/meLoginForm.jsp" ;
		
		super.GotoPage(gotopage);
		
		
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.id = request.getParameter("id");
		this.password = request.getParameter("password");
		
		if(this.validate(request) == false) {
			String gotopage ;
			gotopage = "login/login.jsp";
			
			String errmsg = "회원 정보가 없습니다.";
			
			
			super.setErrorMessage(errmsg);
			super.doPost(request, response);
			super.GotoPage(gotopage);
			
			
		}
		
		if(this.validate(request)==true) {
			
			MemberDao dao = new MemberDao();
			
			MemberVO member =  dao.Insertdate(id,password);
			
			super.session.setAttribute("loginfo", member);
			
			String gotopage ;
			gotopage = "common/index.jsp";
			
			super.GotoPage(gotopage);
			
			
		}
		
		
		
	
		
		
		
		super.doPost(request, response);
	}
	
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true;	// 기본 값은 true 입니다. 
		// 만일 유효성 검사의 문제가 있으면 isCheck 는 false 로 변경합니다.
		
		if(this.id.length() < 4 || this.id.length()> 10) {
			request.setAttribute(super.PREFIX+"id", "아이디는 4자리 이상 10자리 이하이어야 합니다.");
			
			isCheck = false;
		}
		
		if(this.password.length() < 4 || this.password.length()> 10) {
			request.setAttribute(super.PREFIX+"passowrd", "비밀번호는 4자리 이상 10자리 이하이어야 합니다.");
			isCheck = false;
		}
		
		return isCheck;
	}
	

}