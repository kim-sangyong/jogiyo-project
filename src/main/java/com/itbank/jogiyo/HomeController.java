package com.itbank.jogiyo;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itbank.jogiyo.admin.service.AdminMapper;
import com.itbank.jogiyo.dto.CategoryDTO;
import com.itbank.jogiyo.dto.NoticeDTO;
import com.itbank.jogiyo.properties.PropertyReader;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private AdminMapper adminmapper;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = {"/", "index.do"}, method = RequestMethod.GET)
	public String home(Locale locale, HttpServletRequest req) {
		logger.info("Welcome home! The client locale is {}.", locale);
		List<CategoryDTO> list = adminmapper.listCate();
		boolean result = adminmapper.countNotice();
		PropertyReader reader = new PropertyReader();
		String fileDir = reader.getProperty("file_dir");
		req.setAttribute("result", result);
		req.setAttribute("cateList", list);
		req.setAttribute("fileDir", fileDir);
		return "main";
	}
	@RequestMapping("indexNotice.do")
	public String indexNotice(HttpServletRequest req) {
		NoticeDTO dto = adminmapper.indexNotice();
		req.setAttribute("dto", dto);
		return "viewNotice";
	}
	
}
