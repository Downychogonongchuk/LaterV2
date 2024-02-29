package com.icia.later.dao;

import com.icia.later.dto.CustomerDto;


public interface CustomerDao {
	
	// 사업자 회원가입
		void insertCustomer(CustomerDto customer);
		
		// 사업자 로그인
		CustomerDto login(CustomerDto customer);
		
		// 업데이트
		void updateCustomer(CustomerDto customer);
		
		// 사업자 회원 탈퇴
		void deleteCustomer(Integer customerId);
		
		// 이메일 중복체크
		int checkDuplicateId(String customerEmailCheck);

		// 사업자 이메일 찾기
		CustomerDto FindById(CustomerDto customer);
		
		// 비밀번호 찾기
		CustomerDto FindByPass(CustomerDto customer);
				
		// 비밀번호 업데이트
		void cUpdatePassProc(CustomerDto customer);

	}