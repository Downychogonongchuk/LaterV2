package com.icia.later;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.later.dto.BoardDto;
import com.icia.later.dto.CustomerDto;
import com.icia.later.dto.MemberDto;
import com.icia.later.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BoardController {
	@Autowired
	private BoardService bServ;

	// 모집등록페이지 전환
	@GetMapping("writeFrm")
	public String writeFrm(Model model, HttpSession session) {
		log.info("writeFrm()");

		CustomerDto cLogInInfo = (CustomerDto) session.getAttribute("cLogin");

		System.out.println(cLogInInfo);
		if (cLogInInfo != null) {
			model.addAttribute("customer", cLogInInfo);

		}

		return "writeFrm";
	}

	// 모집등록 처리 메서드
	@PostMapping("writeProc")
	public String writeProc(@RequestPart List<MultipartFile> files, 
			BoardDto board,
			HttpSession session,
			RedirectAttributes rttr) {
		log.info("writeProc()");
		
		String view = bServ.insertBoard(files, board, session, rttr);
		return view;
	}
	//업체정보 수정페이지 전환
			@GetMapping("bUpdate")
			public String bUpdate(Integer boardId, Model model, HttpSession session) {
				log.info("bUpdate()");
				
				boardId = 1;
				
				BoardDto board = bServ.getBoard(boardId);
				
				CustomerDto cLogInInfo = (CustomerDto) session.getAttribute("cLogin");
				
				System.out.println(cLogInInfo);
				if(cLogInInfo != null) {
					model.addAttribute("customer", cLogInInfo);
				}
				
				model.addAttribute("board", board);
				return "bUpdate";
			}
			
			//업체정보 수정 처리 메서드
			@PostMapping("bUpdateProc")
			public String bUpdateProc(@RequestPart List<MultipartFile> files, 
					Integer boardId,
					HttpSession session,
					RedirectAttributes rttr) {
				log.info("bUpdateProc()");
				
				BoardDto board = bServ.getBoard(boardId);
				
				String view = bServ.boardUpdate(files, board, session, rttr);
				
				return view;
			}
			
			// 업체 삭제 메서드
			@GetMapping("bDelete")
			public String bDelete(Integer boardId,
								  HttpSession session,
								  RedirectAttributes rttr) {
				log.info("bDelete()");
				String view = bServ.boardDelete(boardId, session, rttr);
				return view;
			}

}
