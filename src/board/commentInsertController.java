package board;

import java.io.IOException;

import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import DAO.BoardDAO;
import VO.BbsPostVo;
import VO.commentVO;
import common.SuperClass;

public class commentInsertController extends SuperClass {
	
	private commentVO bean = null;
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		int seq_index = Integer.parseInt(request.getParameter("no"));
		System.out.println(seq_index);
		
		request.setAttribute("seq_index", seq_index);
		
		String gotopage = "/customer/commentwrite.jsp";
		super.GotoPage(gotopage);
		
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {	
		
		int seq = Integer.parseInt(request.getParameter("seq_index"));
		
		System.out.println(seq + "seq가 들어왔나요");
		
		bean  = new commentVO();
		
		//bean.setNo(no); //�������� �ʿ� ����
		
		bean.setComment(request.getParameter("comment"));
		bean.setId(request.getParameter("id"));
		
		
	
		
		System.out.println( bean);
		
		if ( this.validate( request ) == false ) {			
			request.setAttribute("bean", bean);
			super.doPost(request, response);
			String url = "/customer/commentwrite.jsp";
			super.GotoPage( url );
//			super.GotoPage(this.getClass().toString(), "boInsertForm");
		}else{
			//url = "/board/boList.jsp";
			//DAO ��ü�� �����Ѵ�.
			BoardDAO bdao = new BoardDAO();			
			int cnt = -99999 ; 			
			//Bean ��ü�� �̿��Ͽ� �ش� �Խù��� �߰��Ѵ�.
			cnt = bdao.InsertData(bean,seq) ;
			new BoardListController().doGet( request, response );
		}
	}
	
	
	
	@Override
	public boolean validate(HttpServletRequest request) {
			final String PREFIX = "err" ;
			boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
	
			return isCheck ;
	}
	
	
}
