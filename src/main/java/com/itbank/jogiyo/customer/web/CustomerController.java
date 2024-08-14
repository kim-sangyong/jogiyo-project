package com.itbank.jogiyo.customer.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itbank.jogiyo.customer.service.CustomerMapper;
import com.itbank.jogiyo.dto.BasketDTO;
import com.itbank.jogiyo.dto.CategoryDTO;
import com.itbank.jogiyo.dto.CouponDTO;
import com.itbank.jogiyo.dto.DeliveryDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.MenuDTO;
import com.itbank.jogiyo.dto.NoticeDTO;
import com.itbank.jogiyo.dto.OrderDTO;
import com.itbank.jogiyo.dto.ReviewDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.dto.UserCouponDTO;
import com.itbank.jogiyo.dto.ViewCateStoreDTO;
import com.itbank.jogiyo.dto.ViewStoreDTO;
import com.itbank.jogiyo.login.service.LoginMapper;
import com.itbank.jogiyo.properties.PropertyReader;
import com.itbank.jogiyo.util.UploadFile;

@Controller
public class CustomerController {
	@Autowired
	private CustomerMapper customerMapper;
	@Autowired
	private LoginMapper loginMapper;
	private UploadFile uploadFile;

	@RequestMapping("/customer/mypage.do")
	public String listCustomer(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		LoginDTO user = customerMapper.cMypageList(authentication.getName());
		req.setAttribute("customer", user);
		return "customer/mypage";
	}

	@RequestMapping(value = "/customer/update.do", method = RequestMethod.POST)
	public String updateCustomer(HttpServletRequest req, LoginDTO dto) {
		req.setAttribute("customer", dto);
		return "customer/updateCustomer";
	}

	@RequestMapping(value = "/customer/updateOk.do", method = RequestMethod.POST)
	public ModelAndView updateCustomerOk(HttpServletRequest req, LoginDTO dto) {
		ModelAndView mav = new ModelAndView();
		int res = customerMapper.updateCustomer(dto);
		if (res > 0) {
			mav.addObject("msg", "�쉶�썝�닔�젙 �셿猷�");
			mav.addObject("url", "/customer/mypage.do");
			mav.setViewName("message");
		} else {
			mav.addObject("msg", "�쉶�썝 �닔�젙 �떎�뙣");
			mav.addObject("url", "/customer/mypage.do");
			mav.setViewName("message");
		}
		return mav;
	}

	@RequestMapping("/customer/secession.do")
	public ModelAndView secessionCustomer(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView mav = new ModelAndView();
		int res = customerMapper.secessionCustomer(authentication.getName());
		if (res > 0) {
			mav.addObject("msg", "�깉�눜�꽦怨�");
			mav.addObject("url", "/login/logout.do");
			mav.setViewName("message2");
		} else {
			mav.addObject("msg", "�깉�눜�떎�뙣");
			mav.addObject("url", "/");
			mav.setViewName("message");
		}
		return mav;
	}

	@RequestMapping("/customer/basket.do")
	public String BasketList(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		try {
			List<BasketDTO> list = customerMapper.basket(authentication.getName());
			int sid = customerMapper.checkBasket(authentication.getName());
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", authentication.getName());
			params.put("storeid", sid);
			List<UserCouponDTO> coupon = customerMapper.customerCoupon(params);
			req.setAttribute("cCoupon", coupon);
			req.setAttribute("basket", list);

			// 泥� 踰덉㎏ 媛�寃� ID瑜� �슂泥� �냽�꽦�뿉 異붽�
			if (!list.isEmpty()) {
				req.setAttribute("storeid", list.get(0).getStoreid());
			} else {
				req.setAttribute("storeid", "媛�寃� �뾾�쓬");
			}

			// 荑좏룿 紐⑸줉�씠 鍮꾩뼱 �엳吏� �븡�쑝硫� 泥� 踰덉㎏ 荑좏룿 ID瑜� �슂泥� �냽�꽦�뿉 異붽�
			if (!coupon.isEmpty()) {
				req.setAttribute("couponid", coupon.get(0).getCouponid());
			} else {
				req.setAttribute("couponid", "荑좏룿 �뾾�쓬");
			}

		} catch (Exception e) {
			System.err.println("�옣諛붽뎄�땲 �삉�뒗 荑좏룿 紐⑸줉 議고쉶 以� �뿉�윭 諛쒖깮");
			e.printStackTrace();
			return "error/exception";
		}

		return "customer/basket";
	}

