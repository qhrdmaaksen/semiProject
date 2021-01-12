package CS;

import java.io.IOException;
import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.NoticeDAO;
import VO.NoticeVO;
import common.SuperClass;

public class NoticeUpdateController extends SuperClass{
	private NoticeVO bean = null ;
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int seq_index = Integer.parseInt(request.getParameter("seq_index")) ;
		Enumeration<String> en= request.getAttributeNames();
		while(en.hasMoreElements()) {
			System.out.print(en.nextElement()+", ");
		}
		
		
		NoticeDAO dao = new NoticeDAO();
		
		// 여기서 xxx는 현재 수정하고자 하는 이전에 기입했던 게시물 1건을 의미합니다.
		NoticeVO xxx = dao.SelectDataByPk(seq_index);
		
		request.setAttribute("bean", xxx);
		
		super.doGet(request, response);
		
		String gotopage = "cs_center/notice_update.jsp" ;
		super.GotoPage(gotopage);
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		bean = new NoticeVO();
		
		bean.setSeq_index(Integer.parseInt(request.getParameter("seq_index"))) ;
		bean.setCategory(request.getParameter("category"));		
		bean.setTitle(request.getParameter("title")); 
		bean.setContent(request.getParameter("content")) ;
		bean.setId(request.getParameter("id")); 
		
		String gotopage = "" ;
		if (this.validate(request) == true) {
			// 유효성 검사 통과
			NoticeDAO dao = new NoticeDAO();
			int cnt = -999999 ;
			cnt = dao.UpdateData(bean) ;
			
			// request 객체의 내용을 보존하면서 목록 보기 페이지로 넘겨 줍니다.
			new NoticeListController().doGet(request, response);
			
		}else { // 유효성 검사 실패
			request.setAttribute("bean", bean);			
			super.doPost(request, response);
			gotopage = "cs_center/notice_update.jsp" ;
			super.GotoPage(gotopage);
		}
	}
	@Override
	public boolean validate(HttpServletRequest request) {
		//기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
		boolean isCheck = true ; 
		Enumeration<String> it =    request.getParameterNames();
		
		while(it.hasMoreElements()) {
			System.out.println("it.nextElement() : "+it.nextElement());
		}
	
		if( bean.getTitle().length() < 3 || bean.getTitle().length() > 50 ){
			request.setAttribute( super.PREFIX + "subject", "제목은 3글자 이상 50글자 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getContent().length() < 5 || bean.getContent().length() > 1000 ){
			request.setAttribute( super.PREFIX + "content", "글 내용은 5자리 이상 1000자리 이하이어야 합니다.");
			isCheck = false  ;
		}
		return isCheck ;
	}
}
