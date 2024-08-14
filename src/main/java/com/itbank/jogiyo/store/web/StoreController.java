package com.itbank.jogiyo.store.web;
import java.awt.Window;
import java.awt.event.WindowStateListener;
import java.io.PrintStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.jogiyo.customer.service.CustomerMapper;
import com.itbank.jogiyo.dto.CategoryDTO;
import com.itbank.jogiyo.dto.CouponDTO;
import com.itbank.jogiyo.dto.JstoreCateDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.MenuDTO;
import com.itbank.jogiyo.dto.OrderDTO;
import com.itbank.jogiyo.dto.OrderListDTO;
import com.itbank.jogiyo.dto.ReviewDTO;
import com.itbank.jogiyo.dto.StopStoreDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.login.service.LoginMapper;
import com.itbank.jogiyo.properties.PropertyReader;
import com.itbank.jogiyo.store.service.StoreMapper;
import com.itbank.jogiyo.util.UploadFile;

@Controller
public class StoreController {
	@Autowired
	private StoreMapper storemapper;
	@Autowired
	private CustomerMapper customerMapper;
	private UploadFile uploadFile; 
	private LoginMapper loginmapper;
	
	
	
	@RequestMapping("/store/store.do")
	public String listStore(HttpServletRequest req) {
		List<StoreDTO> list = storemapper.listStore();
		req.setAttribute("list", list);
		return "store/store";
	}
	@RequestMapping(value="/store/AddStore.do" , method = RequestMethod.GET)
	public String AddStore(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		req.setAttribute("jId", authentication.getName());
		List<CategoryDTO> clist = storemapper.getAllCate();
		req.setAttribute("clist", clist);
		return "store/AddStore";
		
	}
	
	@RequestMapping(value ="/store/AddStore.do", method = RequestMethod.POST)
	public ModelAndView AddStoreOk(HttpServletRequest req , StoreDTO dto) {
		ModelAndView mav = new ModelAndView();
		uploadFile = new UploadFile();
		if(uploadFile.uploadFile(dto.getFile())) {
			dto.setImg(uploadFile.getFullName());
			dto.setRun(1);
		
		}
		System.out.println(dto.getPostcode()+","+dto.getAddress()+","+dto.getDetailaddress()+","+dto.getExtraaddress());
		int res = storemapper.addStore(dto);
		if (res>0) {
			mav.addObject("msg" , "가게추가 완료!");
			mav.addObject("url" , "/store/ListStore.do");
			mav.setViewName("message");
		}else {
			mav.addObject("msg" , "가게추가 실패! 관리자에게 문의해주세요");
			mav.addObject("url" , "/store/ListStore.do");
			mav.setViewName("message");
		
		}
		return mav;
		//가게 추가 
	}
	@RequestMapping("/store/ListStore.do")
	public String ListStore(HttpServletRequest req) {	
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<StoreDTO> slist = storemapper.getStore(authentication.getName());
		req.setAttribute("getStore",slist);
	
		//이미지처리도해야됨
		return "store/ListStore";
		//세션에있는 아이디값으로 storeDTO값 받아오기
	}
	@RequestMapping("/store/Myinfo.do")
		public String MyInfo(HttpServletRequest req) {
		return "store/MyInfo";
	}
	@RequestMapping("/store/test.do")
		public String test(HttpServletRequest req) {
		PropertyReader reader = new PropertyReader();
		String key = reader.getProperty("kakao_key");
		req.setAttribute("address", "서울 종로구 삼일대로 394");
		req.setAttribute("key", key);
		return "store/kakaomaptest";
	}
	@RequestMapping("/store/selectStore.do")
		public String selectStore(HttpServletRequest req) {
		String storename = req.getParameter("storename");
		String storeid=req.getParameter("storeid");
		req.setAttribute("storename", storename);
		req.setAttribute("storeid", storeid);
		
		List<OrderListDTO>orderList=storemapper.orderList(Integer.parseInt(storeid));
		int run=storemapper.run(Integer.parseInt(storeid));
		if(run == 0) {
			req.setAttribute("run","[영업중지중]");
			req.setAttribute("orderList", orderList);
			req.setAttribute("storename", storename);
		}else if(run == 1) {
			req.setAttribute("run", "[영업중]");
			req.setAttribute("orderList", orderList);
			req.setAttribute("storename", storename);
		}
		
	
		return "store/selectStore";
	}
	@RequestMapping("/store/reviewStore.do")
	public ModelAndView reviewStore(@RequestParam("storeid") String storeid, HttpServletRequest req,
	                                @RequestParam(value = "page", defaultValue = "1") int page) {
	    int itemsPerPage = 5; // 한 페이지에 보여질 리뷰 수
	    int startIndex = (page - 1) * itemsPerPage; // 시작 인덱스 수정
	    int endIndex = page * itemsPerPage; // 끝 인덱스 수정

	    // 파라미터 설정
	    Map<String, Object> params = new HashMap<>();
	    params.put("storeid", storeid);
	    params.put("startIndex", startIndex);
	    params.put("endIndex", endIndex);
	   
	   
	    List<ReviewDTO> rList = storemapper.getReview(params);

	  
	    int totalCount = storemapper.getReviewCount(Integer.parseInt(storeid));
	    int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage); // 전체 페이지 수 계산

