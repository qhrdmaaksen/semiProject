package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import VO.DetailRegularorderVO;
import VO.MemberVO;
import VO.OrderVO;
import VO.OrderdetailVO;
import VO.ProductVO;
import VO.RegularOrderVO;

public class MallDAO extends SuperDAO{

	public void Calculate(MemberVO mem, Map<Integer, Integer> maplists, int totalPoint) {
		// mem 객체는 고객 정보이고, maplists 객체느 구매한 상품 리스트 입니다.
		// totalPoint 는 회원 에게 적립할 마일리지 포인트 금액입니다. 
		
		// 고객의 장바구니에 대한 결제를 진행합니다.
		
		
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null;
		
		String sql = " ";
		int cnt = -9999;
		int maxnum = -99999; // 방금 추가된 송장 번호
		
		try {
			conn = super.getConnection();
			conn.setAutoCommit(false);
			
			//1. 주문(orders) 테이블에 추가합니다. 
			sql = "insert into orders(oid, mid, orderdate, remark) ";
			sql += " values (seqodid.nextval, ?, sysdate, ? )";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, mem.getId()); // 구매자
			pstmt.setString(2, " "); //코멘트 
			// ? 처리
			cnt = pstmt.executeUpdate();
			if(pstmt != null) {pstmt.close();}
			
			
			
			//2.방금 추가된 송장 번호를 읽어 옵니다.
			sql = " select max(oid) as maxnum from orders ";
			pstmt = conn.prepareStatement(sql);
			// ? 처리
			rs = pstmt.executeQuery();
			if(rs.next() ) {
				maxnum = rs.getInt("maxnum");
				
			}
			
			if(pstmt != null ) {pstmt.close();}
			System.out.println("신규 송장 번호 : " + maxnum);
			
			Set<Integer> keylist = maplists.keySet();
			System.out.println("상품 개수 :" + keylist.size()) ;
			
			for(Integer pnum : keylist) {
				// 3. 주문 상세 (orderdetails) 테이블에 추가합니다. 
				// orders.oid 와 orderdetails의 oid 는 동일한 값입니다. 
				// 송장 번호가 참조 무결성 제약 조건에 의하여 연결이 되어 있습니다.
				
				sql = " insert into orderdetails(odid, oid, pnum, qty, remark) ";
				sql += " values(seqodid.nextval, ?, ?, ?, ? )";
						
				pstmt = conn.prepareStatement(sql);
				
				int qty = maplists.get(pnum);
				
				pstmt.setInt(1, maxnum); // 신규로 생성된 송장 번호
				pstmt.setInt(2, pnum); // 해당 상품 번호
				pstmt.setInt(3, qty); // 구매한 수량 
				pstmt.setString(4, " "); // 비고 
				
				
				
				cnt = pstmt.executeUpdate();
				if(pstmt != null) {pstmt.close();}
				
				
				// 4. 해당 상품 번호(pnum) 을 이용하여 재고 수량(stock)을 감소시킵니다. 
				sql = " update Products set stock = stock - ?";
				sql += " where num = ?"	;
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, qty);
				
				pstmt.setInt(2, pnum);
				
				cnt = pstmt.executeUpdate();
				if(pstmt != null) {pstmt.close();}
				
			}
			
			
			//5. 구매자에 대한 마일리지 적립 포인트를 누적시켜 줍니다.    
			sql = " update members set mpoint = mpoint + ? ";
			sql += " where id = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, totalPoint);
			
			pstmt.setString(2, mem.getId());
			
