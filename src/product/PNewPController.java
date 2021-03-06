package product;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import DAO.ProductDAO;
import VO.ProductVO;
import common.SuperClass;

public class PNewPController extends SuperClass{
	private ProductVO bean = null ;
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
		
		String gotopage = "/product/pnewproduct.jsp";
		super.GotoPage( gotopage ); 	
	}
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// request 영역에 있는 업로드을 위한 객체 multi 정보를 읽어 들입니다.
		MultipartRequest multi = (MultipartRequest)request.getAttribute("multi") ;
		
		System.out.println("멀티 : " + multi);
		bean = new ProductVO();
		
		//상품 번호는 시퀀스이므로 구할 수 없다.
		//int num = Integer.parseInt(multi.getParameter("num"));		
		if( multi.getParameter("stock") != null && multi.getParameter("stock").equals("") == false  ){
			bean.setStock( Integer.parseInt( multi.getParameter("stock") ));	
		}
		if( multi.getParameter("productprice") != null && multi.getParameter("productprice").equals("") == false ){
			bean.setProductprice( Integer.parseInt( multi.getParameter("productprice") ));	
		}
		bean.setBloodCirculation(Integer.parseInt(multi.getParameter("bloodcirculation")));
		bean.setDigestiveapparatus(Integer.parseInt(multi.getParameter("digestiveapparatus")));
		bean.setEyes(Integer.parseInt(multi.getParameter("eyes")));
		bean.setFatigue(Integer.parseInt(multi.getParameter("fatigue")));
		bean.setHair(Integer.parseInt(multi.getParameter("hair")));
		bean.setImmunity(Integer.parseInt(multi.getParameter("immunity")));
		bean.setJoint(Integer.parseInt(multi.getParameter("joint")));
		//bean.setProductcode(Integer.parseInt(multi.getParameter("productcode")));
		bean.setProductname(multi.getParameter("productname"));
		bean.setSkin(Integer.parseInt(multi.getParameter("skin")));
		bean.setImages( multi.getFilesystemName("images") );

		System.out.println("이미지 : " + bean.getImages());
		System.out.println("재고 : " + bean.getStock());
		// 상품 번호는 시퀀스로 처리합니다.
		// bean.setNum(num);		 
		
		String gotopage = "";
		if ( this.validate( request ) == true ) {
			//DAO 객체를 생성한다.
			ProductDAO pdao = new ProductDAO();
			
			int cnt = -99999 ; 
			
			// Bean 객체를 이용하여 해당 게시물을 추가합니다.
			cnt = pdao.InsertData(bean) ;
			//super.session.setAttribute( "message" , "상품 등록을 완료 하였습니다." );
			// 목록 보기로 리다이렉션시킵니다.
			new PlistController().doGet(request, response);			
		}else{
			request.setAttribute("bean", bean);
			System.out.println("여기까지는 온건가?");
			super.doPost(request, response);
			gotopage = "product/pnewproduct.jsp";
			super.GotoPage( gotopage ); 	
		}	
	}
	
	@Override
	public boolean validate(HttpServletRequest request) {
		boolean isCheck = true ; //기본 값으로 true이고, 유효성 검사에 문제가 생기면 false으로 변경
		System.out.println("isCheck : " + isCheck);
		if( bean.getProductname().length() < 3 || bean.getProductname().length() > 30 ){
			request.setAttribute( super.PREFIX + "productname", "상품 이름은 3자리 이상 30자리 이하이어야 합니다.");
			isCheck = false  ;
		}
		/*
		if( bean.getImages() == null || bean.getImages() == "" ){
			request.setAttribute( super.PREFIX + "images", "이미지는 필수 입력 사항입니다.");
			isCheck = false  ;
		}	*/	
		int stock = 10 ;
		if( bean.getStock() < stock ){
			request.setAttribute( super.PREFIX + "stock", "재고 수량은 최소 " + stock + "개 이상입니다.");
			isCheck = false  ;
		}		
		if( bean.getBloodCirculation() < 0 ){
			request.setAttribute( super.PREFIX + "bloodcirculation", "필수 입력사항 입니다. 해당하지 않을 시 0을 입력 해 주세요.");
			isCheck = false  ;
		}		
		if( bean.getDigestiveapparatus() < 0 ){
			request.setAttribute( super.PREFIX + "digestiveapparatus", "필수 입력사항 입니다. 해당하지 않을 시 0을 입력 해 주세요.");
			isCheck = false  ;
		}		
		if( bean.getEyes() < 0 ){
			request.setAttribute( super.PREFIX + "eyes", "필수 입력사항 입니다. 해당하지 않을 시 0을 입력 해 주세요.");
			isCheck = false  ;
		}		
		if( bean.getFatigue() < 0 ){
			request.setAttribute( super.PREFIX + "fatigue", "필수 입력사항 입니다. 해당하지 않을 시 0을 입력 해 주세요.");
			isCheck = false  ;
		}		
		if( bean.getHair() < 0  ){
			request.setAttribute( super.PREFIX + "hair", "필수 입력사항 입니다. 해당하지 않을 시 0을 입력 해 주세요.");
			isCheck = false  ;
		}		
		if( bean.getImmunity() < 0 ){
			request.setAttribute( super.PREFIX + "immunity", "필수 입력사항 입니다. 해당하지 않을 시 0을 입력 해 주세요.");
			isCheck = false  ;
		}		
		if( bean.getJoint() < 0){
			request.setAttribute( super.PREFIX + "joint", "필수 입력사항 입니다. 해당하지 않을 시 0을 입력 해 주세요.");
			isCheck = false  ;
		}		
		System.out.println("isCheck : " + isCheck);
		if( bean.getSkin() < 0){
			request.setAttribute( super.PREFIX + "skin", "필수 입력사항 입니다. 해당하지 않을 시 0을 입력 해 주세요.");
			isCheck = false  ;
		}		
		if( bean.getProductprice() < 0 ){
			request.setAttribute( super.PREFIX + "productprice", "상품 가격을 입력 해 주세요.");
			isCheck = false  ;
		}	
		System.out.println("isCheck : " + isCheck);
		return isCheck ;
	}
}