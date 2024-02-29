package com.icia.later.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.icia.later.dto.BoardDto;
import com.icia.later.dto.ReservationDto;

public interface ReservationDao {

	// 체험단 신청 정보 저장
	void insertReservation(ReservationDto reserv);

	// 예약 목록 가져오기
	List<BoardDto> getBoardListBymemberId(@Param("pMap") Map<String, Integer> pMap);

	// 신청한 업체 수 구하기
	@Select("SELECT count(*) FROM board")
	int cntBoard();

	// 에약 유무 확인 데이터 가져오기
	ReservationDto selectRev(@Param("pMap") Map<String, Integer> pMap);
	
	
}