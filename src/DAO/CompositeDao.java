package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import VO.PostVo;
import VO.ProductVO;
import shopping.ShoppingInfo;

public class CompositeDao extends SuperDAO{
	public List<PostVo> SelectDataZipcode(String dong) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;

		/* emd_nm : 동면읍, rd_nm : 도로 이름, / search_word : 검색할 단어 */ 
		String sql = " select * from  \"POSTCODES\" " ;
		sql += " where \"EMD_NM\" like '%" + dong + "%' or "  ;
		sql += " \"RD_NM\" like '%" + dong + "%' or "  ;
		sql += " \"SEARCH_WORD\" like '%" + dong + "%' "  ;
		sql += " order by \"SI_NM\", \"SGG_NM\", \"RD_NM\" " ;
		
		System.out.println("동네 이름 : " + dong);
		
		List<PostVo> lists = new ArrayList<PostVo>();
		try {
			conn = getConnection() ;
			pstmt = conn.prepareStatement(sql) ;			
			 
			rs = pstmt.executeQuery() ;			
			while( rs.next() ){
				PostVo bean = new PostVo();
				
				bean.setArea_cd( rs.getString( "area_cd" )) ; 
				bean.setBd_ma_sn( rs.getString( "bd_ma_sn" ));
				bean.setBd_sb_sn( rs.getString( "bd_sb_sn" ));
				bean.setDisplay_word( rs.getString( "display_word" ));
				bean.setDisplay_word_dtail( rs.getString( "display_word_dtail" ));
				bean.setEmd_nm( rs.getString( "emd_nm" ));
				bean.setLndn_ma_sn( rs.getString( "lndn_ma_sn" ));
				bean.setLndn_sb_sn( rs.getString( "lndn_sb_sn" ));
				bean.setMt_yn( rs.getString( "mt_yn" ));
				bean.setRd_nm( rs.getString( "rd_nm" ));
				bean.setRi_nm( rs.getString( "ri_nm" ));
				bean.setSearch_word( rs.getString( "search_word" ));
				bean.setSgg_nm( rs.getString( "sgg_nm" ));
				bean.setSi_nm( rs.getString( "si_nm" ));
				bean.setUdrgrnd_yn( rs.getString( "udrgrnd_yn" ));

				//System.out.println( bean.toString() );
				lists.add( bean ) ;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {
				if( rs != null ){ rs.close(); }
				if( pstmt != null ){ pstmt.close(); }
				if( conn != null){ conn.close(); } 
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		}
		
		return lists ;
	}

	
}