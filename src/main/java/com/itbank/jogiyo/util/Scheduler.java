package com.itbank.jogiyo.util;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class Scheduler {
	@Autowired
	private SqlSession sqlSession;
	
//	@Scheduled(cron = "0 0/1 * * * ?") 매분마다 실행
//	@Scheduled(cron = "0 0 2 * * ?")		//매일 새벽 2시마다 실행
//    public void autoInsert() {
//		System.out.println("스케줄러 실행");
//        sqlSession.insert("login.test");
//    }
	@Scheduled(cron = "0 0/1 * * * ?")
	public void updateDelivery() {
		sqlSession.update("delivery.deliveryStatus");
	}
	@Scheduled(cron = "0 0 * * * ?")
	public void autoRunStore() {
		sqlSession.update("store.autorunStore");
	}
}
