package member;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.MemberDAO;
import VO.MemberVO;
import common.SuperClass;

public class MemberModifyController extends SuperClass{
	private MemberVO bean = null ;	
	String gotopage = "";
	HttpSession session = null;
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		this.session = request.getSession();
        MemberVO tem = (MemberVO)session.getAttribute("loginfo");
        System.out.println(tem.toString());
        
		String id = tem.getId();
		MemberDAO dao = new MemberDAO();
		// bean 객체 : 로그인 한 사람의 정보
		MemberVO bean = dao.SelectDataByPk(id);
		System.out.println(bean.getId().equals(tem.getId()));
		System.out.println("접속한 아이디" + id );
		super.doGet(request, response);
		request.setAttribute("bean", bean);
		
		String gotopage = "/member/memodify.jsp";	
		super.GotoPage(gotopage);
		
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.session = request.getSession();
        MemberVO per = (MemberVO)session.getAttribute("loginfo");
        bean  = new MemberVO();
        String id = per.getId();
		MemberDAO dao = new MemberDAO();	
		// bean 객체 : 로그인 한 사람의 정보
		bean = dao.SelectDataByPk(id);
        
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		
		System.out.println(bean.getId().equals(per.getId()));
		
		
		Date birth = null;
		try {
			birth = sdf.parse(request.getParameter("birth"));
			bean.setBirth(birth);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		bean.setId(request.getParameter("id"));
		bean.setName(request.getParameter("name"));
		bean.setPassword(request.getParameter("password"));
		bean.setPhone(request.getParameter("phone"));
		//System.out.println(tem.getId());
		bean.setLevel(per.getLevel());
		//System.out.println("리퀘스트에서는?" + request.getParameter("point"));
		bean.setPoint(per.getPoint());
		//bean.setPoint( Integer.parseInt( request.getParameter("point") ));
		bean.setPicture(per.getPicture());
		
		
		
		/*
		 * if( request.getParameter("level") != null ||
		 * request.getParameter("level").equals("") == false ){
		 * bean.setLevel(request.getParameter("level")); } if(
		 * request.getParameter("point") != null ||
		 * request.getParameter("point").equals("") == false ){ bean.setPoint(
		 * Integer.parseInt( request.getParameter("point") )); } if(
		 * request.getParameter("picture") != null ||
		 * request.getParameter("picture").equals("") == false ){
		 * bean.setPicture(request.getParameter("picture")); }
		 */
		
		System.out.println("여기까지 왔니? " +  bean );
		System.out.println("이름이 왜? " + request.getParameter("name"));
		
		if ( this.validate( request ) == true ) {
			MemberDAO mdao = new MemberDAO();			
			int cnt = -99999 ; 		
			cnt = mdao.ModifyData(bean) ;
			
		super.session.setAttribute( "message" , "정보 수정이 완료 되었습니다. 로그인 후 메인 페이지로 이동합니다." );
			
			// 회원 가입을 성공하면, 바로 로그인되도록 처리해줍니다.
			// doPost() 메소드를 호출하여 바로 로그인을 수행합니다.
			new MemberLoginController().doPost(request, response);
		}else{
			gotopage = "/member/memodify.jsp";  
			request.setAttribute("bean", bean);
			super.doPost(request, response);
			super.GotoPage( gotopage );
		}		
	}
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
		
	
		if( bean.getName().length() < 2 || bean.getName().length() > 15 ){
			request.setAttribute( super.PREFIX + "name", "이름은 2자리 이상 15자리 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getPassword().length() < 6 || bean.getPassword().length() > 15 ){
			request.setAttribute( super.PREFIX + "password", "비밀 번호는 6자리 이상 15자리 이하이어야 합니다.");
			isCheck = false  ;
			}
		System.out.println("비밀번호 잘 나오나? : " + bean.getPassword() + "/" + request.getParameter("password2"));
		if( !bean.getPassword().equals(request.getParameter("password2"))){
			request.setAttribute( super.PREFIX + "password2", "비밀 번호가 일치하지 않습니다.");
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