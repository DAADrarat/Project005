package lx.project.calander.dao;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lx.project.calander.controller.LoginoutController;
import lx.project.calander.to.UserTO;


@Component
public class LoginoutDAO {
	
	
	@Autowired
	SqlSession session;
	
	public List<AddrBookTO> getList() {
		return session.selectList("mapper-ab.getlist");
	}

	public int insert(AddrBookTO to) {
		return session.insert("insert", to);
	}
	
	public AddrBookTO getAddrById(int abId) {
		return session.selectOne("getById", abId);
	}
	
	
	public int update(AddrBookTO ab) {
		int result = session.update("update", ab); 
		return result;	
	}
	
	
	public int delete(AddrBookTO to) {
		int result = session.delete("delete", to); 
		return result;	
	}
	
	
	
	
	
}