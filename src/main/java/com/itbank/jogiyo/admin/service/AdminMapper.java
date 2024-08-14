package com.itbank.jogiyo.admin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.CategoryDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.NoticeDTO;
import com.itbank.jogiyo.dto.OrderDTO;

@Service
public class AdminMapper {
	@Autowired
	private SqlSession sqlSession;

	public int inputCate(CategoryDTO dto) {
		int res = sqlSession.insert("category.insertCate", dto);
		return res;
	}

	public List<CategoryDTO> listCate() {
		List<CategoryDTO> list = sqlSession.selectList("category.listCate");
		return list;
	}

	public List<OrderDTO> dateOrder(String cal1, String cal2) {
		Map<String, String> params = new HashMap<>();
		params.put("cal1", cal1);
		params.put("cal2", cal2);
		List<OrderDTO> list = sqlSession.selectList("order.dateOrder", params);
		return list;
	}
	
	public List<NoticeDTO> listNotice(){
		List<NoticeDTO> list = sqlSession.selectList("notice.listNotice");
		return list;
	}
	public List<LoginDTO> listAcc(String sel){
		List<LoginDTO> list = sqlSession.selectList("login.listAccountGrade", sel);
		return list;
	}
	
	public int deleteUser(String id) {
		return sqlSession.delete("login.deleteUser", id);
	}
	public NoticeDTO indexNotice() {
		return sqlSession.selectOne("notice.indexNotice");
	}
	public boolean countNotice() {
		return sqlSession.selectOne("notice.countNotice");
	}
	// 점주 회원가입 목록
	public List<LoginDTO> ownerList() {
      List<LoginDTO> ownerList = sqlSession.selectList("login.ownerList");
      return ownerList;
	}
	   
	public int ownerListOk(String ownerId){
      int res = sqlSession.update("login.ownerListOk", ownerId);
      return res;
	}
}
