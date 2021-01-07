package member;

import DAO.CouponDAO;
import DAO.MemberDAO;
import DAO.PointDAO;
import VO.MemberVO;
import common.IndexController;
import common.SuperClass;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class MyPointController extends SuperClass {
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


        CouponDAO cu_dao = new CouponDAO();
        session.setAttribute("cpnCount", cu_dao.CountCoupons(tem.getId()));

        PointDAO po_dao = new PointDAO();
        session.setAttribute("exPoint", po_dao.selectExtinctionPoint(tem.getId()));

        super.doProcess(request, response);
        super.GotoPage("/member/point.jsp");
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
