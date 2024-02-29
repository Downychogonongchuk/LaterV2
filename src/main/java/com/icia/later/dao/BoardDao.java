package com.icia.later.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.icia.later.dto.BoardDto;
import com.icia.later.dto.MemberDto;

public interface BoardDao {
	
	// 게시글 등록하기
	void insertBoard(BoardDto board);
		
	// 게시글 수정
	void updateBoard(BoardDto board);
	
	//수정할 업체 정보 가져오기
	List<BoardDto> getBoardList();
	
	// 업체 삭제
	void deleteBoard(Integer boardId);

	// 게시글 정보 상세보기
	BoardDto selectBoard(Integer boardId);

	// 로그인
	MemberDto login(BoardDto board);

	// ByMemberId 페이징  // 내가 신청한 글 목록 
	int getTotalgetBoardByMemberId(String memberId);

	// 모집글 목록 보기 // 내가 모집한 글 목록
	List<BoardDto> getBoardListBycustomerId(@Param("pMap") Map<String, Integer> pMap, Integer customerId);

	// 모집글 수 구하기
	@Select("SELECT count(*) FROM board")
	int cntBoard();



	

	




}
