package com.itbank.jogiyo.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.itbank.jogiyo.properties.PropertyReader;

public class UploadFile {
	
	private String fullname;
	
	public String getFullName() {
		return fullname;
	}

	public void setUniqueName(String fullname) {
		this.fullname = fullname;
	}

	public boolean uploadFile(MultipartFile file) {
		PropertyReader reader = new PropertyReader();
		String fileDir = reader.getProperty("file_dir");
		UUID uuid = UUID.randomUUID();
		String[] uuids = uuid.toString().split("-");
		String uniqueName = uuids[0];
		String fileExtension = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."),file.getOriginalFilename().length());
		fullname = uniqueName+fileExtension;
		System.out.println(fileDir);
		try {
			file.transferTo(new File(fileDir+fullname));
			return true;
		} catch (IllegalStateException e) {
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}
}
