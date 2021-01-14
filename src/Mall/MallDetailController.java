package Mall;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MallDAO;
import VO.OrderVO;
import mypkg.bean.Order;
import mypkg.common.SuperClass;
import mypkg.dao.CompositeDao;
import mypkg.dao.MallDao;
import mypkg.shopping.ShoppingInfo;


public class MallDetailController extends common.SuperClass{
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int oid = Integer.parseInt( request.getParameter("oid") );
		
		super.doGet(request, response);
		String gotopage = "" ;		
		
		if (super.session.getAttribute("loginfo") == null) {		
			gotopage = "member/meLoginForm.jsp";
			super.GotoPage(gotopage);	
			
		} else {			
			MallDAO mdao = new MallDAO(); 
			//Order 주문 정보 가져 오기
			OrderVO order = mdao.SelectDataByPk(oid) ;
			
			DAO.CompositeDao cdao = new DAO.CompositeDao() ;
			// sql 문에 조인문을 쓰는 복합적인 메쏘드가 필요하기 떄문에 compositeDao 에 코딩했습니다. 
			//lists : 해당 송장 번호에 대한 주문 상세 내역을 보여 주세요
			List<shopping.ShoppingInfo> lists = cdao.ShowDetail( oid ) ;
			
			request.setAttribute( "order", order ); //주문 정보			
			request.setAttribute( "lists", lists ); //쇼핑 정보
			
			gotopage = "mall/ShopResult.jsp";
			super.GotoPage(gotopage);	
		}
	}
}