package DAO;

import javax.servlet.http.HttpServletRequest;

public class PdetailDao extends SuperDAO{
	
	public PdetailDao() {
		// TODO Auto-generated constructor stub
	}
	HttpServletRequest request ; 
	
	public PdetailDao(HttpServletRequest request) {
		this.request = request ; 
	}
}
