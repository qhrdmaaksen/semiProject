package payments;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.CouponDAO;
import DAO.MemberDAO;
import VO.MemberVO;
import common.IndexController;
import common.SuperClass;

public class CouponSelectController extends SuperClass{
	  @Override
	    public void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        HttpSession session = request.getSession();

	        MemberVO tem = (MemberVO)session.getAttribute("loginfo");

	        try {
	            MemberDAO dao = new MemberDAO();
	            MemberVO mem = dao.selectMember(tem.getId(), tem.getPassword());
	            session.setAttribute("loginfo", mem);
	        } catch (NoSuchFieldException e) {
	            e.printStackTrace();
	            new IndexController().doGet(request, response);
	        }


	        CouponDAO dao = new CouponDAO();
	        session.setAttribute("cpnCount", dao.CountCoupons(tem.getId()));
	        request.setAttribute("coupons", dao.SelectCoupons(tem.getId(),0, 0, 10));
	        request.setAttribute("usedcoupons", dao.SelectCoupons(tem.getId(),1, 0, 10));

	        super.doProcess(request, response);
	        
	        String gotopage = "";
	        if (request.getParameter("couponselect") == null) {
	        	super.GotoPage("/member/coupon.jsp");
			} else {
				super.GotoPage("/pay/payment.jsp");
			}
	        super.GotoPage(gotopage);
	    }

	    @Override
	    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        this.doProcess(request, response);
	    }

	    @Override
	    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        HttpSession session = request.getSession();
	        if(session.getAttribute("loginfo") == null){
	            new IndexController().doGet(request, response);
	        }
	        this.doProcess(request, response);
	    }
}
