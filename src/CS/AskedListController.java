package CS;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import DAO.AskedDAO;
import VO.AskedVO;
import common.SuperClass;
import utility.FlowParameters;
import utility.Paging;

public class AskedListController extends SuperClass{
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AskedDAO dao = new AskedDAO();
		FlowParameters parameters 
			= new FlowParameters(
					request.getParameter("pageNumber"),
					request.getParameter("pageSize"),
					request.getParameter("mode"),
					request.getParameter("keyword")
		);
		System.out.println(this.getClass() + " : " + parameters.toString());
		int totalCount
			=	dao.SelectTotalCount(parameters.getMode(), parameters.getKeyword());
		
		String contextPath = request.getContextPath();
		String myurl = contextPath + "/dodamdodam?command=cs_center_main_asked" ;
		
		Paging pageInfo = new Paging(
				parameters.getPageNumber(),
				parameters.getPageSize(),
				totalCount,
				myurl,
				parameters.getMode(),
				parameters.getKeyword());
		
		List<AskedVO> lists = dao.SelectDataList(
			pageInfo.getPageNumber(),
			pageInfo.getBeginRow(),
			pageInfo.getEndRow(),
			parameters.getMode(),
			parameters.getKeyword() + "%");
		
		for (AskedVO askedVO : lists) {
			System.out.println(askedVO.toString());
		}
		request.setAttribute("askedlists", lists);
		request.setAttribute("askedpagingHtml", pageInfo.getPagingHtml());
		request.setAttribute("askedpagingStatus", pageInfo.getPagingStatus());
		request.setAttribute("askedmode", parameters.getMode());
		request.setAttribute("askedkeyword", parameters.getKeyword());
		request.setAttribute("askedparameters", parameters.toString());
		
		String json = new Gson().toJson(lists);
		
		response.setContentType("application/json;");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(json);
		
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
		
		String gotopage = "" ;
		if (this.validate(request)==true) {
			gotopage = "";
			super.GotoPage(gotopage);
			
		} else {
			gotopage = "" ; 
			super.GotoPage(gotopage);
		}
	}
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true ; 
		return isCheck ; 
	}
}
