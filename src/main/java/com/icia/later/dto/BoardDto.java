package com.icia.later.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

		
@Data
@Alias("board")
public class BoardDto {	
		 private int boardId;  
		 private String category; // 카테고리
		 private String companyName; // 업체명
		 private String periodStart; // 모집 시작 
		 private String periodEnd;  // 모집 마감
		 private String personnel;  // 모집 인원 
		 private int price; // 가격
		 private String provideType; // 제공타입
		 private String detail;  // 상세설명 
		 private String checkInfo;  // 체크사항
		 private String boardFile; // 게시글 업체사진 
		 private int customerId; //  사업자 아이디  // 추가 dao controller
}
