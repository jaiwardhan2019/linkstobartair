package com.linkportal.dbripostry;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.google.common.base.Strings;

public class codusSageFuelInvoice {
	
	private String invoiceNo;
	private String invoiceDate;
	private String invoiceBatch;
	private String invoiceFinYear;
	private String invoicePeriod;
	private String invoiceSupplierCode;
	private String invoiceSupplierName;
	private String franchiseName;
	private String nominalCode;
	private String invoiceVatCode;
	private String invoiceAmount;
	private String invoiceIataCode;
	private String invoiceTicketNo;
	private String flightNo;
	private String airCraftReg;
	private String feeType;
	private String value1;
	
	
	
	
	public codusSageFuelInvoice(String invoiceNo, String invoiceDate, String invoiceBatch, String invoiceFinYear,
			String invoicePeriod, String invoiceSupplierCode, String invoiceSupplierName, String franchiseName,
			String nominalCode, String invoiceVatCode, String invoiceAmount, String invoiceIataCode,
			String invoiceTicketNo, String flightNo, String airCraftReg, String feeType, String value1) {
		super();
		this.invoiceNo = invoiceNo;
		this.invoiceDate = invoiceDate;
		this.invoiceBatch = invoiceBatch;
		this.invoiceFinYear = invoiceFinYear;
		this.invoicePeriod = invoicePeriod;
		this.invoiceSupplierCode = invoiceSupplierCode;
		this.invoiceSupplierName = invoiceSupplierName;
		this.franchiseName = franchiseName;
		this.nominalCode = nominalCode;
		this.invoiceVatCode = invoiceVatCode;
		this.invoiceAmount = invoiceAmount;
		this.invoiceIataCode = invoiceIataCode;
		this.invoiceTicketNo = invoiceTicketNo;
		this.flightNo = flightNo;
		this.airCraftReg = airCraftReg;
		this.feeType = feeType;
		this.value1 = value1;
	}




	public String getInvoiceNo() {
		return invoiceNo;
	}




	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}




	public String getInvoiceDate() {
		return invoiceDate;
	}


	

	//-------- Conver String to Date in this format 
	public String getInvoiceDateInddmmyyyy() throws ParseException {
		    if(Strings.isNullOrEmpty(this.getInvoiceDate())) { return "N/A"; } 
		    Date dtFormated=new SimpleDateFormat("dd-MM-yyyy").parse(this.getInvoiceDate());
		    return dtFormated.toString();	 	
	}
	
	
	
		


	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}




	public String getInvoiceBatch() {
		return invoiceBatch;
	}




	public void setInvoiceBatch(String invoiceBatch) {
		this.invoiceBatch = invoiceBatch;
	}




	public String getInvoiceFinYear() {
		return invoiceFinYear;
	}




	public void setInvoiceFinYear(String invoiceFinYear) {
		this.invoiceFinYear = invoiceFinYear;
	}




	public String getInvoicePeriod() {
		return invoicePeriod;
	}




	public void setInvoicePeriod(String invoicePeriod) {
		this.invoicePeriod = invoicePeriod;
	}




	public String getInvoiceSupplierCode() {
		return invoiceSupplierCode;
	}




	public void setInvoiceSupplierCode(String invoiceSupplierCode) {
		this.invoiceSupplierCode = invoiceSupplierCode;
	}




	public String getInvoiceSupplierName() {
		return invoiceSupplierName;
	}




	public void setInvoiceSupplierName(String invoiceSupplierName) {
		this.invoiceSupplierName = invoiceSupplierName;
	}




	public String getFranchiseName() {
		return franchiseName;
	}




	public void setFranchiseName(String franchiseName) {
		this.franchiseName = franchiseName;
	}




	public String getNominalCode() {
		return nominalCode;
	}




	public void setNominalCode(String nominalCode) {
		this.nominalCode = nominalCode;
	}




	public String getInvoiceVatCode() {
		return invoiceVatCode;
	}




	public void setInvoiceVatCode(String invoiceVatCode) {
		this.invoiceVatCode = invoiceVatCode;
	}




	public String getInvoiceAmount() {
		return invoiceAmount;
	}




	public void setInvoiceAmount(String invoiceAmount) {
		this.invoiceAmount = invoiceAmount;
	}




	public String getInvoiceIataCode() {
		return invoiceIataCode;
	}




	public void setInvoiceIataCode(String invoiceIataCode) {
		this.invoiceIataCode = invoiceIataCode;
	}




	public String getInvoiceTicketNo() {
		return invoiceTicketNo;
	}




	public void setInvoiceTicketNo(String invoiceTicketNo) {
		this.invoiceTicketNo = invoiceTicketNo;
	}




	public String getFlightNo() {
		return flightNo;
	}




	public void setFlightNo(String flightNo) {
		this.flightNo = flightNo;
	}




	public String getAirCraftReg() {
		return airCraftReg;
	}




	public void setAirCraftReg(String airCraftReg) {
		this.airCraftReg = airCraftReg;
	}




	public String getFeeType() {
		return feeType;
	}




	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}




	public String getValue1() {
		return value1;
	}




	public void setValue1(String value1) {
		this.value1 = value1;
	}
	
	
	
	
	

}
