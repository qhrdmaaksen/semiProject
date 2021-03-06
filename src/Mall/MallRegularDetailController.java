package Mall;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MallDAO;
import DAO.ProductDAO;
import VO.DetailRegularorderVO;
import VO.MemberVO;
import VO.OrderVO;
import VO.OrderdetailVO;
import VO.ProductVO;
import VO.RegularOrderVO;


public class MallRegularDetailController extends common.SuperClass{
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		String id = request.getParameter("id");
		//	int productcode = 
		
		System.out.println(id+"입니다");
		
		
		super.doGet(request, response);
		String gotopage = "" ;		
		
		if (super.session.getAttribute("loginfo") == null) {		
			gotopage = "member/login.jsp";
			super.GotoPage(gotopage);	
			
		} else {			
			MallDAO mdao = new MallDAO(); 
			ProductDAO pdao = new ProductDAO();
			
			//Order 주문 정보 가져 오기
			RegularOrderVO order = mdao.SelectregularDataByPk2(id) ;
			
			System.out.println(order);
			
			DetailRegularorderVO odetail = mdao.SelectRegularDataByPk(order.getOrdernumber());
			
			System.out.println(order.getOrdernumber()+"입니다.");
			System.out.println(odetail);
			
			List<ProductVO> lists = pdao.SelectDataList(odetail.getProductcode());
			// sql 문에 조인문을 쓰는 복합적인 메쏘드가 필요하기 떄문에 compositeDao 에 코딩했습니다. 
			//lists : 해당 송장 번호에 대한 주문 상세 내역을 보여 주세요
			
			request.setAttribute( "order", order ); //주문 정보			
			
			request.setAttribute( "odetail", odetail ); // 디테일 오더 
			
			System.out.println(odetail);
					
			request.setAttribute( "lists", lists ); //쇼핑 정보
			
			if(lists == null) {
				System.out.println("리스트값이 비어있습니다.");
				
				
			}else {
				System.out.println("list 값이 잘 들어 있습니다. ");
				
				
			}
			
			
		
			
			
			gotopage = "member/legularorderdetail.jsp";
			super.GotoPage(gotopage);	
		}
	}
}