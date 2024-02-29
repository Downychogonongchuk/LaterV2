package com.icia.later.dao;

import org.springframework.ui.Model;

import com.icia.later.dto.MemberDto;

public interface MemberDao {
	
		// 회원가입
		void insertMember(MemberDto member);
		
		// 로그인
		MemberDto login(MemberDto member);
	
		// 회원정보 상세 가져오기
		MemberDto selectMember(Integer memberId);
		
		// 업데이트
		void updateMember(MemberDto member);
		
		// 삭제
		void deleteMember(Integer memberId);
		
		// 이메일 중복체크
		int checkDuplicateId(String memberEmailCheck);
		
		// 이메일 찾기
		MemberDto FindById(MemberDto member);
		
		// 비밀번호 찾기
		MemberDto FindByPass(MemberDto member);
		
		// 비밀번호 업데이트
		void mUpdatePassProc(MemberDto member);
}