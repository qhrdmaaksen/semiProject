package DAO;

import VO.ProductVO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends SuperDAO {
    // index에서 사용할 판매량 가장많은 4개 상품을 출력
    public List<ProductVO> SelectTop4Lists(){
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;

        String sql = "SELECT * FROM ";
        sql += "(SELECT \"productcode\", \"SUM\", DENSE_RANK() over (ORDER BY \"SUM\") AS \"RANK\" FROM ";
        sql += "(SELECT \"productcode\", SUM(\"SUM\") AS SUM FROM( ";
        sql += "SELECT \"productcode\",SUM(\"qty\") AS \"SUM\" FROM DETAIL_REGULAR_ORDER WHERE \"ordernumber\" IN ";
        sql += "(SELECT \"ordernumber\" FROM REGULAR_ORDER WHERE \"orderdate\" BETWEEN ";
        sql += "(SELECT TRUNC(TRUNC(SYSDATE, 'MM')-1, 'MM') FROM DUAL) AND (SELECT TRUNC(SYSDATE, 'MM')-1 FROM DUAL)) ";
        sql += "GROUP BY \"productcode\" UNION ";
        sql += "SELECT \"productcode\",SUM(\"qty\") AS \"SUM\" FROM DETAIL_ORDER WHERE \"ordernumber\" IN ";
        sql += "(SELECT \"ordernumber\" FROM ORDERS WHERE \"orderdate\" BETWEEN ";
        sql += "(SELECT TRUNC(TRUNC(SYSDATE, 'MM')-1, 'MM') FROM DUAL) AND (SELECT TRUNC(SYSDATE, 'MM')-1 FROM DUAL)) ";
        sql += "GROUP BY \"productcode\") GROUP BY \"productcode\")) ";
        sql += "WHERE RANK < 5";

        List<ProductVO> lists = new ArrayList<ProductVO>();

        try {
            super.conn = super.getConnection() ;
            pstmt = super.conn.prepareStatement(sql) ;

            rs = pstmt.executeQuery() ;
            while (lists.size()<4){
                rs.next();
                System.out.println("productcode : " + rs.getInt("productcode"));
                ProductVO product = SelectProduct(rs.getInt("productcode"));
                lists.add(product);
            }
        } catch (Exception e) {
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

    public ProductVO SelectProduct(int productcode){
        ProductVO product = new ProductVO();

        String sql = "SELECT * FROM products WHERE \"productcode\" in(?)";

        PreparedStatement pstmt = null ;
        ResultSet rs = null ;

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            pstmt.setInt(1, productcode);

            rs = pstmt.executeQuery() ;

            while(rs.next()) {
                product.setProductcode(rs.getInt("productcode"));
                product.setProductname(rs.getString("productname"));
                product.setProductprice(rs.getInt("productprice"));
                product.setStock(rs.getInt("stock"));
                product.setEyes(rs.getInt("eyes"));
                product.setBloodCirculation(rs.getInt("bloodcirculation"));
                product.setDigestiveapparatus(rs.getInt("digestiveapparatus"));
                product.setSkin(rs.getInt("skin"));
                product.setFatgue(rs.getInt("fatigue"));
                product.setJoint(rs.getInt("joint"));
                product.setHair(rs.getInt("hair"));
                product.setImmunity(rs.getInt("immunity"));
                product.setImages(rs.getString("images"));
            }
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

        return product  ;
    }
}
