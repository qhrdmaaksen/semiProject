package mypkg.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		
		
		
		
		super.doPost(request, response);
	}
	
	@Override
	public boolean validate(HttpServletRequest request) {
		// TODO Auto-generated method stub
		return super.validate(request);
	}
	
	

}
