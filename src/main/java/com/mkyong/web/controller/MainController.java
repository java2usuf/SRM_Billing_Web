package com.mkyong.web.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mkyong.web.dao.LineItemDao;
import com.mkyong.web.dao.TransactionDao;
import com.mkyong.web.model.LineItem;
import com.mkyong.web.model.Transaction;

@Controller
public class MainController {
	
	@Autowired
	TransactionDao transactionDao;
	@Autowired
	LineItemDao lineItemDao;

	@RequestMapping(value = { "/", "/welcome**" }, method = RequestMethod.GET)
	public ModelAndView defaultPage() {
		
		ModelAndView model = new ModelAndView();
		model.addObject("title", "login Page");
		model.addObject("message", "This is default page!");
		
		
		
		model.setViewName("hello");
		return model;

	}

	@RequestMapping(value = "/admin**", method = RequestMethod.GET)
	public ModelAndView adminPage() {
		ModelAndView model = new ModelAndView();
		String totalTxn = transactionDao.totalTxn();
		List<Transaction> results = transactionDao.summaryReport();
		model.addObject("title", "Spring Security Login Form - Database Authentication");
		model.addObject("message", totalTxn);
		model.addObject("results",results);
		model.setViewName("admin");

		return model;
	}

	@RequestMapping(value = {"/save/", "/save"}, method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView save(
			@RequestParam(value = "itemNo", required = false) String itemNo,
			@RequestParam(value = "itemName", required = false) String itemName,
			@RequestParam(value = "price", required = false) String price,
			@RequestParam(value = "quantity", required = false) String quantity,
			@RequestParam(value = "total", required = false) String total,
			@RequestParam(value = "subTotal", required = false) String subTotal,
			@RequestParam(value = "disacountAmount", required = false) String disacountAmount,
			@RequestParam(value = "discountPercent", required = false) String discountPercent,
			@RequestParam(value = "totalAfterAmount", required = false) String totalAfterAmount,
			@RequestParam(value = "mobile", required = false) String mobile) {
		
		String[] ItemNoArray = itemNo.split("\\s*,\\s*");
		String[] ItemNameArray = itemName.split("\\s*,\\s*"); 
		String[] priceArray = price.split("\\s*,\\s*"); 
		String[] quantityArray = quantity.split("\\s*,\\s*"); 
		String[] totalArray = total.split("\\s*,\\s*");
		
		
		
		int counter = 0;
		Transaction txn = new Transaction();
		txn.setDiscountedAmount(disacountAmount);
		txn.setDiscountPercentage(discountPercent);
		txn.setSubTotal(subTotal);
		txn.setTotalAfterDiscount(totalAfterAmount);
		txn.setMobileNumber(mobile);
		transactionDao.insert(txn);
		List<LineItem> lineObjcts = new ArrayList<LineItem>();
		
		for(String ItemNo : ItemNoArray){
			
			LineItem lineItem = new LineItem();
			lineItem.setTransactionNumber(txn.getAutoGeneratedId());
			lineItem.setItemNumber(ItemNo);
			lineItem.setItemDesc(ItemNameArray[counter]);
			lineItem.setPrice(priceArray[counter]);
			lineItem.setQuantity(quantityArray[counter]);
			lineItem.setLineTotal(totalArray[counter]);
			
			if(lineItem.getItemNumber().isEmpty())
				lineItem.setItemNumber("000");
			if(lineItem.getItemDesc().isEmpty())
				lineItem.setItemDesc("DEFAULT ITEM");
			
			if(!lineItem.getLineTotal().isEmpty()){
				lineObjcts.add(lineItem);
				lineItemDao.insert(lineItem);
			}
			counter ++;
		}
		
		new PrinterHelper().mappingTheData(txn, lineObjcts);
		
		ModelAndView model = new ModelAndView();
		model.setViewName("json");
		model.addObject("txn_Number", "Bill Number : <b>"+txn.getAutoGeneratedId()+" <b> <br> <br> <b> Amount "+ txn.getTotalAfterDiscount()+"</b>");
		return model;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {

		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");

		return model;

	}
	
	//for 403 access denied page
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public ModelAndView accesssDenied() {

		ModelAndView model = new ModelAndView();
		
		//check if user is login
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			System.out.println(userDetail);
			model.addObject("username", userDetail.getUsername());
		}
		
		model.setViewName("403");
		return model;

	}

}