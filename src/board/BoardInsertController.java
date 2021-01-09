package board;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import DAO.BoardDAO;
import VO.BbsPostVo;
import common.SuperClass;

public class BoardInsertController extends SuperClass {
	
	private BbsPostVo bbsbean = null ;
	
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		String gotopage = "/customer/bbsinsert.jsp";
		super.GotoPage(gotopage);
		
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		
		MultipartRequest multi = (MultipartRequest)request.getAttribute("multi") ;
		
		System.out.println(multi);
		
		bbsbean  = new BbsPostVo();
		
		//bean.setNo(no); //�������� �ʿ� ����
		bbsbean.setContent( multi.getParameter("content") );
		bbsbean.setId(multi.getParameter("id"));
		bbsbean.setPostdate(multi.getParameter("postdate"));
		bbsbean.setTitle(multi.getParameter("title"));
		bbsbean.setImage( multi.getFilesystemName("image") );
		if( multi.getParameter("likenumber") != null && multi.getParameter("likenumber") != "" ){
			bbsbean.setLikenumber(Integer.parseInt( multi.getParameter("likenumber")));	
		}   
		
	
		
		System.out.println( bbsbean );
		
		if ( this.validate( request ) == false ) {			
			request.setAttribute("bean", bbsbean);
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
			cnt = bdao.InsertData(bbsbean) ;
			new BoardListController().doGet( request, response );
		}
	}
	
	
	
	@Override
	public boolean validate(HttpServletRequest request) {
			final String PREFIX = "err" ;
			boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
			
			if( bbsbean.getTitle().length() < 3 || bbsbean.getTitle().length() > 10 ){
				request.setAttribute( PREFIX + "subject", "제목은 3글자 이상 10글자 이하이어야 합니다.");
				isCheck = false  ;
			}
			if( bbsbean.getContent().length() < 5 || bbsbean.getContent().length() > 30 ){
				request.setAttribute( PREFIX + "content", "글 내용은 5자리 이상 30자리 이하이어야 합니다.");
				isCheck = false  ;
			}
	 		String regex = "\\d{4}[-/]\\d{2}[-/]\\d{2}" ;
			if( bbsbean.getPostdate() == null){
				bbsbean.setPostdate( "" );
			}
			boolean result = Pattern.matches(regex, bbsbean.getPostdate());
			if (result == false ) {
				request.setAttribute( PREFIX + "regdate", "날짜는 yyyy/MM/dd 또는 yyyy-MM-dd 형식으로 입력해 주세요.");
				isCheck = false  ;
			}
			return isCheck ;
	}
	
	
}
