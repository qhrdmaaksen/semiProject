package member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class MemberLogoutController extends common.SuperClass {
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		super.doGet(request, response);
		
		
			super.session.invalidate();
		
		//SuperClass 에 구해놓은 세션 객체가 있습니다. 
		//super.session.invalidate(); // 로그인 정보를 세션 영역에서 지우기.
		
		String gotopage = "/member/login.jsp";
		super.GotoPage(gotopage);
	}
}
