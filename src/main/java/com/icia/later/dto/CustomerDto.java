package com.icia.later.dto;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("customer")
public class CustomerDto {
	private int customerId;
	private String customerName;
	private String customerEmail;
	private String customerPass;
	private String customerNum;
	private String companyName;
	private String companyAddress;
	private String sectors;
	private String customerProfile;
	
	
}