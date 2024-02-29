package com.icia.later.dto;

import java.sql.Date;
import java.time.DateTimeException;
import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@Alias("reserv")
public class ReservationDto {
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private int reservationId;
	private LocalDateTime reservationTime;
	private String status;
	private int memberId;
	private int boardId;
	
}
