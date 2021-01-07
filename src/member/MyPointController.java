package member;

import DAO.CouponDAO;
import DAO.MemberDAO;
import DAO.PointDAO;
import VO.MemberVO;
import VO.PointVO;
import common.IndexController;
import common.SuperClass;
import utility.FlowParameters;
import utility.Paging;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class MyPointController extends SuperClass {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("loginfo") == null){
            new IndexController().doGet(request, response);
        }
        MemberVO tem = (MemberVO)session.getAttribute("loginfo");

        try {
            MemberDAO dao = new MemberDAO();
            MemberVO mem = dao.selectMember(tem.getId(), tem.getPassword());
            session.setAttribute("loginfo", mem);
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
            new IndexController().doGet(request, response);
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        FlowParameters parameters = null;

        String mode = null;
        if(request.getParameter("mode")==null){
            mode="all";
        }else {
            mode=request.getParameter("mode");
        }
        if(request.getParameter("fromDate")==null||request.getParameter("toDate")==null){
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MONTH, -1);

            parameters = new FlowParameters(
                    request.getParameter("pageNumber"),
                    request.getParameter("pageSize"),
                    new Date(cal.getTimeInMillis()),
                    new Date(),
                    mode);
        }else {
            try {
                parameters = new FlowParameters(
                        request.getParameter("pageNumber"),
                        request.getParameter("pageSize"),
                        sdf.parse(request.getParameter("fromDate")),
                        sdf.parse(request.getParameter("toDate")),
                        mode);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }

        CouponDAO cu_dao = new CouponDAO();
        PointDAO po_dao = new PointDAO();

        String contextPath = request.getContextPath();
        String myurl = contextPath + "/dodamdodam?command=point";

        Paging pageInfo = new Paging(
                parameters.getPageNumber(),
                parameters.getPageSize(),
                po_dao.selectTotalCount(tem.getId()),
                myurl,
                parameters.getFromdate(),
                parameters.getTodate());

        List<PointVO> lists = po_dao.selectPoints(pageInfo.getBeginRow(), pageInfo.getEndRow(), tem.getId(), parameters.getFromdate(), parameters.getTodate());

        // 쿠폰 갯수
        session.setAttribute("cpnCount", cu_dao.CountCoupons(tem.getId()));

        // 페이징 관련 항목들
        request.setAttribute("fromdate", sdf.format(parameters.getFromdate()));
        System.out.println("fromdate : " + sdf.format(parameters.getFromdate()));
        request.setAttribute("todate", sdf.format(parameters.getTodate()));
        System.out.println("todate : " + sdf.format(parameters.getTodate()));
        request.setAttribute("pagingHtml", pageInfo.getPagingPointHtml());
        request.setAttribute("pagingStatus", pageInfo.getPagingStatus());

        // 소멸예정 포인트, 적립예정 포인트, 포인트 내역들
        request.setAttribute("exPoint", po_dao.selectExtinctionPoint(tem.getId()));
        request.setAttribute("scPoint", po_dao.selectSchedulePoint(tem.getId()));
        request.setAttribute("points", lists);

        request.setAttribute("parameters", parameters.toStringPoint());

        super.doProcess(request, response);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/member/point.jsp");
        dispatcher.forward(request, response);
    }
}
