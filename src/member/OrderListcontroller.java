package member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MemberDAO;
import VO.MemberVO;
import common.IndexController;
import common.SuperClass;

public class OrderListcontroller extends SuperClass{
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		String message = " ";
		
		if (super.session.getAttribute("loginfo") == null) {// 로그인 안되있으면 로그인하세요 
			 message = "로그인이 필요합니다.";
			super.setErrorMessage(message);
			new MemberLoginController().doGet(request, response);
			
		} else {
			// mallinsertcontroller 에서 바인딩했습니다. 
			MyCartList mycart = (MyCartList)super.session.getAttribute("mycart");
			
		
			
			if(mycart == null) {
				
				message = "쇼핑 내역이 없어서 상품 목록으로 이동했습니다.";
				
				super.setErrorMessage(message);
				
				new MallListController().doGet(request, response);
				
			}
			
			Map<Integer,Integer> maplists = mycart.GetAllOrderLists(); // maplists 에는 mycart 에 저장 했던 키,값을 저장합니다.  
			
			System.out.println(maplists + "개 있습니다.");
			
			// keylist : 구매하고자 하는 상품 번호를 저장하고 있는 set 자료 구조 
			Set<Integer> keylist = maplists.keySet(); // 키 값을 저장합니다. 
			
			System.out.println(keylist + "keylist 값입니다.");
			
			// ShoppingInfo : 상품 1건에 대한 정보를 저장하고 있는 Bean 객체 
			// shoplist : ShoppingInfo 객체들을 저장하고 있는 컬렉션 객체
			List<ShoppingInfo> shoplists = new ArrayList<ShoppingInfo>();
			
			int totalAmount = 0; // 총 판매 금액
			int totalPoint = 0; // 총 누적 포인트 
			
			for(Integer num : keylist) { //pnum : 상품번호
				Integer qty = maplists.get(num); // 구매수량  key 에해당하는 값을 가져옵니다 .
				
				
				System.out.println(num + "pnum 값이 널입니다. ");
				ProductDao pdao = new ProductDao();
				
				//상품 번호 pnum 에 대한 Bean 정보 
				Product bean = pdao.SelectDataByPk(num);
				
			
		
				int price = bean.getPrice();
				int point = bean.getPoint();
				
				totalAmount += qty * price;
				totalPoint += qty * point ;
				
				ShoppingInfo shopinfo = new ShoppingInfo();
				
				shopinfo.setImage(bean.getImage());
				shopinfo.setPname(bean.getName());
				shopinfo.setPnum(num);
				shopinfo.setPoint(point );
				shopinfo.setPrice(price);
				shopinfo.setQty(qty);
				
				shoplists.add(shopinfo);
			}
			
			// 이번에 구매할 총 목록 
			super.session.setAttribute("shoplists", shoplists);
			super.session.setAttribute("totalAmount", totalAmount);
			super.session.setAttribute("totalPoint", totalPoint);
		}
		
		String ogtopage = "mall/MallList.jsp";
		super.GotoPage(ogtopage);
		
	}
}