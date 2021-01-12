package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import DAO.BoardDAO;
import VO.BbsPostVo;
import common.SuperClass;


public class BoardUpdateController extends SuperClass {
	private BbsPostVo bean = null;

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));

		BoardDAO dao = new BoardDAO();

		// xxx 는 이전에 기입했던 게시물 1건의 정보
		BbsPostVo xxx = dao.SelctDataByPK(no);

		request.setAttribute("bean", xxx);

		super.doGet(request, response);

		String gotopage = "customer/bbsupdateform.jsp";
		super.GotoPage(gotopage);

	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		MultipartRequest multi = (MultipartRequest)request.getAttribute("multi") ;
		
		bean  = new BbsPostVo();
		bean.setContent(multi.getParameter("content"));
		bean.setTitle(multi.getParameter("title"));
		bean.setImage( multi.getFilesystemName("image") );
		bean.setId(multi.getParameter("id"));
		bean.setNo(Integer.parseInt(multi.getParameter("no")));
		
		
		
//		다음 항목들은 수정에 반영할 필요가 없습니다. 
//		bean.setReadhit(Integer.parseInt(request.getParameter("readhit")));
//		bean.setOrderno(Integer.parseInt(request.getParameter("orderno")));
//		bean.setGroupno(Integer.parseInt(request.getParameter("groupno")));
//		bean.setDepth(Integer.parseInt(request.getParameter("depth")));
//		
		System.out.println(bean + "입니다. ");
		
		String gotopage = "";
		if (this.validate(request) == true) {
			// 유효성 검사 통과
			BoardDAO dao = new BoardDAO();
			int cnt = -99999;
			cnt = dao.UpdateData(bean);
			
			//request 객체의 내용을 보존하면서 목록 보기 페이지로 넘겨 줍니다. 
			new BoardListController().doGet(request, response);

		} else { // 유효성 검사 실패
			request.setAttribute("bean", bean);
			super.doPost(request, response);
			gotopage = "customer/bbsupdateform.jsp";
			super.GotoPage(gotopage);

		}

	}

	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
		
		if( bean.getTitle().length() < 3 || bean.getTitle().length() > 10 ){
			request.setAttribute( super.PREFIX + "title", "제목은 3글자 이상 10글자 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getContent().length() < 5 || bean.getContent().length() > 30 ){
			request.setAttribute( super.PREFIX + "content", "글 내용은 5자리 이상 30자리 이하이어야 합니다.");
			isCheck = false  ;
		}
		String regex = "\\d{4}[-/]\\d{2}[-/]\\d{2}" ;
		if( bean.getPostdate() == null){
			bean.setPostdate( "" );
		}
		
		return isCheck ;
	}
}
