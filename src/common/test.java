package common;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class test extends SuperClass{
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String imp_uid = request.getParameter("imp_uid");
        String merchant_uid = request.getParameter("merchant_uid");
        String name = request.getParameter("name");
        String amount = request.getParameter("amount");
        String buyer_email = request.getParameter("buyer_email");
        String buyer_name = request.getParameter("buyer_name");
        String buyer_tel = request.getParameter("buyer_tel");
        String buyer_addr = request.getParameter("buyer_addr");


        System.out.println("imp_uid : " + imp_uid);
        System.out.println("merchant_uid : " + merchant_uid);
        System.out.println("name : " + name);
        System.out.println("amount : " + amount);
        System.out.println("buyer_email : " + buyer_email);
        System.out.println("buyer_name : " + buyer_name);
        System.out.println("buyer_tel : " + buyer_tel);
        System.out.println("buyer_addr : " + buyer_addr);
    }
}
