package DAO;

import javax.servlet.http.HttpServletRequest;

public class PdetailDAO extends SuperDAO{
	
	public PdetailDAO() {
	}
	HttpServletRequest request ; 
	
	public PdetailDAO(HttpServletRequest request) {
		this.request = request ; 
	}
}
