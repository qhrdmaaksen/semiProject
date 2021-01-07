package DAO;

import VO.PointVO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class PointDAO extends SuperDAO{
    public int selectExtinctionPoint(String id) {
        String sql = "SELECT SUM(\"po_bal\") AS sum FROM POINT_BALANCE WHERE \"seq_point\" IN(" +
                "SELECT \"seq_point\" FROM points WHERE \"plma\" = 0 AND \"po_date\">? AND \"po_date\"<? AND \"id\" in(?)) ORDER BY \"seq_point\"";

        conn = null ;
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;
        int result = -1;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar fromtime = Calendar.getInstance();
        Calendar totime = Calendar.getInstance();
        fromtime.add(Calendar.MONTH, -3);
        totime.add(Calendar.MONTH, -2);

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;
            pstmt.setDate(1, new java.sql.Date(fromtime.getTimeInMillis()));
            pstmt.setDate(2, new java.sql.Date(totime.getTimeInMillis()));
            pstmt.setString(3, id);

            rs = pstmt.executeQuery() ;

            while(rs.next()) {
                result = rs.getInt("sum");
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
        return result;
    }

    public int selectSchedulePoint(String id){
        String sql = "SELECT SUM(\"point\") AS sum FROM points WHERE \"plma\" = 0 AND \"po_date\" = TRUNC(SYSDATE) AND \"id\" IN(?)";

        conn = null ;
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;
        int result = -1;

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;
            pstmt.setString(1, id);

            rs = pstmt.executeQuery() ;

            while(rs.next()) {
                result = rs.getInt("sum");
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
        return result;
    }

    public List<PointVO> selectPoints(int beginrow, int endrow, String id, Date fromdate, Date todate){
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;

        String sql = "SELECT * FROM (SELECT \"seq_point\", \"id\", \"plma\", \"point\", \"po_date\", \"po_subject\", RANK() over (ORDER BY \"po_date\" DESC) AS ranking FROM points WHERE \"id\" IN(?) AND \"po_date\" BETWEEN ? AND ?) WHERE ranking BETWEEN ? AND ?";
        List<PointVO> lists = new ArrayList<PointVO>();

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            Calendar cal = Calendar.getInstance();
            pstmt.setString(1, id);

            cal.setTime(fromdate);
            pstmt.setDate(2, new java.sql.Date(cal.getTimeInMillis()));

            cal.setTime(todate);
            pstmt.setDate(3, new java.sql.Date(cal.getTimeInMillis()));
            pstmt.setInt(4, beginrow);
            pstmt.setInt(5, endrow);

            rs = pstmt.executeQuery() ;
            while( rs.next() ){
                PointVO point = new PointVO();
                point.setSeq_point(rs.getInt("seq_point"));
                point.setId(id);
                point.setPlma(rs.getBoolean("plma"));
                point.setPoint(rs.getInt("point"));
                point.setPo_subject(rs.getString("po_subject"));
                point.setPo_date(rs.getDate("po_date"));

                lists.add(point) ;
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
        return lists;
    }

    public int selectTotalCount(String id){
        String sql = "SELECT COUNT(*) AS count FROM POINTS WHERE \"id\" IN(?)";

        conn = null ;
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;
        int result = -1;

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;
            pstmt.setString(1, id);

            rs = pstmt.executeQuery() ;

            while(rs.next()) {
                result = rs.getInt("count");
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
        return result;
    }
}
