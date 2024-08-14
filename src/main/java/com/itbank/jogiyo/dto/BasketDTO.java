package com.itbank.jogiyo.dto;

public class BasketDTO {
	private int basketid;
	private String id;
	private int qty;
	private int totprice;
	private int menuid;
	private int storeid;
	private String menuname;
	private String img;
	private int price;
	private String jscateid;
	
	
	public String getJscateid() {
		return jscateid;
	}
	public void setJscateid(String jscateid) {
		this.jscateid = jscateid;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getBasketid() {
		return basketid;
	}
	public void setBasketid(int basketid) {
		this.basketid = basketid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getTotprice() {
		return totprice;
	}
	public void setTotprice(int totprice) {
		this.totprice = totprice;
	}
	public int getMenuid() {
		return menuid;
	}
	public void setMenuid(int menuid) {
		this.menuid = menuid;
	}
	public int getStoreid() {
		return storeid;
	}
	public void setStoreid(int storeid) {
		this.storeid = storeid;
	}
	
	
}
