package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.BoardDAO;
import VO.BbsPostVo;
import VO.MemberVO;
import VO.commentVO;
import common.SuperClass;
import utility.FlowParameters;

public class BoardDetailViewController extends SuperClass {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
		
		BoardDAO dao = new BoardDAO();
		BbsPostVo bean = dao.SelctDataByPK(no);
		List<commentVO> comment = dao.SelctDataByPK2(no);
		
		
		System.out.println(bean );
		
		FlowParameters parameters =new FlowParameters(
				
								request.getParameter("pageNumber"),
								request.getParameter("pageSize"),
								request.getParameter("mode"),
								request.getParameter("keyword"));
		
		System.out.println(this.getClass() + ":" + parameters);
		

		
		super.doGet(request, response);
		
		

		
		
		
		if(bean!= null) {
			
			//작성자의 게시물이 아니면 조회수를 +1 증가 시킵니다.
			// 1) bean.getid()와 세션의 loginfo의 id를 비교합니다.
			// 동일하지 않으면 조회수를 +1 
			
			//login : 현재 접속한 사람의 정보를 저장하고 있는 객체입니다. 
			MemberVO login = (MemberVO)super.session.getAttribute("loginfo") ;
			
			
			/*
			 * if(!bean.getId().equals(login.getId())) { dao.UpdateReadhit(no);
			 * 
			 * }
			 */
			 
	
			request.setAttribute("bean", bean);
			request.setAttribute("parameters", parameters.toString());
			request.setAttribute("comment", comment);
			// 상세 보기 페이지로 이동
			String gotopage = "customer/bbsdetailview.jsp";
			super.GotoPage(gotopage);
			
			//
		} else {
			//다시 목록 페이지로 돌아가기
			//다음과 같이 코딩하면 request와 response 객체가 그대로 다시 넘어갑니다.
			new BoardInsertController().doGet(request, response);
			
			
		}

	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
		
		String gotopage = "";
		if(this.validate(request)==true) {
			gotopage = "";
			super.GotoPage(gotopage);
			
		}else {
			gotopage = "";
			super.GotoPage(gotopage);
			
		}
	
	}
	
	
	@Override
	public boolean validate (HttpServletRequest request) {
		boolean isCheck = true ;
		
		
		return super.validate(request);
	}
	
	
}