	@RequestMapping("/customer/pastOrder.do")
	public String listPastOrder(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<OrderDTO> pOrder = customerMapper.pastOrder(authentication.getName());
		req.setAttribute("porder", pOrder);
		// req.setAttribute("path", fileDir);
		return "customer/pastOrder";
	}

	@RequestMapping("/customer/coupon.do")
	public String cCouponList(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<UserCouponDTO> coupon = customerMapper.CouponList(authentication.getName());
		req.setAttribute("cCoupon", coupon);
		return "customer/coupon";
	}

	@RequestMapping(value = "/customer/viewStore.do")
	public String viewStore(HttpServletRequest req, @RequestParam("storeid") int storeid,
			@RequestParam(value = "isReview", required = false) String isReview) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", authentication.getName());
		params.put("storeid", storeid);
		List<UserCouponDTO> coupon = customerMapper.customerCoupon(params);
		req.setAttribute("cCoupon", coupon);

		StoreDTO dto = customerMapper.viewStore(storeid);
		List<ViewStoreDTO> menuList = customerMapper.viewStoreInfo(storeid);
		Map<String, List<ViewStoreDTO>> menuMap = new LinkedHashMap<>();
		for (ViewStoreDTO menu : menuList) {
			if (!menuMap.containsKey(menu.getJstorename())) {
				menuMap.put(menu.getJstorename(), new ArrayList<ViewStoreDTO>());
			}
			menuMap.get(menu.getJstorename()).add(menu);
		}
		List<ReviewDTO> review = new ArrayList<>();
		review = customerMapper.listReview(storeid);
		if (isReview != null && isReview.equals("ok")) {
			req.setAttribute("isReview", isReview);
		}
		if (review.size() != 0 || review.isEmpty()) {
			req.setAttribute("review", review);
		}
		//
		List<CouponDTO> scoupon = customerMapper.storeCoupon(storeid);
		req.setAttribute("store", dto);
		req.setAttribute("menuMap", menuMap);
		req.setAttribute("storecou", scoupon);
		PropertyReader reader = new PropertyReader();
		String key = reader.getProperty("kakao_key");
		req.setAttribute("key", key);
		return "customer/viewStore";
	}

	@RequestMapping("/customer/storeList.do")
	public String jogiyoStoreList(HttpServletRequest req,
			@RequestParam(value = "cateId", required = false) String cateId) {
		List<StoreDTO> list = new ArrayList<>();
		if (cateId != null) {
			list = customerMapper.storeListByCate(cateId);
		} else {
			list = customerMapper.storeList();
		}
		List<CategoryDTO> list2 = customerMapper.cateList();
		req.setAttribute("cateList", list2);
		req.setAttribute("storeList", list);
		return "customer/jogiyoStoreList";
	}

