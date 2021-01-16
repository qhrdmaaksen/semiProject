package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import VO.ProductVO;

public class ProductDAO extends SuperDAO{
		public List<ProductVO> selectServeyList(String keyword){
			String sql = "select * from PRODUCTS where \"" + keyword + "\" > 0 order by \"stock\" desc";
			List<ProductVO> lists = new ArrayList<ProductVO>();
			System.out.println(sql);

			conn = null ;
			PreparedStatement pstmt = null ;
			ResultSet rs = null ;
			int num = 0;

			try {
				conn = super.getConnection() ;
				pstmt = conn.prepareStatement(sql) ;

				rs = pstmt.executeQuery() ;

				while(rs.next()) {
					ProductVO product = new ProductVO();
					product.setProductcode(rs.getInt("productcode"));
					product.setProductname(rs.getString("productname"));
					product.setProductprice(rs.getInt("productprice"));
					product.setStock(rs.getInt("stock"));
					product.setBloodCirculation(rs.getInt("bloodCirculation"));
					product.setDigestiveapparatus(rs.getInt("digestiveapparatus"));
					product.setSkin(rs.getInt("skin"));
					product.setEyes(rs.getInt("eyes"));
					product.setFatigue(rs.getInt("fatigue"));
					product.setJoint(rs.getInt("joint"));
					product.setHair(rs.getInt("hair"));
					product.setImmunity(rs.getInt("immunity"));
					product.setImages(rs.getString("images"));

					lists.add(product);
					num++;
					if(num==4)
						break;
				}
				System.out.println("ok");
			} catch (Exception e) {
				e.printStackTrace();
				try {
					conn.rollback();
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} finally {
				try {
					if(rs != null) {rs.close();}
					if(pstmt != null) {pstmt.close();}
					if(conn != null) {conn.close();}
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			return lists;
		}
								
		public int SelectTotalCount(String mode, String keyword) {
			// 해당 검색 모드(상품명, 제조 회사, 카테고리)에 충족하는 항목들의 갯수를 구해줍니다. 
			Connection conn = null ;
			PreparedStatement pstmt = null ;
			ResultSet rs = null ;		
			
			String sql = " select count(*) as cnt from products " ;
				
			if (keyword == null) {
				sql += " where \""+ mode +"\" is not null"; 
			}else {
				sql += " where \""+ mode +"\" like '" + keyword + "'" ;
			}
			
			
			int cnt = -999999 ;

			try {
				conn = super.getConnection() ;
				pstmt = conn.prepareStatement(sql) ;
				
				// placeholder 

				rs = pstmt.executeQuery() ; 
				
				if ( rs.next() ) { 
					cnt = rs.getInt("cnt");
				}
				
			} catch (SQLException e) {			
				SQLException err = (SQLException)e ;			
				cnt = - err.getErrorCode() ;			
				e.printStackTrace();
				try {
					conn.rollback(); 
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} finally{
				try {
					if( rs != null){ rs.close(); } 
					if( pstmt != null){ pstmt.close(); } 
					if(conn != null){conn.close();}
				} catch (Exception e2) {
					e2.printStackTrace(); 
				}
			} 		
			return cnt  ; 
		}

		
		public List<ProductVO> SelectDataList(int beginRow, int endRow, String mode, String keyword) {
			// 페이징 처리와 필드 검색을 통한 상품 목록을 구해줍니다.
			Connection conn = null ;
			PreparedStatement pstmt = null ;
			ResultSet rs = null ;

			String sql = " select \"productcode\", \"productname\" , \"productprice\", \"stock\" , \"eyes\" , \"bloodcirculation\"	, \"digestiveapparatus\", \"skin\", \"fatigue\" , \"joint\" , \"hair\" , \"immunity\" , \"images\" " ;
			sql += " from  " ;
			sql += " ( " ;
			sql += " select \"productcode\", \"productname\" , \"productprice\", \"stock\" , \"eyes\" , \"bloodcirculation\" , \"digestiveapparatus\", \"skin\", \"fatigue\" , \"joint\" , \"hair\" , \"immunity\" , \"images\", " ;
			sql += " rank() over(order by \"productcode\" desc) as ranking " ;
			sql += " from products " ;
			
			 if(mode.equalsIgnoreCase("all") == false) { 
				 sql += " where \"" + mode + "\" like '" + keyword + "'" ;
				 }
			 
			sql += " )  " ;
			sql += " where ranking between ? and ? " ;
			
			System.out.println(sql);
			List<ProductVO> lists = new ArrayList<ProductVO>();

			try {
				conn = super.getConnection() ;
				pstmt = conn.prepareStatement(sql) ;

				// placeholder
				pstmt.setInt(1, beginRow) ;
				pstmt.setInt(2, endRow) ; 
				
				rs = pstmt.executeQuery() ;			
				while( rs.next() ){
					ProductVO bean = new ProductVO();
					
					bean.setBloodCirculation(rs.getInt("bloodCirculation"));
					bean.setDigestiveapparatus(rs.getInt("digestiveapparatus"));
					bean.setEyes(rs.getInt("eyes"));
					bean.setFatigue(rs.getInt("fatigue"));
					bean.setHair(rs.getInt("hair"));
					bean.setImages(rs.getString("images"));
					bean.setImmunity(rs.getInt("immunity"));
					bean.setJoint(rs.getInt("joint"));
					bean.setProductcode(rs.getInt("productcode"));
					bean.setProductname(rs.getString("productname"));
					bean.setProductprice(rs.getInt("productprice"));
					bean.setSkin(rs.getInt("skin"));
					bean.setStock(rs.getInt("stock"));
					
					lists.add( bean ) ;
					
					System.out.println("상품목록을 잘 가져옵니다.");
				}
			} catch (Exception e) {
				SQLException err = (SQLException)e ;			
				int cnt = - err.getErrorCode() ;			
				e.printStackTrace();
				try {
					conn.rollback(); 
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} finally{
				try {
					if(rs != null){ rs.close(); }
					if(pstmt != null){ pstmt.close(); }
					if(conn != null){conn.close();}
				} catch (Exception e2) {
					e2.printStackTrace(); 
				}
			}
			
			return lists ;
		}


		public ProductVO SelectDataByPk(int productcode) {
			ProductVO bean = null ;
			
			String sql = "select * " ;
			sql += " from products " ; 
			sql += " where \"productcode\" = ? " ;
			
			Connection conn = null ;
			PreparedStatement pstmt = null ;
			ResultSet rs = null ;
			
			try {
				conn = super.getConnection() ;
				pstmt = conn.prepareStatement(sql) ;

				pstmt.setInt( 1, productcode   ); 
							
				rs = pstmt.executeQuery() ;
				
				while(rs.next()) {
					bean = new ProductVO() ;
					
					bean.setBloodCirculation(rs.getInt("bloodCirculation"));
					bean.setDigestiveapparatus(rs.getInt("digestiveapparatus"));
					bean.setEyes(rs.getInt("eyes"));
					bean.setFatigue(rs.getInt("fatigue"));
					bean.setHair(rs.getInt("hair"));
					bean.setImages(rs.getString("images"));
					bean.setImmunity(rs.getInt("immunity"));
					bean.setJoint(rs.getInt("joint"));
					bean.setProductcode(rs.getInt("productcode"));
					bean.setProductname(rs.getString("productname"));
					bean.setProductprice(rs.getInt("productprice"));
					bean.setSkin(rs.getInt("skin"));
					bean.setStock(rs.getInt("stock"));
					
				}
				
				System.out.println("ok");
			} catch (Exception e) {
				SQLException err = (SQLException)e ;			
				e.printStackTrace();
				try {
					conn.rollback(); 
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} finally {
				try {
					if(rs != null) {rs.close();}
					if(pstmt != null) {pstmt.close();}
					if(conn != null) {conn.close();}
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			
			return bean  ;
		}
		
		public int DeleteItem(int productcode) {
			Connection conn = null ;
			PreparedStatement pstmt = null ;
			int cnt = -999999 ;

			try {
				conn = super.getConnection() ;
								
				
				// 해당 상품을 삭제합니다.
				String sql = " delete from products  " ;
				sql += " where \"num\" = ?" ;
				
				pstmt = conn.prepareStatement(sql) ;
				
				pstmt.setInt(1, productcode); // 상품 번호
				cnt = pstmt.executeUpdate() ; 
				
				conn.commit(); 

			} catch (Exception e) {
				SQLException err = (SQLException)e ;			
				cnt = - err.getErrorCode() ;			
				e.printStackTrace();
				try {
					conn.rollback(); 
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} finally{
				try {
					if(pstmt != null){pstmt.close();}
					if(conn != null){conn.close();}
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			return cnt ;
		}


		public int SelectTotalCount2(String mode) {
			// 해당 검색 모드(상품명, 제조 회사, 카테고리)에 충족하는 항목들의 갯수를 구해줍니다. 
						Connection conn = null ;
						PreparedStatement pstmt = null ;
						ResultSet rs = null ;		
						
						String sql = " select count(*) as cnt from products " ;
							sql += " where \"" + mode + "\" > 0 ";
						
						int cnt = -999999 ;

						try {
							conn = super.getConnection() ;
							pstmt = conn.prepareStatement(sql) ;
							
							// placeholder 

							rs = pstmt.executeQuery() ; 
							
							if ( rs.next() ) { 
								cnt = rs.getInt("cnt");
							}
							
						} catch (SQLException e) {			
							SQLException err = (SQLException)e ;			
							cnt = - err.getErrorCode() ;			
							e.printStackTrace();
							try {
								conn.rollback(); 
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						} finally{
							try {
								if( rs != null){ rs.close(); } 
								if( pstmt != null){ pstmt.close(); } 
								if(conn != null){conn.close();}
							} catch (Exception e2) {
								e2.printStackTrace(); 
							}
						} 		
						return cnt  ; 
					}


		public List<ProductVO> SelectDataList2(int beginRow, int endRow, String mode) {
			// 페이징 처리와 필드 검색을 통한 상품 목록을 구해줍니다.
						Connection conn = null ;
						PreparedStatement pstmt = null ;
						ResultSet rs = null ;

						String sql = " select \"productcode\", \"productname\" , \"productprice\", \"stock\" , \"eyes\" , \"bloodcirculation\"	, \"digestiveapparatus\", \"skin\", \"fatigue\" , \"joint\" , \"hair\" , \"immunity\" , \"images\" " ;
						sql += " from  " ;
						sql += " ( " ;
						sql += " select \"productcode\", \"productname\" , \"productprice\", \"stock\" , \"eyes\" , \"bloodcirculation\" , \"digestiveapparatus\", \"skin\", \"fatigue\" , \"joint\" , \"hair\" , \"immunity\" , \"images\", " ;
						sql += " rank() over(order by \"productcode\" desc) as ranking " ;
						sql += " from products " ;
						sql += " where \"" + mode + "\" > 0 ";
						sql += " )  " ;
						sql += " where ranking between ? and ? " ;
						
						System.out.println(sql);
						List<ProductVO> lists = new ArrayList<ProductVO>();

						try {
							conn = super.getConnection() ;
							pstmt = conn.prepareStatement(sql) ;

							// placeholder
							pstmt.setInt(1, beginRow) ;
							pstmt.setInt(2, endRow) ; 
							
							rs = pstmt.executeQuery() ;			
							while( rs.next() ){
								ProductVO bean = new ProductVO();
								
								bean.setBloodCirculation(rs.getInt("bloodCirculation"));
								bean.setDigestiveapparatus(rs.getInt("digestiveapparatus"));
								bean.setEyes(rs.getInt("eyes"));
								bean.setFatigue(rs.getInt("fatigue"));
								bean.setHair(rs.getInt("hair"));
								bean.setImages(rs.getString("images"));
								bean.setImmunity(rs.getInt("immunity"));
								bean.setJoint(rs.getInt("joint"));
								bean.setProductcode(rs.getInt("productcode"));
								bean.setProductname(rs.getString("productname"));
								bean.setProductprice(rs.getInt("productprice"));
								bean.setSkin(rs.getInt("skin"));
								bean.setStock(rs.getInt("stock"));
								
								lists.add( bean ) ;
								
								System.out.println("상품목록을 잘 가져옵니다.");
							}
						} catch (Exception e) {
							SQLException err = (SQLException)e ;			
							int cnt = - err.getErrorCode() ;			
							e.printStackTrace();
							try {
								conn.rollback(); 
							} catch (Exception e2) {
								e2.printStackTrace();
							}
						} finally{
							try {
								if(rs != null){ rs.close(); }
								if(pstmt != null){ pstmt.close(); }
								if(conn != null){conn.close();}
							} catch (Exception e2) {
								e2.printStackTrace(); 
							}
						}
						
						return lists ;
					}


		public int DeleteData(int productcode) {
			Connection conn = null ;
			PreparedStatement pstmt = null ;
			int cnt = -999999 ;

			try {
				conn = super.getConnection() ;
				
				// 해당 상품을 삭제합니다.
				String sql = " delete from products  " ;
				sql += " where \"productcode\" = ? " ;
				
				pstmt = conn.prepareStatement(sql) ;
				
				pstmt.setInt(1, productcode); // 상품 번호
				cnt = pstmt.executeUpdate() ; 
				
				conn.commit(); 

			} catch (Exception e) {
				SQLException err = (SQLException)e ;			
				cnt = - err.getErrorCode() ;			
				e.printStackTrace();
				try {
					conn.rollback(); 
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} finally{
				try {
					if(pstmt != null){pstmt.close();}
					if(conn != null){conn.close();}
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			}
			return cnt ;
		}

		
		public List<ProductVO> SelectDataList(int productcode) {
			Connection conn = null ;
			PreparedStatement pstmt = null ;
			ResultSet rs = null ;

			String sql = "select * from products " ;
			sql += " where \"productcode\" = ? " ;
			
			 
			
			
			System.out.println(sql);
			List<ProductVO> lists = new ArrayList<ProductVO>();

			try {
				conn = super.getConnection() ;
				pstmt = conn.prepareStatement(sql) ;
				
				pstmt.setInt(1, productcode);
			
			
				
				rs = pstmt.executeQuery() ;			
				while( rs.next() ){
					ProductVO bean = new ProductVO();
					
					bean.setBloodCirculation(rs.getInt("bloodCirculation"));
					bean.setDigestiveapparatus(rs.getInt("digestiveapparatus"));
					bean.setEyes(rs.getInt("eyes"));
					bean.setFatigue(rs.getInt("fatigue"));
					bean.setHair(rs.getInt("hair"));
					bean.setImages(rs.getString("images"));
					bean.setImmunity(rs.getInt("immunity"));
					bean.setJoint(rs.getInt("joint"));
					bean.setProductcode(rs.getInt("productcode"));
					bean.setProductname(rs.getString("productname"));
					bean.setProductprice(rs.getInt("productprice"));
					bean.setSkin(rs.getInt("skin"));
					bean.setStock(rs.getInt("stock"));
					
					lists.add( bean ) ;
					
					System.out.println("상품목록을 잘 가져옵니다.");
				}
			} catch (Exception e) {
				SQLException err = (SQLException)e ;			
				int cnt = - err.getErrorCode() ;			
				e.printStackTrace();
				try {
					conn.rollback(); 
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} finally{
				try {
					if(rs != null){ rs.close(); }
					if(pstmt != null){ pstmt.close(); }
					if(conn != null){conn.close();}
				} catch (Exception e2) {
					e2.printStackTrace(); 
				}
			}
			
			return lists ;
		}
		
		
		


}
