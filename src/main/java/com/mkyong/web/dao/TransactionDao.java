package com.mkyong.web.dao;

import com.mkyong.web.model.Transaction;

public interface TransactionDao {
	public String totalTxn();
	public void insert(Transaction txn);
	public Transaction findByCustomerId(int txnId);
}
