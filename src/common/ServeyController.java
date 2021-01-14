package common;

import DAO.ProductDAO;
import VO.MemberVO;
import VO.ProductVO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ServeyController extends SuperClass{
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        super.doGet(request, response);
        super.GotoPage("common/survey.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("loginfo")==null){
            request.setAttribute("name", request.getParameter("name"));
        }else {
            MemberVO tem = (MemberVO)session.getAttribute("loginfo");
            request.setAttribute("name", tem.getName());
        }

        String[] symptom = request.getParameterValues("answer3");
        List<List<ProductVO>> lists = new ArrayList();
        List<String> list_string = new ArrayList<>();
        ProductDAO p_dao = new ProductDAO();

        for(String tmp : symptom){
            list_string.add(tmp);
            lists.add(p_dao.selectServeyList(tmp));
        }

        request.setAttribute("gender", request.getParameter("gender"));
        request.setAttribute("height", request.getParameter("height"));
        request.setAttribute("weight", request.getParameter("weight"));
        request.setAttribute("momentum", request.getParameter("momentum"));
        request.setAttribute("symptoms", lists);
        request.setAttribute("symptom",list_string);
        System.out.println(lists);
        super.doPost(request, response);
        super.GotoPage("common/cmpSrv.jsp");
    }
}
