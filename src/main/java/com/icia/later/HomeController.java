package com.icia.later;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.later.dto.CustomerDto;
import com.icia.later.dto.MemberDto;
import com.icia.later.service.MemberService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class HomeController {
	@Autowired
	private MemberService mServ;
			
	//메인페이지
		@GetMapping("/")
		public String home(Model model,HttpSession session) {
			log.info("home()");

			MemberDto logInInfo = (MemberDto) session.getAttribute("mLogin");
			
			if (logInInfo != null && session.getAttribute("mLogin") != null) {
		        // 로그인한 회원 정보를 모델에 추가하여 JSP로 전달
		        model.addAttribute("mLogInInfo", logInInfo);
		        System.out.println(logInInfo);
			}
			
			CustomerDto logInInfo1 = (CustomerDto) session.getAttribute("cLogin");
			
			
			if (logInInfo1 != null && session.getAttribute("cLogin") != null) {
		        // 로그인한 회원 정보를 모델에 추가하여 JSP로 전달
		        model.addAttribute("cLogInInfo", logInInfo1);
		        	        	        	        
		}
			return "home";
		}
		
	// 마이페이지 홈 이동
		@GetMapping("myPage")
		public String myPage(Model model,HttpSession session) {
			log.info("myPage()");
			
			MemberDto logInInfo = (MemberDto) session.getAttribute("mLogin");
			
			if (logInInfo != null && session.getAttribute("mLogin") != null) {
		        // 로그인한 회원 정보를 모델에 추가하여 JSP로 전달
		        model.addAttribute("mLogInInfo", logInInfo);
		        System.out.println(logInInfo);
			}
			return "myPage";
		}
	
	
	// 회원가입 유형선택페이지
	@GetMapping("signSelect")
	public String signSelect() {
		log.info("signSelect()");
		
		return "signSelect";
	}
	
	// 일반회원 가입페이지 이동
	@GetMapping("mSignIn")
	public String mSignIn() {
		log.info("mSignIn()");
		
		return "mSignIn";
	}
	
	// 일반회원 이메일 중복체크
	@PostMapping("mEmailCheck")
	@ResponseBody
	public String mEmailCheck(String memberEmailCheck) {
	log.info("mEmailCheck()" + memberEmailCheck);
	String res = mServ.mEmailCheck(memberEmailCheck); 
	
		return res;
	}
	
	// 회원가입 처리 메서드
	@PostMapping("mSignInProc")
	public String mSignInProc(@RequestPart List<MultipartFile> files, 
			MemberDto member,
			HttpSession session,
			RedirectAttributes rttr) {
		log.info("mSignInProc()");
				
		String view = mServ.insertMember(files, member, session, rttr);
		
		return view;
		}
	
	// 로그인선택 페이지 이동
	@GetMapping("loginSelect")
	public String loginSelect() {
		log.info("login()");

		return "loginSelect";
	}
	
	//일반 로그인 페이지
	@GetMapping("mLogin")
	public String mLogin() {
		log.info("mLogin()");

		return "mLogin";
	}
	
	
	// 일반회원 로그인 처리 메서드
	@PostMapping("mLoginProc")
	public String mLoginProc(MemberDto member,
							HttpSession session,
							RedirectAttributes rttr) {
		log.info("mLoginProc()");
		System.out.println(member);
		
		String view = mServ.mLogin(member, session, rttr);
		return view;
		
	}
	
	//일반회원 아이디찾기
	@GetMapping("mFindById")
	public String mFindById() {
		log.info("mFindById()");
		
		return "mFindById";
	}
	
	//일반회원 아이디찾기 처리 메서드
	@PostMapping("mFindByIdProc")
	public String mFindByIdProc(MemberDto member,
								Model model,
								RedirectAttributes rttr) {
		log.info("mFindById()");
		String view = mServ.mFindById(member,model,rttr);
		
		return view;
	}
	
	//일반회원 비번찾기 페이지
		@GetMapping("mFindByPass")
		public String mFindByPass() {
			log.info("mFindByPass()");
			
			return "mFindByPass";
		}
		
		//일반회원 비밀번호찾기 가입정보 확인 메서드
		@PostMapping("mFindByPassProc")
		public String mFindByPassProc(MemberDto member,
										Model model,
										RedirectAttributes rttr) {
			log.info("mFindByPassProc()");
			String view = mServ.mFindByPass(member,model,rttr);
			
			return view;
		}
		
		//비밀번호 찾기 -> 비밀번호 변경페이지
		@PostMapping("mPassUpdate")
		public String mPassUpdate() {
			log.info("mPassUpdate1()");
			
			return "mPassUpdate";
		}
		
		//비밀번호 변경 처리 메서드
		@PostMapping("mUpdatePassProc")
		public String mUpdatePassProc(MemberDto member,
									RedirectAttributes rttr) {
			log.info("mUpdatePassProc1()");
			
			String view = mServ.mUpdatePassProc(member,rttr);
			return view;
		}

	// 로그아웃 
	@GetMapping("logout")
	public String logout(HttpServletRequest request, RedirectAttributes rttr) {
	    log.info("logout()");
	    String msg = null;

	    HttpSession session = request.getSession(false); // false 플래그는 새로운 세션이 생성되지 않도록 합니다.

	    if (session != null && session.getAttribute("mLogin") != null) {
	        // 세션이 비어있지 않을 때 로그아웃 처리
	        session.invalidate();
	        System.out.println(session);
	        msg = "로그아웃 되었습니다. 감사합니다.";
	        
	    } else {
	        // 이미 로그아웃 되어있거나 세션이 없는 경우
	    	System.out.println(session);
	    	msg = "이미 로그아웃 되어 있습니다.";
	        
	    }

	    rttr.addFlashAttribute("msg", msg);
	    return "redirect:/";
	}
	
	
	// 일반회원정보 수정페이지 이동
	@GetMapping("mUpdate")
	public String mUpdate(Model model,HttpSession session) {
		log.info("mUpdate()");
		
		MemberDto logInInfo = (MemberDto) session.getAttribute("mLogin");
		
		if (logInInfo != null && session.getAttribute("mLogin") != null) {
	        // 로그인한 회원 정보를 모델에 추가하여 JSP로 전달
	        model.addAttribute("mLogInInfo", logInInfo);
	        	        	        	        
	}
		return "mUpdate";
}
	
	// 일반회원정보 수정 처리
	@PostMapping("mUpdateProc")
	public String mUpdateProc(@RequestPart List<MultipartFile> files, 
			MemberDto member,
			HttpSession session,
			RedirectAttributes rttr) {
		log.info("updateProc()");
		System.out.println("mUpdate에서 넘어온 dto"+member);
		String view = mServ.memberUpdate(files, member, session, rttr);
		
		return view;
	}
	
	// 일반회원 탈퇴
	@GetMapping("mDelete")
	public String mDelete(Integer memberId,HttpSession session,RedirectAttributes rttr) {
		log.info("mDelete()");
		
		
		String view = mServ.mDelete(memberId,session,rttr);
		if (session != null && session.getAttribute("mLogin") != null) {
	        // 탈퇴 후 세션에 저장되어있는 값 삭제
	        session.invalidate();
	    }

		return view;
	}
	
}