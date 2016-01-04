package com.mkyong.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mkyong.web.model.LineItem;
import com.mkyong.web.model.Transaction;
@Service
public class LineItemDaoImpl implements LineItemDao {
	
	@Autowired
	DataSource dataSource;
	@Override
	public void insert(LineItem lineItem) {
		String sql = "INSERT INTO LINEITEM " +
				"(TRANSACTIONNUMBER, ITEMNUMBER, ITEMDESC ,PRICE, QUANTITY, LINETOTAL) VALUES (?, ?, ?, ?, ?,?)";
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, lineItem.getTransactionNumber());
			ps.setString(2, lineItem.getItemNumber());
			ps.setString(3, lineItem.getItemDesc());
			ps.setString(4, lineItem.getPrice());
			ps.setString(5, lineItem.getQuantity());
			ps.setString(6, lineItem.getLineTotal());
			ps.executeUpdate();
			ps.close();
		} catch (SQLException e) {
			throw new RuntimeException(e);
			
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {}
			}
		}

	}

	@Override
	public Transaction findByCustomerId(int lineItemId) {
		// TODO Auto-generated method stub
		return null;
	}

}
