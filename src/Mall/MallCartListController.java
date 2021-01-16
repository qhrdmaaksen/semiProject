package Mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ProductDAO;
import VO.ProductVO;
import common.SuperClass;
import member.MemberLoginController;
import product.PlistController;
import shopping.MyCartList;
import shopping.RegulerShoppingInfo;
import shopping.ShoppingInfo;

public class MallCartListController extends SuperClass{
	
	//MallListController와 같다.
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		String message = "" ;
		
		if (super.session.getAttribute("loginfo") == null) {
			message = "로그인이 필요합니다." ;
			super.setErrorMessage(message);
			new MemberLoginController().doGet(request, response);			
		} else {
			
			MyCartList mycart = (MyCartList)super.session.getAttribute("mycart") ;
			MyCartList Rmycart = (MyCartList)super.session.getAttribute("Rmycart") ;
			
			if (mycart == null) {
				
				Map<Integer, Integer> Rmaplists = Rmycart.GetAllROrderLists() ;
				Set<Integer> Rkeylist = Rmaplists.keySet() ;
				List<RegulerShoppingInfo> Rshoplists = new ArrayList<RegulerShoppingInfo>();
				
				int RtotalAmount = 0 ; // 총 정기 상품 판매 금액
				
				for(Integer productcode : Rkeylist){ // productcode : 상품 번호
					Integer months = Rmaplists.get(productcode) ; // 구매 개월 수 
					
					ProductDAO pdao = new ProductDAO();
					
					// 상품 번호 productcode에 대한 Bean 정보
					ProductVO bean = pdao.SelectDataByPk(productcode) ;
					
					int productprice = bean.getProductprice() ;
					
					RtotalAmount += months * productprice ;
													
					RegulerShoppingInfo Rshopinfo = new RegulerShoppingInfo() ;
					
					Rshopinfo.setImages(bean.getImages());
					Rshopinfo.setProductname(bean.getProductname()); 
					Rshopinfo.setProductcode(productcode);
					//shopinfo.setPoint(point);
					Rshopinfo.setProductprice(productprice); 
					Rshopinfo.setMonths(months);  
					
					Rshoplists.add(Rshopinfo) ;
					System.out.println("R이거 실행 되나?");
				}
				super.session.setAttribute("Rshoplists", Rshoplists);
				super.session.setAttribute("RtotalAmount", RtotalAmount);
				
				
			} else if (Rmycart == null){
				Map<Integer, Integer> maplists = mycart.GetAllOrderLists() ;
				Set<Integer> keylist = maplists.keySet() ;
				List<ShoppingInfo> shoplists = new ArrayList<ShoppingInfo>();
				
				int totalAmount = 0 ; // 총 판매 금액
				
				for(Integer productcode : keylist){ // productcode : 상품 번호
					Integer qty = maplists.get(productcode) ; // 구매 수량
					
					ProductDAO pdao = new ProductDAO();
					
					// 상품 번호 productcode에 대한 Bean 정보
					ProductVO bean = pdao.SelectDataByPk(productcode) ;
					
					int productprice = bean.getProductprice() ;
					int point = bean.getProductprice();
					
					totalAmount += qty * productprice ;
													
					ShoppingInfo shopinfo = new ShoppingInfo() ;
					
					shopinfo.setImages(bean.getImages());
					shopinfo.setProductname(bean.getProductname()); 
					shopinfo.setProductcode(productcode);
					shopinfo.setPoint(point);
					shopinfo.setProductprice(productprice); 
					shopinfo.setQty(qty);  
					
					shoplists.add(shopinfo) ;
					System.out.println("이거 실행 되나?");
				}
				super.session.setAttribute("shoplists", shoplists);
				super.session.setAttribute("totalAmount", totalAmount);
				
			}else if (mycart != null && Rmycart != null) {
				Map<Integer, Integer> maplists = mycart.GetAllOrderLists() ;
				Map<Integer, Integer> Rmaplists = Rmycart.GetAllROrderLists() ;
				
				// keylist : 구매하고자 하는 상품 번호를 저장하고 있는 Set 자료 구조
				Set<Integer> keylist = maplists.keySet() ;
				Set<Integer> Rkeylist = Rmaplists.keySet() ;
				
				// ShoppingInfo : 상품 1건에 대한 정보를 저장하고 있는 Bean 객체
				// shoplists : ShoppingInfo 객체들을 저장하고 있는 컬렉션 객체
				List<ShoppingInfo> shoplists = new ArrayList<ShoppingInfo>();
				List<RegulerShoppingInfo> Rshoplists = new ArrayList<RegulerShoppingInfo>();
				
				int totalAmount = 0 ; // 총 판매 금액
				int RtotalAmount = 0 ; // 총 정기 상품 판매 금액
				
				for(Integer productcode : keylist){ // productcode : 상품 번호
					Integer qty = maplists.get(productcode) ; // 구매 수량
					
					ProductDAO pdao = new ProductDAO();
					
					// 상품 번호 productcode에 대한 Bean 정보
					ProductVO bean = pdao.SelectDataByPk(productcode) ;
					
					int productprice = bean.getProductprice() ;
					int point = bean.getProductprice();
					
					totalAmount += qty * productprice ;
													
					ShoppingInfo shopinfo = new ShoppingInfo() ;
					
					shopinfo.setImages(bean.getImages());
					shopinfo.setProductname(bean.getProductname()); 
					shopinfo.setProductcode(productcode);
					shopinfo.setPoint(point);
					shopinfo.setProductprice(productprice); 
					shopinfo.setQty(qty);  
					
					shoplists.add(shopinfo) ;
					System.out.println("이거 실행 되나?");
				}
				
				for(Integer productcode : Rkeylist){ // productcode : 상품 번호
					Integer months = Rmaplists.get(productcode) ; // 구매 개월 수 
					
					ProductDAO pdao = new ProductDAO();
					
					// 상품 번호 productcode에 대한 Bean 정보
					ProductVO bean = pdao.SelectDataByPk(productcode) ;
					
					int productprice = bean.getProductprice() ;
					
					RtotalAmount += months * productprice ;
													
					RegulerShoppingInfo Rshopinfo = new RegulerShoppingInfo() ;
					
					Rshopinfo.setImages(bean.getImages());
					Rshopinfo.setProductname(bean.getProductname()); 
					Rshopinfo.setProductcode(productcode);
					//shopinfo.setPoint(point);
					Rshopinfo.setProductprice(productprice); 
					Rshopinfo.setMonths(months);  
					
					Rshoplists.add(Rshopinfo) ;
					System.out.println("R이거 실행 되나?");
				}
				
				// 이번에 구매할 총 목록
				super.session.setAttribute("shoplists", shoplists);
				super.session.setAttribute("Rshoplists", Rshoplists);
				super.session.setAttribute("totalAmount", totalAmount);
				super.session.setAttribute("RtotalAmount", RtotalAmount);
				
				
			}
		}
		
		String gotopage = "mall/cartlist.jsp" ;
		super.GotoPage(gotopage);
	}
}