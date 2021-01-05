package Mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import VO.MemberVO;
import common.SuperClass;
import member.MemberLoginController;

public class MallHistoryController extends SuperClass{

@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	
	super.doGet(request, response);
	
	MemberVO loginfo = (MemberVO)super.session.getAttribute("loginfo") ;
	
	if( loginfo == null ){  
		new MemberLoginController().doGet(request, response);  
		return ;
	}
	else {
		
		//ordervo 완성 되면 코딩.
		
		
	}
	
		super.doGet(request, response);
	}	
	

	
}