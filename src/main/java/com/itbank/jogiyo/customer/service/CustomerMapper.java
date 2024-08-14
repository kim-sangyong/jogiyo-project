package com.itbank.jogiyo.customer.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

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

@Service
public class CustomerMapper {
	@Autowired
	private SqlSession sqlSession;
	private final PasswordEncoder bcryptPasswordEncoder;

	public CustomerMapper(PasswordEncoder bcryptPasswordEncoder) {
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
	}

	public LoginDTO cMypageList(String id) {
		return sqlSession.selectOne("customer.cMypageList", id);
	}

	public int updateCustomer(LoginDTO dto) {
		dto.setPasswd(bcryptPasswordEncoder.encode(dto.getPasswd()));
		return sqlSession.update("customer.updateCustomer", dto);

	}

	public int secessionCustomer(String id) {
		return sqlSession.delete("customer.secessionCustomer", id);
	}

	public List<OrderDTO> pastOrder(String id) {
		return sqlSession.selectList("customer.pastOrderList", id);
	}

	public List<UserCouponDTO> customerCoupon(Map<String, Object> params) {
		return sqlSession.selectList("customer.customerCoupon", params);
	}

	public List<UserCouponDTO> CouponList(String id) {
		return sqlSession.selectList("customer.CouponList", id);
	}

	public StoreDTO viewStore(int storeid) {
		return sqlSession.selectOne("customer.viewStore", storeid);
	}

	public List<ViewStoreDTO> viewStoreInfo(int storeid) {
		return sqlSession.selectList("customer.viewStoreInfo", storeid);
	}

	public List<StoreDTO> storeList() {
		return sqlSession.selectList("customer.storeList");
	}

	public List<StoreDTO> storeListByCate(String cateId) {
		return sqlSession.selectList("customer.storeListByCate", cateId);
	}

	public List<CategoryDTO> cateList() {
		return sqlSession.selectList("customer.cateList");
	}

	public List<StoreDTO> cateStoreList(String sel) {
		return sqlSession.selectList("customer.cateStoreList", sel);
	}

	public List<MenuDTO> basketList(String menuid) {
		String str = menuid;
		String[] arr = str.split(",");
		List<Integer> menuIds = new ArrayList<>();
		for (String cut : arr) {
			System.out.println(cut.trim());
			menuIds.add(Integer.parseInt(cut));
		}
		// MyBatis 쿼리에 List<Integer>를 전달하여 결과 반환
		return sqlSession.selectList("customer.basketList", menuIds);
	}

	public List<BasketDTO> basket(String id) {
		return sqlSession.selectList("customer.basket", id);
	}

	public int insertBasket(BasketDTO dto) {
		return sqlSession.insert("customer.insertBasket", dto);
	}

	public List<ReviewDTO> listReview(int storeid) {
		return sqlSession.selectList("customer.listReview", storeid);
	}

	public int insertReview(ReviewDTO dto) {
		return sqlSession.insert("customer.insertReview", dto);
	}

	public int addOrder(OrderDTO order) {
		return sqlSession.insert("customer.addOrder", order);
	}

	public int deleteCartItems(String userId) {
		return sqlSession.delete("customer.deleteBasket", userId); // 적절한 Mapper 메서드 호출 (예시로 표시)
	}

	public int convertToInt(Object value) {
		if (value instanceof String) {
			return Integer.parseInt((String) value);
		} else if (value instanceof Double) {
			return ((Double) value).intValue();
		} else if (value instanceof Integer) {
			return (Integer) value;
		} else {
			throw new IllegalArgumentException("Unexpected value type: " + value.getClass().getName());
		}
	}

	public List<NoticeDTO> listNotice() {
		List<NoticeDTO> list = sqlSession.selectList("notice.listNotice");
		return list;
	}

	public NoticeDTO viewNotice(int notiid) {
		return sqlSession.selectOne("notice.viewNotice", notiid);
	}

	public int insertDelivery(DeliveryDTO dto) {
		return sqlSession.insert("delivery.insertDelivery", dto);
	}

	public DeliveryDTO viewDelivery(int deliveryid) {
		return sqlSession.selectOne("delivery.viewDelivery", deliveryid);
	}

	public int seqDelivery() {
		return sqlSession.selectOne("delivery.seqDelivery");
	}

	public List<DeliveryDTO> listDelivery(String id) {
		return sqlSession.selectList("delivery.listDelivery", id);
	}

	public int basketDelete(String basketid) {
		return sqlSession.delete("customer.basketDelete", basketid);
	}

	public int orderDelete(String orderid) {
		return sqlSession.delete("customer.orderDelete", orderid);
	}

	public int directOrder(List<OrderDTO> orderList) {
		return sqlSession.insert("customer.directOrder", orderList);
	}

	public int checkBasket(String id) {
		List<String> sid = sqlSession.selectList("customer.checkBasket", id);
		if (sid.size() == 0) {
			return 0;
		} else {
			return Integer.parseInt(sid.get(0));
		}
	}

	public List<CouponDTO> storeCoupon(int storeid) {
		return sqlSession.selectList("customer.storecoupon", storeid);
	}

	public int checkCoupon(Map<String, Object> params) {
		return sqlSession.selectOne("customer.checkCoupon", params);
	}

	public int getCoupon(Map<String, Object> params) {
		return sqlSession.insert("customer.getCoupon", params);
	}

	public int updateBasketQty(Map<String, Object> params) {
		return sqlSession.update("customer.updateBasketQty", params);
	}

	public int userCouponDel(Map<String, Object> paramMap) {
		return sqlSession.delete("customer.userCouponDel", paramMap);
	}

	public List<NoticeDTO> getNotice(Map<String, Object> params) {
		return sqlSession.selectList("notice.getNotice", params);
	}

	public int getNoticeCount() {
		return sqlSession.selectOne("notice.getNoticeCount");
	}

}