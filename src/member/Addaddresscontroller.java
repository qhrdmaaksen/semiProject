package member;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import DAO.AddressDAO;
import VO.AddressVO;
import common.SuperClass;

public class Addaddresscontroller extends SuperClass {
	
	private AddressVO bean = null ;
	
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		String gotopage = "/member/addaddress.jsp";
		super.GotoPage(gotopage);
		
	}
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {		
	
		bean  = new AddressVO();
		//bean.setNo(no); //�������� �ʿ� ����
		bean.setAddress1(request.getParameter("sample4_roadAddress"));
		bean.setAddress2(request.getParameter("sample4_jibunAddress"));
		bean.setId(request.getParameter("id"));
		bean.setName(request.getParameter("name"));
		bean.setPhone(request.getParameter("phone"));
		bean.setShippingname(request.getParameter("shippingname"));
		
		
	
		
		System.out.println( bean );
		
		if ( this.validate( request ) == false ) {			
			request.setAttribute("bean", bean);
			super.doPost(request, response);
			String url = "/board/boInsert.jsp";
			super.GotoPage( url );
//			super.GotoPage(this.getClass().toString(), "boInsertForm");
		}else{
			//url = "/board/boList.jsp";
			//DAO ��ü�� �����Ѵ�.
			AddressDAO bdao = new AddressDAO();			
			int cnt = -99999 ; 			
			//Bean ��ü�� �̿��Ͽ� �ش� �Խù��� �߰��Ѵ�.
			cnt = bdao.InsertData(bean) ;
			new Addresscontroller().doGet( request, response );
		}
	}
	
	@Override
	public boolean validate(HttpServletRequest request) {
			final String PREFIX = "err" ;
			boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
			
			return isCheck;
}
}