			// ? 처리
			cnt = pstmt.executeUpdate();
			if(pstmt != null) {pstmt.close();}
			
			
			conn.commit();
			System.out.println("계산 완료");
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally {
			try {
				if(rs != null ) {rs.close();}
				if(pstmt != null ) {pstmt.close();}
				if(conn != null ) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}

	public List<OrderVO> OrderMall(String id) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;	
		
		String sql = "select * from orders " ;
		sql += " where \"id\" = ? order by \"orderdate\" desc  " ;
		
		List<OrderVO> lists = new ArrayList<OrderVO>() ;
		
		try {
			conn = super.getConnection() ;	
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setString( 1, id ); 
			rs = pstmt.executeQuery() ; 
			while ( rs.next()) {
				OrderVO bean = new OrderVO() ; 
				bean.setId(rs.getString("id"));
				bean.setInvoice(rs.getString("invoice"));
				bean.setOrderdate(rs.getDate("orderdate"));
				bean.setSeq_add(rs.getInt("seq_add"));
				bean.setPaykind(rs.getInt("paykind"));
				bean.setOrdernumber(rs.getInt("ordernumber"));
				bean.setShippingstatus(rs.getInt("shippingstatus"));
				
				
				lists.add( bean ) ; 
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if( rs != null){ rs.close(); } 
				if( pstmt != null){ pstmt.close(); } 
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		} 		
		return lists  ;
	}

	public OrderVO SelectDataByPk(String id) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;	
		
		String sql = "select * from orders " ;  
		sql += " where \"id\" = ? " ; 

		OrderVO bean = null ;
		try {
			conn = super.getConnection() ;		
			pstmt = this.conn.prepareStatement(sql) ;			
			pstmt.setString( 1 , id  ); 
			
			rs = pstmt.executeQuery() ;			
			if ( rs.next() ) {
				bean = new OrderVO();								
				bean.setId(rs.getString("id"));
				bean.setInvoice(rs.getString("invoice"));
				bean.setOrderdate(rs.getDate("orderdate"));
				bean.setSeq_add(rs.getInt("seq_add"));
				bean.setPaykind(rs.getInt("paykind"));
				bean.setOrdernumber(rs.getInt("ordernumber"));
				bean.setShippingstatus(rs.getInt("shippingstatus"));
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if( rs != null){ rs.close(); } 
				if( pstmt != null){ pstmt.close(); } 
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		} 		
		return bean  ;
	}

	public OrderdetailVO SelectDataByPk(int ordernumber) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;	
		
		String sql = "select * from detail_order " ;  
		sql += " where \"ordernumber\" = ? " ; 

		OrderdetailVO bean = null ;
		try {
			conn = super.getConnection() ;		
			pstmt = this.conn.prepareStatement(sql) ;			
			pstmt.setInt( 1 , ordernumber  ); 
			
			rs = pstmt.executeQuery() ;			
			if ( rs.next() ) {
				bean = new OrderdetailVO();								
				bean.setAmount(rs.getInt("amount"));
				bean.setOrdernumber(rs.getInt("ordernumber"));
				bean.setProductcode(rs.getInt("productcode"));
				bean.setQty(rs.getInt("qty"));
				
				
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if( rs != null){ rs.close(); } 
				if( pstmt != null){ pstmt.close(); } 
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		} 		
		return bean  ;
	}

	public List<RegularOrderVO> OrderMallRegular(String id) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;	
		
		String sql = "select * from regular_order " ;
		sql += " where \"id\" = ? order by \"orderdate\" desc  " ;
		
		List<RegularOrderVO> lists = new ArrayList<RegularOrderVO>() ;
		
		try {
			conn = super.getConnection() ;	
			pstmt = conn.prepareStatement(sql) ;
			pstmt.setString( 1, id ); 
			rs = pstmt.executeQuery() ; 
			while ( rs.next()) {
				RegularOrderVO bean = new RegularOrderVO() ; 
				bean.setId(rs.getString("id"));
				bean.setInvoice(rs.getString("invoice"));
				bean.setOrderdate(rs.getDate("orderdate"));
				bean.setSeq_add(rs.getInt("seq_add"));
				bean.setPaykind(rs.getInt("paykind"));
				bean.setOrdernumber(rs.getInt("ordernumber"));
				bean.setShippingstatus(rs.getInt("shippingstatus"));
				
				
				lists.add( bean ) ; 
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if( rs != null){ rs.close(); } 
				if( pstmt != null){ pstmt.close(); } 
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		} 		
		return lists  ;

	}

	public DetailRegularorderVO SelectDataByPk2(int no) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;	
		
		String sql = "select * from detail_regular_order " ;  
		sql += " where \"ordernumber\" = ? " ; 

		DetailRegularorderVO bean = null ;
		try {
			conn = super.getConnection() ;		
			pstmt = this.conn.prepareStatement(sql) ;			
			pstmt.setInt( 1 , no  ); 
			
			rs = pstmt.executeQuery() ;			
			if ( rs.next() ) {
				bean = new DetailRegularorderVO();								
				bean.setAmount(rs.getInt("amount"));
				bean.setOrdernumber(rs.getInt("ordernumber"));
				bean.setProductcode(rs.getInt("productcode"));
				bean.setQty(rs.getInt("qty"));
				bean.setOrderclosing(rs.getDate("orderclosing"));
				
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if( rs != null){ rs.close(); } 
				if( pstmt != null){ pstmt.close(); } 
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		} 		
		return bean  ;
	}

	public RegularOrderVO SelectregularDataByPk2(String id) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;	
		
		String sql = "select * from regular_order " ;  
		sql += " where \"id\" = ? " ; 

		RegularOrderVO bean = null ;
		try {
			conn = super.getConnection() ;		
			pstmt = this.conn.prepareStatement(sql) ;			
			pstmt.setString( 1 , id  ); 
			
			rs = pstmt.executeQuery() ;			
			if ( rs.next() ) {
				bean = new RegularOrderVO();								
				bean.setId(rs.getString("id"));
				bean.setInvoice(rs.getString("invoice"));
				bean.setOrderdate(rs.getDate("orderdate"));
				bean.setSeq_add(rs.getInt("seq_add"));
				bean.setPaykind(rs.getInt("paykind"));
				bean.setOrdernumber(rs.getInt("ordernumber"));
				bean.setShippingstatus(rs.getInt("shippingstatus"));
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if( rs != null){ rs.close(); } 
				if( pstmt != null){ pstmt.close(); } 
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		} 		
		return bean  ;
}

	public DetailRegularorderVO SelectRegularDataByPk(int ordernumber) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;	
		
		String sql = "select * from \"DETAIL_REGULAR_ORDER\" " ;  
		sql += " where \"ordernumber\" = ? " ; 

		DetailRegularorderVO bean = null ;
		try {
			conn = super.getConnection() ;		
			pstmt = this.conn.prepareStatement(sql) ;			
			pstmt.setInt( 1 , ordernumber  ); 
			
			rs = pstmt.executeQuery() ;			
			if ( rs.next() ) {
				bean= new DetailRegularorderVO();
				bean.setAmount(rs.getInt("amount"));
				bean.setOrderclosing(rs.getDate("orderclosing"));
				bean.setOrdernumber(rs.getInt("ordernumber"));
				bean.setProductcode(rs.getInt("productcode"));
				bean.setQty(rs.getInt("qty"));
				
				
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} finally{
			try {
				if( rs != null){ rs.close(); } 
				if( pstmt != null){ pstmt.close(); } 
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		} 		
		return bean  ;
	}
}

	
	/*
	 * public void InsertCartData(MemberVO mem, Map<Integer, Integer> maplist) { //
	 * mem 객체는 로그인한 고객의 정보입니다. // maplist 는 카트에 담겨 있는 나의 쇼핑 정보 입니다. Connection conn
	 * = null ; PreparedStatement pstmt = null ;
	 * 
	 * 
	 * String sql = "";
	 * 
	 * int cnt = -999;
	 * 
	 * try { conn = super.getConnection() ; conn.setAutoCommit(false);
	 * 
	 * // 1. 장바구니 테이블에 남아있는 회원의 행(row)을 모두 제거합니다. sql =
	 * " delete from shoppinginfos "; sql += " where mid = ? "; pstmt =
	 * conn.prepareStatement(sql);
	 * 
	 * pstmt.setString(1, mem.getId());
	 * 
	 * 
	 * cnt = pstmt.executeUpdate(); if(pstmt != null ) {pstmt.close(); }
	 * 
	 * //2. 반복문을 사용하여 테이블에 인서트 합니다. Set<Integer> keylist = maplist.keySet();
	 * System.out.println("상품 개수 : " + keylist.size());
	 * 
	 * System.out.println(keylist);
	 * 
	 * for (Integer pnum : keylist) {
	 * 
	 * sql =
	 * " insert into shoppinginfos(mid, pnum, pname, qty, price, image, point) " ;
	 * sql += " values(?, ?, ?, ?, ?, ?, ?)" ; pstmt = conn.prepareStatement(sql);
	 * 
	 * int qty = maplist.get(pnum); ProductDAO pdao = new ProductDAO(); ProductVO
	 * bean = pdao.SelectDataByPk(pnum);
	 * 
	 * pstmt.setString(1, mem.getId()); pstmt.setInt(2, pnum); pstmt.setString(3,
	 * bean.getName()); pstmt.setInt(4, qty); pstmt.setInt(5, bean.getPrice());
	 * pstmt.setString(6, bean.getImage()); pstmt.setInt(7, bean.getPoint());
	 * 
	 * cnt = pstmt.executeUpdate(); if(pstmt != null ) {pstmt.close(); }
	 * 
	 * 
	 * }
	 * 
	 * conn.commit(); System.out.println("장바구니 테이블에 저장 성공");
	 * 
	 * 
	 * } catch (Exception e) {
	 * 
	 * try { conn.rollback(); } catch (SQLException e2) { e2.printStackTrace(); }
	 * e.printStackTrace(); } finally{ try { if( pstmt != null){ pstmt.close(); }
	 * if(conn != null){conn.close();} } catch (Exception e2) {
	 * e2.printStackTrace(); } }
	 * 
	 * }
	 * 
	 * public List<ShoppingInfo> GetShoppingInfo(String id) { List<ShoppingInfo>
	 * lists = new ArrayList<ShoppingInfo>();
	 * 
	 * Connection conn = null ; PreparedStatement pstmt = null ; ResultSet rs =
	 * null;
	 * 
	 * String sql = " select * from shoppinginfos "; sql += " where mid = ? " ;
	 * 
	 * try { conn = super.getConnection(); pstmt = conn.prepareStatement(sql);
	 * pstmt.setString(1, id); rs = pstmt.executeQuery();
	 * 
	 * while(rs.next()) { ShoppingInfo shop = new ShoppingInfo();
	 * shop.setImage(rs.getString("image")); shop.setMid(rs.getString("mid"));
	 * shop.setPname(rs.getString("pname")); shop.setPoint(rs.getInt("point"));
	 * shop.setPrice(rs.getInt("price")); shop.setQty(rs.getInt("qty"));
	 * 
	 * lists.add(shop);
	 * 
	 * }
	 * 
	 * 
	 * 
	 * }catch (Exception e) { e.printStackTrace(); } finally { try { if(rs != null )
	 * {rs.close();} if(pstmt != null ) {pstmt.close();} if(conn != null )
	 * {conn.close();} } catch (Exception e2) { e2.printStackTrace(); } }
	 * 
	 * return lists; }
	 */
	
