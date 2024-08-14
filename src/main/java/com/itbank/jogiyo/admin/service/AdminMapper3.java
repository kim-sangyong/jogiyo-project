package com.itbank.jogiyo.admin.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.NoticeDTO;

@Service
public class AdminMapper3 {
	@Autowired
	private SqlSession sqlSession;
	
	public int insertNotice(NoticeDTO dto) {
		int res = sqlSession.insert("notice.insertNotice", dto);
		return res;
	}
	public int deleteNotice(int notiid) {
		int res = sqlSession.delete("notice.deleteNotice", notiid);
		return res;
	}
	public NoticeDTO viewNotice(int notiid) {
		return sqlSession.selectOne("notice.viewNotice", notiid);
	}
	public int editNotice(NoticeDTO dto) {
		int res = sqlSession.update("notice.editNotice", dto);
		return res;
	}

}