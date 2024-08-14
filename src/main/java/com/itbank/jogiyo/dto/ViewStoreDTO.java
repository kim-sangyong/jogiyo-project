package com.itbank.jogiyo.dto;

public class ViewStoreDTO {
	private int menuid;
	private int storeid;
	private int jscateid;
	private String menuname;
	private String menucontent;
	private String img;
	private String price;
	private String jstorename;
	private int mqty;
	private int cnt;
	// 윤장호 mqty추가

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
	public int getJscateid() {
		return jscateid;
	}
	public void setJscateid(int jscateid) {
		this.jscateid = jscateid;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getMenucontent() {
		return menucontent;
	}
	public void setMenucontent(String menucontent) {
		this.menucontent = menucontent;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getJstorename() {
		return jstorename;
	}
	public void setJstorename(String jstorename) {
		this.jstorename = jstorename;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	public int getMqty() {
		return mqty;
	}
	public void setMqty(int mqty) {
		this.mqty = mqty;
	}
}