package com.icia.later;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.icia.later.dto.CustomerDto;
import com.icia.later.service.CustomerService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CustomerController {
		@Autowired CustomerService cServ;
	
		
	@GetMapping("cSignIn")
	public String cSignIn() {
		log.info("cSignIn()");
		
		return "cSignIn";
	}
	
	@PostMapping("cSignInProc")
	public String cSignInProc(@RequestPart List<MultipartFile> files, 
			CustomerDto customer,
			HttpSession session,
			RedirectAttributes rttr) {
		log.info("cSignInProc()");
				
		String view = cServ.insertCustomer(files, customer, session, rttr);
		
		return view;
	}
	
	@PostMapping("cEmailCheck")
	@ResponseBody
	public String cEmailCheck(String customerEmailCheck) {
	log.info("cEmailCheck()" + customerEmailCheck);
	String res = cServ.cEmailCheck(customerEmailCheck); 
	
		return res;
	}
	
	//사업자 로그인 페이지
		@GetMapping("cLogin")
		public String cLogin() {
			log.info("cLogin()");

			return "cLogin";
		}
	
	// 로그인 처리 메서드
		@PostMapping("cLoginProc")
		public String cLoginProc(CustomerDto customer,
								HttpSession session,
								RedirectAttributes rttr) {
			log.info("cLoginProc()");
			System.out.println(customer);
			
			String view = cServ.cLogin(customer, session, rttr);
			return view;
		}
		
		//사업자회원 아이디찾기
				@GetMapping("cFindById")
				public String cFindById() {
					log.info("cFindById()");
					
					return "cFindById";
				}
				
				//사업자 아이디찾기 처리
				@PostMapping("cFindByIdProc")
				public String cFindByIdProc(CustomerDto customer, Model model, RedirectAttributes rttr) {
					log.info("cFindById()");
					String view = cServ.cFindById(customer, model, rttr);

					return view;
				}
		
				//사업자회원 비번찾기
				@GetMapping("cFindByPass")
				public String cFindByPass() {
					log.info("cFindByPass()");
					
					return "cFindByPass";
				}
				
				//사업자회원 비밀번호찾기 가입정보 확인 메서드
				@PostMapping("cFindByPassProc")
				public String cFindByPassProc(CustomerDto customer,
												Model model,
												RedirectAttributes rttr) {
					log.info("cFindByPassProc()");
					String view = cServ.cFindByPass(customer,model,rttr);
					
					return view;
				}
				
				//비밀번호 찾기 -> 비밀번호 변경페이지
				@PostMapping("cPassUpdate")
				public String cPassUpdate() {
					log.info("cPassUpdate()");
					
					return "cPassUpdate";
				}
				
				//비밀번호 변경 처리 메서드
				@PostMapping("cUpdatePassProc")
				public String cUpdatePassProc(CustomerDto customer,
											RedirectAttributes rttr) {
					log.info("cUpdatePassProc()");
					
					String view = cServ.cUpdatePassProc(customer,rttr);
					return view;
				}
		
	// 사업자 회원정보 수정페이지 이동
		@GetMapping("cUpdate")
		public String cUpdate(Model model,HttpSession session) {
			log.info("cUpdate()");
			
			CustomerDto logInInfo = (CustomerDto) session.getAttribute("cLogin");
			
			
			if (logInInfo != null && session.getAttribute("cLogin") != null) {
		        // 로그인한 회원 정보를 모델에 추가하여 JSP로 전달
		        model.addAttribute("cLogInInfo", logInInfo);
		        	        	        	        
		}
			return "cUpdate";
	}
		
	// 사업자 회원정보 수정 처리
		@PostMapping("cUpdateProc")
		public String cUpdateProc(@RequestPart List<MultipartFile> files, 
				CustomerDto customer,
				HttpSession session,
				RedirectAttributes rttr) {
			log.info("cUpdateProc()");
			System.out.println("cUpdate에서 넘어온 dto"+customer);
			String view = cServ.customerUpdate(files, customer, session, rttr);
			
			return view;
		}
		
	// 사업자 회원 정보 탈퇴
		// 일반회원 탈퇴
		@GetMapping("cDelete")
		public String cDelete(Integer customerId,HttpSession session,RedirectAttributes rttr) {
			log.info("cDelete()");
			
			
			String view = cServ.cDelete(customerId,session,rttr);
			if (session != null && session.getAttribute("cLogin") != null) {
		        // 탈퇴 후 세션에 저장되어있는 값 삭제
		        session.invalidate();
		    }

			return view;
		}
		
		
}