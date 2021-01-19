package payments;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.AddressDAO;
import VO.AddressVO;
import common.SuperClass;

public class PaymentShippingController extends SuperClass{
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AddressVO bean  = new AddressVO();
		bean.setAddress1(request.getParameter("sample4_roadAddress"));
		bean.setAddress2(request.getParameter("sample4_jibunAddress"));
		bean.setId(request.getParameter("id"));
		bean.setName(request.getParameter("name"));
		bean.setPhone(request.getParameter("phone"));
		bean.setShippingname(request.getParameter("shippingname"));
		
		AddressDAO bdao = new AddressDAO();			
		int cnt = -99999 ; 			
		cnt = bdao.InsertData(bean) ;
		
		new PaymentController().doPost(request, response);
	}
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true ;
		
		return super.validate(request);
	}
}
