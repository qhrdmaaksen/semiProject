package product;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ProductDAO;
import VO.ProductVO;
import common.SuperClass;
import utility.FlowParameters;
import utility.Paging;

public class PlistController extends SuperClass{
	String pageSize = "12";
	String mode = "productname";
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FlowParameters parameters 
			= new FlowParameters(
					request.getParameter("pageNumber"), 
					pageSize, 
					mode, 
					request.getParameter("keyword")) ;
		
		System.out.println(this.getClass() + " : " + parameters.toString());
		
		ProductDAO dao = new ProductDAO();
		
		int totalCount 
				= dao.SelectTotalCount(
						parameters.getMode(), 
						parameters.getKeyword() + "%");
		
		String contextPath = request.getContextPath() ;
		String myurl = contextPath + "/dodamdodam?command=plist" ;
		
		Paging pageInfo = new Paging(
				parameters.getPageNumber(), 
				parameters.getPageSize(), 
				totalCount, 
				myurl, 
				parameters.getMode(), 
				parameters.getKeyword()) ;
		
		List<ProductVO> lists = dao.SelectDataList(
				pageInfo.getBeginRow(), 
				pageInfo.getEndRow(),
				parameters.getMode(), 
				parameters.getKeyword() + "%");
		
		
		// 표에 들어갈 목록들
		request.setAttribute("lists", lists);
		
		// 페이징 관련 항목들
		request.setAttribute("pagingHtml", pageInfo.getPagingHtml());
		request.setAttribute("pagingStatus", pageInfo.getPagingStatus());
		
		// 필드 검색과 관련된 항목들
		request.setAttribute("mode", parameters.getMode());
		request.setAttribute("keyword", parameters.getKeyword());
		
		// 파라미터 리스트 문자열 : 상세보기, 수정, 삭제, 답글 등에 사용됨
		request.setAttribute("parameters", parameters.toString());		
		
		super.doGet(request, response);
		System.out.println("모드는? : " + request.getAttribute("mode"));
		System.out.println("키워드는? : " + request.getAttribute("keyword"));
		String gotopage = "product/plist.jsp" ;
		super.GotoPage(gotopage);
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
		
		String gotopage = "" ;
		if (this.validate(request) == true) {
			gotopage = "" ;
			super.GotoPage(gotopage);
			
		}else {
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