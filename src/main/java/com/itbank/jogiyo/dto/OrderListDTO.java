package com.itbank.jogiyo.dto;

public class OrderListDTO {
	//가게 orderlist불러올때 사용
	private String indate;
	private String menuname;
	private String qty;
	private String id;
	private String totprice;
	private String phone;
	private int menu_totprice;
	private String daily;
	private int daily_total;
	private String month;
	private int monthly_total;
	private int run;
	public int getRun() {
		return run;
	}
	public void setRun(int run) {
		this.run = run;
	}
	public String getDate1() {
		return date1;
	}
	public void setDate1(String date1) {
		this.date1 = date1;
	}
	public String getDate2() {
		return date2;
	}
	public void setDate2(String date2) {
		this.date2 = date2;
	}
	public int getStoreid() {
		return storeid;
	}
	public void setStoreid(int storeid) {
		this.storeid = storeid;
	}
	private String date1;
	private String date2;
	private int storeid;
	
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getQty() {
		return qty;
	}
	public void setQty(String qty) {
		this.qty = qty;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTotprice() {
		return totprice;
	}
	public void setTotprice(String totprice) {
		this.totprice = totprice;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getMenu_totprice() {
		return menu_totprice;
	}
	public void setMenu_totprice(int menu_totprice) {
		this.menu_totprice = menu_totprice;
	}
	public String getDaily() {
		return daily;
	}
	public void setDaily(String daily) {
		this.daily = daily;
	}
	public int getDaily_total() {
		return daily_total;
	}
	public void setDaily_total(int daily_total) {
		this.daily_total = daily_total;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public int getMonthly_total() {
		return monthly_total;
	}
	public void setMonthly_total(int monthly_total) {
		this.monthly_total = monthly_total;
	}
	
}
	
