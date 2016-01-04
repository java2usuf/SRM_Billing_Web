package com.mkyong.web.model;

public class LineItem {
	private int transactionNumber;
	private String itemNumber;
	private String itemDesc;
	private String price;
	private String quantity;
	private String lineTotal;
	
	
	public String replace(String str){
		if(str != null){
			str = str.replace(",", "");
		}
		return str;
	}
	
	
	
	public String getLineTotal() {
		return lineTotal;
	}
	public void setLineTotal(String lineTotal) {
		
		this.lineTotal = replace(lineTotal);;
	}
	public int getTransactionNumber() {
		return transactionNumber;
	}
	public void setTransactionNumber(int transactionNumber) {
		this.transactionNumber = transactionNumber;
	}
	public String getItemNumber() {
		
		return itemNumber;
	}
	public void setItemNumber(String itemNumber) {
		
		this.itemNumber = replace(itemNumber);
	}
	public String getItemDesc() {
		return itemDesc;
	}
	public void setItemDesc(String itemDesc) {
		
		this.itemDesc = replace(itemDesc);
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		
		this.price = replace(price);
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		
		this.quantity = replace(quantity);
	}
	
	
}
