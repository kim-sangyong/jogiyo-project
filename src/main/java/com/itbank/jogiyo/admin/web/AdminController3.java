package com.itbank.jogiyo.admin.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itbank.jogiyo.admin.service.AdminMapper3;
import com.itbank.jogiyo.dto.NoticeDTO;

@Controller
public class AdminController3 {
	@Autowired
	private AdminMapper3 adminmapper;
	
	@RequestMapping("admin/notice.do")
	public String notice() {
		return "admin/notice";
	}

	@RequestMapping(value = "admin/insertNotice.do", method = RequestMethod.POST)
	public String insertNotice(HttpServletRequest req, NoticeDTO dto) {
		int res = adminmapper.insertNotice(dto);
		return "redirect:/admin/listNotice.do";
	}
	
	@RequestMapping(value = "admin/deleteNotice.do", method = RequestMethod.POST)
	public String deleteNotice(HttpServletRequest req, int notiid) {
		int res = adminmapper.deleteNotice(notiid);
		return "redirect:/admin/listNotice.do";
	}
	//게시글 수정하는 페이지
	@RequestMapping(value = "admin/editNotice.do", method = RequestMethod.POST)
	public String editNotice(HttpServletRequest req, int notiid) {
		NoticeDTO dto = adminmapper.viewNotice(notiid);
		req.setAttribute("dto", dto);
		return "admin/editNotice";
	}
	//게시글 수정
	@RequestMapping(value = "admin/updateNotice.do" , method = RequestMethod.POST)
	public String update(HttpServletRequest req, NoticeDTO dto) {
		System.out.println(dto.getSubject()+","+dto.getContent());
		int res = adminmapper.editNotice(dto);
		return "redirect:/admin/listNotice.do";
	}
	@RequestMapping(value="admin/viewNotice.do", method = RequestMethod.POST)
	public String viewNotice(HttpServletRequest req, @RequestParam("notiid") int notiid) {
		NoticeDTO dto = adminmapper.viewNotice(notiid);
		req.setAttribute("dto", dto);
		return "admin/viewNotice";
	}
}