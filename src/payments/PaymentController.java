package payments;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.AddressDAO;
import DAO.CouponDAO;
import DAO.ProductDAO;
import VO.AddressVO;
import VO.MemberVO;
import VO.ProductVO;
import common.SuperClass;
import shopping.MyCartList;
import shopping.RegulerShoppingInfo;
import shopping.ShoppingInfo;

public class PaymentController extends SuperClass{
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("loginfo");

		System.out.println("directbuy : " + request.getParameter("directbuy"));
		System.out.println("regular : " + request.getParameter("regular"));
		if(request.getParameter("directbuy").equals("1")){
			if(request.getParameter("regular").equals("1")){
				List<RegulerShoppingInfo> Rshoplists = new ArrayList<RegulerShoppingInfo>();
				RegulerShoppingInfo reguler = new RegulerShoppingInfo();
				ProductDAO pdao = new ProductDAO();
				ProductVO product = pdao.SelectDataByPk(Integer.parseInt(request.getParameter("productcode")));

				int productprice = 0;
				if(Integer.parseInt(request.getParameter("months"))>1) {
					productprice = (int)(product.getProductprice() * 0.7);
				}else {
					productprice = (int)(product.getProductprice() * 0.8);
				}

				reguler.setImages(product.getImages());
				reguler.setProductname(product.getProductname());
				reguler.setProductcode(product.getProductcode());
				reguler.setProductprice((int)(product.getProductprice() * 0.8));
				reguler.setMonths(Integer.parseInt(request.getParameter("months")));

				Rshoplists.add(reguler);

				request.setAttribute("productRLists", Rshoplists);
				request.setAttribute("totalcount", Rshoplists.size());
				request.setAttribute("totalprice", productprice);
				request.setAttribute("regular", "1");
			}else {
				List<ShoppingInfo> lists = new ArrayList<ShoppingInfo>();
				ShoppingInfo order = new ShoppingInfo();
				ProductDAO pdao = new ProductDAO();
				ProductVO product = pdao.SelectDataByPk(Integer.parseInt(request.getParameter("productcode")));

				int productprice = (int)(product.getProductprice() * 0.8);

				order.setImages(product.getImages());
				order.setProductname(product.getProductname());
				order.setProductcode(product.getProductcode());
				order.setProductprice(productprice);
				order.setQty(Integer.parseInt(request.getParameter("qty")));
				System.out.println("qty : " + Integer.parseInt(request.getParameter("qty")));
				lists.add(order);
				request.setAttribute("productLists", lists);
				request.setAttribute("totalcount", lists.size());
				request.setAttribute("totalprice", productprice * Integer.parseInt(request.getParameter("qty")));
				request.setAttribute("regular", "-1");
			}
		}else {
			if(request.getParameter("regular").equals("1")){
				MyCartList Rmycart = (MyCartList)session.getAttribute("Rmycart") ;

				Map<Integer, Integer> Rmaplists = Rmycart.GetAllROrderLists() ;
				Set<Integer> Rkeylist = Rmaplists.keySet() ;
				List<RegulerShoppingInfo> Rshoplists = new ArrayList<RegulerShoppingInfo>();

				int RtotalAmount = 0 ; // 총 정기 상품 판매 금액

				for(Integer productcode : Rkeylist){ // productcode : 상품 번호
					Integer months = Rmaplists.get(productcode) ; // 구매 개월 수

					ProductDAO pdao = new ProductDAO();

					// 상품 번호 productcode에 대한 Bean 정보
					ProductVO bean = pdao.SelectDataByPk(productcode) ;
					int productprice = 0;
					if(months>1) {
						productprice = (int)(bean.getProductprice() * 0.7);
					}else {
						productprice = (int)(bean.getProductprice() * 0.8);
					}

					RtotalAmount += months * productprice ;

					RegulerShoppingInfo Rshopinfo = new RegulerShoppingInfo() ;

					Rshopinfo.setImages(bean.getImages());
					Rshopinfo.setProductname(bean.getProductname());
					Rshopinfo.setProductcode(productcode);
					Rshopinfo.setProductprice(productprice);
					Rshopinfo.setMonths(months);

					Rshoplists.add(Rshopinfo) ;
				}
				request.setAttribute("productRLists", Rshoplists);
				request.setAttribute("totalcount", Rshoplists.size());
				request.setAttribute("totalprice", RtotalAmount);
				request.setAttribute("regular", "1");
			}else {
				MyCartList mycart = (MyCartList)session.getAttribute("mycart");

				Map<Integer, Integer> maplists = mycart.GetAllOrderLists();
				Set<Integer> keylist = maplists.keySet() ;
				List<ShoppingInfo> lists = new ArrayList<ShoppingInfo>();

				int totalAmount = 0 ; // 총 판매 금액

				for(Integer productcode : keylist){ // productcode : 상품 번호
					Integer qty = maplists.get(productcode) ; // 구매 수량

					ProductDAO pdao = new ProductDAO();

					// 상품 번호 productcode에 대한 Bean 정보
					ProductVO bean = pdao.SelectDataByPk(productcode) ;

					int productprice = (int)(bean.getProductprice() * 0.8);
					int point = bean.getProductprice();

					totalAmount += qty * productprice ;

					ShoppingInfo shopinfo = new ShoppingInfo() ;

					shopinfo.setImages(bean.getImages());
					shopinfo.setProductname(bean.getProductname());
					shopinfo.setProductcode(productcode);
					shopinfo.setPoint(point);
					shopinfo.setProductprice(productprice);
					shopinfo.setQty(qty);

					lists.add(shopinfo) ;
				}
				request.setAttribute("productLists", lists);
				request.setAttribute("totalcount", lists.size());
				request.setAttribute("totalprice", totalAmount);
				request.setAttribute("regular", "-1");
			}
		}

		AddressDAO addrdao = new AddressDAO();
		AddressVO address = addrdao.SelectDateByPK(member.getId());
		request.setAttribute("address", address);
		request.setAttribute("addressList", addrdao.selectAllAddress(member.getId()));
		super.doPost(request, response);

		CouponDAO coudao = new CouponDAO();
		request.setAttribute("coupons", coudao.selectAllCoupons(member.getId()));

		request.setAttribute("directbuy", request.getParameter("directbuy"));
		super.GotoPage("./pay/payment.jsp");
	}
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true ;
		
		return isCheck ;
	}
}