//	@RequestMapping(value = "/customer/basketList.do", method = RequestMethod.POST)
//	public String OrderBasketList(HttpServletRequest req, @RequestParam("sub") String menuid,
//			@RequestParam("sub2") String storename) {
//		List<MenuDTO> list = customerMapper.basketList(menuid);
//		req.setAttribute("basket", list);
//		req.setAttribute("storename", storename);
//		return "customer/basket";
//	}

	@ResponseBody
	@RequestMapping(value = "customer/listCate.ajax", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	public String listAccount(HttpServletRequest req, @RequestParam("sel") String sel) {
		List<StoreDTO> catelist = customerMapper.cateStoreList(sel);
		List<CategoryDTO> list2 = customerMapper.cateList();
		if (catelist == null) {
			catelist = new ArrayList<>();
		}
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		Iterator<StoreDTO> it = catelist.iterator();
		while (it.hasNext()) {
			StoreDTO dto = it.next();
			JsonObject object = new JsonObject();
			object.addProperty("storeid", dto.getStoreid());
			object.addProperty("storename", dto.getStorename());
			object.addProperty("cateid", dto.getCateid());
			object.addProperty("storecontent", dto.getStorecontent());
			object.addProperty("id", dto.getId());
			object.addProperty("img", dto.getImg());
			object.addProperty("couponid", dto.getCouponid());
			object.addProperty("address", dto.getAddress());
			// object.addProperty("file", dto.getFile());
			object.addProperty("detailaddress", dto.getDetailaddress());
			object.addProperty("extraaddress", dto.getExtraaddress());
			object.addProperty("postcode", dto.getPostcode());
			object.addProperty("catename", dto.getCatename());
			// 0703�쑄�옣�샇�닔�젙
			object.addProperty("row_count", dto.getRow_count());
			object.addProperty("reply_count", dto.getReply_count());
			object.addProperty("rev_avg", dto.getRev_avg());
			jArray.add(object);
		}
		String json = gson.toJson(jArray);
		req.setAttribute("cateList", list2);
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "customer/checkPasswd.ajax", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	public String ChekcPass(@RequestParam("id") String id, @RequestParam("passwd") String passwd) {
		LoginDTO dto = new LoginDTO();
		dto.setId(id);
		dto.setPasswd(passwd);
		if (loginMapper.isPass(dto)) {
			return "ok";
		} else {
			return "nok";
		}
	}

	@ResponseBody
	@RequestMapping(value = "customer/insertBasket.ajax", method = RequestMethod.POST, consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insertBasket(@RequestBody BasketDTO[] baksets) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		int res = 0;
		int sid = customerMapper.checkBasket(authentication.getName());
		System.out.println(sid);
		System.out.println(baksets[0].getStoreid());
		if (sid == 0 || sid == baksets[0].getStoreid()) {
			for (BasketDTO basket : baksets) {
				basket.setId(authentication.getName());
				basket.setTotprice(basket.getTotprice() * basket.getQty());
				res += customerMapper.insertBasket(basket);
			}
			String msg = "�옣諛붽뎄�땲�뿉 臾쇳뭹�쓣 " + res + "媛� 留뚰겮 �떞�븯�뒿�땲�떎. \n�옣諛붽뎄�땲 �럹�씠吏�濡� �씠�룞�븯�떆寃좎뒿�땲源�?";
			return ResponseEntity.ok(msg);
		} else {
			String msg = "�씠誘� �옣諛붽뎄�땲�뿉 �떎瑜� 媛�寃� �긽�뭹�씠 �떞寃⑥엳�뒿�땲�떎.";
			return ResponseEntity.ok(msg);
		}
	}

	@RequestMapping(value = "customer/insertReview.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ModelAndView insertReview(HttpServletRequest req, ReviewDTO dto) {
		UploadFile uploadFile = new UploadFile();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView mav = new ModelAndView();
		int res = 0;
		if (uploadFile.uploadFile(dto.getFile())) {
			dto.setImg(uploadFile.getFullName());
			dto.setId(authentication.getName());
			res = customerMapper.insertReview(dto);
		}
		if (res > 0) {
			mav.addObject("msg", "由щ럭�옉�꽦 �셿猷�");
			mav.addObject("url", "/customer/viewStore.do?storeid=" + dto.getStoreid());
			mav.setViewName("message");
		} else {
			mav.addObject("msg", "由щ럭 �옉�꽦 �떎�뙣");
			mav.addObject("url", "/customer/viewStore.do?storeid=" + dto.getStoreid());
			mav.setViewName("message");

		}
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "customer/addOrder.ajax", method = RequestMethod.POST, consumes = "application/json")
	public String addOrder(@RequestBody Map<String, Object> itemsObject) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		try {
			// itemsObject�뿉�꽌 �뜲�씠�꽣 異붿텧 諛� 二쇰Ц �뜲�씠�꽣濡� 蹂��솚
			String menuname = "";
			DeliveryDTO delivery = new DeliveryDTO();
			for (Map.Entry<String, Object> entry : itemsObject.entrySet()) {
				Map<String, Object> item = (Map<String, Object>) entry.getValue();
				menuname += entry.getKey() + " ";
				OrderDTO order = new OrderDTO();
				order.setId(authentication.getName());
				order.setIndate(String.valueOf(System.currentTimeMillis())); // �쁽�옱 �떆媛꾩쑝濡� �꽕�젙

				// 媛믪씠 臾몄옄�뿴�씤吏� �솗�씤�븯怨� 蹂��솚
				int quantity = customerMapper.convertToInt(item.get("quantity"));
				int total = customerMapper.convertToInt(item.get("total"));
				int menuID = customerMapper.convertToInt(item.get("menuID"));
				int storeid = customerMapper.convertToInt(item.get("storeid"));
				int cateid = customerMapper.convertToInt(item.get("cateid"));
				String address = (String) item.get("address");
				order.setQty(quantity);
				order.setTotprice(total);
				order.setStoreid(storeid); // �떎�젣 storeID濡� �꽕�젙
				order.setCateid(cateid); // �떎�젣 cateID濡� �꽕�젙
				order.setMenuid(menuID);
				delivery.setDestiaddress(address);
				delivery.setStoreid(storeid);
				customerMapper.addOrder(order);
			}
			delivery.setMenuname(menuname);
			delivery.setId(authentication.getName());
			customerMapper.insertDelivery(delivery);
			int seq = customerMapper.seqDelivery();
			customerMapper.deleteCartItems(authentication.getName());
			return Integer.toString(seq - 1);
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}

	@RequestMapping("/customer/viewDelivery.do")
	public String viewDelivery(@RequestParam("deliveryid") int deliveryid, HttpServletRequest req) {
		PropertyReader reader = new PropertyReader();
		String key = reader.getProperty("kakao_key");
		req.setAttribute("key", key);
		DeliveryDTO dto = customerMapper.viewDelivery(deliveryid);
		req.setAttribute("delivery", dto);
		return "customer/deliveryStatus";
	}

	@RequestMapping("/customer/notice.do")
	public String noticeList(HttpServletRequest req, @RequestParam(value = "page", defaultValue = "1") int page) {

		int itemsPerPage = 7;
		int startIndex = (page - 1) * itemsPerPage;
		int endIndex = page * itemsPerPage;

		Map<String, Object> params = new HashMap<>();
		params.put("startIndex", startIndex);
		params.put("endIndex", endIndex);

		List<NoticeDTO> rList = customerMapper.getNotice(params);
		for (NoticeDTO dto : rList) {
			System.out.println(dto.getSubject());
		}
		int totalCount = customerMapper.getNoticeCount();
		int pageCount = (int) Math.ceil((double) totalCount / itemsPerPage);
		req.setAttribute("rList", rList);
		req.setAttribute("pageCount", pageCount);
		req.setAttribute("currentPage", page);
		return "customer/listNotice";
	}

	@RequestMapping("/customer/viewNotice.do")
	public String viewNotice(HttpServletRequest req, @RequestParam("notiid") int notiid) {
		NoticeDTO dto = customerMapper.viewNotice(notiid);
		req.setAttribute("dto", dto);
		return "customer/viewNotice";
	}

	@RequestMapping("customer/listDelivery.do")
	public String listDelivery(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<DeliveryDTO> dlist = customerMapper.listDelivery(authentication.getName());
		req.setAttribute("dlist", dlist);
		return "customer/listDelivery";
	}

	// �옣諛붽뎄�땲 �궘�젣
	@RequestMapping(value = "/customer/BasketDelete.do", method = RequestMethod.POST)
	public ModelAndView BasketDelete(HttpServletRequest req, @RequestParam("basketid") String basketid) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		int list = customerMapper.basketDelete(basketid);
		ModelAndView mav = new ModelAndView();
		if (list > 0) {
			mav.addObject("msg", "�옣諛붽뎄�땲�뿉�꽌 �궘�젣 �꽦怨�");
			mav.addObject("url", "/customer/basket.do");
			mav.setViewName("message");
		} else {
			mav.addObject("msg", "�옣諛붽뎄�땲�뿉�꽌 �궘�젣 �떎�뙣");
			mav.addObject("url", "/customer/basket.do");
			mav.setViewName("message");
		}
		return mav;
	}
	// 怨쇨굅 二쇰Ц�궡�뿭 �궘�젣

	@RequestMapping(value = "/customer/orderDelete.do", method = RequestMethod.POST)
	public ModelAndView OrderDelete(HttpServletRequest req, @RequestParam("orderid") String orderid) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		int list = customerMapper.orderDelete(orderid);
		ModelAndView mav = new ModelAndView();
		if (list > 0) {
			mav.addObject("msg", "二쇰Ц�궡�뿭 �궘�젣 �꽦怨�");
			mav.addObject("url", "/customer/pastOrder.do");
			mav.setViewName("message");
		} else {
			mav.addObject("msg", "二쇰Ц�궡�뿭 �궘�젣 �떎�뙣");
			mav.addObject("url", "/customer/pastOrder.do");
			mav.setViewName("message");
		}
		return mav;
	}

	// 諛붾줈寃곗젣寃쎈줈
	@RequestMapping("customer/directPay.do")
	public String directPayPage(Model model) {
		// 寃곗젣 �럹�씠吏�濡� �씠�룞
		return "customer/directPay";
	}

	@ResponseBody
	@RequestMapping(value = "customer/directOrder.ajax", method = RequestMethod.POST, consumes = "application/json")
	public String directOrder(@RequestBody List<OrderDTO> orderList) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		DeliveryDTO delivery = new DeliveryDTO();
		String menuname = "";
		for (OrderDTO dto : orderList) {
			dto.setId(authentication.getName());
			menuname += dto.getMenuname() + " ";
			delivery.setDestiaddress(dto.getAddress());
			delivery.setStoreid(dto.getStoreid());
		}
		delivery.setMenuname(menuname);
		delivery.setId(authentication.getName());
		customerMapper.insertDelivery(delivery);
		int seq = customerMapper.seqDelivery();
		try {
			customerMapper.directOrder(orderList);
			return Integer.toString(seq - 1);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

	}

	// 媛�寃뚯퓼�룿諛쏄린
	@ResponseBody
	@RequestMapping(value = "customer/getCoupon.do", method = RequestMethod.POST)
	public Map<String, String> getCoupon(@RequestParam int couponid) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Map<String, String> response = new HashMap<>();
		String userId = authentication.getName();
		try {
			// �뙆�씪誘명꽣 以�鍮�
			Map<String, Object> params = new HashMap<>();
			params.put("couponid", couponid);
			params.put("id", userId);

			// 荑좏룿�씠 �씠誘� 議댁옱�븯�뒗吏� �솗�씤
			int count = customerMapper.checkCoupon(params);
			if (count > 0) {
				response.put("message", "�씠誘� �씠 荑좏룿�쓣 諛쏆븯�뒿�땲�떎.");
				return response;
			}

			// 荑좏룿 �궫�엯 �꽌鍮꾩뒪 �샇異�
			customerMapper.getCoupon(params);

			response.put("message", "荑좏룿�쓣 諛쏆븯�뒿�땲�떎.");
		} catch (Exception e) {
			e.printStackTrace();
			response.put("message", "荑좏룿�쓣 諛쏆� 紐삵뻽�뒿�땲�떎." + e);
		}

		return response;
	}

	@ResponseBody
	@RequestMapping(value = "customer/updateBasketQty.ajax", method = RequestMethod.POST)
	public String updateBasketQty(@RequestParam("menuid") int menuid, @RequestParam("qty") int qty) {
		// �뙆�씪誘명꽣 以�鍮�
		Map<String, Object> params = new HashMap<>();
		params.put("menuid", menuid);
		params.put("qty", qty);
		System.out.println("!!!!!!!");

		// �닔�웾 �뾽�뜲�씠�듃 留ㅽ띁 �샇異�
		int result = customerMapper.updateBasketQty(params);

		// 寃곌낵 諛섑솚
		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}

	}

	// �궗�슜 荑좏룿 �궘�젣 湲곕뒫
	@ResponseBody
	@RequestMapping(value = "customer/useCoupon.ajax", method = RequestMethod.POST, consumes = "application/json")
	public void deleteUserCoupon(@RequestBody Map<String, Integer> payload) {
		if (payload.containsKey("usercid")) {
			int usercid = payload.get("usercid");
			System.out.println("荑좏룿�븘�씠�뵒 : " + usercid);
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("usercid", usercid);

			customerMapper.userCouponDel(paramMap);
		} else {
			System.out.println("usercid �뙆�씪誘명꽣媛� �븘�슂�빀�땲�떎.");
		}
	}

