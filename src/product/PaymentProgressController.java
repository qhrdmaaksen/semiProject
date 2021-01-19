package product;

import DAO.OrderDAO;
import DAO.OrderdetailDao;
import DAO.RegularDAO;
import DAO.RegularDetailDAO;
import VO.*;
import common.SuperClass;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.text.StringEscapeUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

public class PaymentProgressController extends SuperClass {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        MemberVO member = (MemberVO)session.getAttribute("loginfo");
        String jsonString = request.getParameter("productLists");
        JSONTokener tokener = new JSONTokener(jsonString);
        JSONArray productArray = new JSONArray(tokener);

        System.out.println(request.getParameter("regular"));

        if(request.getParameter("regular").equals("1")){
            System.out.println("처리 시작1");
            RegularOrderVO regularorder = new RegularOrderVO();
            regularorder.setOrdernumber(Integer.parseInt(request.getParameter("merchant_uid")));
            regularorder.setId(member.getId());
            regularorder.setSeq_add(Integer.parseInt(request.getParameter("buyer_addr")));
            regularorder.setPaykind(1);
            regularorder.setInvoice(Math.random()*1000000000+"");
            regularorder.setOrderdate(new Date());

            RegularDAO regulardao = new RegularDAO();
            regulardao.insertOrder(regularorder);
            for(int i=0 ; i<productArray.length() ; i++){
                JSONObject product = productArray.getJSONObject(i);
                RegularDetailVO detailregular = new RegularDetailVO();
                RegularDetailDAO detailregulardao = new RegularDetailDAO();

                detailregular.setOrdernumber(regularorder.getOrdernumber());
                detailregular.setProductcode(Integer.parseInt(product.getString("code")));
                detailregular.setAmount(Integer.parseInt(product.getString("price")));
                Calendar cal = Calendar.getInstance();
                cal.add(Calendar.MONTH, Integer.parseInt(product.getString("months")));
                detailregular.setOrderclosing(new Date(cal.getTimeInMillis()));

                detailregulardao.insertOrder(detailregular);
            }
        }else {
            System.out.println("처리 시작2");
            OrderVO order = new OrderVO();
            System.out.println("변수생성 : " + request.getParameter("merchant_uid"));
            order.setOrdernumber(Integer.parseInt(request.getParameter("merchant_uid")));
            System.out.println("주문번호삽입");
            order.setId(member.getId());
            System.out.println("아이디 삽입");
            order.setSeq_add(Integer.parseInt(request.getParameter("buyer_addr")));
            System.out.println("주소 삽입");
            order.setPaykind(1);
            System.out.println("1삽입");
            order.setInvoice(Math.random()*1000000000+"");
            System.out.println("랜덤인보");
            order.setOrderdate(new Date());
            System.out.println("날짜생성");

            System.out.println(order);

            OrderDAO orderdao = new OrderDAO();
            orderdao.insertOrder(order);
            for(int i=0 ; i<productArray.length() ; i++){
                JSONObject product = productArray.getJSONObject(i);
                OrderdetailVO detailorder = new OrderdetailVO();
                OrderdetailDao detaildao = new OrderdetailDao();

                detailorder.setOrdernumber(order.getOrdernumber());
                detailorder.setProductcode(Integer.parseInt(product.getString("code")));
                detailorder.setQty(Integer.parseInt(product.getString("qty")));
                detailorder.setAmount(Integer.parseInt(product.getString("price")));
                detaildao.insertOrder(detailorder);

                System.out.println(detailorder);
            }
        }
    }
}
