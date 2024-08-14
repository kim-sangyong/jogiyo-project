package com.itbank.jogiyo.dto;

import org.springframework.web.multipart.MultipartFile;

public class CategoryDTO {
	private int cateid;
	private String catename;
	private String img;
	private MultipartFile file;
	public int getCateid() {
		return cateid;
	}
	public void setCateid(int cateid) {
		this.cateid = cateid;
	}
	public String getCatename() {
		return catename;
	}
	public void setCatename(String catename) {
		this.catename = catename;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public CategoryDTO(int cateid, String catename, String img, MultipartFile file) {
		super();
		this.cateid = cateid;
		this.catename = catename;
		this.img = img;
		this.file = file;
	}
	public CategoryDTO() {}
	
	
	
}