//  @ResponseBody
//  @RequestMapping(value = "/customer/kakaopay.ajax", method = RequestMethod.POST)
//  public KakaoPayReadyDTO KakaoPay(@RequestParam Map<String,Object> params) {
//      System.out.println("Received params: " + params);
//        KakaoPayReadyDTO res = customerMapper.kakaoPay(params);
//     
//  
//     return res;
//  }
//  @ResponseBody
//   @RequestMapping(value = "/api/kakaopay", method = RequestMethod.POST)
//   public String kakaoPay(@RequestBody Map<String, Object> params) {
//       String url = "https://open-api.kakaopay.com/v1/payment/ready";
//
//       HttpHeaders headers = new HttpHeaders();
//       headers.set("Content-Type", "application/json");
//       headers.set("Authorization", "KakaoAK SECRET_KEY_DEV9021211DB0E046ECE7E5FC9701CB1D019AE6B");
//
//       HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(params, headers);
//       RestTemplate restTemplate = new RestTemplate();
//       ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, String.class);
//
//       return response.getBody();
//   }

//  @ResponseBody
//   @RequestMapping(value = "/api/kakaopay", method = RequestMethod.POST)
//  public ResponseEntity<?> kakaoPay(@RequestBody Map<String, Object> data) {
//     
//       try {
//           RestTemplate restTemplate = new RestTemplate();
//           HttpHeaders headers = new HttpHeaders();
//           headers.setContentType(MediaType.APPLICATION_JSON);
//           headers.set("Authorization",  "SECRET_KEY DEV9021211DB0E046ECE7E5FC9701CB1D019AE6B"); // Admin �궎 �엯�젰
//           
//           Map<String, Object> params = new HashMap<>();
//           params.put("cid", "TC0ONETIME");
//           params.put("partner_order_id", "partner_order_id");
//           params.put("partner_user_id", "partner_user_id");
//           params.put("item_name", data.get("item_name"));
//           params.put("quantity", data.get("quantity"));
//           params.put("total_amount", data.get("total_amount"));
//           params.put("vat_amount", data.get("tax_free_amount"));
//           params.put("tax_free_amount", "0");
//           params.put("approval_url", "http://localhost:7080/kakaoPaySuccess");
//           params.put("cancel_url", "http://localhost:7080/kakaoPayCancel");
//           params.put("fail_url", "http://localhost:7080/kakaoPaySuccessFail");
//           HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);
//           ResponseEntity<Map> response = restTemplate.exchange(
//               "https://open-api.kakaopay.com/online/v1/payment/ready",
//               HttpMethod.POST,
//               entity,
//               Map.class
//           );
//
//           return ResponseEntity.ok(response.getBody());
//       } catch (Exception e) {
//           e.printStackTrace();
//           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("移댁뭅�삤�럹�씠 �슂泥� �떎�뙣");
//       }
//   }
//
//  @GetMapping("/kakaoPaySuccess")
//   public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model) {
//     Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//     List<BasketDTO> list = customerMapper.basket(authentication.getName());
//     //List<OrderDTO> order = customerMapper.addOrder(); 
//     
//       return "redirect:/customer/basket.do";
//   }
//  
//  
}