package com.mkyong.web.dao;

import com.mkyong.web.model.LineItem;
import com.mkyong.web.model.Transaction;

public interface LineItemDao {
	public void insert(LineItem txn);
	public Transaction findByCustomerId(int lineItemId);
}
