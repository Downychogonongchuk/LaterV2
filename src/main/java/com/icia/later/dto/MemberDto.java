package com.icia.later.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@Alias("member")
public class MemberDto {
	private int memberId;
	private String memberName;
	private String memberEmail;
	private String memberPass;
	private String memberPhone;
	private String snsFollower;
	private String snsLink;
	private String memberProfile;
	private String snsKind;

}