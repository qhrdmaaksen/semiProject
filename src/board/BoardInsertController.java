package board;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.BoardDAO;
import VO.BbsPostVo;
import common.SuperClass;

public class BoardInsertController extends SuperClass {
	
	private BbsPostVo bean = null ;
	
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		String gotopage = "/customer/bbsinsert.jsp";
		super.GotoPage(gotopage);
		
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {		
		bean  = new BbsPostVo();
		//bean.setNo(no); //�������� �ʿ� ����
		bean.setContent( request.getParameter("content") );
		bean.setId(request.getParameter("id"));
		bean.setLikenumber(Integer.parseInt(request.getParameter("likenumber")));
		
		bean.setPostdate(String.valueOf(request.getParameter("postdate")));
		bean.setTitle(request.getParameter("title"));
		
		
		if( request.getParameter("num") != null && request.getParameter("num") != "" ){
			bean.setNum(Integer.parseInt(request.getParameter("num")));
		}
  
		
		System.out.println( bean );
		
		if ( this.validate( request ) == false ) {			
			request.setAttribute("bean", bean);
			super.doPost(request, response);
			String url = "/customer/bbs.jsp";
			super.GotoPage( url );
//			super.GotoPage(this.getClass().toString(), "boInsertForm");
		}else{
			//url = "/board/boList.jsp";
			//DAO ��ü�� �����Ѵ�.
			BoardDAO bdao = new BoardDAO();			
			int cnt = -99999 ; 			
			//Bean ��ü�� �̿��Ͽ� �ش� �Խù��� �߰��Ѵ�.
			cnt = bdao.InsertData(bean) ;
			new BoardListController().doGet( request, response );
		}
	}
	
	
	
	@Override
	public boolean validate(HttpServletRequest request) {
			final String PREFIX = "err" ;
			boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
			
			if( bean.getTitle().length() < 3 || bean.getTitle().length() > 10 ){
				request.setAttribute( PREFIX + "subject", "제목은 3글자 이상 10글자 이하이어야 합니다.");
				isCheck = false  ;
			}
			if( bean.getContent().length() < 5 || bean.getContent().length() > 30 ){
				request.setAttribute( PREFIX + "content", "글 내용은 5자리 이상 30자리 이하이어야 합니다.");
				isCheck = false  ;
			}
	 		String regex = "\\d{4}[-/]\\d{2}[-/]\\d{2}" ;
			if( bean.getPostdate() == null){
				bean.setPostdate( "" );
			}
			boolean result = Pattern.matches(regex, bean.getPostdate());
			if (result == false ) {
				request.setAttribute( PREFIX + "regdate", "날짜는 yyyy/MM/dd 또는 yyyy-MM-dd 형식으로 입력해 주세요.");
				isCheck = false  ;
			}
			return isCheck ;
	}
	
	
}
