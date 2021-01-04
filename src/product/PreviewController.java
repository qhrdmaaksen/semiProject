package product;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.PreviewDAO;
import VO.PreviewVO;
import common.SuperClass;

public class PreviewController extends SuperClass{
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("PreviewController doGet");
		PreviewDAO dao = new PreviewDAO(request);
		List<PreviewVO> result = dao.listsSelect() ;
		HttpSession session = request.getSession();
		session.setAttribute("lists", result);
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PreviewDAO dao = new PreviewDAO(request);
		//TODO
		//dao.getList
		//request.setAttr (lists,lists)
		//--------------------
		
		int result = dao.addReview();
		if(result <=0) {
			System.out.println("result : "+result);
			System.out.println("Review DB 입력 실패");
		}else {
			System.out.println("Review DB 입력 성공");
			System.out.println("result : "+result);
		} 
		
		doProcess(request, response);
		GotoPage("/product/pdetail.jsp");
	}
	/*@Override
	public boolean validate(HttpServletRequest request) {
		final String PREFIX = "err" ;
		boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
		
		if( bean.getSubject().length() < 3 || bean.getSubject().length() > 10 ){
			request.setAttribute( PREFIX + "subject", "제목은 3글자 이상 10글자 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getPassword().length() < 4 || bean.getPassword().length() > 12 ){
			request.setAttribute( PREFIX + "password", "비밀 번호는 4자리 이상 10자리 이하이어야 합니다.");
			isCheck = false  ;
		}
		if( bean.getContent().length() < 5 || bean.getContent().length() > 30 ){
			request.setAttribute( PREFIX + "content", "글 내용은 5자리 이상 30자리 이하이어야 합니다.");
			isCheck = false  ;
		}
 		String regex = "\\d{4}[-/]\\d{2}[-/]\\d{2}" ;
		if( bean.getRegdate() == null){
			bean.setRegdate( "" );
		}
		boolean result = Pattern.matches(regex, bean.getRegdate());
		if (result == false ) {
			request.setAttribute( PREFIX + "regdate", "날짜는 yyyy/MM/dd 또는 yyyy-MM-dd 형식으로 입력해 주세요.");
			isCheck = false  ;
		}
		return isCheck ;*/
	

}
