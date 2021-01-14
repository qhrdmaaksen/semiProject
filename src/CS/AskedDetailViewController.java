package CS;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.AskedDAO;
import DAO.NoticeDAO;
import VO.AskedVO;
import VO.MemberVO;
import VO.NoticeVO;
import common.SuperClass;
import utility.FlowParameters;

public class AskedDetailViewController extends SuperClass{
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int seq_index = Integer.parseInt(request.getParameter("seq_index")) ;
		
		AskedDAO dao = new AskedDAO() ;
		
		AskedVO bean = dao.SelectDataByPk(seq_index) ;
		
		FlowParameters parameters 
			= new FlowParameters(
					request.getParameter("pageNumber"), 
					request.getParameter("pageSize"), 
					request.getParameter("mode"), 
					request.getParameter("keyword")) ;
		
		System.out.println(this.getClass() + " : " + parameters.toString());
		
		super.doGet(request, response);
		
		if (bean != null) { 
			// 작성자의 게시물이 아니면 조회수를 +1 증가시킵니다.
			// bean.getWriter()와 세션의 loginfo의 id를 비교합니다.
			// 동일하지 않으면 조회수를 +1
			
			// login : 현재 접속한 사람의 정보를 저장하고 있는 객체입니다.
			MemberVO login =  (MemberVO)super.session.getAttribute("loginfo") ;
			if(!bean.getId().equals(login.getId())) {
			}
			request.setAttribute("bean", bean);
			request.setAttribute("parameters", parameters.toString());
			
			//상세 보기 페이지로 이동
			String gotopage = "/cs_center/asked_detailview.jsp" ;
			super.GotoPage(gotopage);
		} else {
			// 포워딩을 이용하여 목록 페이지로 다시 돌아갑니다.
			// 다음과 같이 코딩하면 request와 response 객체가 그대로 다시 넘어 갑니다.
			new NoticeListController().doGet(request, response); 
		}		
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
		
		String gotopage = "" ;
		if (this.validate(request) == true) {
			gotopage = "" ;
			super.GotoPage(gotopage);
			
		}else {
			gotopage = "" ;
			super.GotoPage(gotopage);
		}
	}
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true ;
		
		return isCheck ;
	}

}
