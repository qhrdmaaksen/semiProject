package CS;

import java.io.IOException;
import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.AskedDAO;
import DAO.NoticeDAO;
import VO.AskedVO;
import VO.NoticeVO;
import common.SuperClass;

public class AskedUpdateController extends SuperClass{
	private AskedVO bean = null ;
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no")) ;
		
		AskedDAO dao = new AskedDAO();
		
		// 여기서 xxx는 현재 수정하고자 하는 이전에 기입했던 게시물 1건을 의미합니다.
		AskedVO xxx = dao.SelectDataByPk(no);
		
		request.setAttribute("bean", xxx);
		
		super.doGet(request, response);
		
		String gotopage = "cs_center/notice_update.jsp" ;
		super.GotoPage(gotopage);
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		bean = new AskedVO();
		
		bean.setContent(request.getParameter("content")) ;
		bean.setNo(Integer.parseInt(request.getParameter("no"))) ;
		bean.setPassword(request.getParameter("password"));		
		bean.setRegdate(request.getParameter("regdate")); 
		bean.setSubject(request.getParameter("subject")); 
		bean.setWriter(request.getParameter("writer")); 
		
		String gotopage = "" ;
		if (this.validate(request) == true) {
			// 유효성 검사 통과
			AskedDAO dao = new AskedDAO();
			int cnt = -999999 ;
			cnt = dao.UpdateData(bean) ;
			
			// request 객체의 내용을 보존하면서 목록 보기 페이지로 넘겨 줍니다.
			new AskedListController().doGet(request, response);
			
		}else { // 유효성 검사 실패
			request.setAttribute("bean", bean);			
			super.doPost(request, response);
			gotopage = "cs_center/asked_update.jsp" ;
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
	
		if( bean.getSubject().length() < 3 || bean.getSubject().length() > 50 ){
			request.setAttribute( super.PREFIX + "subject", "제목은 3글자 이상 50글자 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getContent().length() < 5 || bean.getContent().length() > 1000 ){
			request.setAttribute( super.PREFIX + "content", "글 내용은 5자리 이상 1000자리 이하이어야 합니다.");
			isCheck = false  ;
		}
 		String regex = "\\d{4}[-/]\\d{2}[-/]\\d{2}" ;
		if( bean.getRegdate() == null){
			bean.setRegdate( "" );
		}
		boolean result = Pattern.matches(regex, bean.getRegdate());
		if (result == false ) {
			request.setAttribute( super.PREFIX + "regdate", "날짜는 yyyy/MM/dd 또는 yyyy-MM-dd 형식으로 입력해 주세요.");
			isCheck = false  ;
		}
		return isCheck ;
	}
}
