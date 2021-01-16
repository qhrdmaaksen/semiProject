package Mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MallDAO;
import VO.MemberVO;
import VO.OrderVO;
import common.SuperClass;
import member.MemberLoginController;

public class MallHistoryControllerDetail extends SuperClass{

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		MemberVO loginfo = (MemberVO)super.session.getAttribute("loginfo") ;
		
		if( loginfo == null ){  //미로그인 시
			//session.setAttribute("destination", "redirect:/Order.mall");
			new MemberLoginController().doGet(request, response);  
			return ;
		}else{ 
			//orderlists : 로그인 된 사람의 이전 쇼핑 내역을 저장하고 있는 컬렉션
			List<OrderVO> orderlists = new ArrayList<OrderVO>() ;
			
			MallDAO mdao = new MallDAO() ;
			
			// lists : 현재 로그인 한 사람의 쇼핑 주문 내역들을 담고 있는 컬렉션(최근 주문 내역이 먼저 나옴)
			List<OrderVO> lists = mdao.OrderMalldetail(loginfo.getId()) ;
				
			request.setAttribute("lists", lists);
			
			if(lists.size() == 0) {
				super.session.setAttribute("message", "이전 쇼핑 내역이 존재하지 않습니다.");	
			}
			
			String gotopage = "member/order.jsp";  
			super.GotoPage(gotopage);	
		}			
	}
}