package member;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MemberDAO;
import VO.MemberVO;
import common.IndexController;
import common.SuperClass;

public class MemberNewmemberController extends SuperClass{
	private MemberVO bean = null ;	
	String gotopage = "";
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doGet(request, response);
		String gotopage = "member/newmember.jsp";		
		super.GotoPage( gotopage );
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		bean  = new MemberVO();

		Date birth = null;
		try {
			birth = sdf.parse(request.getParameter("birth"));
			bean.setBirth(birth);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		System.out.println(request.getParameter("birth"));
		System.out.println("생일은?" + bean.getBirth());
		bean.setId(request.getParameter("id"));
		bean.setName(request.getParameter("uname"));
		bean.setPassword(request.getParameter("password"));
		/*
		 * if (request.getParameter("password1") == request.getParameter("password2")) {
		 * bean.setPassword(request.getParameter("password1"));
		 * System.out.println(request.getParameter("password1"));
		 * System.out.println(request.getParameter("password2")); }
		 */
		/*
			 * else { System.out.println(request.getParameter("password1"));
			 * System.out.println(request.getParameter("password2"));
			 *  gotopage =
			 * "member/newmember.jsp"; super.GotoPage( gotopage ); }
			 */
		bean.setPhone(request.getParameter("phone"));
		
		/*
		 * if( request.getParameter("point") != null ||
		 * request.getParameter("point").equals("") == false ){ bean.setPoint(
		 * Integer.parseInt( request.getParameter("point") )); } if(
		 * request.getParameter("picture") != null ||
		 * request.getParameter("picture").equals("") == false ){ bean.setPicture(
		 * request.getParameter("picture")); } if( request.getParameter("level") != null
		 * || request.getParameter("level").equals("") == false ){
		 * bean.setLevel(request.getParameter("level")); }
		 */
		
		System.out.println( bean );

		if (this.validate(request)) {
			//DAO 객체를 생성한다.
			MemberDAO mdao = new MemberDAO();			
			int cnt = -99999 ; 			
			//Bean 객체를 이용하여 해당 게시물을 추가한다.
			cnt = mdao.NewData(bean) ;
			
			super.session.setAttribute( "message" , "축하합니다. 회원 가입이 되었습니다. 로그인 후 메인 페이지로 이동합니다." );
			
			// 회원 가입을 성공하면, 바로 로그인되도록 처리해줍니다.
			// doPost() 메소드를 호출하여 바로 로그인을 수행합니다.
			new MemberLoginController().doPost(request, response);
		}else{
			gotopage = "member/newmember.jsp";  
			request.setAttribute("bean", bean);
			super.doPost(request, response);
			super.GotoPage( gotopage );
		}		
	}
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
		
		if( bean.getId().length() < 4 || bean.getId().length() > 10 ){
			request.setAttribute( super.PREFIX + "id", "아이디는 4자리 이상 12자리 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getName().length() < 2 || bean.getName().length() > 10 ){
			request.setAttribute( super.PREFIX + "name", "이름은 2자리 이상 15자리 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getPassword().length() < 6 || bean.getPassword().length() > 10 ){
			request.setAttribute( super.PREFIX + "password", "비밀 번호는 6자리 이상 15자리 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getBirth() == null){
			request.setAttribute( super.PREFIX + "birth", "생년월일을 형식에 맞게 작성 해 주세요.	");
			isCheck = false  ;
		}
			
		if( bean.getPhone().length() < 11 || bean.getPhone().length() > 11 ){
			request.setAttribute( super.PREFIX + "phone", "휴대폰 번호를 정확하게 작성 해 주세요.");
			isCheck = false  ;
		}
				
		String regex = "\\d{4}[-]\\d{2}[-]\\d{2}" ;
		boolean result = Pattern.matches(regex, request.getParameter("birth"));
		if (result == false ) {
			request.setAttribute( super.PREFIX + "birth", "생일은 yyyy-MM-dd 형식으로 입력해 주세요.");
			isCheck = false  ;
		}
		return isCheck ;
	}
}