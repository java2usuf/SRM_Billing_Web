package com.mkyong.web.dao;

import java.util.List;

import com.mkyong.web.model.Transaction;

public interface TransactionDao {
	
	public List<Transaction> summaryReport();
	public String totalTxn();
	public void insert(Transaction txn);
	public Transaction findByCustomerId(int txnId);
}
