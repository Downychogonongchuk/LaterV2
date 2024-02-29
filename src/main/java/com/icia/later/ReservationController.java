package com.icia.later;

import java.time.LocalDateTime;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.later.dto.BoardDto;
import com.icia.later.dto.MemberDto;
import com.icia.later.dto.ReservationDto;
import com.icia.later.service.BoardService;
import com.icia.later.service.MemberService;
import com.icia.later.service.ReservationService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReservationController {
	
	@Autowired
	private BoardService bServ;
	@Autowired
	private ReservationService rServ;
	

	
	// 예약처리
			@PostMapping("rev")
			public String rev(HttpSession session,
					RedirectAttributes rttr,
					Integer boardId) {
				log.info("rev()");
				
				MemberDto member = (MemberDto) session.getAttribute("mLogin");
				
				if(member != null) {
					Integer memberId = member.getMemberId();
					System.out.println(memberId);
					ReservationDto rDto = rServ.selectRev(memberId, boardId, rttr, session);
					if (rDto == null) {
						String view = rServ.insertRev(memberId, boardId, rttr, session);
						return view;
					} else {
						String msg = "이미 신청하셨습니다.";
						String view = "redirect:/";
						rttr.addFlashAttribute("msg", msg);
						return view;
					}
					
					
				} else {
					
					return "redirect:mlogin";
				}
			}
}
				
			
	
	
	
	

	
	
	
	

