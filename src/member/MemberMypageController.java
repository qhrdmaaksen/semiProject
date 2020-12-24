package member;

import common.SuperClass;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MemberMypageController extends SuperClass {
    @Override
    public void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        super.doProcess(request, response);
        super.GotoPage("/member/mypage.jsp");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doProcess(request, response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doProcess(request, response);
    }
}