	    String storename= req.getParameter("storename");
	    req.setAttribute("storename", storename);
	    req.setAttribute("storeid", storeid);
	    ModelAndView mav = new ModelAndView("store/reviewStore");
	    mav.addObject("rList", rList);
	    mav.addObject("currentPage", page);
	    mav.addObject("pageCount", pageCount); 
	    mav.addObject("storename",storename);

	    return mav;
	}
	/*
	@RequestMapping("/store/reviewStore.do")
	public String orderList(HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		List<ReviewDTO>rList = storemapper.getReview(Integer.parseInt(storeid));
		req.setAttribute("rList",rList);
		return "store/reviewStore";
	}
	*/
	@RequestMapping("/store/stopStore.do")
	public String stopStore(HttpServletRequest req) {
	String storeid =req.getParameter("storeid");
	String storename=req.getParameter("storename");
	req.setAttribute("storeid",storeid);
	req.setAttribute("storename", storename);
	return "store/stopStore";
	}
	@RequestMapping(value="/store/stopStorePro.do", method=RequestMethod.POST)
	public String stopStorePro(	HttpServletRequest req,@ModelAttribute StopStoreDTO dto, BindingResult results) {
		
		String storeid =req.getParameter("storeid");
		String selectDatetime = req.getParameter("selectDatetime");
		System.out.println(selectDatetime);
		if(results.hasErrors()) {
			System.out.println("dto구성중 에러발생");
		}

		int res= storemapper.stopStore(dto);
		if (res>0) {
			req.setAttribute("url", "/store/selectStore.do?storeid="+storeid);
			req.setAttribute("msg","일시정지성공");
		}else {
			req.setAttribute("url","/store/selectStore.do?storeid="+storeid);
			req.setAttribute("msg", "일시정지실패");
			
		}
		
		return "message";
		
	}
	@RequestMapping("/store/instacestopStore.do")
	public String instancestopStoreMenu(HttpServletRequest req) {
		String storeid = req.getParameter("storeid");
		int res= storemapper.stopStore2(Integer.parseInt(storeid));
		if (res>0) {
			req.setAttribute("url", "/store/selectStore.do?storeid="+storeid);
			req.setAttribute("msg","일시정지성공");
			
		}else {
			req.setAttribute("url","/store/selectStore.do?storeid="+storeid);
			req.setAttribute("msg", "일시정지실패");
			
		}
		
		return "message";
	}
	@RequestMapping("/store/runStore.do")
		public String runStoreMenu(HttpServletRequest req) {
			String storeid = req.getParameter("storeid");
			String storename=req.getParameter("storename");
			int res= storemapper.runStore(Integer.parseInt(storeid));
			if (res>0) {
				req.setAttribute("url", "/store/selectStore.do?storeid="+storeid);
				req.setAttribute("msg","영업시작성공");
				
				
			}else {
				req.setAttribute("url","/store/selectStore.do?storeid="+storeid);
				req.setAttribute("msg", "영업시작실패");
				
			}
			
			return "message";
		}
	@RequestMapping("/store/storeMenu.do")
	public String storeMenu(HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		String storename=req.getParameter("storename");
		req.setAttribute("storeid",storeid);
		List<MenuDTO>mlist = storemapper.listMenu(Integer.parseInt(storeid));
		req.setAttribute("mlist",mlist);
		req.setAttribute("storename", storename);
		return "store/storeMenu";
	}
	
	@RequestMapping("/store/storeSales.do")
	public String storeSales(HttpServletRequest req) {
		String storeid= req.getParameter("storeid");
		String storename=req.getParameter("storename");
		req.setAttribute("storeid", storeid);
		req.setAttribute("storename", storename);
		return "store/storeSales";
	}
	@RequestMapping("/store/ownerInfo.do")
	public String ownerInfo(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		LoginDTO owner = storemapper.getOwner(authentication.getName());
		req.setAttribute("owner", owner);
		return "store/ownerInfo";
	}
	@RequestMapping("/store/storeInfo.do")
	public String storeInfo(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<StoreDTO> slist = storemapper.getStore(authentication.getName());
		req.setAttribute("getStore",slist);
		
		//이미지처리도해야됨
		return "store/storeInfo";
	}
	@RequestMapping("/store/addMenu.do")
	public String addMenu(HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		String storename=req.getParameter("storename");
		req.setAttribute("storeid", storeid);
		List<JstoreCateDTO>cateList = storemapper.getCateList(Integer.parseInt(storeid));
		req.setAttribute("cateList", cateList);
		req.setAttribute("storename", storename);
		return "store/addMenu";
	}
	@RequestMapping(value="/store/addMenuPro.do", method=RequestMethod.POST)
	public String addMenuPro(@ModelAttribute MenuDTO dto,BindingResult result,HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		uploadFile = new UploadFile();
		if(uploadFile.uploadFile(dto.getFile())) {
			dto.setImg(uploadFile.getFullName());
			dto.setMqty(1);
		}
		if(result.hasErrors()) {
			System.out.println("메뉴dto구성중 오류발생");
		}
		System.out.println(dto.getJscateid()+","+ dto.getMenucontent()+","+dto.getStoreid()+","+ dto.getImg()+","+dto.getPrice()+","+dto.getMenuname());
		int res = storemapper.addMenu(dto);
		
		if (res>0) {
			req.setAttribute("url", "/store/storeMenu.do?storeid="+storeid);
			req.setAttribute("msg","메뉴추가완료!");
			
		}else {
			req.setAttribute("url","/store/storeMenu.do");
			req.setAttribute("msg", "메뉴추가실패!");
			
		}
		return "message";
	}
	@RequestMapping("/store/editMenu.do")
	public String editMenu(HttpServletRequest req) {
		String menuid=req.getParameter("menuid");
		String storeid=req.getParameter("storeid");
		String storename=req.getParameter("storename");
		List<MenuDTO>getMenu=storemapper.getMenu(Integer.parseInt(menuid));
		List<JstoreCateDTO>cateList = storemapper.getCateList(Integer.parseInt(storeid));
		req.setAttribute("cateList", cateList);
		req.setAttribute("getMenu", getMenu);
		req.setAttribute("storename", storename);
		return "store/editMenu";
	}
	@RequestMapping(value="/store/editMenuPro.do" ,method=RequestMethod.POST)
	public ModelAndView editMenuPro(@ModelAttribute MenuDTO dto,BindingResult result,HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String storeid=req.getParameter("storeid");
		uploadFile = new UploadFile();
		try {	
		if(dto.getFile()!=null) {
			if(uploadFile.uploadFile(dto.getFile())) {
				dto.setImg(uploadFile.getFullName());
		}
			}
		}catch(IndexOutOfBoundsException e){
			e.printStackTrace();
		}
		
		if(result.hasErrors()) {
			System.out.println("dto생성중 오류발생");
		}
		
		int res=storemapper.editMenu(dto);
		if(res>0) {
			mav.addObject("msg","메뉴수정완료");
			mav.addObject("url","/store/storeMenu.do?storeid="+storeid);
			mav.setViewName("message");
		}else {
			mav.addObject("msg","메뉴수정실패");
			mav.addObject("url","/store/storeMenu.do?storeid="+storeid);
			mav.setViewName("message");
		}
		return mav;
	}
	@RequestMapping("/store/deleteMenu.do")
	public String deleteMenu(HttpServletRequest req) {
		String storeid = req.getParameter("storeid");
		String menuid=req.getParameter("menuid");
		int res=storemapper.deleteMenu(Integer.parseInt(menuid));
		if(res>0) {
			req.setAttribute("url","/store/storeMenu.do?storeid="+storeid);
			req.setAttribute("msg", "메뉴삭제완료");
		
		}else {
			req.setAttribute("url", "/store/storeMenu.do");
			req.setAttribute("msg", "메뉴삭제실패");
		}
		
		return "message";
	}
	@RequestMapping("/store/editStore.do")
	public String editStore(HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		List <StoreDTO>list=storemapper.findStore(Integer.parseInt(storeid));
		req.setAttribute("findStore",list);
		return "store/editStore";
	}
	@RequestMapping(value ="/store/editStorePro.do", method=RequestMethod.POST)
	public ModelAndView editStorePro(@ModelAttribute StoreDTO dto, BindingResult result) {
		ModelAndView mav = new ModelAndView();
		uploadFile = new UploadFile();
		try {	
		if(dto.getFile()!=null) {
			if(uploadFile.uploadFile(dto.getFile())) {
				dto.setImg(uploadFile.getFullName());
		}
			}
		}catch(IndexOutOfBoundsException e){
			e.printStackTrace();
		}
		if (result.hasErrors()) {
			dto.setCouponid(0);
			dto.setRun(1);
		}
		
		//System.out.println(dto.getStorecontent()+","+dto.getCateid()+","+dto.getStorename()+","+
		//dto.getImg()+","+dto.getLat()+","+dto.getHar()+","+dto.getStoreid());
		int res = storemapper.updateStore(dto);
		if (res>0) {
			mav.addObject("msg" , "가게수정 완료!");
			mav.addObject("url" , "/store/ListStore.do");
			mav.setViewName("message");
		}else {
			mav.addObject("msg" , "가게수정 실패! 관리자에게 문의해주세요");
			mav.addObject("url" , "/store/ListStore.do");
			mav.setViewName("message");
		
		}
		return mav;
		
		
	}
	@RequestMapping("/store/editOwner.do")
	public ModelAndView editOwner(@ModelAttribute LoginDTO dto, BindingResult result) {
		if(result.hasErrors()) {
			dto.setGrade("미정");
		}
		int res=storemapper.updateOwner(dto);
		ModelAndView mav = new ModelAndView();
		if(res>0) {
			mav.addObject("msg","수정이 완료되었습니다");
			mav.addObject("url","/store/Myinfo.do");
			mav.setViewName("message");
		}else {
			mav.addObject("msg","수정실패 관리자에게 문의해주세요");
			mav.addObject("url","/store/Myinfo.do");
			mav.setViewName("message");
		}
		return mav;
	}
	@RequestMapping("/store/deleteOwner.do")
	public ModelAndView deleteOwner(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView mav = new ModelAndView();
		int res = storemapper.deleteOwner(authentication.getName());
		if(res>0) {
			req.getSession().invalidate();
			mav.addObject("msg","탈퇴가 완료되었습니다");
			mav.addObject("url","/");
			mav.setViewName("message");
		}else {
			mav.addObject("msg","탈퇴실패 관리자에게 문의해주세요");
			mav.addObject("url","/");
			mav.setViewName("message");
		}
		return mav;
	}
	@RequestMapping("/store/deleteStore.do")
	public String deleteStore(HttpServletRequest req) {
		String storename = req.getParameter("storename");
		int res = storemapper.deleteStore(storename);
		if(res>0) {
			req.setAttribute("url", "/store/ListStore.do");
			req.setAttribute("msg", "가게삭제완료");
		}
		return "message";
	}
	@RequestMapping("/store/addCate.do")
	public String addCate(HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		String storename=req.getParameter("storename");
		req.setAttribute("storeid", storeid);
		req.setAttribute("storename",storename);
		
		
		return "/store/addCate";
	}
	@RequestMapping("/store/addCateOk.do")
	public String addCateOk(@RequestParam Map<String ,String> params, HttpServletRequest req) {
		int res = storemapper.addCate(params);
		String storeid= req.getParameter("storeid");
		if(res>0) {
			req.setAttribute("msg", "카테고리추가완료");
			req.setAttribute("url", "/store/selectStore.do?storeid="+storeid);	
		}else {
			req.setAttribute("msg", "카테고리추가실패");
			req.setAttribute("url", "/store/selectStore.do");
		}
		return "message";
	}
	@ResponseBody
	@RequestMapping(value="store/menuSales.ajax",method=RequestMethod.POST,produces="text/plain;charset=UTF-8")
	public String menuSales(@ModelAttribute OrderListDTO dto , BindingResult results) {
		if(results.hasErrors()) {
			System.out.println("dto구성중 에러발생");
		}
		List<OrderListDTO>menuSList = storemapper.menuSales(dto);
		
		//System.out.println(menuSList);
		//System.out.println(dto.getStoreid());
		//System.out.println(dto.getDate1());
		//System.out.println(dto.getDate2());
		Gson gson = new Gson();
		JsonArray jarray = new JsonArray();
		Iterator <OrderListDTO>it = menuSList.iterator();
		while(it.hasNext()) {
			OrderListDTO odto = it.next();
			JsonObject jObject = new JsonObject();
			int menu_totprice = odto.getMenu_totprice();
			String menuname = odto.getMenuname();
			jObject.addProperty("menu_totprice",menu_totprice);
			jObject.addProperty("menuname", menuname);
			jarray.add(jObject);
		}
		String json = gson.toJson(jarray);
		return json;
	}
	@RequestMapping("/store/storeSales2.do")
	public String storeSales2(HttpServletRequest req) {
		String storeid= req.getParameter("storeid");
		String storename= req.getParameter("storename");
		req.setAttribute("storeid", storeid);
		req.setAttribute("storename", storename);
		return "store/storeSales2";
	}
	@ResponseBody
	@RequestMapping(value="store/indateSales.ajax",method=RequestMethod.POST,produces="text/plain;charset=UTF-8")
	public String indateSales(@ModelAttribute OrderListDTO dto , BindingResult results) {
		if(results.hasErrors()) {
			System.out.println("dto구성중 에러발생");
		}
		List<OrderListDTO>indateList = storemapper.indateSales(dto);
		
		
		Gson gson = new Gson();
		JsonArray jarray = new JsonArray();
		Iterator <OrderListDTO>it = indateList.iterator();
		while(it.hasNext()) {
			OrderListDTO odto = it.next();
			JsonObject jObject = new JsonObject();
			String daily1= odto.getDaily();
			int hcount = daily1.length() - daily1.replace("-", "").length();
			if(hcount == 2) {
				String daily=odto.getDaily();
				int daily_total=odto.getDaily_total();
				jObject.addProperty("daily",daily);
				jObject.addProperty("daily_total",daily_total);
				System.out.println(daily);
				System.out.println(daily_total);
			}else if(hcount==1){
				String month=odto.getDaily();
				int monthly_total=odto.getDaily_total();
				jObject.addProperty("month", month);
				jObject.addProperty("monthly_total",monthly_total);
				System.out.println(month);
				System.out.println(monthly_total);
			}
			
			jarray.add(jObject);
		}
		String json = gson.toJson(jarray);
		return json;
	}
	@RequestMapping("/store/stopMenu.do")
	public String stopMenu(HttpServletRequest req) {
		String menuid=req.getParameter("menuid");
		String storeid=req.getParameter("storeid");
		int res=storemapper.stopMenu(Integer.parseInt(menuid));
		if(res>0) {
			req.setAttribute("msg", "품절처리완료");
			req.setAttribute("url", "/store/storeMenu.do?storeid="+storeid);	
		}else {
			req.setAttribute("msg", "품절처리실패");
			req.setAttribute("url", "/store/storeMenu.do?storeid="+storeid);
		}
		return "message";
	}
	@RequestMapping("/store/startMenu.do")
	public String startMenu(HttpServletRequest req) {
		String menuid=req.getParameter("menuid");
		String storeid=req.getParameter("storeid");
		int res=storemapper.startMenu(Integer.parseInt(menuid));
		if(res>0) {
			req.setAttribute("msg", "품절취소완료");
			req.setAttribute("url", "/store/storeMenu.do?storeid="+storeid);	
		}else {
			req.setAttribute("msg", "품절취소실패");
			req.setAttribute("url", "/store/storeMenu.do?storeid="+storeid);
		}
		return "message";
	}
	
	
	@RequestMapping("/store/addCoupon.do")
	public String addCoupon(HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		String storename=req.getParameter("storename");
		req.setAttribute("storeid",storeid);
		req.setAttribute("storename", storename);
		
		return "/store/addCoupon";
	}
	@RequestMapping("store/addCouponOk.do")
	public String addCouponOk(@ModelAttribute CouponDTO dto, BindingResult Results,HttpServletRequest req) {
		int storeid= dto.getStoreid();
		if(Results.hasErrors()) {
			System.out.println("쿠폰dto 생성시 오류");
		}
		int res = storemapper.addCoupon(dto);
		int res2 = storemapper.updateCoupon(storeid);
		if(res2>0) {
		if(res>0) {
				req.setAttribute("msg", "쿠폰등록완료!");
				req.setAttribute("url", "/store/selectStore.do?storeid="+storeid);
			}else {
				req.setAttribute("msg", "쿠폰등록실패!");
				req.setAttribute("url", "/store/selectStore.do?storeid="+storeid);
			}
		}else {
			System.out.println("error coupon");
		}
		return "message";
	}
	
	
	@RequestMapping("/store/addReviewOk.do")
	public String addReviewOk(HttpServletRequest req,@ModelAttribute ReviewDTO dto , BindingResult results) {
		if(results.hasErrors()) {
			System.out.println("리뷰dto구성중에러발생");
		}
		String reviewid = req.getParameter("reviewid");
		String storeid=req.getParameter("storeid");
		int res = storemapper.addReview(dto);
		if(res>0) {
			req.setAttribute("url", "/store/reviewStore.do?storeid="+storeid);
			req.setAttribute("msg", "답글등록성공!");
		}else {
			req.setAttribute("url", "/store/reviewStore.do?storeid="+storeid);
			req.setAttribute("msg", "답글등록실패!");
		}
		return "message";
	}
	
	@RequestMapping("/store/editReviewOk.do")
	public String editReviewOk(HttpServletRequest req,@ModelAttribute ReviewDTO dto , BindingResult results) {
		if(results.hasErrors()) {
			System.out.println("리뷰dto구성중에러발생");
		}
		String reviewid = req.getParameter("reviewid");
		String storeid=req.getParameter("storeid");
		int res = storemapper.addReview(dto);
		if(res>0) {
			req.setAttribute("url", "/store/reviewStore.do?storeid="+storeid);
			req.setAttribute("msg", "답글수정성공!");
		}else {
			req.setAttribute("url", "/store/reviewStore.do?storeid="+storeid);
			req.setAttribute("msg", "답글수정실패!");
		}
		return "message";
	}
	@RequestMapping("/store/deleteReview.do")
	public String deleteReview(HttpServletRequest req){
	String reviewid=req.getParameter("reviewid");
	String storeid=req.getParameter("storeid");
	int res = storemapper.deleteReview(Integer.parseInt(reviewid));
	if(res>0) {
		req.setAttribute("msg", "답글삭제성공");
		req.setAttribute("url", "/store/reviewStore.do?storeid="+storeid);
	}else {
		req.setAttribute("msg", "답글삭제실패");
		req.setAttribute("url", "/store/reviewStore.do?storeid="+storeid);
	}
	return "message";
	}
	@RequestMapping("/store/headerSearch.do")
	public String headerSearch(HttpServletRequest req) {
		String headerSearch = req.getParameter("headerSearch");
		List<StoreDTO>storeList=storemapper.headerSearch(headerSearch);
		req.setAttribute("storeList",storeList);
		return "customer/jogiyoStoreList";
	}
	
}

	
	
	