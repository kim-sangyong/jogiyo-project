package com.itbank.jogiyo.admin.web;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itbank.jogiyo.admin.service.AdminMapper;
import com.itbank.jogiyo.dto.CategoryDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.NoticeDTO;
import com.itbank.jogiyo.dto.OrderDTO;
import com.itbank.jogiyo.util.UploadFile;

@Controller
public class AdminController {
	@Autowired
	private AdminMapper adminmapper;
	private UploadFile uploadfile;
	
	@RequestMapping("admin/insertCate.do")
	public String insertCate() {
		return "admin/inputCate";
	}
	
	@RequestMapping(value = "admin/insertCateOk.do", method = RequestMethod.POST)
	public String insertCateOk(@ModelAttribute CategoryDTO dto, HttpServletRequest req) {
			uploadfile = new UploadFile();
			if(uploadfile.uploadFile(dto.getFile())) {
				dto.setImg(uploadfile.getFullName());
				adminmapper.inputCate(dto);
			}
		return "redirect:" + req.getContextPath() + "/index.do";
	}
	
	@RequestMapping("admin/viewSales.do")
	public String viewSales() {
		return "admin/viewSales";
	}
	
	@ResponseBody
	@RequestMapping(value="admin/dateOrder.ajax", produces="text/plain;charset=UTF-8", method = RequestMethod.POST)
	public String dateOrder(@RequestParam("cal1") String cal1, @RequestParam("cal2") String cal2) {
		List<OrderDTO> list = adminmapper.dateOrder(cal1, cal2);
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
				
		Iterator<OrderDTO> it = list.iterator();
		while(it.hasNext()) {
			OrderDTO dto = it.next();
			JsonObject object = new JsonObject();
			int totprice = dto.getTotprice();
			int cnt = dto.getCnt();
			String storename = dto.getStorename();
		    object.addProperty("Totprice", totprice);
			object.addProperty("Storename", storename);
			object.addProperty("Cnt", cnt);
			jArray.add(object);
		}
		String json = gson.toJson(jArray);
		return json;
	}
	
	@RequestMapping("admin/listAcc.do")
	public String listAcc() {
		return "admin/listAcc";
	}
	@ResponseBody
	@RequestMapping(value="admin/listAcc.ajax", produces="text/plain;charset=UTF-8", method = RequestMethod.POST)
	public String listAccount(@RequestParam("sel") String sel) {
		List<LoginDTO> list = adminmapper.listAcc(sel);
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		Iterator<LoginDTO> it = list.iterator();
		while(it.hasNext()) {
			LoginDTO dto = it.next();
			JsonObject object = new JsonObject();
			object.addProperty("Id", dto.getId());
			object.addProperty("Passwd", dto.getPasswd());
			object.addProperty("Name", dto.getName());
			object.addProperty("Mail", dto.getMail());
			object.addProperty("Phone", dto.getPhone());
			String grade = "관리자";
			if(dto.getGrade().equals("ROLE_2")) {
				grade = "점주";
			}else if(dto.getGrade().equals("ROLE_3")) {
				grade = "사용자";
			}
			object.addProperty("Grade", grade);
			jArray.add(object);
		}
		String json = gson.toJson(jArray);
		return json;
	}
	@RequestMapping("admin/listNotice.do")
	public String listNotice(HttpServletRequest req) {
		List<NoticeDTO> list = adminmapper.listNotice();
		req.setAttribute("list", list);
		return "admin/listNotice";
		
	}

	@ResponseBody
	@RequestMapping(value="admin/deleteUser.ajax", produces="text/plain;charset=UTF-8")
	public String deleteUser(@RequestParam("id") String id) {
		adminmapper.deleteUser(id);
		return "OK";
	}
	//점주 회원가입 목록
   @RequestMapping(value = "admin/ownerList.do")
   public String ownerList(HttpServletRequest req) {
      List<LoginDTO> ownerList = adminmapper.ownerList();
      System.out.println(ownerList);
      req.setAttribute("ownerList", ownerList);
      return "admin/ownerList";
   }
	// 점주 회원가입 승인
   @RequestMapping(value = "admin/ownerList_ok.do")
   public String ownerList_ok(HttpServletRequest req) {
      String ownerId = req.getParameter("id");
      int res = adminmapper.ownerListOk(ownerId);
       if (res > 0) {
             req.setAttribute("msg", "승인이 완료되었습니다.");
             req.setAttribute("url", "ownerList.do");
          } else {
              req.setAttribute("msg", "승인에 실패하였습니다.");
              req.setAttribute("url", "ownerList.do");
          }
      return "message";
   }
	
}
