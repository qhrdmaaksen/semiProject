package product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.PreviewDAO;
import VO.PreviewVO;
import common.SuperClass;

public class PreviewUpdateController extends SuperClass{
	private PreviewVO bean = null ; 
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int seq_review = Integer.parseInt(request.getParameter("seq_review")) ;
		PreviewDAO dao = new PreviewDAO(request);
		
		PreviewVO xxx = dao.selectdatabypk(seq_review);
		
		request.setAttribute("bean", xxx);
		
		super.doGet(request, response);
		
		String gotopage = "product/previewupdate.jsp";
		super.GotoPage(gotopage);
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		bean = new PreviewVO();
		
		bean.setReviewno(Integer.parseInt(request.getParameter("reviewno")));		
		bean.setId(request.getParameter("id")) ;
		bean.setContent(request.getParameter("content")) ;
		bean.setPostdate(request.getParameter("postdate")); 
		
		String gotopage = "" ;
		if (this.validate(request) == true) {
			// 유효성 검사 통과
			PreviewDAO dao = new PreviewDAO(request);
			int cnt = -999999 ;
			cnt = dao.UpdateData(bean) ;
			
			// request 객체의 내용을 보존하면서 목록 보기 페이지로 넘겨 줍니다.
			response.sendRedirect("/SemiProject/dodamdodam?command=pdetail&productcode="+request.getParameter("reviewno"));
			
		}else { // 유효성 검사 실패
			request.setAttribute("bean", bean);			
			super.doPost(request, response);
			gotopage = "product/previewupdate.jsp" ;
			super.GotoPage(gotopage);
		}
	}
}
